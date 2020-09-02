package com.gojls.ems.event.controller;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gojls.common.controller.BaseController;
import com.gojls.ems.event.model.EmsEventModel;
import com.gojls.ems.event.model.EmsEventSongModel;
import com.gojls.ems.event.model.EmsEventSongUserDataModel;
import com.gojls.ems.event.service.EmsEventService;

import gojlslib.util.CustomProp;
import net.sf.json.JSONObject;


@Controller
public class EmsEventController extends BaseController {

	private EmsEventService emsEventService;
	
	
	
	@Autowired
	public void setemsEventService(EmsEventService emsEventService){
		this.emsEventService = emsEventService;
	}
	
	@GetMapping(value="/musichero")
	public String main(HttpServletRequest req, HttpServletResponse res) throws Exception{
		return "redirect:/musichero/ep2";	
	}

	@GetMapping(value="/song/1")
	public String main2(HttpServletRequest req, HttpServletResponse res) throws Exception{
		return "redirect:/musichero/ep1";	
	}
		
	@GetMapping(value = "/musichero/ep{emsEventSeq}")
	public ModelAndView getHome(HttpServletRequest request, HttpServletResponse respondse,
			@PathVariable int emsEventSeq) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView("song/musichero_ep" + emsEventSeq);
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		int isChess = 0;
		
		if(cookieProp != null){	// 회원 정보 세팅
			
			isChess = emsEventService.selectChessUser(cookieProp.get("USER_SEQ"));
			modelAndView.addObject("isCookies", 1);
			modelAndView.addObject("isChess", isChess);
			modelAndView.addObject("userSeq", cookieProp.get("USER_SEQ"));	
		}
		else{
			modelAndView.addObject("isCookies", 0);
			modelAndView.addObject("isChess", 0);
			modelAndView.addObject("userSeq", "");
		}
		
		EmsEventModel emsEvent = new EmsEventModel();
		emsEvent.setEmsEventSeq(emsEventSeq);
		EmsEventModel eventInfo = emsEventService.selectEventInfo(emsEventSeq);
		
		int totalPlaySong = emsEventService.selectTotSongPlayCnt(emsEventSeq);
		eventInfo.setActivityCnt(totalPlaySong);
		DecimalFormat decimalFormat = new DecimalFormat("#,##0");
		modelAndView.addObject("totCnt", decimalFormat.format(totalPlaySong));
				
		// 현재 날자 읽어 오기
		java.util.Date today  = Calendar.getInstance().getTime();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
					
		int eventState = 0;  // 0:open 1:Activity start, 2:Activity End 3:announced winner
		int openState = 0;   // 히든 카드 0:오픈전   1:오픈일  2:+1W  3:+2W     
		long todayDate = Long.parseLong(simpleDate.format(today));
	    long activityStartDate = Long.parseLong(eventInfo.getActivityStartDt());
		long activityCloseDate = Long.parseLong(eventInfo.getActivityEndDt());
		long announceWinnerDate = Long.parseLong(eventInfo.getWinnerAnnounceDt());
		
		long openDate1 = Long.parseLong(eventInfo.getOpenDt1());
		long openDate2 = Long.parseLong(eventInfo.getOpenDt2());
		long openDate3 = Long.parseLong(eventInfo.getOpenDt3());
		
		eventInfo.setOpenDt1(String.valueOf((openDate1%10000)/100) + '/' + String.valueOf(openDate1%100));
		eventInfo.setOpenDt2(String.valueOf((openDate2%10000)/100) + '/' + String.valueOf(openDate2%100));
		eventInfo.setOpenDt3(String.valueOf((openDate3%10000)/100) + '/' + String.valueOf(openDate3%100));
		
		if(todayDate < activityStartDate){eventState = 0;}
		else if(todayDate <= activityCloseDate){eventState = 1;}
		else if(todayDate < announceWinnerDate){eventState = 2;}
		else{eventState = 3;}
		
		if(todayDate < openDate1){openState = 0;}		//0424	
		else if(todayDate < openDate2){openState = 1;}  //0501 
		else if(todayDate < openDate3){openState = 2;}  //0508
		else{openState = 3;}
		
		eventInfo.setEventState(eventState);
		eventInfo.setOpenState(openState);
		modelAndView.addObject("eventInfo", eventInfo);
		
		return modelAndView;
		
	}
	
	
	@PostMapping(value ="/song/loadSongList/{emsEventSeq}")
	@ResponseBody
	public void loadSongList(HttpServletRequest request, HttpServletResponse respondse,
			@PathVariable int emsEventSeq) throws Exception{
		Map<String , Object> map = new HashMap<String, Object>();
		
		try{
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			String userSeq = "";
			
			if(cookieProp != null){	// 회원 정보 세팅
				
				int isChess = emsEventService.selectChessUser(cookieProp.get("USER_SEQ"));
				
				if(isChess == 1) {
					userSeq = cookieProp.get("USER_SEQ");
				}	
			}
			
			String studyTime = "";
			int myLevel = 0;
			String songType = "MUSIC";
			List<EmsEventSongModel> songList = emsEventService.selectSongList(emsEventSeq, userSeq, songType);
			EmsEventSongUserDataModel songData = new EmsEventSongUserDataModel();
			if(!userSeq.equals("")){
				
				songData =  emsEventService.selectSongPlayCnt(emsEventSeq, userSeq, songType);
				
				int totCardCnt = songData.getCardCnt();
				int totPlayCnt = songData.getPlayCnt();
				int totPlayCntAll = songData.getPlayCntAll();

				if(emsEventSeq == 1) {	
					if(totCardCnt > 0){myLevel = 1; }
					if(totCardCnt > 16){myLevel = 2;}
					if(totCardCnt == 34){myLevel = 3;}
					if(totCardCnt == 34 && totPlayCnt >= 100){myLevel = 4;}
				}else {
					if(totCardCnt > 0){myLevel = 1; }
					if(totCardCnt > 24){myLevel = 2;}
					if(totCardCnt >= 50){myLevel = 3;}
					if(totCardCnt >= 50 && totPlayCntAll >= 150){myLevel = 4;}
				}
				//if(totPlayCnt>180)totPlayCnt=180;
				//studyTime = (totPlayCnt%6>0)?String.valueOf(totPlayCnt*10)+"분":"";	
				//studyTime = (totPlayCnt>5)? String.valueOf(totPlayCnt/6)+"시간 ":"";
				//studyTime += (totPlayCnt%6>0)?String.valueOf(totPlayCnt%6*10)+"분":"";				
				//if(studyTime.equals(""))studyTime="0분";
				
			}
			
			songType = "HIDDEN";
			List<EmsEventSongModel> hiddenList = emsEventService.selectSongList(emsEventSeq, userSeq, songType);
			map.put("result", "SUCCESS");
			map.put("myLevel", myLevel);
			map.put("studyTime", studyTime);
			map.put("songList", songList);
			map.put("songData", songData);
			map.put("hiddenList", hiddenList);
			
		}catch(Exception e){
			
			map.put("result", "FAIL");
			map.put("message", "컨텐츠 정보 읽어오기에 실패 하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(map);
		respondse.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = respondse.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
	
	
	/* 사용자 플레이 기록 저장  */
	@PostMapping(value = "/song/addPlayCount/{emsEventSeq}/{eventSongSeq}")
	@ResponseBody
	public void addPlayCount(HttpServletRequest request, HttpServletResponse respondse,
			@PathVariable int eventSongSeq,
			@PathVariable int emsEventSeq) throws Exception{

		EmsEventModel eventInfo = emsEventService.selectEventInfo(emsEventSeq);
		// 현재 날자 읽어 오기
		java.util.Date today  = Calendar.getInstance().getTime();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
					
		int eventState = 0;  // 0:open 1:Activity start, 2:Activity End 3:announced winner
		long todayDate = Long.parseLong(simpleDate.format(today));
	    long activityStartDate = Long.parseLong(eventInfo.getActivityStartDt());
		long activityCloseDate = Long.parseLong(eventInfo.getActivityEndDt());
		long announceWinnerDate = Long.parseLong(eventInfo.getWinnerAnnounceDt());
		
		if(todayDate < activityStartDate){eventState = 0;}
		else if(todayDate <= activityCloseDate){eventState = 1;}
		else if(todayDate < announceWinnerDate){eventState = 2;}
		else{eventState = 3;}
		 
		Map<String , Object> map = new HashMap<String, Object>();
		if(eventState < 1) {			
			map.put("cnt", 0);
			map.put("result", "FAIL");
			map.put("message", "이벤트 참여기간이 아닙니다.");			
		}else if(eventState > 1) {			
			map.put("cnt", 0);
			map.put("result", "FAIL");
			map.put("message", "이벤트 기간이 종료 되었습니다.");
		}else {		
	
			try{
				
				CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
				String userSeq = "";
				
				if(cookieProp != null){	// 회원 정보 세팅
					
					int isChess = emsEventService.selectChessUser(cookieProp.get("USER_SEQ"));
					if(isChess == 1) {
						userSeq = cookieProp.get("USER_SEQ");
					}	
				}
				
				if(userSeq.equals("")){
					map.put("cnt", 0);
					map.put("result", "FAIL");
					map.put("message", "CHESS 학생이 아닙니다.");
				}
				else{
					map.put("cnt", emsEventService.mergeSongPlay(eventSongSeq, userSeq));
					
					int myLevel = 0;
					String songType = "MUSIC";
					EmsEventSongUserDataModel songData = new EmsEventSongUserDataModel();
					songData =  emsEventService.selectSongPlayCnt(emsEventSeq, userSeq, songType);

					int totCardCnt = songData.getCardCnt();
					int totPlayCnt = songData.getPlayCnt();
					int totPlayCntAll = songData.getPlayCntAll();
						
					if(emsEventSeq == 1) {	
						if(totCardCnt > 0){myLevel = 1; }
						if(totCardCnt > 16){myLevel = 2;}
						if(totCardCnt == 34){myLevel = 3;}
						if(totCardCnt == 34 && totPlayCnt >= 100){myLevel = 4;}
					}else {
						if(totCardCnt > 0){myLevel = 1; }
						if(totCardCnt > 24){myLevel = 2;}
						if(totCardCnt >= 50){myLevel = 3;}
						if(totCardCnt >= 50 && totPlayCntAll >= 150){myLevel = 4;}
					}	
					
					int songPlayCnt = emsEventService.selectSongPlayCnt2(eventSongSeq, userSeq );
					
					map.put("result", "SUCCESS");
					map.put("myLevel", myLevel);
					map.put("songPlayCnt", songPlayCnt);
				}
				
			}catch(Exception e){
				map.put("cnt", 0);
				map.put("result", "FAIL");
				map.put("message", "플레이 기록 저장에 실패하였습니다.");
			}
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(map);
		respondse.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = respondse.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
	}

	@RequestMapping(value="/song/movie", method=RequestMethod.GET)
	public String moviePop(HttpServletRequest request) {

		CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
		
		request.setAttribute("eventSongSeq", request.getParameter("eventSongSeq"));
		request.setAttribute("title", request.getParameter("title"));		
		request.setAttribute("userSeq", cookieProp.get("USER_SEQ"));

		return "song/movie";
	}


}


	
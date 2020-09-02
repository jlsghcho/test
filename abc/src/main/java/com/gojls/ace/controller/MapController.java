package com.gojls.ace.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gojls.ace.model.MapModel;
import com.gojls.ace.service.MapService;
import com.gojls.common.controller.BaseController;

import gojlslib.util.CustomProp;
import net.sf.json.JSONObject;


@Controller
public class MapController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
 
	private MapService mapService;
	
	@Value("#{globalContext['SITE_URL']?:''}")
	protected String SITE_URL;

	@Autowired
	public void setMapService(MapService mapService) { this.mapService = mapService; }
 
	//@GetMapping( { "/ace/map" })
	@RequestMapping(value="/ace/map", method=RequestMethod.GET)
	public ModelAndView getHome(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="map", defaultValue="") String map)
	{	
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /ace/map");
		}		

		System.out.println("::mapSeq::"+map);
		
		ModelAndView modelAndView = new ModelAndView("ace/map");

		String eventSeq = "2";
		
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		String userSeq = "";

		// 이벤트 리스트 가져오기
		MapModel mapModel = new MapModel();
		if(cookieProp != null){	// 회원 정보 세팅
			userSeq = cookieProp.get("USER_SEQ");
			modelAndView.addObject("isCookies", 1);
		}
		else{	
			modelAndView.addObject("isCookies", 0);
		}

		modelAndView.addObject("userSeq", userSeq);
		mapModel.setUserSeq(userSeq);
		mapModel.setEventSeq(eventSeq);
		//modelAndView.addObject("mapInfo", mapInfo);
        //개인 미션 참여 정보
		MapModel mapUserInfo = mapService.selectUserMissionInfo(mapModel);
		modelAndView.addObject("mapUserInfo", mapUserInfo);

		//맵미션정보(카운트)
		MapModel mapInfo = mapService.selectMapInfo(mapModel);
		
		DecimalFormat df = new DecimalFormat("#,##0");	 
		modelAndView.addObject("viewCnt", df.format(mapInfo.getViewCnt()));		
		modelAndView.addObject("mission1Cnt", df.format(mapInfo.getMission1Cnt()));		
		modelAndView.addObject("mission2Cnt", df.format(mapInfo.getMission2Cnt()));		
		modelAndView.addObject("goods1Cnt", df.format(mapInfo.getGoods1Cnt()));		
		modelAndView.addObject("goods2Cnt", df.format(mapInfo.getGoods2Cnt()));		
		modelAndView.addObject("goods3Cnt", df.format(mapInfo.getGoods3Cnt()));		
		modelAndView.addObject("goods4Cnt", df.format(mapInfo.getGoods4Cnt()));		
		
		modelAndView.addObject("mapSeq", map);
		
        //페이지뷰 카운트 업데이트
		mapService.updateMissionView(mapModel);
		
		return modelAndView;

	}

	@PostMapping({"/ace/map/missionCntInfo"})
	@ResponseBody
	public void selectMissionCntInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /ace/map/missionCntInfo");
		}		
 
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		String userSeq = "";

		String eventSeq = "2";
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(cookieProp != null){	// 회원 정보 세팅
				userSeq = cookieProp.get("USER_SEQ");

				MapModel mapModel = new MapModel();
				mapModel.setUserSeq(userSeq);
				mapModel.setEventSeq(eventSeq);
		        //개인 미션 참여 정보
				MapModel mapUserInfo = mapService.selectUserMissionInfo(mapModel);
				map.put("mapUserInfo", mapUserInfo);

				//맵미션정보(카운트)
				MapModel mapInfo = mapService.selectMapInfo(mapModel);
				
				DecimalFormat df = new DecimalFormat("#,##0");	
				map.put("viewCnt", df.format(mapInfo.getViewCnt()));		
				map.put("mission1Cnt", df.format(mapInfo.getMission1Cnt()));		
				map.put("mission2Cnt", df.format(mapInfo.getMission2Cnt()));		
				map.put("goods1Cnt", df.format(mapInfo.getGoods1Cnt()));		
				map.put("goods2Cnt", df.format(mapInfo.getGoods2Cnt()));		
				map.put("goods3Cnt", df.format(mapInfo.getGoods3Cnt()));		
				map.put("goods4Cnt", df.format(mapInfo.getGoods4Cnt()));	
				
				
				map.put("RESULT", "SUCCESS"); 	
				
			}else{
				map.put("RESULT", "ERROR");
				map.put("MSG", "로그인이 되어있지 않습니다.");
		    }
		} catch (Exception e) {
			logger.error(e.getMessage());
			map.put("RESULT", "ERROR");
			map.put("MSG", e.getMessage());
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
	}
	
	@PostMapping({"/ace/map/mission1Info"})
	@ResponseBody
	public void selectMission1Info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /ace/map/mission1Info");
		}		

		String mapCd = (String)request.getParameter("mapCd");
		String eventMapSeq = (String)request.getParameter("eventMapSeq");
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		String userSeq = "";
 
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(cookieProp != null){	// 회원 정보 세팅
				userSeq = cookieProp.get("USER_SEQ");
			}
			MapModel mapModel = new MapModel();
			mapModel.setEventMapSeq(eventMapSeq);
			mapModel.setMapCd(mapCd);
			mapModel.setUserSeq(userSeq);
			MapModel missionInfo = mapService.selectMission1Info(mapModel);
			 
			map.put("RESULT", "SUCCESS"); 		
			map.put("missionInfo", missionInfo);			
			 
		} catch (Exception e) {
			logger.error(e.getMessage());
			map.put("RESULT", "ERROR");
			map.put("MSG", e.getMessage());
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
	}
	
	@PostMapping({"/ace/map/missionCnt"})
	@ResponseBody
	public void selectMissionCnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /ace/map/missionCnt::missionFg::"+(String)request.getParameter("missionFg"));
		}		
 
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		String missionFg = (String)request.getParameter("missionFg");
 
		Map<String, Object> map = new HashMap<String, Object>();
		try {

			if(cookieProp != null){	// 회원 정보 세팅
				MapModel mapModel = new MapModel();
				mapModel.setUserSeq(cookieProp.get("USER_SEQ"));
				mapModel.setMissionFg(missionFg);
	    		int cnt = mapService.selectMissionCnt(mapModel);
				 
				map.put("RESULT", "SUCCESS"); 		
				map.put("cnt", cnt);			
		    }else{
				map.put("RESULT", "ERROR");
				map.put("MSG", "로그인이 되어있지 않습니다.");
		    }
		} catch (Exception e) {
			logger.error(e.getMessage());
			map.put("RESULT", "ERROR");
			map.put("MSG", e.getMessage());
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
	}

	@PostMapping({"/ace/map/mission"})
	@ResponseBody
	public void insertMapMission(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /ace/map/mission");
		}		
 
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		String missionFg = (String)request.getParameter("missionFg");
		String deptSeq = (String)request.getParameter("deptSeq");
		String clsSeq = (String)request.getParameter("clsSeq");
		String eventMapSeq = (String)request.getParameter("eventMapSeq");
		String goodsFg = (String)request.getParameter("goodsFg");
		String answer = (String)request.getParameter("answer");
		//System.out.println("::deptSeq::"+deptSeq+"::clsSeq::"+clsSeq);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(cookieProp != null){	// 회원 정보 세팅
				MapModel mapModel = new MapModel();
				mapModel.setUserSeq(cookieProp.get("USER_SEQ"));
				mapModel.setMissionFg(missionFg);
				mapModel.setDeptSeq(deptSeq);
				mapModel.setClsSeq(clsSeq);
				mapModel.setEventMapSeq(eventMapSeq);
				mapModel.setGoodsFg(goodsFg);
				mapModel.setAnswer(answer);
	    		int cnt = mapService.insertMapMission(mapModel);
	    		 
				map.put("RESULT", "SUCCESS"); 
				map.put("cnt", cnt); 		
							
		    }else{
				map.put("RESULT", "ERROR");
				map.put("MSG", "로그인이 되어있지 않습니다.");
		    } 
		} catch (Exception e) {
			logger.error(e.getMessage());
			map.put("RESULT", "ERROR");
			map.put("MSG", e.getMessage());
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
	} 

	@RequestMapping(value="/ace/download", method=RequestMethod.GET)
	@ResponseBody
	public void download(HttpServletResponse response, HttpServletRequest request) throws Exception{
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /download");
		} 
		try {
			// 파일명 가져오기
	        String fileUrl = request.getParameter("fileUrl");
	        String fileNm = request.getParameter("fileNm");

//			System.out.println("::fileUrl::"+fileUrl);
	        // 경로 가져오기
	        File file = new File(fileUrl);
 
	        // 무조건 다운로드하도록 설정
	        response.setHeader("Content-type", "application/unknown");
	        response.setHeader("Content-Disposition","attachment;filename=\"" + new String(fileNm.getBytes("euc-kr"),"8859_1") + "\";");
	         
	        // 요청된 파일을 읽어서 클라이언트쪽으로 저장한다.
	        FileInputStream fileInputStream = new FileInputStream(file);
	        ServletOutputStream servletOutputStream = response.getOutputStream();
	         
	        byte b [] = new byte[1024];
	        int data = 0;
	         
	        while((data=(fileInputStream.read(b, 0, b.length))) != -1)
	        {
	            servletOutputStream.write(b, 0, data);
	        }
	         
	        servletOutputStream.flush();
	        servletOutputStream.close();
	        fileInputStream.close();
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}

}

package com.gojls.ems.gwizard.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gojls.common.controller.BaseController;
import com.gojls.ems.gwizard.model.EventElevateModel;
import com.gojls.ems.gwizard.model.EventHistoryModel;
import com.gojls.ems.gwizard.model.EventQuizModel;
import com.gojls.ems.gwizard.model.EventUserModel;
import com.gojls.ems.gwizard.service.EventHistoryService;
import com.gojls.ems.gwizard.service.MainService;

import gojlslib.util.CustomProp;
import net.sf.json.JSONObject;

@Controller
public class MainController extends BaseController {
	@Autowired
	private MainService mainService;
	
	@Autowired
	private EventHistoryService eventHistoryService;
	
	@GetMapping(value="/grammar")
	public String main(){
		return "redirect:/grammar/ep2";	
	}	
	
	@GetMapping(value = "/grammar/ep{episodeSeq}")
	public String getMain(HttpServletRequest request, @PathVariable int episodeSeq){
		
		// 회원 정보 가져오기
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("episodeSeq", episodeSeq);
		if(cookieProp != null) {
			request.setAttribute("isCookies", 1);
			map.put("userSeq", cookieProp.get("USER_SEQ"));
			map.put("userNm", cookieProp.get("USER_NM"));
		}else {
			request.setAttribute("isCookies", 0);
			map.put("userSeq", "");
			map.put("userNm", "");
		}
		
		String isTest = "N";//테스트계정여부
		if(cookieProp != null && (cookieProp.get("USER_ID").equals("grammar01") || cookieProp.get("USER_ID").equals("grammar02") || cookieProp.get("USER_ID").equals("grammar03")
				|| cookieProp.get("USER_ID").equals("grammar04") || cookieProp.get("USER_ID").equals("grammar05") || cookieProp.get("USER_ID").equals("grammar06")
				|| cookieProp.get("USER_ID").equals("grammar07") || cookieProp.get("USER_ID").equals("grammar08") || cookieProp.get("USER_ID").equals("grammar09")
				|| cookieProp.get("USER_ID").equals("grammar10"))) isTest = "Y";

		Map<String, Object> resultMap = mainService.getMain(map);
		request.setAttribute("episodeSeq", resultMap.get("episodeSeq"));
		request.setAttribute("totalMovieCntInfo", resultMap.get("totalMovieCntInfo"));
		request.setAttribute("eventInfo", resultMap.get("eventInfo"));
		request.setAttribute("eventNoticeList", resultMap.get("eventNoticeList"));
		request.setAttribute("eventTopUserList", resultMap.get("eventTopUserList"));
		request.setAttribute("eventMovieList", resultMap.get("eventMovieList"));
		request.setAttribute("isUserCheck", resultMap.get("isUserCheck"));
		request.setAttribute("eventUser", resultMap.get("eventUser"));
		request.setAttribute("eventAttendanceList", resultMap.get("eventAttendanceList"));
		request.setAttribute("isTest", isTest);
		
		return "gwizard/ep" + episodeSeq;
		
	}
	
	@PostMapping(value ="/grammar/{episodeSeq}", produces="application/json")
	@ResponseBody
	public void getData(HttpServletRequest request, HttpServletResponse response, @PathVariable int episodeSeq) throws Exception{
		Map<String , Object> returnMap = new HashMap<String, Object>();
		
		try{
			// 회원 정보 가져오기
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("episodeSeq", episodeSeq);
			if(cookieProp != null) {
				request.setAttribute("isCookies", 1);
				map.put("userSeq", cookieProp.get("USER_SEQ"));
			}else {
				request.setAttribute("isCookies", 0);
				map.put("userSeq", "");
			}
	
			Map<String, Object> resultMap = mainService.getMain(map);
			returnMap.put("RESULT", "SUCCESS");
			returnMap.put("totalMovieCntInfo", resultMap.get("totalMovieCntInfo"));
			returnMap.put("eventUser", resultMap.get("eventUser"));
			returnMap.put("eventTopUserList", resultMap.get("eventTopUserList"));
			returnMap.put("eventMovieList", resultMap.get("eventMovieList"));
			returnMap.put("eventAttendanceList", resultMap.get("eventAttendanceList"));
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "마법사 이름 CHECK에 실패 하였습니다.");
		}
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
	
	@PostMapping(value ="/grammar/{eventSeq}/nickNmCheck", produces="application/json")
	@ResponseBody
	public void nickNmCheck(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq, @ModelAttribute EventUserModel eventUserModel) throws Exception{
		Map<String , Object> returnMap = new HashMap<String, Object>();
		
		try{
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			if(cookieProp == null) {
				returnMap.put("RESULT", "FAIL");
				returnMap.put("MSG", "로그인 후 이용가능합니다.");
			}else {
				eventUserModel.setEventSeq(eventSeq);
				eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
				Map<String, Object> resultMap = mainService.selectEventUserNickNmCheck(eventUserModel);
				
				if(resultMap.get("RESULT").equals("SUCCESS")) {
					returnMap.put("RESULT", "SUCCESS");
				}else if(resultMap.get("RESULT").equals("FAIL1")) {
					returnMap.put("RESULT", "FAIL1");
					returnMap.put("MSG", "사용중인 마법사 이름입니다.");
				}else {
					returnMap.put("RESULT", "FAIL2");
					returnMap.put("swear", resultMap.get("swearWord"));
					returnMap.put("MSG", "욕설이 포함된 이름은 사용할 수 없습니다.");
				}
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "마법사 이름 CHECK에 실패 하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
	
	@PostMapping(value ="/grammar/{eventSeq}/changeNickNm")
	@ResponseBody
	public void changeNickNm(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq, @ModelAttribute EventUserModel eventUserModel) throws Exception{
		Map<String , Object> returnMap = new HashMap<String, Object>();
		
		try{
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			if(cookieProp == null) {
				returnMap.put("RESULT", "FAIL");
				returnMap.put("MSG", "로그인 후 이용가능합니다.");
			}else {
				eventUserModel.setEventSeq(eventSeq);
				eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
				eventUserModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				eventUserModel.setRegUserNm(cookieProp.get("USER_NM"));
				mainService.updateEventUserNickNm(eventUserModel);
				
				returnMap.put("RESULT", "SUCCESS");
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "마법사 이름 CHECK에 실패 하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
	
	@RequestMapping(value="/grammar/{eventSeq}/movie", method=RequestMethod.GET)
	public String moviePop(HttpServletRequest request,@PathVariable int eventSeq, @ModelAttribute EventHistoryModel eventHistoryModel) {

		CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
		
		EventUserModel eventUserModel = new EventUserModel();
		eventUserModel.setEventSeq(eventSeq);
		eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
		
		eventHistoryModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
		eventHistoryModel.setRegUserNm(cookieProp.get("USER_NM"));
		
		Map<String, Object> resultInfo = eventHistoryService.insertEventHistory(eventUserModel, eventHistoryModel);

		request.setAttribute("eventSeq", eventSeq);
		request.setAttribute("eventMovieInfo", resultInfo.get("eventMovieInfo"));
		request.setAttribute("eventHistorySeq", resultInfo.get("eventHistorySeq"));

		return "gwizard/movie";
	}
	
	@PostMapping(value="/grammar/{eventSeq}/movie")
	@ResponseBody
	public void getMovieHitorytInfo(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq, @ModelAttribute EventHistoryModel eventHistoryModel) throws Exception {
		Map<String , Object> returnMap = new HashMap<String, Object>();
		
		try{
			CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
			
			EventUserModel eventUserModel = new EventUserModel();
			eventUserModel.setEventSeq(eventSeq);
			eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
			
			eventHistoryModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
			eventHistoryModel.setRegUserNm(cookieProp.get("USER_NM"));
			
			Map<String, Object> resultInfo = eventHistoryService.insertEventHistory(eventUserModel, eventHistoryModel);
	
			returnMap.put("RESULT", "SUCCESS");
			returnMap.put("eventHistorySeq", resultInfo.get("eventHistorySeq"));
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "문법정보를 처리하는데 실패하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
	}
	
	@RequestMapping(value="/grammar/{eventSeq}/afterQuestion/{eventHistorySeq}", method=RequestMethod.GET)
	public String quizPop(HttpServletRequest request,@PathVariable int eventSeq,@PathVariable int eventHistorySeq, @ModelAttribute EventQuizModel eventQuizModel) {		
		
		eventQuizModel.setEventSeq(eventSeq);
		Map<String, Object> resultInfo = mainService.selectEventQuiz(eventQuizModel);

		request.setAttribute("eventSeq", eventSeq);
		request.setAttribute("eventHistorySeq", eventHistorySeq);
		request.setAttribute("eventQuiz", resultInfo.get("eventQuizList"));

		return "gwizard/afterQuestion";
	}
	
	
	@PostMapping(value ="/grammar/{eventSeq}/insertEventHistory")
	@ResponseBody
	public void insertEventHistory(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq, @ModelAttribute EventHistoryModel eventHistoryModel) throws Exception{
		Map<String , Object> returnMap = new HashMap<String, Object>();
		
		try{
			CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
			if(cookieProp == null) {
				returnMap.put("RESULT", "FAIL");
				returnMap.put("MSG", "로그인 후 이용가능합니다.");
			}else {
				EventUserModel eventUserModel = new EventUserModel();
				eventUserModel.setEventSeq(eventSeq);
				eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
				
				eventHistoryModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				eventHistoryModel.setRegUserNm(cookieProp.get("USER_NM"));
				
				Map<String, Object> resultInfo = eventHistoryService.insertEventHistory(eventUserModel, eventHistoryModel);
				
				returnMap.put("RESULT", "SUCCESS");
				returnMap.put("eventHistorySeq", resultInfo.get("eventHistorySeq"));
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "문법정보를 처리하는데 실패하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
	
	@RequestMapping(value="/grammar/{eventSeq}/updateEventHistory", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public Map<String, Object> updateEventHistory(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq, @ModelAttribute EventHistoryModel eventHistoryModel) throws Exception{
		if (LOGGER.isDebugEnabled()) { LOGGER.debug("////////// Welcome POST /grammar/updateEventHistory"); }
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
			if(cookieProp == null) {
				resultMap.put("RESULT", "FAIL");
				resultMap.put("MSG", "로그인 후 이용가능합니다.");
			}else {
				EventUserModel eventUserModel = new EventUserModel();
				eventUserModel.setEventSeq(eventSeq);
				eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
				eventUserModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				eventUserModel.setRegUserNm(cookieProp.get("USER_NM"));
				
				eventHistoryModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				eventHistoryModel.setRegUserNm(cookieProp.get("USER_NM"));
				
				Map<String, Object> resultInfo = eventHistoryService.updateEventHistory(eventUserModel, eventHistoryModel);
				
				if(resultInfo.get("RESULT").equals("SUCCESS")) {
					resultMap.put("RESULT", "SUCCESS");
					resultMap.put("accessCnt", resultInfo.get("accessCnt")); //오늘 접근 수
					resultMap.put("viewCnt", resultInfo.get("viewCnt"));	//이 문법 뷰 수
					resultMap.put("elevateFl", resultInfo.get("elevateFl"));	//승급여부
					resultMap.put("nextLevelInfo", resultInfo.get("nextLevelInfo"));	//다음레벨정보
				}else {
					resultMap.put("RESULT", "FAIL");
					resultMap.put("MSG", resultInfo.get("MSG"));
				}
			}
		}catch(Exception ex){
			LOGGER.error(ex.getMessage(), ex); 
			
			resultMap.put("RESULT", "FAIL");
			resultMap.put("MSG", "문법정보를 처리하는데 실패하였습니다.");
		}
		return resultMap;
	}
	
	@PostMapping(value ="/grammar/{eventSeq}/selectEventQuiz/{eventMovieSeq}")
	@ResponseBody
	public void selectEventQuiz(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq,@PathVariable int eventMovieSeq, @ModelAttribute EventQuizModel eventQuizModel) throws Exception{
		Map<String , Object> returnMap = new HashMap<String, Object>();
		
		try{
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			if(cookieProp == null) {
				returnMap.put("RESULT", "FAIL");
				returnMap.put("MSG", "로그인 후 이용가능합니다.");
			}else {
				eventQuizModel.setEventSeq(eventSeq);
				eventQuizModel.setEventMovieSeq(eventMovieSeq);
				Map<String, Object> resultInfo = mainService.selectEventQuiz(eventQuizModel);
				
				returnMap.put("RESULT", "SUCCESS");
				returnMap.put("eventQuizList", resultInfo.get("eventQuizList"));
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "문법 quiz를 가져오는데 실패하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
	
	@RequestMapping(value="/grammar/{eventSeq}/levelup", method=RequestMethod.GET)
	public String levelupPop(HttpServletRequest request,@PathVariable int eventSeq) {		

		CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
		
		EventUserModel eventUserModel = new EventUserModel();
		eventUserModel.setEventSeq(eventSeq);
		eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
		eventUserModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
		eventUserModel.setRegUserNm(cookieProp.get("USER_NM"));
		
		Map<String, Object> resultInfo = mainService.selectEventLevelUpQuiz(eventUserModel);

		request.setAttribute("eventSeq", eventSeq);
		request.setAttribute("eventUserInfo", resultInfo.get("eventUserInfo"));
		request.setAttribute("eventMovieList", resultInfo.get("eventMovieList"));
		request.setAttribute("eventElevateSeq", resultInfo.get("eventElevateSeq"));
		request.setAttribute("eventQuizList", resultInfo.get("eventQuizList"));

		return "gwizard/levelupChallenge";
	}
	
	//인증시험
	@RequestMapping(value="/grammar/{eventSeq}/certification", method=RequestMethod.GET)
	public String certification(HttpServletRequest request,@PathVariable int eventSeq) {		

		CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
		
		int eventPrevSeq = (request.getParameter("eventPrevSeq") == null)?2:Integer.valueOf(request.getParameter("eventPrevSeq"));
		
		EventUserModel eventUserModel = new EventUserModel();
		eventUserModel.setEventSeq(eventSeq);
		eventUserModel.setEventPrevSeq(eventPrevSeq);//이전 이벤트 seq 
		eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
		eventUserModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
		eventUserModel.setRegUserNm(cookieProp.get("USER_NM"));
		
		Map<String, Object> resultInfo = mainService.selectEventCertificationQuiz(eventUserModel);

		request.setAttribute("eventSeq", eventSeq);
		request.setAttribute("eventUserInfo", resultInfo.get("eventUserInfo"));
		request.setAttribute("eventMovieList", resultInfo.get("eventMovieList"));
		request.setAttribute("eventElevateSeq", resultInfo.get("eventElevateSeq"));
		request.setAttribute("eventQuizList", resultInfo.get("eventQuizList"));

		return "gwizard/certification";
	}
	
	@PostMapping(value ="/grammar/{eventSeq}/updateEventElevate")
	@ResponseBody
	public void updateEventElevate(HttpServletRequest request, HttpServletResponse response,@PathVariable int eventSeq, @ModelAttribute EventElevateModel eventElevateModel) throws Exception{
		Map<String , Object> returnMap = new HashMap<String, Object>();
		try{
			CustomProp cookieProp = (CustomProp) request.getAttribute("cookieProp");
			if(cookieProp == null) {
				returnMap.put("RESULT", "FAIL");
				returnMap.put("MSG", "로그인 후 이용가능합니다.");
			}else {
				EventUserModel eventUserModel = new EventUserModel();
				eventUserModel.setEventSeq(eventSeq);
				eventUserModel.setUserSeq(cookieProp.get("USER_SEQ"));
				eventUserModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				eventUserModel.setRegUserNm(cookieProp.get("USER_NM"));
				
				eventElevateModel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				eventElevateModel.setRegUserNm(cookieProp.get("USER_NM"));
				
				Map<String, Object> resultInfo = eventHistoryService.updateEventElevate(eventUserModel, eventElevateModel);
				
				if(resultInfo.get("RESULT").equals("SUCCESS")) {
					returnMap.put("RESULT", "SUCCESS");
					returnMap.put("eventUserInfo", resultInfo.get("eventUserInfo"));
				}else {
					returnMap.put("RESULT", "FAIL1");
					returnMap.put("MSG", "비정상적인 접근입니다.");
					returnMap.put("eventUserInfo", resultInfo.get("eventUserInfo"));
				}
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage(), e);
			
			returnMap.put("RESULT", "FAIL");
			returnMap.put("MSG", "승급 처리하는데 실패하였습니다.");
		}
		
		JSONObject  jsonobj = JSONObject.fromObject(returnMap);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonobj.toString());
		printWriter.flush();
		
	}
}

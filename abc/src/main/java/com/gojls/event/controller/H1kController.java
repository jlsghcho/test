package com.gojls.event.controller;


import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gojls.common.controller.BaseController;
import com.gojls.event.model.H1kModel;
import com.gojls.event.service.H1kService;

import net.sf.json.JSONObject;


@Controller
public class H1kController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(H1kController.class);
 
	private H1kService h1kService;
	
	@Value("#{globalContext['SITE_URL']?:''}")
	protected String SITE_URL;

	@Autowired
	public void setH1kService(H1kService h1kService) { this.h1kService = h1kService; }
  

	@RequestMapping(value="/1000hours/intro", method=RequestMethod.GET)
	public String main(HttpServletRequest req, HttpServletResponse res) throws Exception{
		return "redirect:/1000hours/intro/2019";	
	}
	
	@RequestMapping(value="/1000hours/intro/{eventYear}", method=RequestMethod.GET)
	public ModelAndView getH1kSeason2(HttpServletRequest request, HttpServletResponse response,
			@PathVariable String eventYear)
	{	
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /1000hours/intro/{eventYear}");
		}		
 		
		ModelAndView modelAndView = new ModelAndView("event/h1k_" + eventYear );
		Boolean cookieYN = (Boolean) request.getAttribute("cookieYN");
		
		String userSeq = "";
		// 이벤트 리스트 가져오기
		H1kModel h1kModel = new H1kModel();
		if(cookieYN){	// 회원 정보 세팅
			userSeq = request.getAttribute("cookieUserSeq").toString();
			modelAndView.addObject("isCookies", 1);
		}
		else{	
			modelAndView.addObject("isCookies", 0);
		}

		modelAndView.addObject("userSeq", userSeq);
		h1kModel.setUserSeq(userSeq);
		
		int eventSeq = 5;
		if(eventYear.equals("2017")){return modelAndView;}
		else if(eventYear.equals("2018")){eventSeq = 3; }
		else if(eventYear.equals("2019")){eventSeq = 5; }
		else if(eventYear.equals("2020")){eventSeq = 6; }
		h1kModel.setEventSeq(String.valueOf(eventSeq));
		
		String code = (String)request.getParameter("code");
		modelAndView.addObject("code", code);
		
		//개인 미션 참여 정보
		H1kModel h1kEventInfo = h1kService.selectH1kEventInfo(h1kModel);
		modelAndView.addObject("h1kEventInfo", h1kEventInfo);
		modelAndView.addObject("eventSeq", String.valueOf(eventSeq));
		DecimalFormat df = new DecimalFormat("#,##0");		
		modelAndView.addObject("mission1Cnt", df.format(h1kEventInfo.getMission1Cnt()));
		modelAndView.addObject("mission2Cnt", df.format(h1kEventInfo.getMission2Cnt()));
		modelAndView.addObject("mission3Cnt", df.format(h1kEventInfo.getMission3Cnt()));
		return modelAndView;
	}
		
  
	@PostMapping({"/event/h1k/missionCnt"})
	@ResponseBody
	public void selectH1kMissionCnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /event/h1k/missionCnt::missionSeq::"+(String)request.getParameter("missionSeq"));
		}		

		Boolean cookieYN = (Boolean) request.getAttribute("cookieYN");
		String missionSeq = (String)request.getParameter("missionSeq");
		String eventSeq = (String)request.getParameter("eventSeq");
 
		Map<String, Object> map = new HashMap<String, Object>();
		try {

			if(cookieYN){	// 회원 정보 세팅
				H1kModel h1kModel = new H1kModel();
				h1kModel.setUserSeq(request.getAttribute("cookieUserSeq").toString());
				h1kModel.setEventSeq(eventSeq);
				h1kModel.setMissionSeq(missionSeq);
	    		int cnt = h1kService.selectMissionCnt(h1kModel);

	    		DecimalFormat df = new DecimalFormat("#,##0");	 		
	    		map.put("viewCnt", df.format(cnt));
 
				map.put("RESULT", "SUCCESS"); 		
				map.put("cnt", cnt);			
		    }else{
		    	System.out.println("::ERROR1111::" );
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
	

	@PostMapping({"/event/h1k/mission"})
	@ResponseBody
	public void insertH1kMission(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome POST /event/h1k/mission");
		}		

		Boolean cookieYN = (Boolean) request.getAttribute("cookieYN");
		String missionSeq = (String)request.getParameter("missionSeq");
		String eventSeq = (String)request.getParameter("eventSeq");
		String answer = (String)request.getParameter("answer");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(cookieYN){	// 회원 정보 세팅
				H1kModel h1kModel = new H1kModel();
				h1kModel.setUserSeq(request.getAttribute("cookieUserSeq").toString());
				h1kModel.setMissionSeq(missionSeq);
				h1kModel.setEventSeq(eventSeq);
				h1kModel.setAnswer(answer);

	    		int cnt = h1kService.insertMission(h1kModel);
	    		 
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
 
}

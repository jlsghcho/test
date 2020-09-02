package com.gojls.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gojls.Global;
import gojlslib.util.CookieUtil;
import gojlslib.util.CustomProp;
import com.gojls.common.controller.BaseController;
import com.gojls.report.service.ReportService;


import com.gojls.report.model.EmpModel;
import com.gojls.report.model.DeptModel;
import com.gojls.report.model.EventSearchModel;
import com.gojls.dlive.model.EventList;
import com.gojls.dlive.service.DLiveService;

@Controller
public class ReportController extends BaseController  {

	private ReportService reportService;
	private DLiveService dliveService;
	
	//private static final String currentEcvent = Global.Secret.getCurrentEvent();
	private static final Logger LOGGER = LoggerFactory.getLogger(ReportController.class);
	@Value("#{globalContext['COOKIE_URL']?:''}") private String COOKIE_URL;
	
	@Autowired
	public void setDLiveService(DLiveService dliveService) { this.dliveService = dliveService; }
	@Autowired
	public void setReportService(ReportService reportService) { this.reportService = reportService; }
	
	
	@RequestMapping(value="/admin/signIn", method=RequestMethod.GET)
	public String home(HttpServletRequest request) throws Exception  {
		if (LOGGER.isDebugEnabled()) { LOGGER.debug("////////// Welcome GET /login"); }
		
		System.out.println(" controller /report/signIn GET>>>>>>>>>>");
		if (request.getAttribute("cookieProp_event") != null) {		// 이미 로그인 한 경우
			
			return "redirect:/report/dlive-report";
		}else{
			return "/report/signIn";
		}
	}

	@RequestMapping(value="/admin/signIn", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loginProcess(HttpServletRequest request, 
			HttpServletResponse response, @ModelAttribute EmpModel empModel) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /loginProcess");
		}
		
		System.out.println(" controller /report/signIn POST>>>>>>>>>>");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			if (request.getAttribute("cookieProp_event") == null) {		// 로그인 되지 않은 경우
			
				if (empModel.getEmpId() != null && empModel.getEmpPw() != null) {	// 로그인 시도한 경우
					empModel = reportService.authEmp(empModel);
					
					if (empModel == null) {
						map.put("result", "fail");
						map.put("message", "아이디, 비밀번호가 맞지 않습니다.");
					} else {
					    
				        if (empModel.getUseFg().equals("N")) {
							// 사용불가능한 계정인 경우
				        	map.put("result", "fail");
							map.put("message", "사용 불가 계정입니다.");
						} else {
							
							
							if(empModel.getEmpTypeCd().equals("99"))
							{
								map.put("result", "fail");
								map.put("message", "접근 권한이 없습니다.");
							}
							else{
								HashMap<String, String> cookieMap = new HashMap<String, String>();
								cookieMap.put("EMP_SEQ", empModel.getEmpSeq());
								cookieMap.put("EMP_ID", empModel.getEmpId());
								cookieMap.put("EMP_NM", empModel.getEmpNm());
								cookieMap.put("EMP_TYPE", empModel.getEmpTypeCd());
								cookieMap.put("EMP_ROLE", empModel.getEmpRole());
								
								CookieUtil.setCookie("eventadm", COOKIE_URL , cookieMap, response);
							    map.put("result", "success");
						        map.put("redirectUrl", "/report/dlive-report");
							}
					    }
					}		
				
				} else {
					map.put("result", "fail");
					map.put("message", "I'm sorry. login failed. please try again.");	
					System.out.println(" input null >>>>" );
				}
				
			} else {
				map.put("result","fail");
				map.put("message", "your account is already logged in.");	
				System.out.println(" your account is already logged in. >>>>" );
				map.put("redirectUrl", "/report/dlive-report");
			}
		} catch (Exception e) {
			LOGGER.debug(e.getMessage());
			LOGGER.error(e.getMessage());
			map.put("result", "fail");
			map.put("message", "I'm sorry. login failed. please try again." + e.getMessage());
			System.out.println(" failed. >>>>" );
			
		}	
		return map;
	}
	
	@RequestMapping(value="/admin/signOut", method=RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /logOutProcess");
		}
		
		CookieUtil.deleteCookie("eventadm", COOKIE_URL , "/admin/signIn" , response);
	}
	

	@RequestMapping(value="/report/dlive-report", method=RequestMethod.GET)
	public String dliveReport(HttpServletRequest request, HttpServletResponse response){
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/dlive-report");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			
			EmpModel empModel = new EmpModel();
			//boolean bLogin = false;
			
			CustomProp cookieProp = CookieUtil.getCookie(request.getCookies(), "eventadm");
    		if(cookieProp.size() > 0){
    			empModel.setEmpSeq(cookieProp.get("EMP_SEQ"));
    			empModel.setEmpNm(cookieProp.get("EMP_NM"));
    			empModel.setEmpRole(cookieProp.get("EMP_ROLE"));
    			empModel.setEmpTypeCd(cookieProp.get("EMP_TYPE"));
    		}
	
    		String curEvent = Global.Secret.getCurrentEvent();
			List<EventList> eventList = dliveService.getEventList(curEvent);
			Map<String, Object> map = reportService.selectEmpDeptList(empModel);
			
			request.setAttribute("result", "success");
			request.setAttribute("eventList", eventList);
			request.setAttribute("userNm", empModel.getEmpNm());
			request.setAttribute("userRole", empModel.getEmpRole());
			request.setAttribute("userType", empModel.getEmpTypeCd());
			request.setAttribute("deptList", map.get("deptList"));
			
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
			returnMap.put("result", "fail");
			returnMap.put("message", "분원 정보 읽기를 실폐하였습니다");
			returnMap.put("redirectUrl", "/report/signOut");
		}
		
		return "/report/dlive-report";
	}	
	
	/**
	 * 분원 선생님  정보 (Ajax)
	 * @param deptSeq
	 * @return
	 */
	@RequestMapping(value="/report/dlive-report/{deptSeq}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getTeacherList(HttpServletRequest request, 
			@PathVariable String deptSeq ) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/dlive-report/{deptSeq}");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			EmpModel empModel = new EmpModel();
			
			CustomProp cookieProp = CookieUtil.getCookie(request.getCookies(), "eventadm");
    		if(cookieProp.size() > 0){
    			empModel.setEmpSeq(cookieProp.get("EMP_SEQ"));
    			empModel.setEmpNm(cookieProp.get("EMP_NM"));
    			empModel.setEmpRole(cookieProp.get("EMP_ROLE"));
    			empModel.setEmpTypeCd(cookieProp.get("EMP_TYPE"));
    		}
			    		
			if(empModel.getEmpTypeCd().equals("01"))
			{
				returnMap.put("result", "success");
				returnMap.put("teacherList", empModel);
			}
			else //if(empModel.getEmpRole().equals("01"))
			{	
				DeptModel deptModel = new DeptModel();
				deptModel.setDeptSeq(deptSeq);
				
				Map<String, Object> map = reportService.selectDeptTeacherList(deptModel);
				returnMap.put("result", "success");
				returnMap.put("teacherList", map.get("teacherList"));
			}
			
		} catch (Exception e) {
			
			LOGGER.error(e.getMessage(), e);
			returnMap.put("result", "fail");
			returnMap.put("message", "선생님  정보 읽기를 실폐하였습니다");
			returnMap.put("redirectUrl", "/report/signOut");
		}
		
		return returnMap;
	}
	
	
	/**
	 * 분원 선생님  정보 (Ajax)
	 * @param deptSeq
	 * @return
	 */
	@RequestMapping(value="/report/dlive-report/{deptSeq}/{empSeq}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getClassList(HttpServletRequest request, 
			@PathVariable String deptSeq,			
			@PathVariable String empSeq) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/dlive-report/{deptSeq}/{empSeq}");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			EmpModel empModel = new EmpModel();
			CustomProp cookieProp = CookieUtil.getCookie(request.getCookies(), "eventadm");
    		if(cookieProp.size() > 0){
    			empModel.setEmpSeq(cookieProp.get("EMP_SEQ"));
    		}
			
			Map<String, Object> map = reportService.selectDeptClassList(deptSeq, empModel.getEmpSeq());
			returnMap.put("result", "success");
			returnMap.put("classList", map.get("classList"));
			
		} catch (Exception e) {
			
			LOGGER.error(e.getMessage(), e);
			returnMap.put("result", "fail");
			returnMap.put("message", "수업 중인 클래스  정보 읽기를 실폐하였습니다");
			returnMap.put("redirectUrl", "/report/signOut");
		}
		
		return returnMap;
	}
	
	@RequestMapping(value="/report/dlive-report-list", method=RequestMethod.GET)
	public String getDLiveList(HttpServletRequest request,
			@ModelAttribute EventSearchModel searchVal) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/dlive-report-list");
		}	
		
		try {	
			Map<String, Object> resultMap = reportService.getDliveList(searchVal);
			request.setAttribute("dliveList", resultMap.get("dliveList"));
			
		}catch(Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return "/report/dliveList";
		
	}
	
	
	@RequestMapping(value="/report/dlive-report-dlist/{eventSeq}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object>  getDliveRanking(HttpServletRequest request,
			@PathVariable int eventSeq) {
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/dlive-report-dlist");
		}	
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {	
		
			Map<String, Object> map = reportService.selectDliveRankingList(eventSeq);
			returnMap.put("result", "success");
			returnMap.put("dliveRankList", map.get("dliveRankList"));
			
		}catch(Exception e) {
			LOGGER.error(e.getMessage(), e);
			returnMap.put("result", "fail");
		}
		
		return returnMap;
		
	}
	
	
	
	@RequestMapping(value="/report/msucc-report", method=RequestMethod.GET)
	public String getMsuccReport(HttpServletRequest request, HttpServletResponse response){
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/msucc-report");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			request.setAttribute("result", "success");
		} catch (Exception e) {
			
			LOGGER.error(e.getMessage(), e);
			returnMap.put("result", "fail");
			returnMap.put("message", "");
		}
		return "/report/msucc-report";
	}	
	
	

	@RequestMapping(value="/report/roulette-report", method=RequestMethod.GET)
	public String getRouletteReport(HttpServletRequest request, HttpServletResponse response){
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /report/roulette-report");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			request.setAttribute("result", "success");
			
		} catch (Exception e) {
			
			LOGGER.error(e.getMessage(), e);
			returnMap.put("result", "fail");
			returnMap.put("message", "");
			
		}
		return "/report/roulette-report";
	}	
	
	
	
	
}

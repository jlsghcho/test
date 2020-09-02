package com.gojls.h1k.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gojls.common.controller.BaseController;
import com.gojls.h1k.model.H1KTimeModel;
import com.gojls.h1k.model.RecordModel;
import com.gojls.h1k.model.SurveyModel;
import com.gojls.h1k.model.UserModel;
import com.gojls.h1k.service.H1KService;

import gojlslib.util.CustomProp;
import net.sf.json.JSONObject;

@Controller
public class H1KController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(H1KController.class);

	@Autowired
	H1KService h1kService;
	
	/*
	@GetMapping({ "/h1k", "/h1k/main" })
	public String getH1KMain(HttpServletRequest request, HttpServletResponse response, @ModelAttribute UserModel userModel) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/main");
		}
		
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		
		if (cookieProp == null) {	// 로그인이 되지 않은 경우
			String scriptStr = "location.href = \"https://www.gojls.com/login?preURL="+siteUrl+"/h1k/main\";";
			
			getMessageView(response, "로그인 후 이용가능합니다.", scriptStr);
			return null;
		}else{
			
			boolean state = true;
			boolean userChk = false;
			String userSeq = cookieProp.get("USER_SEQ");
			if (cookieProp.get("GT_USER_TYPE").equals("US6001") || cookieProp.get("GT_USER_TYPE").equals("US6002")) {	// 학생 or 학부모

				Calendar today = Calendar.getInstance();
				SimpleDateFormat nowDt = new SimpleDateFormat("yyyyMMdd");
				String nowDate	=	nowDt.format(today.getTime());
				request.setAttribute("nowDate", nowDate);		

				if(cookieProp.get("GT_USER_TYPE").equals("US6002")){				
					List<UserModel> list = h1kService.selectChildList(userSeq);	
					if(list.size() > 0){			
						UserModel user = new UserModel();
						if(userModel != null && userModel.getUserSeq() != null){						
							for (int i = 0; i < list.size(); i++) {
								user = list.get(i);
								System.out.println("userSeq::"+userModel.getUserSeq()+"||"+user.getUserSeq());
								if(user.getUserSeq().equals(userModel.getUserSeq())){
									userChk = true;
									userModel = user;
									System.out.println("userChk::"+userChk);
								}
							}
							System.out.println("userChk::"+userChk);
							if(!userChk){
								userModel = list.get(0);	
							}
							System.out.println("userModel.getUserSeq::"+userModel.getUserSeq());
						}else{		
							userModel = list.get(0);	
						}	
						request.setAttribute("childList", list);									
					}else{
						state = false;								
					}	
				}else{
					userModel.setUserSeq(userSeq);				
					userModel = h1kService.selectUserInfo(userModel);
					if(userModel == null || userModel.getUserSeq().equals("")){
						state = false;		
					}
				}
				request.setAttribute("userInfo", userModel);
					
				if(state){		
					return "/h1k/main";		
				}else{
					getMessageView(response, "이벤트 대상이 아닙니다.", "self.close()");
					return null;				
				} 
			} else {
				getMessageView(response, "이벤트 대상이 아닙니다.", "self.close()");
				return null;
			}
		}	
	}
	*/

	@GetMapping({ "/h1k/api/{userSeq}/{h1kEventSeq}/{term}/info" })
	@ResponseBody	
	public void getH1KUserTimeInfo(HttpServletResponse response, @ModelAttribute H1KTimeModel timeModel) throws Exception{
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/api/{userSeq}/{h1kEventSeq}/info");
		}		
		//Map<String, Object> map = new HashMap<String, Object>();

		Map<String, Object> map = null;
		try {
			map = h1kService.selectH1KEventInfo(timeModel);
			
			map.put("result", "success");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			
			map.put("result", "fail");
			map.put("msg", "정보 로딩에 실패했습니다.");
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
		
	}	
	
	@GetMapping({ "/h1k/api/{userSeq}/{h1kEventSeq}/{surveySysCode}/survey" })
	@ResponseBody	
	public void getH1KUserSurveyInfo(HttpServletResponse response, @ModelAttribute H1KTimeModel timeModel) throws Exception{
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/api/survey/{userSeq}/{h1kEventSeq}/{surveySysCode}/survey");
		}		

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			SurveyModel surveymodel = new SurveyModel();
			surveymodel.setUserSeq(timeModel.getUserSeq());
			surveymodel.setH1kEventSeq(timeModel.getH1kEventSeq());
			surveymodel.setSurveySysCode(timeModel.getSurveySysCode());
			
			surveymodel = h1kService.selectH1KSurveySave(surveymodel);
			if(surveymodel != null){			
				surveymodel.setSurveySysCode(timeModel.getSurveySysCode());				
			}
			
			map.put("surveyInfo",surveymodel);
			map.put("result", "success");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			
			map.put("result", "fail");
			map.put("msg", "정보 로딩에 실패했습니다.");
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
		
	}	

	@GetMapping({"/h1k", "/h1k/main", "/h1k/record" })
	public String getH1KRecord(HttpServletRequest request, HttpServletResponse response, @ModelAttribute H1KTimeModel timeModel) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/record");
		}
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");

		if (cookieProp == null) {	// 로그인이 되지 않은 경우
			String scriptStr = "location.href = \"https://www.gojls.com/login?preURL="+siteUrl+"/h1k/record\";";			
			getMessageView(response, "로그인 후 이용가능합니다.", scriptStr);
			return null;
		}else{			
			String userSeq = cookieProp.get("USER_SEQ");
			System.out.println("timemodel::"+timeModel.getH1kEventSeq()+"|"+timeModel.getUserSeq());
			if(cookieProp.get("GT_USER_TYPE").equals("US6002")||cookieProp.get("GT_USER_TYPE").equals("US6001")) {	// 학부모

				Calendar today = Calendar.getInstance();
				SimpleDateFormat nowDt = new SimpleDateFormat("yyyyMMdd");
				String nowDate	=	nowDt.format(today.getTime());
				request.setAttribute("nowDate", nowDate);			
				System.out.println("notdate::"+nowDate);						
				UserModel userModel = new UserModel();
				
				if(timeModel.getUserSeq() != null){		
					userModel.setUserSeq(timeModel.getUserSeq());			
					
					userModel = h1kService.selectUserInfo(userModel);	
					request.setAttribute("userInfo", userModel);
					if(userModel == null || userModel.getUserSeq().equals("")){
						getMessageView(response, "이벤트 대상이 아닙니다.", "self.close()");
						return null;	
					}else{						
						if(cookieProp.get("GT_USER_TYPE").equals("US6002")){	
							List<UserModel> list = h1kService.selectChildList(userSeq);
							request.setAttribute("childList", list);
						}
						return "/h1k/record";
					}				
				}else{
					boolean state = true;		
					if(cookieProp.get("GT_USER_TYPE").equals("US6001")){
						userModel.setUserSeq(userSeq);
						userModel = h1kService.selectUserInfo(userModel);
						if(userModel == null || userModel.getUserSeq().equals("")){			
							state = false;	
						}else{						
							state = true;							
						}
					}else if(cookieProp.get("GT_USER_TYPE").equals("US6002")){	
						List<UserModel> list = h1kService.selectChildList(userSeq);
						request.setAttribute("childList", list);		
						
						if(list.size() > 0){
							userModel = list.get(0);
							state = true;			
						}else{
							state = false;
						}
					}
					
					if(state){			
						request.setAttribute("userInfo", userModel);
						return "/h1k/record";		
					}else{
						getMessageView(response, "이벤트 대상이 아닙니다.", "self.close()");
						return null;				
					} 				
				} 
			}else{			
				getMessageView(response, "이벤트 대상이 아닙니다.", "self.close()");
				return null;			
			}
		}
	}
	

	@GetMapping({ "/h1k/survey" })
	public String getH1KSurvey(HttpServletRequest request, HttpServletResponse response, @ModelAttribute H1KTimeModel timeModel) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/survey");
		}

		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");

		if (cookieProp == null) {	// 로그인이 되지 않은 경우
			String scriptStr = "location.href = \"https://www.gojls.com/login?preURL="+siteUrl+"/h1k/survey\";";			
			getMessageView(response, "로그인 후 이용가능합니다.", scriptStr);
			return null;
		}else{		
			if(cookieProp.get("GT_USER_TYPE").equals("US6002")||cookieProp.get("GT_USER_TYPE").equals("US6001")) {	// 학부모
				if(timeModel.getUserSeq() != null){
					
					UserModel userModel = new UserModel();
					userModel.setUserSeq(timeModel.getUserSeq());	
					
					userModel = h1kService.selectUserInfo(userModel);	
					request.setAttribute("userInfo", userModel);

					Calendar today = Calendar.getInstance();
					SimpleDateFormat nowDt = new SimpleDateFormat("yyyyMMdd");
					String nowDate	=	nowDt.format(today.getTime());
					request.setAttribute("nowDate", nowDate);			
					System.out.println("nowdate::"+nowDate);	
					
					return "/h1k/survey";				
				}else{
					getMessageView(response, "정상적인 접근이 아닙니다.", "self.close()");
					return null;					
				} 
			}else{			
				getMessageView(response, "이벤트 대상이 아닙니다.", "self.close()");
				return null;			
			}
		}
	}
	
	@PostMapping({ "/h1k/api/{userSeq}/{h1kEventSeq}/survey/save" })
	@ResponseBody	
	public void getH1KUserSurveySave(HttpServletRequest request, HttpServletResponse response, @ModelAttribute RecordModel recordModel) throws Exception{
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/api/{userSeq}/{h1kEventSeq}/survey/save");
		}		

		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		
		System.out.println(recordModel.getQ1());
		System.out.println(recordModel.getQ2());
		System.out.println(recordModel.getQ3());
		System.out.println(recordModel.getQ4());
		System.out.println(recordModel.getQ5());
		System.out.println(recordModel.getAddTime());
		System.out.println(recordModel.getUserSeq());
		System.out.println(recordModel.getSurveySysCode());
		int addTime = 0;		
		String answerStr = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(recordModel != null && recordModel.getQ1() != null && recordModel.getQ2() != null && recordModel.getAddTime() > 0){
				answerStr = recordModel.getQ1()+"|"+recordModel.getQ2()+"|"+recordModel.getQ3()+"|"+recordModel.getQ4()+"|"+recordModel.getQ5();
				
				SurveyModel surveymodel = new SurveyModel();
				surveymodel.setUserSeq(recordModel.getUserSeq());
				surveymodel.setH1kSurveySeq(recordModel.getH1kEventSeq());
				surveymodel.setH1kEventSeq(recordModel.getH1kEventSeq());
				surveymodel.setAddTime(recordModel.getAddTime());
				surveymodel.setSurveySysCode(recordModel.getSurveySysCode());
				surveymodel.setSurveyAnswer(answerStr);
				surveymodel.setRegUserNm(cookieProp.get("USER_NM"));
				surveymodel.setRegUserSeq(cookieProp.get("USER_SEQ"));
				surveymodel.setSurveyFinishYn("Y");
				
				int retval = h1kService.procH1KSurveySave(surveymodel);
				System.out.println("retval::"+retval);
				if(retval < 0){		
					map.put("result", "fail");
					map.put("msg", "재등록중 오류가 발생했습니다. 다시 시도해 주세요.");					
				}else if(retval > 0){
					map.put("result", "success");					
				}else{
					map.put("result", "fail");
					map.put("msg", "처리중 문제가 발생했습니다. 다시 시도해 주세요.");					
				}
			}else{				
				map.put("result", "fail");
				map.put("msg", "처리중 문제가 발생했습니다. 다시 시도해 주세요.");
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			
			map.put("result", "fail");
			map.put("msg", "정보 저장에 실패했습니다.");
		}
		
		JSONObject jsonObj = JSONObject.fromObject(map);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.write(jsonObj.toString());
		printWriter.flush();
	}	
	
	
	@GetMapping({ "/h1k/certificate" })
	public String getH1KCertificate(HttpServletRequest request, HttpServletResponse response, @ModelAttribute UserModel userModel) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("////////// Welcome GET /h1k/certificate");
		}
		System.out.println(userModel.getUserNm()+"|"+userModel.getTerm());
		
		return "/h1k/certificate";
	}
	


}

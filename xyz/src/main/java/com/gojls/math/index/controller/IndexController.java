package com.gojls.math.index.controller;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.gojls.math.common.controller.BaseController;
import com.gojls.math.index.service.IndexService;
import com.gojls.util._Cookie;
import com.gojls.util._Response;
import com.google.common.base.Splitter;

import net.sf.json.JSONObject;

@Controller
@RequestMapping ("/")
public class IndexController extends BaseController {
	
	@Autowired IndexService indexService;
	
	@RequestMapping(value={"/", "/index"}, method=RequestMethod.GET)
	public String indexView(HttpServletRequest req) throws Exception{
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexController] indexView");	}
		
		/* 인터셉터를 거칠수가 없어서 이쪽은 별도로 작업했음 */
		Boolean cookieYN = Boolean.parseBoolean(req.getAttribute("cookieYN").toString());
		if(cookieYN) {
			String[] cookieData = _Cookie.getTokenData(req, _Cookie.getCookieStr(req.getCookies(), COOKIE_NAME));
    		Object cookieObj = JSONObject.fromObject(cookieData[1]);
    		Map<String, Object> cookieMap = _Response.formatJsonToMap(cookieObj);
    		req.setAttribute("cookieUserType", cookieMap.get("GT_USER_TYPE").toString());

    		if(_Cookie.isTokenCookie(req, COOKIE_INFO_NAME)) {
        		Map<String, String> cookiesub = Splitter.on("&").withKeyValueSeparator("=").split(_Cookie.getCookieStr(req.getCookies(), COOKIE_INFO_NAME));
        		req.setAttribute("cookieUserCourse", cookiesub.get("USER_COURSE_INFO").toString());
        		req.setAttribute("cookieUserFcYn", cookiesub.get("USER_DEPT_INFO").toString());
    		}else {
        		req.setAttribute("cookieUserCourse", "");
        		req.setAttribute("cookieUserFcYn", "");
    		}
    	}
		
		return "/index.tiles";
	}
	
	@RequestMapping(value="/{param_step:[a-z]+}/{param_detail:[a-z]+}", method=RequestMethod.GET)
	public ModelAndView indexCommonView(HttpServletRequest req, @PathVariable String param_step, @PathVariable String param_detail) throws Exception, NumberFormatException{
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexController] indexCommonView");	}
		ModelAndView mav = new ModelAndView();
		try {
			/* 파라메터 확인후 피드백 */
			int param_seq = 0;
			int param_link = 0;
			Enumeration params = req.getParameterNames();
			while (params.hasMoreElements()) {
				String param_name = (String)params.nextElement();
				mav.addObject(param_name , req.getParameter(param_name));
				if(param_name.equals("param_seq")) { 
					param_seq = Integer.parseInt(req.getParameter(param_name).toString()); 
				}else if(param_name.equals("param_link")) {
					param_link = Integer.parseInt(req.getParameter(param_name).toString()); 
				}
			}
			
			/* 분원상세소식일때 데이터에서 뿌려줌 */
			if(param_detail.equals("newsview")){
				if(param_seq > 0) {
					mav.addObject("notice", indexService.selNoticeView(param_seq)); 
					mav.setViewName("/otherpage/"+ param_step +"/"+ param_detail +".tiles");
				}else {
					mav.clear();
					mav.setViewName("redirect:/");
				}
			}else {
				mav.setViewName("/"+ param_step +"/"+ param_detail +".tiles");
			}
		}catch(Exception ex) {
			System.out.println(">>" + ex);
			mav.clear();
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	@RequestMapping(value="/{param_step:[a-z]+}/{param_sub:[a-z]+}/{param_detail:[a-z]+}", method=RequestMethod.GET)
	public ModelAndView indexCommonView_Sub(HttpServletRequest req, @PathVariable String param_step, @PathVariable String param_sub, @PathVariable String param_detail) throws Exception{
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexController] indexCommonView_Sub");	}
		ModelAndView mav = new ModelAndView("/"+ param_step +"/"+ param_sub +"/"+ param_detail +".tiles");

		Enumeration params = req.getParameterNames();
		while (params.hasMoreElements()) {
			String param_name = (String)params.nextElement();
			mav.addObject(param_name , req.getParameter(param_name));
		}
		return mav;
	}
	
	@RequestMapping(value="/{param_step:[a-z]+}/sub/{param_detail:[a-z]+}", method=RequestMethod.GET)
	public ModelAndView indexCommonDetailView(HttpServletRequest req, @PathVariable String param_step, @PathVariable String param_detail) throws Exception{
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexController] indexCommonDetailView");	}
		ModelAndView mav = new ModelAndView("/"+ param_step +"/"+ param_detail );
		/* 파라메터 확인후 피드백 */
		Enumeration params = req.getParameterNames();
		while (params.hasMoreElements()) {
			String param_name = (String)params.nextElement();
			mav.addObject(param_name , req.getParameter(param_name));
		}
		return mav;
	}

	@RequestMapping(value="/{param_step:[a-z]+}/sub/{param_sub:[a-z]+}/{param_detail:[a-z]+}", method=RequestMethod.GET)
	public ModelAndView indexCommonDetailSubView(HttpServletRequest req, @PathVariable String param_step, @PathVariable String param_sub, @PathVariable String param_detail) throws Exception{
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexController] indexCommonDetailSubView");	}
		ModelAndView mav = new ModelAndView("/"+ param_step +"/"+ param_sub +"_"+ param_detail );
		/* 파라메터 확인후 피드백 */
		Enumeration params = req.getParameterNames();
		while (params.hasMoreElements()) {
			String param_name = (String)params.nextElement();
			mav.addObject(param_name , req.getParameter(param_name));
		}
		return mav;
	}
}

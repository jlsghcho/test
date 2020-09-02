package com.gojls.math.common.interceptor;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.gojls.util._Cookie;
import com.gojls.util._Date;
import com.gojls.util._Response;
import com.google.common.base.Splitter;

import net.sf.json.JSONObject;

public class BaseHandlerInterceptor extends HandlerInterceptorAdapter{
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("#{globalContext['COOKIE_NAME']?:'jls'}") private String COOKIE_NAME;
	@Value("#{globalContext['SITE_ROOT_ACADEMY']?:'/academy'}") private String SITE_ROOT_ACADEMY;
	@Value("#{globalContext['SITE_ROOT_MATH']?:'/math'}") private String SITE_ROOT_MATH;
	
	@Value("#{globalContext['COOKIE_INFO_NAME']?:'jlsinfo'}") private String COOKIE_INFO_NAME;
	@Value("#{globalContext['COOKIE_PAID_NAME']?:'jlsinfo'}") private String COOKIE_PAID_NAME;
	@Value("#{globalContext['COOKIE_OLD_NAME']?:'jlsuser'}") private String COOKIE_OLD_NAME;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		String param_request_url = req.getRequestURI();
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/BaseHandlerInterceptor] preHandle() -"+ param_request_url);	}
		
		/*
		Boolean param_secure = req.isSecure();
		if(param_secure == true) {
			String queryString = (req.getQueryString() != null) ? "?"+ req.getQueryString() : "";
			res.sendRedirect("http://"+ req.getServerName() + req.getRequestURI() + queryString);
			return false;
		}
		*/
		
		String ua = req.getHeader("User-Agent").replace("WOW64; ", "");
		System.out.println("[USERAGENT]" + ua);
		Boolean pagemove = false;
		if(ua.indexOf("MSIE 7.0; Windows NT 5.1; Trident/4.0") > -1) { pagemove = true; } // XP , ie7
		if(ua.indexOf("MSIE 8.0; Windows NT 5.1; Trident/4.0") > -1) { pagemove = true; } // XP , ie8
		if(ua.indexOf("MSIE 7.0; Windows NT 6.0; Trident/4.0") > -1) { pagemove = true; } // Vista , ie8(with ie7)
		if(ua.indexOf("MSIE 8.0; Windows NT 6.0; Trident/4.0") > -1) { pagemove = true; } // Vista , ie8
		if(ua.indexOf("MSIE 8.0; Windows NT 6.1; Trident/4.0") > -1) { pagemove = true; } // Win7 , ie8
		if(ua.indexOf("MSIE 7.0; Windows NT 6.1; Trident/4.0") > -1) { pagemove = true; } // Win7 , ie7
		// MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0;
		if(pagemove) { res.sendRedirect("/browser"); return false; } 
		
		if(param_request_url.indexOf("/admission/sub") > -1) { 
	        req.setAttribute("recentUrl", param_request_url);
			System.out.println("sub not intercepter");
		}else {
	        req.setAttribute("serverDate", _Date.getNow("yyyyMMdd"));
	        req.setAttribute("recentUrl", param_request_url);

	        Boolean cookieYN = _Cookie.isTokenCookie(req, COOKIE_NAME);
	        req.setAttribute("cookieYN", cookieYN);

	        // 援ы삎�궗�씠�듃�뿉�꽌 濡쒓렇�븘�썐�뻽�쓣�븣 泥댄겕�빐�꽌 ���몴�솃�룄 濡쒓렇�븘�썐 �떆�궓�떎. 
	        Boolean cookieYnOld = _Cookie.isTokenCookie(req, COOKIE_OLD_NAME);
	        if(cookieYN == true && cookieYnOld == false) {
	    		res.sendRedirect("/logout?preURL="+ SITE_ROOT_MATH);
	    		return false;
	        }
	        
	        if(cookieYN) { 
            	String[] cookieData = _Cookie.getTokenData(req, _Cookie.getCookieStr(req.getCookies(), COOKIE_NAME));
            	
            	if(cookieData[0].equals("0")){
            		Object cookieObj = JSONObject.fromObject(cookieData[1]); 
            		Map<String, Object> cookieMap = _Response.formatJsonToMap(cookieObj);
            		
            		if(cookieMap.get("EN_PASS_WD") == null) { res.sendRedirect("/logout?preURL=/"); return false; }
            		
            		// 泥댄겕 
            		req.setAttribute("cookieUserNm", cookieMap.get("USER_NM").toString());
            		req.setAttribute("cookieUserSeq", cookieMap.get("USER_SEQ").toString());
            		req.setAttribute("cookieUserId", cookieMap.get("USER_ID").toString());
            		req.setAttribute("cookieUserType", cookieMap.get("GT_USER_TYPE").toString());
            		req.setAttribute("cookieEnPass", cookieMap.get("EN_PASS_WD").toString());
            		
            		// 異붽� �븳湲�紐� �씤肄붾뵫 �옉�뾽 
            		req.setAttribute("cookieUserEnNm", URLEncoder.encode(cookieMap.get("USER_NM").toString(),"UTF-8"));

            		if(_Cookie.isTokenCookie(req, COOKIE_INFO_NAME)) {
                		Map<String, String> cookiesub = Splitter.on("&").withKeyValueSeparator("=").split(_Cookie.getCookieStr(req.getCookies(), COOKIE_INFO_NAME));
                		req.setAttribute("cookieUserCourse", cookiesub.get("USER_COURSE_INFO").toString());
                		req.setAttribute("cookieUserFcYn", cookiesub.get("USER_DEPT_INFO").toString());
            		}else {
                		req.setAttribute("cookieUserCourse", "");
                		req.setAttribute("cookieUserFcYn", "");
            		}
            		
            		if(_Cookie.isTokenCookie(req, COOKIE_PAID_NAME)) {
                		Map<String, String> cookiePaid = Splitter.on("&").withKeyValueSeparator("=").split(_Cookie.getCookieStr(req.getCookies(), COOKIE_PAID_NAME));
                		req.setAttribute("cookieUserPaid", cookiePaid.get("PAID").toString());
            		}else {
                		req.setAttribute("cookieUserPaid", "");
            		}
            	}else {
                	System.out.println(">>"+cookieData[0] +"/"+ cookieData[1]);
            		res.sendRedirect("/logout?preURL=/login&msg="+ URLEncoder.encode(cookieData[1]));
            		return false;
            	}
	        }
		}
		return super.preHandle(req, res, handler);
	}
}

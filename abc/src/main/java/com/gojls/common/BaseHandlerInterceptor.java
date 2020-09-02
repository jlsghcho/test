package com.gojls.common;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gojls.common.model.User;
import com.gojls.util._Cookie;
import com.gojls.util._Response;
import gojlslib.util.CookieUtil;
import gojlslib.util.CustomProp;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class BaseHandlerInterceptor extends HandlerInterceptorAdapter {
	//private static final String PORT_FOR_HTTPS = "443";
	private static final Logger LOGGER = LoggerFactory.getLogger(BaseHandlerInterceptor.class);
	@Value("#{globalContext['COOKIE_URL']?:''}") private String COOKIE_URL;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String domain = request.getServerName();
		String queryString = "";
		if(request.getQueryString() != null) { queryString = "?" + request.getQueryString(); }

		String requestURI = request.getRequestURI();
		boolean secure = request.isSecure();
		String referrer = request.getHeader("referrer");

		//String httpUrl = "http://" + domain + requestURI + queryString;
		//String httpsUrl = "https://" + domain + ":" + PORT_FOR_HTTPS + requestURI + queryString;

		
		// 쿠키 처리
		CustomProp cookieProp = CookieUtil.getCookie(request.getCookies(), "jlsuser");
		
		//대표홈 리뉴얼 이후 jls쿠키 사용 20180226 Rachel 
		Boolean cookieJLS_YN = _Cookie.isTokenCookie(request, "jls");

		String cookieUserNm = "";
		String cookieUserSeq = "";
		String cookieUserId = "";
		String cookieUserType = "";

		if(cookieJLS_YN) {
			String[] cookieJLS_Data = _Cookie.getTokenData(request, _Cookie.getCookieStr(request.getCookies(), "jls"));

			if(cookieJLS_Data[0].equals("0")){
				Object cookieObj = JSONObject.fromObject(cookieJLS_Data[1]);
				Map<String, Object> cookieMap = _Response.formatJsonToMap(cookieObj);

				cookieUserNm = cookieMap.get("USER_NM").toString();
				cookieUserSeq = cookieMap.get("USER_SEQ").toString();
				cookieUserId = cookieMap.get("USER_ID").toString();
				cookieUserType = cookieMap.get("GT_USER_TYPE").toString();

				User user = new User(cookieUserSeq, cookieUserId, cookieUserNm, cookieUserType);
				request.setAttribute("commonUser", user);
			}
		}

		request.setAttribute("cookieYN", cookieJLS_YN);
		request.setAttribute("cookieUserNm", cookieUserNm);
		request.setAttribute("cookieUserSeq", cookieUserSeq);
		request.setAttribute("cookieUserId", cookieUserId);
		request.setAttribute("cookieUserType", cookieUserType);

		LOGGER.info("domain: " + domain);
		LOGGER.info("requestURI: " + requestURI);
		LOGGER.info("referrer: " + referrer);

		// Admin Login Cookie Add
		String contextPath = request.getServletContext().getContextPath();
		LOGGER.info("contextPath: " + contextPath);
		
		CustomProp cookieProp_event = CookieUtil.getCookie(request.getCookies(), "eventadm");		
		if(requestURI.startsWith("/report")){
		
			if (cookieProp_event != null){ 
				request.setAttribute("cookieProp_event", cookieProp_event);
			}
			else{
				response.sendRedirect(contextPath + "/admin/signIn");
				return false;
			}
		}
		else if(requestURI.startsWith("/musichero") || requestURI.startsWith("/grammar") || requestURI.startsWith("/h1k") 
				|| requestURI.startsWith("/1000hours") ||requestURI.startsWith("/ad") || requestURI.startsWith("/event") 
				||requestURI.startsWith("/chess") || requestURI.startsWith("/roulette") || requestURI.startsWith("/song") 
				|| requestURI.startsWith("/storyknight")){
			if(cookieProp != null){
				request.setAttribute("cookieProp", cookieProp);
				/*
				if(secure){
					response.sendRedirect(httpUrl);
					return false;
				}else{
					request.setAttribute("cookieProp", cookieProp);
				}
				*/
			}
		} else if(requestURI.equals("/favicon.ico")) {
			return true;
		} else {
			if(cookieProp != null){
				request.setAttribute("cookieProp", cookieProp);
			}
			
			/*
			// 실서버용
			if(!secure && !domain.contains("lcevent.gojls.com") && !domain.contains("devevent.gojls.com") && !domain.startsWith("220.85.55.")) {
				response.sendRedirect(httpsUrl);
				return false;
			}
			*/
		}
		
		if( !requestURI.equals("/") &&
			!requestURI.startsWith("/resources/") &&
			!requestURI.startsWith("/admin/") &&			
			!requestURI.startsWith("/report") &&
			!requestURI.startsWith("/dlive") &&
			!requestURI.startsWith("/home") &&
			!requestURI.startsWith("/ace") &&
			!requestURI.startsWith("/h1k") &&
			!requestURI.startsWith("/1000hours") &&
			!requestURI.startsWith("/chess") &&
			!requestURI.startsWith("/event") &&
			!requestURI.startsWith("/ad") &&
			!requestURI.startsWith("/song") &&
			!requestURI.startsWith("/grammar") &&
			!requestURI.startsWith("/storyknight") &&
			!requestURI.startsWith("/musichero") &&
			!requestURI.equals("/roulette") && 
			!requestURI.startsWith("/roulette/")) {
			response.sendRedirect(contextPath + "/");
			return false;
		}

		return true;
	}
}
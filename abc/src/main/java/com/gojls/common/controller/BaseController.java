package com.gojls.common.controller;

import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;

public class BaseController {
	protected final Logger LOGGER = LoggerFactory.getLogger(getClass());
	protected final Gson GSON = new GsonBuilder().setPrettyPrinting().create();

	@Value("#{globalContext['SITE_URL']}") protected String siteUrl;

	protected void getMessageView(HttpServletResponse response, final String msg, final String script) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		ServletOutputStream outs = response.getOutputStream();
		outs.println("<script type='text/javascript'>");
		if(!msg.equals("")) { outs.println("alert(\"" + new String(msg.getBytes("utf-8"), "8859_1") + "\");"); }

		outs.println(new String(script.getBytes(), "8859_1"));
		outs.println("</script>");
		outs.flush();
	}

	protected String entryLog(HttpServletRequest request) {
		StringBuilder stringBuilder = new StringBuilder();

		stringBuilder.append("entryLog\n[").append(request.getMethod()).append("] requestURI: ").append(request.getRequestURI()).append('\n');

		Map<String, String[]> parameterMap = request.getParameterMap();
		if(parameterMap == null) {
			stringBuilder.append("parameterMap is null.");
		} else if(parameterMap.size() == 0) {
			stringBuilder.append("parameterMap is empty.");
		} else {
			stringBuilder.append("parameterMap:\n");

			for(String key : parameterMap.keySet()) {
				stringBuilder.append("\t\"").append(key).append("\": ");

				String[] values = parameterMap.get(key);
				if(values == null) {
					stringBuilder.append("NULL");
				} else if(values.length == 0) {
					stringBuilder.append("EMPTY");
				} else if(values.length == 1) {
					stringBuilder.append('"').append(values[0]).append('"');
				} else {
					stringBuilder.append(arrayToString(values));
				}

				stringBuilder.append('\n');
			}
		}

		return stringBuilder.toString();
	}

	protected void addScript(ModelAndView modelAndView, String script) {
		final String NAME_FOR_SCRIPT = "script";

		LOGGER.debug("Adding script with name \"" + NAME_FOR_SCRIPT + "\":" + script);
		modelAndView.addObject(NAME_FOR_SCRIPT, script);
	}

	public static String arrayToString(Object[] objects) {
		if(objects == null) { return "null"; }

		int iMax = objects.length - 1;
		if(iMax == -1) { return "[]"; }

		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append('[');
		for(int i = 0; ; i++) {
			Object object = objects[i];
			if(object instanceof String) {
				stringBuilder.append('"').append(object).append('"');
			} else {
				stringBuilder.append(String.valueOf(object));
			}

			if(i == iMax) { return stringBuilder.append(']').toString(); }

			stringBuilder.append(", ");
		}
	}
}
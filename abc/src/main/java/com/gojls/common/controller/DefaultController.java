package com.gojls.common.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DefaultController extends BaseController {
	@GetMapping("/")
	public void getRoot(HttpServletRequest request, HttpServletResponse response) throws IOException {
		LOGGER.debug("Request for \"" + request.getRequestURI() + "\" handled by " + DefaultController.class.getName() + '.');
		response.sendRedirect("/roulette");
	}
}
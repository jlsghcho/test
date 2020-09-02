package com.gojls.math.common.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

public class BaseController {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("#{globalContext['COOKIE_NAME']?:'jls'}") protected String COOKIE_NAME;
	@Value("#{globalContext['COOKIE_INFO_NAME']?:'jlsinfo'}") protected String COOKIE_INFO_NAME;	
}

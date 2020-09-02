package com.gojls.common.helpers.encoding;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EncodingHelper {
	private static final Logger LOGGER = LoggerFactory.getLogger(EncodingHelper.class);
	private static final String DEFAULT_MULTIPART_CHARSET = "iso-8859-1";
	private static final String DESIRED_CHARSET = "UTF-8";

	public static String convert(String source) {
		try {
			return new String(source.getBytes(DEFAULT_MULTIPART_CHARSET), DESIRED_CHARSET);
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);
			return source;
		}
	}
}

package com.gojls.common.helpers.encryption;

import gojlslib.util.AesUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Encryption {
	private static final Logger LOGGER = LoggerFactory.getLogger(Encryption.class);

	public static String decryptUserSequence(String encryptedUserSequence) {
		String userSequence;
		if(encryptedUserSequence == null) {
			userSequence = null;
		} else {
			try {
				userSequence = AesUtil.decrypt(encryptedUserSequence);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				userSequence = null;
			}
		}

		return userSequence;
	}
}

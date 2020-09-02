package com.gojls.common.helpers.upload;

public class UploadingException extends RuntimeException {
	public UploadingException(String message) { super(message); }
	public UploadingException(String message, Throwable cause) { super(message, cause); }
}

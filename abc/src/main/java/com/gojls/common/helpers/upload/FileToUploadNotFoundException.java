package com.gojls.common.helpers.upload;

public class FileToUploadNotFoundException extends UploadingException {
    public FileToUploadNotFoundException(String message) { super(message); }
    public FileToUploadNotFoundException(String message, Throwable cause) { super(message, cause); }
}

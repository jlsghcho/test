package com.gojls.dlive;

import java.util.List;

public class UploadResult {
	private boolean success;
	private List<String> messages;

	public UploadResult(boolean success, List<String> messages) {
		this.success = success;
		this.messages = messages;
	}

	public boolean isSuccessful() { return success; }
	public List<String> getMessages() { return messages; }
}

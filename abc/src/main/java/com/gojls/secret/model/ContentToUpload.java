package com.gojls.secret.model;

public class ContentToUpload {
	private long id;
	private String text;
	private String imageUrl;
	private String userSequence;
	private String userName;

	private ContentToUpload(String userSequence, String userName) {
		this.userSequence = userSequence;
		this.userName = userName;
	}
	public ContentToUpload(String userSequence, String userName, String text) {
		this(userSequence, userName);

		this.text = text;
	}
	public ContentToUpload(String userSequence, String userName, String imageDescription, String imageUrl) {
		this(userSequence, userName, imageDescription);

		this.imageUrl = imageUrl;
	}

	public long getId() { return id; }
	public String getText() { return text; }
	public String getImageUrl() { return imageUrl; }
	public String getUserSequence() { return userSequence; }
	public String getUserName() { return userName; }

	public void setId(long id) { this.id = id; }
}

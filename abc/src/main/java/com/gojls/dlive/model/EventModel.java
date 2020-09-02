package com.gojls.dlive.model;

public class EventModel {
	private int eventSeq;
	private String eventTitle;	
	private String uploadStartDate;
	private String uploadEndDate;
	private String winnerAnnDate;
	private String prizeURL;
	private String winnerAnnURL;
	private String visitCount;
	

	public int getEventSeq() {
		return eventSeq;
	}
	
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	
	public String getEventTitle() {
		return eventTitle;
	}
	
	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}
	
	
	public String getUploadStartDate() {
		return uploadStartDate;
	}
	
	public void setUploadStartDate(String uploadStartDate) {
		this.uploadStartDate = uploadStartDate;
	}
	
	public String getUploadEndDate() {
		return uploadEndDate;
	}
	
	public void setUploadEndDate(String uploadEndDate) {
		this.uploadEndDate = uploadEndDate;
	}
	
	public String getWinnerAnnDate() {
		return winnerAnnDate;
	}
	
	public void setWinnerAnnDate(String winnerAnnDate) {
		this.winnerAnnDate = winnerAnnDate;
	}
	
	public String getPrizeURL() {
		return prizeURL;
	}
	
	public void setPrizeURL(String prizeURL) {
		this.prizeURL = prizeURL;
	}
	
	public String getWinnerAnnURL() {
		return winnerAnnURL;
	}
	
	public void setWinnerAnnURL(String winnerAnnURL) {
		this.winnerAnnURL = winnerAnnURL;
	}

	public String getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(String visitCount) {
		this.visitCount = visitCount;
	}

	
}

package com.gojls.dlive.model;

public class EventList {
	private int eventSeq;
	private String eventTitle;	
	private String winnerAnnounceURL;
	
	
	public String getWinnerAnnounceURL() {
		return winnerAnnounceURL;
	}
	public void setWinnerAnnounceURL(String winnerAnnounceURL) {
		this.winnerAnnounceURL = winnerAnnounceURL;
	}
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
	
}

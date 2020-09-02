package com.gojls.ems.gwizard.model;

public class EventHistoryModel extends EventMovieModel {
	private int eventHistorySeq;
	private int eventUserSeq;
	private int eventMovieSeq;
	private int status;
	private String regUserSeq;
	private String regUserNm;
	
	public int getEventHistorySeq() {
		return eventHistorySeq;
	}
	public void setEventHistorySeq(int eventHistorySeq) {
		this.eventHistorySeq = eventHistorySeq;
	}
	public int getEventUserSeq() {
		return eventUserSeq;
	}
	public void setEventUserSeq(int eventUserSeq) {
		this.eventUserSeq = eventUserSeq;
	}
	public int getEventMovieSeq() {
		return eventMovieSeq;
	}
	public void setEventMovieSeq(int eventMovieSeq) {
		this.eventMovieSeq = eventMovieSeq;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getRegUserSeq() {
		return regUserSeq;
	}
	public void setRegUserSeq(String regUserSeq) {
		this.regUserSeq = regUserSeq;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
}

package com.gojls.ems.event.model;

public class EmsEventModel {

	private int emsEventSeq;
	private String eventType;
	private String eventTemplate;
	private String title;
	
	private String enrolled;	
	private String enrolledCourse;
	
	private int eventState;
	private String eventOpenDt;
	private String eventCloseDt;	
	private String activityStartDt;
	private String activityEndDt;	
	private String winnerAnnounceDt;
	
	private int openState;
	private String openDt1;
	private String openDt2;
	private String openDt3;
	
	private String eventUrl;
	private String winnerAnnounceUrl;
	
	private int viewCnt;
	private int activityCnt;
	
	private String userSeq;
	
	public int getOpenState() {
		return openState;
	}
	public void setOpenState(int openState) {
		this.openState = openState;
	}
	public int getEventState() {
		return eventState;
	}
	public void setEventState(int eventState) {
		this.eventState = eventState;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public int getEmsEventSeq() {
		return emsEventSeq;
	}
	public void setEmsEventSeq(int emsEventSeq) {
		this.emsEventSeq = emsEventSeq;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public String getEventTemplate() {
		return eventTemplate;
	}
	public void setEventTemplate(String eventTemplate) {
		this.eventTemplate = eventTemplate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEnrolled() {
		return enrolled;
	}
	public void setEnrolled(String enrolled) {
		this.enrolled = enrolled;
	}
	public String getEnrolledCourse() {
		return enrolledCourse;
	}
	public void setEnrolledCourse(String enrolledCourse) {
		this.enrolledCourse = enrolledCourse;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public int getActivityCnt() {
		return activityCnt;
	}
	public void setActivityCnt(int activityCnt) {
		this.activityCnt = activityCnt;
	}
	public String getEventOpenDt() {
		return eventOpenDt;
	}
	public void setEventOpenDt(String eventOpenDt) {
		this.eventOpenDt = eventOpenDt;
	}
	public String getEventCloseDt() {
		return eventCloseDt;
	}
	public void setEventCloseDt(String eventCloseDt) {
		this.eventCloseDt = eventCloseDt;
	}
	public String getActivityStartDt() {
		return activityStartDt;
	}
	public void setActivityStartDt(String activityStartDt) {
		this.activityStartDt = activityStartDt;
	}
	public String getActivityEndDt() {
		return activityEndDt;
	}
	public void setActivityEndDt(String activityEndDt) {
		this.activityEndDt = activityEndDt;
	}
	public String getWinnerAnnounceDt() {
		return winnerAnnounceDt;
	}
	public void setWinnerAnnounceDt(String winnerAnnounceDt) {
		this.winnerAnnounceDt = winnerAnnounceDt;
	}
	public String getEventUrl() {
		return eventUrl;
	}
	public void setEventUrl(String eventUrl) {
		this.eventUrl = eventUrl;
	}
	public String getWinnerAnnounceUrl() {
		return winnerAnnounceUrl;
	}
	public void setWinnerAnnounceUrl(String winnerAnnounceUrl) {
		this.winnerAnnounceUrl = winnerAnnounceUrl;
	}
	public String getOpenDt1() {
		return openDt1;
	}
	public void setOpenDt1(String openDt1) {
		this.openDt1 = openDt1;
	}
	public String getOpenDt2() {
		return openDt2;
	}
	public void setOpenDt2(String openDt2) {
		this.openDt2 = openDt2;
	}
	public String getOpenDt3() {
		return openDt3;
	}
	public void setOpenDt3(String openDt3) {
		this.openDt3 = openDt3;
	}
	
	
}

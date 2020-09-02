package com.gojls.ems.gwizard.model;

public class EventAttendanceModel {
	private int eventAttendanceSeq;
	private int eventUserSeq;
	private String accessDt;
	private String accessCnt;
	private String regUserSeq;
	private String regUserNm;
	
	public int getEventAttendanceSeq() {
		return eventAttendanceSeq;
	}
	public void setEventAttendanceSeq(int eventAttendanceSeq) {
		this.eventAttendanceSeq = eventAttendanceSeq;
	}
	public int getEventUserSeq() {
		return eventUserSeq;
	}
	public void setEventUserSeq(int eventUserSeq) {
		this.eventUserSeq = eventUserSeq;
	}
	public String getAccessDt() {
		return accessDt;
	}
	public void setAccessDt(String accessDt) {
		this.accessDt = accessDt;
	}
	public String getAccessCnt() {
		return accessCnt;
	}
	public void setAccessCnt(String accessCnt) {
		this.accessCnt = accessCnt;
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

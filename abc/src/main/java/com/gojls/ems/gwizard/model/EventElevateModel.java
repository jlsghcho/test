package com.gojls.ems.gwizard.model;

public class EventElevateModel {
	private int eventElevateSeq;
	private int eventUserSeq;
	private int oldLevelSeq;
	private int eventLevelSeq;
	private int quizCnt;
	private int answerCnt;
	private int status;
	private String quizArr;
	private String regUserSeq;
	private String regUserNm;
	
	public int getEventElevateSeq() {
		return eventElevateSeq;
	}
	public void setEventElevateSeq(int eventElevateSeq) {
		this.eventElevateSeq = eventElevateSeq;
	}
	public int getEventUserSeq() {
		return eventUserSeq;
	}
	public void setEventUserSeq(int eventUserSeq) {
		this.eventUserSeq = eventUserSeq;
	}
	public int getEventLevelSeq() {
		return eventLevelSeq;
	}
	public void setEventLevelSeq(int eventLevelSeq) {
		this.eventLevelSeq = eventLevelSeq;
	}
	public int getQuizCnt() {
		return quizCnt;
	}
	public void setQuizCnt(int quizCnt) {
		this.quizCnt = quizCnt;
	}
	public int getAnswerCnt() {
		return answerCnt;
	}
	public void setAnswerCnt(int answerCnt) {
		this.answerCnt = answerCnt;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getQuizArr() {
		return quizArr;
	}
	public void setQuizArr(String quizArr) {
		this.quizArr = quizArr;
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
	public int getOldLevelSeq() {
		return oldLevelSeq;
	}
	public void setOldLevelSeq(int oldLevelSeq) {
		this.oldLevelSeq = oldLevelSeq;
	}
}

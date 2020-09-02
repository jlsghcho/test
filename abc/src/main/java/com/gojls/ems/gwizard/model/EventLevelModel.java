package com.gojls.ems.gwizard.model;

public class EventLevelModel {
	private int eventLevelSeq;
	private int eventSeq;
	private String levelNm;
	private int nextLevelSeq;
	private String nextLevelNm;
	private int movieCnt;
	private int viewCnt;
	private int quizCnt;
	private int passCnt;
	private int stageNo;
	
	public int getEventLevelSeq() {
		return eventLevelSeq;
	}
	public void setEventLevelSeq(int eventLevelSeq) {
		this.eventLevelSeq = eventLevelSeq;
	}
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getLevelNm() {
		return levelNm;
	}
	public void setLevelNm(String levelNm) {
		this.levelNm = levelNm;
	}
	public int getNextLevelSeq() {
		return nextLevelSeq;
	}
	public void setNextLevelSeq(int nextLevelSeq) {
		this.nextLevelSeq = nextLevelSeq;
	}
	public String getNextLevelNm() {
		return nextLevelNm;
	}
	public void setNextLevelNm(String nextLevelNm) {
		this.nextLevelNm = nextLevelNm;
	}
	public int getMovieCnt() {
		return movieCnt;
	}
	public void setMovieCnt(int movieCnt) {
		this.movieCnt = movieCnt;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public int getQuizCnt() {
		return quizCnt;
	}
	public void setQuizCnt(int quizCnt) {
		this.quizCnt = quizCnt;
	}
	public int getPassCnt() {
		return passCnt;
	}
	public void setPassCnt(int passCnt) {
		this.passCnt = passCnt;
	}
	public int getStageNo() {
		return stageNo;
	}
	public void setStageNo(int stageNo) {
		this.stageNo = stageNo;
	}
}

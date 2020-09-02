package com.gojls.h1k.model;

public class SurveyModel {
	private int h1kSurveySaveSeq;
	private int h1kSurveySeq;
	private int h1kEventSeq;
	private String surveySysCode;
	private String surveyAnswer;
	private String surveyFinishYn;
	private String userSeq;
	private int addTime;
	private int addTimeSec;
	private String regTs;
	private String regUserSeq;
	private String regUserNm;
	private String gtStatsType;
	
	public int getH1kSurveySaveSeq() {
		return h1kSurveySaveSeq;
	}
	public void setH1kSurveySaveSeq(int h1kSurveySaveSeq) {
		this.h1kSurveySaveSeq = h1kSurveySaveSeq;
	}
	public int getH1kSurveySeq() {
		return h1kSurveySeq;
	}
	public void setH1kSurveySeq(int h1kSurveySeq) {
		this.h1kSurveySeq = h1kSurveySeq;
	}	
	public int getH1kEventSeq() {
		return h1kEventSeq;
	}
	public void setH1kEventSeq(int h1kEventSeq) {
		this.h1kEventSeq = h1kEventSeq;
	}	
	public String getSurveySysCode() {
		return surveySysCode;
	}
	public void setSurveySysCode(String surveySysCode) {
		this.surveySysCode = surveySysCode;
	}
	public String getSurveyAnswer() {
		return surveyAnswer;
	}
	public void setSurveyAnswer(String surveyAnswer) {
		this.surveyAnswer = surveyAnswer;
	}
	public String getSurveyFinishYn() {
		return surveyFinishYn;
	}
	public void setSurveyFinishYn(String surveyFinishYn) {
		this.surveyFinishYn = surveyFinishYn;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public int getAddTime() {
		return addTime;
	}	
	public int getAddTimeSec() {
		return addTimeSec;
	}
	public void setAddTimeSec(int addTimeSec) {
		this.addTimeSec = addTimeSec;
	}
	public void setAddTime(int addTime) {
		this.addTime = addTime;
	}
	public String getRegTs() {
		return regTs;
	}
	public void setRegTs(String regTs) {
		this.regTs = regTs;
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
	public String getGtStatsType() {
		return gtStatsType;
	}
	public void setGtStatsType(String gtStatsType) {
		this.gtStatsType = gtStatsType;
	}
}

package com.gojls.report.model;

public class MsuccRankingModel {
	private int eventSeq;
	private String uccTitle;
	private String uccReconCnt;
	private String uccReconCntDe;
	private String userNm;
	private String imageFilePath;
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getUccTitle() {
		return uccTitle;
	}
	public void setUccTitle(String uccTitle) {
		this.uccTitle = uccTitle;
	}
	public String getUccReconCnt() {
		return uccReconCnt;
	}
	public void setUccReconCnt(String uccReconCnt) {
		this.uccReconCnt = uccReconCnt;
	}
	public String getUccReconCntDe() {
		return uccReconCntDe;
	}
	public void setUccReconCntDe(String uccReconCntDe) {
		this.uccReconCntDe = uccReconCntDe;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getImageFilePath() {
		return imageFilePath;
	}
	public void setImageFilePath(String imageFilePath) {
		this.imageFilePath = imageFilePath;
	}
}

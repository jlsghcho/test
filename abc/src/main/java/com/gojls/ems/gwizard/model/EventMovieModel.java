package com.gojls.ems.gwizard.model;

public class EventMovieModel {
	private int eventMovieSeq;
	private int eventSeq;
	private String movieNm;
	private String movieUrl;
	private int groupSeq;
	private String groupNm;
	private int sortSeq;
	private int useYn;
	
	private int eventUserSeq;
	private int isOpen;
	private int viewCnt;
	
	private int groupCnt;
	private int leastTime;
	
	public int getEventMovieSeq() {
		return eventMovieSeq;
	}
	public void setEventMovieSeq(int eventMovieSeq) {
		this.eventMovieSeq = eventMovieSeq;
	}
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}
	public String getMovieUrl() {
		return movieUrl;
	}
	public void setMovieUrl(String movieUrl) {
		this.movieUrl = movieUrl;
	}
	public int getGroupSeq() {
		return groupSeq;
	}
	public void setGroupSeq(int groupSeq) {
		this.groupSeq = groupSeq;
	}
	public String getGroupNm() {
		return groupNm;
	}
	public void setGroupNm(String groupNm) {
		this.groupNm = groupNm;
	}
	public int getSortSeq() {
		return sortSeq;
	}
	public void setSortSeq(int sortSeq) {
		this.sortSeq = sortSeq;
	}
	public int getUseYn() {
		return useYn;
	}
	public void setUseYn(int useYn) {
		this.useYn = useYn;
	}
	public int getEventUserSeq() {
		return eventUserSeq;
	}
	public void setEventUserSeq(int eventUserSeq) {
		this.eventUserSeq = eventUserSeq;
	}
	public int getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(int isOpen) {
		this.isOpen = isOpen;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public int getGroupCnt() {
		return groupCnt;
	}
	public void setGroupCnt(int groupCnt) {
		this.groupCnt = groupCnt;
	}
	public int getLeastTime() {
		return leastTime;
	}
	public void setLeastTime(int leastTime) {
		this.leastTime = leastTime;
	}
	
}

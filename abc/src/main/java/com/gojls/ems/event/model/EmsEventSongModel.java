package com.gojls.ems.event.model;

public class EmsEventSongModel {
	
	private int eventSongSeq;	
	private String title;
	private String songType;
	private int orderNum;
	private String fileName;	
	private int playYn;
	private int playCnt;   
	private String groupFg;
	private int firstFg;
	private int lastFg;
		
	public int getEventSongSeq() {
		return eventSongSeq;
	}
	public void setEventSongSeq(int eventSongSeq) {
		this.eventSongSeq = eventSongSeq;
	}
	public String getSongType() {
		return songType;
	}
	public void setSongType(String songType) {
		this.songType = songType;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPlayYn() {
		return playYn;
	}
	public void setPlayYn(int playYn) {
		this.playYn = playYn;
	}
	public int getPlayCnt() {
		return playCnt;
	}
	public void setPlayCnt(int playCnt) {
		this.playCnt = playCnt;
	}
	public String getGroupFg() {
		return groupFg;
	}
	public void setGroupFg(String groupFg) {
		this.groupFg = groupFg;
	}
	public int getFirstFg() {
		return firstFg;
	}
	public void setFirstFg(int firstFg) {
		this.firstFg = firstFg;
	}
	public int getLastFg() {
		return lastFg;
	}
	public void setLastFg(int lastFg) {
		this.lastFg = lastFg;
	}	
	
}

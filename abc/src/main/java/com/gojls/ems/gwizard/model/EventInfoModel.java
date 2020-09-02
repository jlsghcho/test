package com.gojls.ems.gwizard.model;

public class EventInfoModel {
	private int eventSeq;
	private String eventNm;
	private String info;
	private String startDt;
	private String endDt;
	private String publicationDt;
	private String gtEventType;
	private int episodeSeq;
	private String eventUrl;
	private int eventState;
	
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getEventNm() {
		return eventNm;
	}
	public void setEventNm(String eventNm) {
		this.eventNm = eventNm;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getPublicationDt() {
		return publicationDt;
	}
	public void setPublicationDt(String publicationDt) {
		this.publicationDt = publicationDt;
	}
	public String getGtEventType() {
		return gtEventType;
	}
	public void setGtEventType(String gtEventType) {
		this.gtEventType = gtEventType;
	}
	public int getEpisodeSeq() {
		return episodeSeq;
	}
	public void setEpisodeSeq(int episodeSeq) {
		this.episodeSeq = episodeSeq;
	}
	public String getEventUrl() {
		return eventUrl;
	}
	public void setEventUrl(String eventUrl) {
		this.eventUrl = eventUrl;
	}
	public int getEventState() {
		return eventState;
	}
	public void setEventState(int eventState) {
		this.eventState = eventState;
	}
}

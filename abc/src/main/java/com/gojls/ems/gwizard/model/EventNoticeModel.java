package com.gojls.ems.gwizard.model;

public class EventNoticeModel {
	private int eventNoticeSeq;
	private int eventSeq;
	private String startDt;
	private String endDt;
	private String content;
	private int useYn;
	public int getEventNoticeSeq() {
		return eventNoticeSeq;
	}
	public void setEventNoticeSeq(int eventNoticeSeq) {
		this.eventNoticeSeq = eventNoticeSeq;
	}
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getUseYn() {
		return useYn;
	}
	public void setUseYn(int useYn) {
		this.useYn = useYn;
	}
	
}

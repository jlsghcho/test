package com.gojls.math.index.model;

public class NoticeModel {
    private String noticeTypeCode;
    private String title;
    private String imageUrl;
    private String registerDate;
    private String contents;
    private int deptSeq;
    private String tag;
    private int noticeNo;
    
	public String getNoticeTypeCode() {
		return noticeTypeCode;
	}
	public void setNoticeTypeCode(String noticeTypeCode) {
		this.noticeTypeCode = noticeTypeCode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(int deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

}

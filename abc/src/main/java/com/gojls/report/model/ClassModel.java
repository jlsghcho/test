package com.gojls.report.model;

public class ClassModel {

	private int clsSeq; 		// 반 일렬 번호
	private String clsNickNm;
	private String clsNm;	
	private int deptSeq;	
	private String tmanEmpSeq;
	private String tmanEmpNm;
	
	public int getClsSeq() {
		return clsSeq;
	}
	public void setClsSeq(int clsSeq) {
		this.clsSeq = clsSeq;
	}
	public String getClsNickNm() {
		return clsNickNm;
	}
	public void setClsNickNm(String clsNickNm) {
		this.clsNickNm = clsNickNm;
	}
	public String getClsNm() {
		return clsNm;
	}
	public void setClsNm(String clsNm) {
		this.clsNm = clsNm;
	}
	public int getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(int deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getTmanEmpSeq() {
		return tmanEmpSeq;
	}
	public void setTmanEmpSeq(String tmanEmpSeq) {
		this.tmanEmpSeq = tmanEmpSeq;
	}
	public String getTmanEmpNm() {
		return tmanEmpNm;
	}
	public void setTmanEmpNm(String tmanEmpNm) {
		this.tmanEmpNm = tmanEmpNm;
	}
}

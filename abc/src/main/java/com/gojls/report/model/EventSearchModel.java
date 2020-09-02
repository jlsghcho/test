package com.gojls.report.model;

public class EventSearchModel {

	private int	page;
	private int rowsPerPage;
	private String eventSeq;
	private String deptSeq;
	private String clsSeq;
	private String empSeq;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRowsPerPage() {
		return rowsPerPage;
	}
	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}
	public String getEventSeq(){
		return eventSeq;
	}
	public void setEventSeq(String eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getClsSeq() {
		return clsSeq;
	}
	public void setClsSeq(String clsSeq) {
		this.clsSeq = clsSeq;
	}
	public String getEmpSeq() {
		return empSeq;
	}
	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}

}

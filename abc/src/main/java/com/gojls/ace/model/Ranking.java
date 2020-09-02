package com.gojls.ace.model;

public class Ranking {
	
	private int sequence;
	private int totalCount;
	private String userSequence;
	private String userName;
	private String departmentSequence;
	private String departmentName;
	
	
	public Ranking(int sequence, int totalCount, String userSequence, String userName, 
			String departmentSequence, String departmentName  )
	{
		this.sequence = sequence;
		this.totalCount = totalCount;
		
		this.userSequence = userSequence;
		this.userName = userName;
		this.departmentSequence = departmentSequence;
		this.departmentName = departmentName;
	}
	
	
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public String getUserSequence() {
		return userSequence;
	}
	public void setUserSequence(String userSequence) {
		this.userSequence = userSequence;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDepartmentSequence() {
		return departmentSequence;
	}
	public void setDepartmentSequence(String departmentSequence) {
		this.departmentSequence = departmentSequence;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	
	

}


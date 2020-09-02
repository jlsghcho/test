package com.gojls.ace.model;

public class UserInfo {

	protected String userSequence;
	protected String userId;
	protected String userName;
	protected String grade;
	protected String schoolName;
	protected String deptSeq;
	protected String deptName;
	

	public UserInfo(String sequence, String id, String name, String gradeString, String schoolName, String deptSeq, String deptName) {
		this.userSequence = sequence;
		this.userId = id;
		this.userName = name;

		Grade grade = Grade.byCode(gradeString);
		if(grade == Grade.ELSE) {
			this.grade = gradeString;
		} else {
			this.grade = grade.DISPLAY_NAME;
		}

		this.schoolName = (schoolName == null? "": schoolName);
		this.deptSeq = deptSeq;
		this.deptName = deptName;
	}
	
	
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getUserSequence() {
		return userSequence;
	}
	public void setUserSequence(String userSequence) {
		this.userSequence = userSequence;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	
	
	public enum Grade {
		ELSE(""), 중등1("GD3007"), 중등2("GD3008"), 중등3("GD3009");

		private final String CODE;
		private final String DISPLAY_NAME;

		Grade(String code) {
			CODE = code;

			switch(CODE) {
			case "GD3007":
				DISPLAY_NAME = "1학년";
				break;
			case "GD3008":
				DISPLAY_NAME = "2학년";
				break;
			case "GD3009":
				DISPLAY_NAME = "3학년";
				break;
			case "GD1000":
				DISPLAY_NAME = "미진학";
				break;
			case "GD1013":
				DISPLAY_NAME = "성인";
				break;
			case "GD1014":
				DISPLAY_NAME = "유치원(어린이집)";
				break;
			case "GD1015":
				DISPLAY_NAME = "대학/대학생";
				break;
			case "GD1016":
				DISPLAY_NAME = "일반인";
				break;
			case "GD2001":
				DISPLAY_NAME = "초등1";
				break;
			case "GD2002":
				DISPLAY_NAME = "초등2";
				break;
			case "GD2003":
				DISPLAY_NAME = "초등3";
				break;
			case "GD2004":
				DISPLAY_NAME = "초등4";
				break;
			case "GD2005":
				DISPLAY_NAME = "초등5";
				break;
			case "GD2006":
				DISPLAY_NAME = "초등6";
				break;
			case "GD4010":
				DISPLAY_NAME = "고등1";
				break;
			case "GD4011":
				DISPLAY_NAME = "고등2";
				break;
			case "GD4012":
				DISPLAY_NAME = "고등3";
				break;
			case "GD5017":
				DISPLAY_NAME = "4세";
				break;
			case "GD5018":
				DISPLAY_NAME = "5세";
				break;
			case "GD5019":
				DISPLAY_NAME = "6세";
				break;
			case "GD5020":
				DISPLAY_NAME = "7세";
				break;
			default:
				DISPLAY_NAME = "";
			}
		}

		@Override
		public String toString() { return DISPLAY_NAME; }

		public static Grade byCode(String code) {
			for(Grade grade : Grade.values()) {
				if(grade.CODE.equals(code)) { return grade; }
			}

			return ELSE;
		}
	}
}

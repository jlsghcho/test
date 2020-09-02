package com.gojls.ace.model;

public class Teacher {
	
	protected String sequence;
	protected String teacherName;
	protected String teacherType;
	
	public Teacher(String teacherSeq, String teacheName, String teacherType)
	{
		this.sequence = teacherSeq;
		this.teacherName = teacheName;
		this.teacherType = teacheName;
	}
		
	public String getSequence() {
		return sequence;
	}

	public void setSequence(String sequence) {
		this.sequence = sequence;
	}

	public String getTeacherType() {
		return teacherType;
	}

	public void setTeacherType(String teacherType) {
		this.teacherType = teacherType;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

}

package com.gojls.ace.model;

import com.gojls.Global;
import com.gojls.ace.model.ContentNew.Type;

public class ContentNew extends UserInfo{
	
	private int sequence;
	private int eventSequence;
	private String type;
	private String questionType;
	private int questionNumber;
	
	private String pathToImage1;
	private String pathToImage2;
	private String comment;
	
	private String deptName;
	private String deptSequence;
	
	private String teacherName;
	private String teacherSequence;
	
	
	private boolean isMine;

	public ContentNew(int eventSequence, Type type, String questionTypeString, int questionNumber, 
			String region, String userSequence, String userId, String userName, String gradeString, String schoolName,
			String departmentName, String departmentSequence, String teacherName, String teacherSequence ) {
		
		this(-1, eventSequence, type.CODE, questionTypeString, questionNumber, 
				region, null, null, null, userSequence, userId, userName, gradeString, schoolName,
				departmentName, departmentSequence, teacherName, teacherSequence );
		
	}
	public ContentNew(int eventSequence, Type type, String questionTypeString, int questionNumber, 
			String region, String comment, String userSequence, String userId, String userName, String gradeString, String schoolName,
			String departmentName, String departmentSequence, String teacherName, String teacherSequence) {
		
		this(-1, eventSequence, type.CODE, questionTypeString, questionNumber, 
				region, null, null, comment, userSequence, userId, userName, gradeString, schoolName,
				departmentName, departmentSequence, teacherName, teacherSequence);
	}
	public ContentNew(int sequence, int eventSequence, String type, String questionType, int questionNumber, 
			String region, String pathToImage1, String pathToImage2, String userSequence, String userId, String userName, String gradeString, String schoolName, 
			String departmentName, String departmentSequence, String teacherName, String teacherSequence) {
		this(sequence, eventSequence, type, questionType, questionNumber, 
				region, pathToImage1, pathToImage2, null, userSequence, userId, userName, gradeString, schoolName,
				departmentName, departmentSequence, teacherName, teacherSequence);
	}
	public ContentNew(int sequence, int eventSequence, String type, String questionType, 
			int questionNumber, String region,String pathToImage1, String pathToImage2, String comment, String userSequence, String userId, String userName, String gradeString, String schoolName,
			String departmentName, String departmentSequence, String teacherName, String teacherSequence) {
		
		
		super(userSequence, userId, userName, gradeString, schoolName, departmentSequence, departmentName);

		this.sequence = sequence;
		this.eventSequence = eventSequence;
		this.type = type;
		this.questionType = questionType;
		this.questionNumber = questionNumber;
		this.pathToImage1 = Global.getRootDirectoryToDownload() + pathToImage1;
		this.pathToImage2 = Global.getRootDirectoryToDownload() + pathToImage2;
		this.comment = comment;
		this.deptName = departmentName;
		this.deptSeq = departmentSequence;
		this.teacherName = teacherName;
		this.teacherSequence = teacherSequence;
		super.userSequence = userSequence;
	}

	public int getSequence() { return this.sequence; }
	public int getEventSequence() { return this.eventSequence; }
	public String getType() { return this.type; }
	public String getQuestionType() { return this.questionType; }
	public int getQuestionNumber() { return this.questionNumber; }
	
	public String getPathToImage1() { return this.pathToImage1; }
	public String getPathToImage2() { return this.pathToImage2; }
	public String getComment() { return this.comment; }
	
	public String getDepartmentName() { return this.deptName; }
	public String getDeparttmentSequence() { return this.deptSequence; }
	public String getTeacherName() { return this.teacherName; }
	public String getTeacherSequence() { return this.teacherSequence; }

	public void setPathToImage1(String pathToImage1) { this.pathToImage1 = pathToImage1; }
	public void setPathToImage2(String pathToImage2) { this.pathToImage2 = pathToImage2; }
	public void decideOwnership(String userSequence) { isMine = (super.userSequence.equals(userSequence)); }

	public enum Type {
		UNKNOWN(""), REPORT("1"), ARREST("2");

		private final String CODE;

		Type(String code) { CODE = code; }

		public static Type byCode(String code) {
			for(Type type : Type.values()) {
				if(type.CODE.equals(code)) { return type; }
			}

			throw new IllegalArgumentException("\"" + code + "\" is illegal.");
		}
	}
}

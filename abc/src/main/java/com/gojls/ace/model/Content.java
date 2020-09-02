package com.gojls.ace.model;

import com.gojls.Global;

// Hannibal also hates to do this! (2017.05.17)
public class Content extends User {
	private int sequence;
	private int eventSequence;
	private String type;
	private String questionType;
	private int questionNumber;
	private String region;
	private String pathToImage1;
	private String pathToImage2;
	private String comment;

	private boolean isMine;

	public Content(int eventSequence, Type type, String questionTypeString, int questionNumber, String region, String userSequence, String userId, String userName, String gradeString, String schoolName) {
		this(-1, eventSequence, type.CODE, questionTypeString, questionNumber, region, null, null, null, userSequence, userId, userName, gradeString, schoolName);
	}
	public Content(int eventSequence, Type type, String questionTypeString, int questionNumber, String region, String comment, String userSequence, String userId, String userName, String gradeString, String schoolName) {
		this(-1, eventSequence, type.CODE, questionTypeString, questionNumber, region, null, null, comment, userSequence, userId, userName, gradeString, schoolName);
	}
	public Content(int sequence, int eventSequence, String type, String questionType, int questionNumber, String region, String pathToImage1, String pathToImage2, String userSequence, String userId, String userName, String gradeString, String schoolName) {
		this(sequence, eventSequence, type, questionType, questionNumber, region, pathToImage1, pathToImage2, null, userSequence, userId, userName, gradeString, schoolName);
	}
	public Content(int sequence, int eventSequence, String type, String questionType, int questionNumber, String region, String pathToImage1, String pathToImage2, String comment, String userSequence, String userId, String userName, String gradeString, String schoolName) {
		super(userSequence, userId, userName, gradeString, schoolName);

		this.sequence = sequence;
		this.eventSequence = eventSequence;
		this.type = type;
		this.questionType = questionType;
		this.questionNumber = questionNumber;
		this.region = region;
		this.pathToImage1 = Global.getRootDirectoryToDownload() + pathToImage1;
		this.pathToImage2 = Global.getRootDirectoryToDownload() + pathToImage2;
		this.comment = comment;
		super.userSequence = userSequence;
	}

	public int getSequence() { return sequence; }
	public int getEventSequence() { return eventSequence; }
	public String getType() { return type; }
	public String getQuestionType() { return questionType; }
	public int getQuestionNumber() { return questionNumber; }
	public String getRegion() { return region; }
	public String getPathToImage1() { return pathToImage1; }
	public String getPathToImage2() { return pathToImage2; }
	public String getComment() { return comment; }

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

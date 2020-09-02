package com.gojls.ems.gwizard.model;

public class EventQuizModel {
	private int eventQuizSeq;
	private int eventSeq;
	private int eventMovieSeq;
	private String question;
	private String questionKr;
	private String example;
	private String answer;
	private int useYn;
	private String explanation;
	
	private String replace1;
	private String replace2;
	
	public int getEventQuizSeq() {
		return eventQuizSeq;
	}
	public void setEventQuizSeq(int eventQuizSeq) {
		this.eventQuizSeq = eventQuizSeq;
	}
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	public int getEventMovieSeq() {
		return eventMovieSeq;
	}
	public void setEventMovieSeq(int eventMovieSeq) {
		this.eventMovieSeq = eventMovieSeq;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getExample() {
		return example;
	}
	public void setExample(String example) {
		this.example = example;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public int getUseYn() {
		return useYn;
	}
	public void setUseYn(int useYn) {
		this.useYn = useYn;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public String getQuestionKr() {
		return questionKr;
	}
	public void setQuestionKr(String questionKr) {
		this.questionKr = questionKr;
	}
	public String getReplace1() {
		return replace1;
	}
	public void setReplace1(String replace1) {
		this.replace1 = replace1;
	}
	public String getReplace2() {
		return replace2;
	}
	public void setReplace2(String replace2) {
		this.replace2 = replace2;
	}
	
}

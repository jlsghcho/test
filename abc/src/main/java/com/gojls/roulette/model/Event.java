package com.gojls.roulette.model;

import com.gojls.common.model.PeriodBase;

public class Event extends PeriodBase {
	private long sequence;
	private String name;

	private String regUserSeq;
	private String regUserNm;
	private String regTs;
	private String modUserSeq;
	private String modUserNm;
	private String modTs;

	public Event(long sequence, String name, String startDt, String endDt) {
		super(startDt, endDt);

		this.sequence = sequence;
		this.name = name;
	}

	@Override
	public String toString() { return String.format("(" + sequence + ") " + name + ": "  + DATE_TIME_FORMATTER.format(STARTS_AT) + " ~ " + DATE_TIME_FORMATTER, ENDS_AT); }

	public long getSequence() { return sequence; }
	public void setSequence(long sequence) { this.sequence = sequence; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getRegUserSeq() { return regUserSeq; }
	public void setRegUserSeq(String regUserSeq) { this.regUserSeq = regUserSeq; }
	public String getRegUserNm() { return regUserNm; }
	public void setRegUserNm(String regUserNm) { this.regUserNm = regUserNm; }
	public String getRegTs() { return regTs; }
	public void setRegTs(String regTs) { this.regTs = regTs; }
	public String getModUserSeq() { return modUserSeq; }
	public void setModUserSeq(String modUserSeq) { this.modUserSeq = modUserSeq; }
	public String getModUserNm() { return modUserNm; }
	public void setModUserNm(String modUserNm) { this.modUserNm = modUserNm; }
	public String getModTs() { return modTs; }
	public void setModTs(String modTs) { this.modTs = modTs; }
}
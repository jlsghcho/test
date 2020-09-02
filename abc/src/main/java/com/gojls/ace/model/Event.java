package com.gojls.ace.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Event {
	
	private int sequence;
	private String name;
	private LocalDateTime startDateTime;
	private LocalDateTime endDateTime;
	private LocalDateTime announcedDateTime;
	
/*	public Event(int sequence, String name, String startDateString, String endDateString) {
		this.sequence = sequence;
		this.name = name;

		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("uuuuMMdd");

		LocalDate startDate = LocalDate.parse(startDateString, dateTimeFormatter);
		startDateTime = LocalDateTime.of(startDate, LocalTime.of(0, 0));

		LocalDate endDate = LocalDate.parse(endDateString, dateTimeFormatter);
		endDateTime = LocalDateTime.of(endDate, LocalTime.of(23, 59, 59));
	}*/
	
	public Event(int sequence, String name, String startDateString, String endDateString, String annDateString){
		
		this.sequence = sequence;
		this.name = name;
		
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("uuuuMMdd");
		LocalDate startDate = LocalDate.parse(startDateString, dateTimeFormatter);
		startDateTime = LocalDateTime.of(startDate, LocalTime.of(0, 0));

		LocalDate endDate = LocalDate.parse(endDateString, dateTimeFormatter);
		endDateTime = LocalDateTime.of(endDate, LocalTime.of(23, 59, 59));
		
		if(annDateString != null)
		{
			LocalDate announcedDate = LocalDate.parse(annDateString, dateTimeFormatter);
			announcedDateTime = LocalDateTime.of(announcedDate, LocalTime.of(0, 0));
		}
		
		
	}
	
	public int getSequence() { return sequence; }
	public String getName() { return name; }
	public LocalDateTime getStartDateTime() { return startDateTime; }
	public LocalDateTime getEndDateTime() { return endDateTime; }
	public LocalDateTime getAnnouncedDateTime() {	return announcedDateTime; }
	
	public boolean isBeforePeriod() { return LocalDateTime.now().isBefore(startDateTime); }
	public boolean isItPeriod() { return !isBeforePeriod() && !isAfterPeriod(); }
	public boolean isAfterPeriod() { return LocalDateTime.now().isAfter(endDateTime); }
	
}

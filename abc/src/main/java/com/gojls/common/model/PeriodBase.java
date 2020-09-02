package com.gojls.common.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

//import com.sun.istack.internal.NotNull;

public abstract class PeriodBase {
	public static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd");

	//@NotNull
	protected final LocalDate STARTS_AT;
	//@NotNull
	protected final LocalDate ENDS_AT;

	public PeriodBase( String startDt,  String endDt) { this(convert(startDt), convert(endDt)); }
	public PeriodBase( LocalDate startsAt,  LocalDate endsAt) {
		STARTS_AT = startsAt;
		ENDS_AT = endsAt;
	}

	public boolean hasStarted() { return hasStarted(LocalDate.now()); }
	public boolean hasStarted(LocalDate localDateTime) { return !localDateTime.isBefore(STARTS_AT); }
	public boolean hasEnded() { return hasEnded(LocalDate.now()); }
	public boolean hasEnded(LocalDate localDateTime) { return localDateTime.isAfter(ENDS_AT); }
	public boolean isDuringPeriod() { return (hasStarted() && !hasEnded()); }
	public boolean isDuringPeriod(LocalDate localDateTime) { return (hasStarted(localDateTime) && !hasEnded(localDateTime)); }

	private static LocalDate convert(String eightLetterDateString) { return LocalDate.parse(eightLetterDateString, DATE_TIME_FORMATTER); }
}
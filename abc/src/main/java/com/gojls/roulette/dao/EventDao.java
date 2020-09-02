package com.gojls.roulette.dao;

import java.util.List;

import com.gojls.roulette.model.Event;
//import com.sun.istack.internal.Nullable;

public interface EventDao {
	Event selectLastStartedEvent();
	Event selectOngoingEvent();
	Event selectUpcomingEvent();
	List<Event> selectEvents(long sequence);
}
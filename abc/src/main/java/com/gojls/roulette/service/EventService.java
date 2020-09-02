package com.gojls.roulette.service;

import com.gojls.roulette.model.Event;
//import com.sun.istack.internal.Nullable;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface EventService {
	//@Nullable
	Event getLastStartedEvent();
	//@Nullable
	Event getOngoingEvent();
	//@Nullable
	Event getUpcomingEvent();
	Event getEvent(long sequence);
}
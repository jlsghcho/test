package com.gojls.roulette.service;

import java.util.List;

import com.gojls.roulette.dao.EventDao;
import com.gojls.roulette.model.Event;
//import com.sun.istack.internal.Nullable;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventServiceImpl implements EventService {
	private static final Logger LOGGER = LoggerFactory.getLogger(EventServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public EventServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }

	@Override
//	@Nullable
	public Event getLastStartedEvent() {
		EventDao eventDao = SQL_SESSION.getMapper(EventDao.class);
		return eventDao.selectLastStartedEvent();
	}
	@Override
	//@Nullable
	public Event getOngoingEvent() {
		EventDao eventDao = SQL_SESSION.getMapper(EventDao.class);
		return eventDao.selectOngoingEvent();
	}
	@Override
	//@Nullable
	public Event getUpcomingEvent() {
		EventDao eventDao = SQL_SESSION.getMapper(EventDao.class);
		return eventDao.selectUpcomingEvent();
	}
	@Override
	public Event getEvent(long sequence) {
		EventDao eventDao = SQL_SESSION.getMapper(EventDao.class);
		List<Event> events = eventDao.selectEvents(sequence);

		switch(events.size()) {
			case 0:
				LOGGER.info("No roulette event found for sequence " + sequence + '.');
				return null;
			default:
				LOGGER.warn("Multiple events found for sequence " + sequence + "; returning the first one.");
			case 1:
				return events.get(0);
		}
	}
}
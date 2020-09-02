package com.gojls.ems.gwizard.dao;

import java.util.List;
import java.util.Map;

import com.gojls.ems.gwizard.model.EventHistoryModel;
import com.gojls.ems.gwizard.model.EventMovieModel;
import com.gojls.ems.gwizard.model.EventUserModel;

public interface EventHistoryDao {
	public List<EventMovieModel> selectEventHistoryList(Map<String, Object> map);
	public EventUserModel selectEventHistoryCnt(EventHistoryModel eventHistoryModel);
	public int insertEventHistory(EventHistoryModel eventHistoryModel);	
	public int updateEventHistory(EventHistoryModel eventHistoryModel);
}

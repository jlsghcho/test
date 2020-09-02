package com.gojls.ems.gwizard.service;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.ems.gwizard.model.EventElevateModel;
import com.gojls.ems.gwizard.model.EventHistoryModel;
import com.gojls.ems.gwizard.model.EventUserModel;

@Transactional
public interface EventHistoryService {
	public Map<String, Object> selectEventHistory(Map<String, Object> map) throws Exception;
	public Map<String, Object> insertEventHistory(EventUserModel eventUserModel, EventHistoryModel eventHistoryModel);
	public Map<String, Object> updateEventHistory(EventUserModel eventUserModel, EventHistoryModel eventHistoryModel) throws Exception;
	public Map<String, Object> updateEventElevate(EventUserModel eventUserModel, EventElevateModel eventElevateModel) throws Exception;
}

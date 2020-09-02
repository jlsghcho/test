package com.gojls.ems.gwizard.dao;

import java.util.List;

import com.gojls.ems.gwizard.model.EventNoticeModel;

public interface EventNoticeDao {
	public List<EventNoticeModel> selectEventNoticeList(EventNoticeModel eventNoticeModel);
}

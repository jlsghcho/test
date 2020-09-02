package com.gojls.ems.gwizard.service;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.ems.gwizard.model.EventAttendanceModel;

@Transactional
public interface EventAttendanceService {
	public Map<String, Object> selectEventAttendance(Map<String, Object> map) throws Exception;
	public void mergeEventAttendance(EventAttendanceModel eventAttendanceModel);
}

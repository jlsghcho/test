package com.gojls.ems.gwizard.dao;

import java.util.List;
import java.util.Map;

import com.gojls.ems.gwizard.model.EventAttendanceModel;

public interface EventAttendanceDao {
	public List<EventAttendanceModel> selectEventAttendanceList(Map<String, Object> map);
	public int selectEventAttendanceCnt(EventAttendanceModel eventAttendanceModel);
	public void mergeEventAttendance(EventAttendanceModel eventAttendanceModel);
}

package com.gojls.ems.gwizard.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gojls.ems.gwizard.dao.EventAttendanceDao;
import com.gojls.ems.gwizard.dao.EventUserDao;
import com.gojls.ems.gwizard.model.EventAttendanceModel;
import com.gojls.ems.gwizard.model.EventUserModel;

@Service
public class EventAttendanceServiceImpl implements EventAttendanceService {
	@Autowired
	@Qualifier("orasql")
	private SqlSession oraSqlSession; 
	
	public Map<String, Object> selectEventAttendance(Map<String, Object> map) throws Exception{
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventAttendanceDao eventAttendanceOra = oraSqlSession.getMapper(EventAttendanceDao.class);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int eventSeq = (map.get("eventSeq") == null)?0:(Integer)map.get("eventSeq");
		String userSeq = (map.get("userSeq")==null)?"":String.valueOf(map.get("userSeq"));
		
		EventUserModel eventUserModel = new EventUserModel();
		eventUserModel.setEventSeq(eventSeq);
		eventUserModel.setUserSeq(userSeq);
		EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
		
		if(eventUserInfo != null) {
			map.put("eventUserSeq", eventUserInfo.getEventUserSeq());
			resultMap.put("eventAttendanceList", eventAttendanceOra.selectEventAttendanceList(map));
		}
		
		return resultMap;
		
		
	}

	public void mergeEventAttendance(EventAttendanceModel eventAttendanceModel) {
		EventAttendanceDao eventAttendanceOra = oraSqlSession.getMapper(EventAttendanceDao.class);
		
		eventAttendanceOra.mergeEventAttendance(eventAttendanceModel);
	}

}

package com.gojls.ems.gwizard.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gojls.ems.gwizard.dao.EventAttendanceDao;
import com.gojls.ems.gwizard.dao.EventElevateDao;
import com.gojls.ems.gwizard.dao.EventHistoryDao;
import com.gojls.ems.gwizard.dao.EventLevelDao;
import com.gojls.ems.gwizard.dao.EventMovieDao;
import com.gojls.ems.gwizard.dao.EventUserDao;
import com.gojls.ems.gwizard.model.EventAttendanceModel;
import com.gojls.ems.gwizard.model.EventElevateModel;
import com.gojls.ems.gwizard.model.EventHistoryModel;
import com.gojls.ems.gwizard.model.EventLevelModel;
import com.gojls.ems.gwizard.model.EventMovieModel;
import com.gojls.ems.gwizard.model.EventUserModel;

@Service
public class EventHistoryServiceImpl implements EventHistoryService {
	@Autowired
	@Qualifier("orasql")
	private SqlSession oraSqlSession; 
	
	public Map<String, Object> selectEventHistory(Map<String, Object> map) throws Exception{
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventHistoryDao eventHistoryOra = oraSqlSession.getMapper(EventHistoryDao.class);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int eventSeq = (map.get("eventSeq") == null)?0:(Integer)map.get("eventSeq");
		String userSeq = (map.get("userSeq")==null)?"":String.valueOf(map.get("userSeq"));
		
		EventUserModel eventUserModel = new EventUserModel();
		eventUserModel.setEventSeq(eventSeq);
		eventUserModel.setUserSeq(userSeq);
		EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
		
		if(eventUserInfo != null) {
			map.put("eventUserSeq", eventUserInfo.getEventUserSeq());
			resultMap.put("eventHistoryList", eventHistoryOra.selectEventHistoryList(map));
		}		
		
		return resultMap;
		
		
	}

	public Map<String, Object> insertEventHistory(EventUserModel eventUserModel, EventHistoryModel eventHistoryModel) {
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventHistoryDao eventHistoryOra = oraSqlSession.getMapper(EventHistoryDao.class);
		EventMovieDao eventMovieOra = oraSqlSession.getMapper(EventMovieDao.class);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//반배정된 학생
		int isUserCheck = eventUserDaoOra.selectUserCheck(eventUserModel.getUserSeq());
		int eventUserSeq = 0;
		if(isUserCheck == 1) {
			EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
			eventUserSeq = eventUserInfo.getEventUserSeq();
			
			//동영상 히스토리 insert
			eventHistoryModel.setEventUserSeq(eventUserInfo.getEventUserSeq());
			eventHistoryOra.insertEventHistory(eventHistoryModel);
		}
		
		//동영상 정보
		EventMovieModel eventMovieModel = new EventMovieModel();
		eventMovieModel.setEventSeq(eventHistoryModel.getEventSeq());
		eventMovieModel.setEventUserSeq(eventUserSeq);
		eventMovieModel.setEventMovieSeq(eventHistoryModel.getEventMovieSeq());
		EventMovieModel eventMovieInfo = eventMovieOra.selectEventMovie(eventMovieModel);
		
		resultMap.put("eventHistorySeq", eventHistoryModel.getEventHistorySeq());
		resultMap.put("eventMovieInfo", eventMovieInfo);
		
		return resultMap;
	}
	
	public Map<String, Object> updateEventHistory(EventUserModel eventUserModel, EventHistoryModel eventHistoryModel) throws Exception {
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventAttendanceDao eventAttendanceDaoOra = oraSqlSession.getMapper(EventAttendanceDao.class);
		EventHistoryDao eventHistoryOra = oraSqlSession.getMapper(EventHistoryDao.class);
		EventLevelDao eventLevelOra = oraSqlSession.getMapper(EventLevelDao.class);
		EventElevateDao eventElevateDaoOra = oraSqlSession.getMapper(EventElevateDao.class);
		EventMovieDao eventMovieDaoOra = oraSqlSession.getMapper(EventMovieDao.class);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//반배정된 학생
		int isUserCheck = eventUserDaoOra.selectUserCheck(eventUserModel.getUserSeq());
		if(isUserCheck == 1) {
			//이벤트 사용자 정보 가져오기
			EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
			
			//동영상 정보 가져오기
			EventMovieModel eventMovieModel = new EventMovieModel();
			eventMovieModel.setEventMovieSeq(eventHistoryModel.getEventMovieSeq());
			EventMovieModel eventMovieInfo = eventMovieDaoOra.selectEventMovie(eventMovieModel);
			
			//문법 history update
			eventHistoryModel.setLeastTime(eventMovieInfo.getLeastTime());
			int result = eventHistoryOra.updateEventHistory(eventHistoryModel);
			if(result == 0) {
				resultMap.put("RESULT", "FAIL");
				resultMap.put("MSG", "스토리영상은 한번에 하나만, 끝까지 봐야합니다.\n(재생중인 영상 플레이타임 : "+eventMovieInfo.getLeastTime()+"분 이상)");
			}else {
			
				//출석 merge
				EventAttendanceModel eventAttendanceModel = new EventAttendanceModel();
				eventAttendanceModel.setEventUserSeq(eventUserInfo.getEventUserSeq());
				eventAttendanceModel.setRegUserSeq(eventUserModel.getRegUserSeq());
				eventAttendanceModel.setRegUserNm(eventUserModel.getRegUserNm());
				eventAttendanceDaoOra.mergeEventAttendance(eventAttendanceModel);
				
				//문법 history cnt 정보
				int eventMovieSeq = eventHistoryModel.getEventMovieSeq();
				eventHistoryModel.setEventUserSeq(eventUserInfo.getEventUserSeq());
				eventHistoryModel.setEventMovieSeq(0);
				EventUserModel eventUserMovieInfo = eventHistoryOra.selectEventHistoryCnt(eventHistoryModel);
				
				//이벤트 사용자 동영상 정보 update
				eventUserInfo.setMovieCnt(eventUserMovieInfo.getMovieCnt());
				eventUserInfo.setViewCnt(eventUserMovieInfo.getViewCnt());
				eventUserInfo.setRegUserSeq(eventUserModel.getRegUserSeq());
				eventUserInfo.setRegUserNm(eventUserModel.getRegUserNm());
				eventUserDaoOra.updateEventUserMovie(eventUserInfo);
				
				String elevateFl = "N";
				EventLevelModel nextLevelInfo = new EventLevelModel();
				if(eventUserInfo.getStageNo() < 4 && eventUserInfo.getLevelMovieCnt() <= eventUserMovieInfo.getMovieCnt() && eventUserInfo.getLevelViewCnt() <= eventUserMovieInfo.getViewCnt()) {
					elevateFl = "Y";
					
					//다음레벨정보
					EventLevelModel eventLevelModel = new EventLevelModel();
					eventLevelModel.setEventLevelSeq(eventUserInfo.getNextLevelSeq());
					nextLevelInfo = eventLevelOra.selectEventLevel(eventLevelModel);
					
					//승급퀴즈 갯수가 0인 경우 승급시험없이 레벨업
					if(eventUserInfo.getLevelQuizCnt() == 0) {
						EventElevateModel eventElevateModel = new EventElevateModel();
						eventElevateModel.setEventUserSeq(eventUserInfo.getEventUserSeq());
						eventElevateModel.setOldLevelSeq(eventUserInfo.getEventLevelSeq());
						eventElevateModel.setEventLevelSeq(nextLevelInfo.getEventLevelSeq());
						eventElevateModel.setQuizArr("");
						eventElevateModel.setStatus(1);
						eventElevateModel.setRegUserSeq(eventUserModel.getRegUserSeq());
						eventElevateModel.setRegUserNm(eventUserModel.getRegUserNm());
						eventElevateDaoOra.insertEventElevate(eventElevateModel);	//승급 히스토리 저장
						eventUserDaoOra.updateEventUserLevel(eventUserInfo);	//레벨 업 업데이트
					}
				}
				eventHistoryModel.setEventMovieSeq(eventMovieSeq);
				resultMap.put("RESULT", "SUCCESS");
				resultMap.put("accessCnt", eventAttendanceDaoOra.selectEventAttendanceCnt(eventAttendanceModel)); //오늘 접근 수
				resultMap.put("viewCnt", eventHistoryOra.selectEventHistoryCnt(eventHistoryModel).getViewCnt());	//이 문법 뷰 수
				resultMap.put("elevateFl", elevateFl);	//승급여부
				resultMap.put("nextLevelInfo", nextLevelInfo);	//다음레벨정보
			}
		}else {
			resultMap.put("RESULT", "FAIL");
			resultMap.put("MSG", "이벤트 대상자가 아닙니다.");
		}
		return resultMap;
	}
	
	public Map<String, Object> updateEventElevate(EventUserModel eventUserModel, EventElevateModel eventElevateModel) throws Exception {
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventElevateDao eventElevateDaoOra = oraSqlSession.getMapper(EventElevateDao.class);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//이벤트 사용자 정보 가져오기
		EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
		eventUserInfo.setRegUserSeq(eventUserModel.getRegUserSeq());
		eventUserInfo.setRegUserNm(eventUserModel.getRegUserNm());
		
		//다음 레벨의 정보보다 많이 봤는지(승급 조건 확인)
		if(eventUserInfo.getStageNo() < 4 && eventUserInfo.getMovieCnt() >= eventUserInfo.getLevelMovieCnt() && eventUserInfo.getViewCnt() >= eventUserInfo.getLevelViewCnt() ) {
			eventElevateDaoOra.updateEventElevate(eventElevateModel);	//승급 히스토리 저장
			eventUserDaoOra.updateEventUserLevel(eventUserInfo);	//레벨 업 업데이트
			resultMap.put("RESULT", "SUCCESS");
		}else {
			resultMap.put("RESULT", "FAIL1");
		}

		resultMap.put("eventUserInfo", eventUserInfo); //오늘 접근 수
		
		return resultMap;
	}
}

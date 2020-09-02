package com.gojls.ems.storyknight.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gojls.ems.gwizard.dao.EventAttendanceDao;
import com.gojls.ems.gwizard.dao.EventElevateDao;
import com.gojls.ems.gwizard.dao.EventHistoryDao;
import com.gojls.ems.gwizard.dao.EventInfoDao;
import com.gojls.ems.gwizard.dao.EventMovieDao;
import com.gojls.ems.gwizard.dao.EventNoticeDao;
import com.gojls.ems.gwizard.dao.EventQuizDao;
import com.gojls.ems.gwizard.dao.EventUserDao;
import com.gojls.ems.gwizard.model.EventElevateModel;
import com.gojls.ems.gwizard.model.EventHistoryModel;
import com.gojls.ems.gwizard.model.EventInfoModel;
import com.gojls.ems.gwizard.model.EventMovieModel;
import com.gojls.ems.gwizard.model.EventNoticeModel;
import com.gojls.ems.gwizard.model.EventQuizModel;
import com.gojls.ems.gwizard.model.EventUserModel;

@Service
public class StoryKnightServiceImpl implements StoryKnightService {
	@Autowired
	@Qualifier("orasql")
	private SqlSession oraSqlSession; 
	
	public Map<String, Object> getMain(Map<String, Object> map){
		EventInfoDao eventInfoDaoOra = oraSqlSession.getMapper(EventInfoDao.class);
		EventNoticeDao eventNoticeDaoOra = oraSqlSession.getMapper(EventNoticeDao.class);
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventAttendanceDao eventAttendanceOra = oraSqlSession.getMapper(EventAttendanceDao.class);
		EventMovieDao eventMovieOra = oraSqlSession.getMapper(EventMovieDao.class);
		EventHistoryDao eventHistoryOra = oraSqlSession.getMapper(EventHistoryDao.class);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//전체 동영상 수가져오기
		
		//이벤트 정보
		EventInfoModel eventInfoModel = new EventInfoModel();
		eventInfoModel.setGtEventType("EVT003");
		eventInfoModel.setEpisodeSeq((Integer)map.get("episodeSeq"));
		EventInfoModel eventInfo = eventInfoDaoOra.selectEventInfo(eventInfoModel);
		
		//공지 리스트 
		EventNoticeModel eventNoticeModel = new EventNoticeModel();
		eventNoticeModel.setEventSeq(eventInfo.getEventSeq());
		List<EventNoticeModel> eventNoticeList = eventNoticeDaoOra.selectEventNoticeList(eventNoticeModel);
		
		String userSeq = (map.get("userSeq")==null)?"":String.valueOf(map.get("userSeq"));
		String userNm = (map.get("userNm")==null)?"":String.valueOf(map.get("userNm"));
		int eventUserSeq = 0;
		
		//마법의 전당 리스트
		EventUserModel eventUserModel = new EventUserModel();
		eventUserModel.setEventSeq(eventInfo.getEventSeq());
		eventUserModel.setUserSeq(userSeq);
		
		if(userSeq != null && !userSeq.equals("")) {
			//반배정된 학생
			int isUserCheck = eventUserDaoOra.selectUserCheck(userSeq);
			resultMap.put("isUserCheck", isUserCheck);
			
			//대상자 인 경우 도전자 정보 가져오기
			if(isUserCheck == 1) {
				//도전자 정보
				eventUserModel.setUserSeq(userSeq);
				EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
				
				if(eventUserInfo == null) {	//이벤트가 없는 경우 도전자로 insert
					int startLevelSeq = 12;
					String nickNm = "";
					
					eventUserInfo = new EventUserModel();
					eventUserInfo.setEventLevelSeq(startLevelSeq);	//도전자
					eventUserInfo.setEventSeq(eventInfo.getEventSeq());
					eventUserInfo.setUserSeq(userSeq);
					eventUserInfo.setNickNm(nickNm);
					eventUserInfo.setRegUserSeq(userSeq);
					eventUserInfo.setRegUserNm(userNm);
					eventUserDaoOra.insertEventUser(eventUserInfo);
					
					eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
				}
				resultMap.put("eventUser", eventUserInfo);
				
				eventUserSeq = eventUserInfo.getEventUserSeq();
				map.put("eventUserSeq", eventUserSeq);
				resultMap.put("eventAttendanceList", eventAttendanceOra.selectEventAttendanceList(map));
			}
		}

		//동영상 리스트
		int groupCnt = 7;
		EventMovieModel eventMovieModel = new EventMovieModel();
		eventMovieModel.setEventSeq(eventInfo.getEventSeq());
		eventMovieModel.setEventUserSeq(eventUserSeq);
		eventMovieModel.setGroupCnt(groupCnt);
		List<EventMovieModel> eventMovieList = eventMovieOra.selectEventMovieList(eventMovieModel);

		EventHistoryModel eventHistoryModel = new EventHistoryModel();
		eventHistoryModel.setEventSeq(eventInfo.getEventSeq());
		resultMap.put("totalMovieCntInfo", eventHistoryOra.selectEventHistoryCnt(eventHistoryModel));
		resultMap.put("eventInfo", eventInfo);
		resultMap.put("eventNoticeList", eventNoticeList);
		resultMap.put("eventMovieList", eventMovieList);
		
		return resultMap;
	}
	
	public Map<String, Object> selectEventQuiz(String userSeq, EventQuizModel eventQuizModel){
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventQuizDao eventQuizDaoOra = oraSqlSession.getMapper(EventQuizDao.class);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("isChessQuizKrCheck", eventUserDaoOra.selectChessUserQuizKrCheck(userSeq));
		resultMap.put("eventQuizList", eventQuizDaoOra.selectEventQuiz(eventQuizModel));
		
		return resultMap;
	}
	
	public Map<String, Object> selectEventLevelUpQuiz(EventUserModel eventUserModel){
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventMovieDao eventMovieDaoOra = oraSqlSession.getMapper(EventMovieDao.class);
		EventQuizDao eventQuizDaoOra = oraSqlSession.getMapper(EventQuizDao.class);
		EventElevateDao eventElevateDaoOra = oraSqlSession.getMapper(EventElevateDao.class);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
		resultMap.put("eventUserInfo", eventUserInfo);
		List<EventMovieModel> eventMovieList = eventMovieDaoOra.selectEventMovieListByUser(eventUserInfo);
		resultMap.put("eventMovieList", eventMovieList);
		
		String quizArr = "";
		List<EventQuizModel> eventQuizList = new ArrayList<EventQuizModel>();
		for(int i=0; i<eventUserInfo.getLevelQuizCnt(); i++) {
			EventMovieModel eventMovieInfo = eventMovieList.get(i);
			
			EventQuizModel eventQuizModel = new EventQuizModel();
			eventQuizModel.setEventSeq(eventUserModel.getEventSeq());
			eventQuizModel.setEventMovieSeq(eventMovieInfo.getEventMovieSeq());
			EventQuizModel eventQuizInfo = eventQuizDaoOra.selectEventQuiz(eventQuizModel);
			eventQuizList.add(eventQuizInfo);

			if(i > 0) quizArr += ",";
			quizArr += eventQuizInfo.getEventQuizSeq();
		}
		
		//승급히스토리 저장
		EventElevateModel eventElevateModel = new EventElevateModel();
		eventElevateModel.setEventUserSeq(eventUserInfo.getEventUserSeq());
		eventElevateModel.setOldLevelSeq(eventUserInfo.getEventLevelSeq());
		eventElevateModel.setEventLevelSeq(eventUserInfo.getNextLevelSeq());
		eventElevateModel.setQuizCnt(eventUserInfo.getLevelQuizCnt());
		eventElevateModel.setQuizArr(quizArr);
		eventElevateModel.setStatus(0);
		eventElevateModel.setRegUserSeq(eventUserModel.getRegUserSeq());
		eventElevateModel.setRegUserNm(eventUserModel.getRegUserNm());
		eventElevateDaoOra.insertEventElevate(eventElevateModel);	//레벨 업 업데이트

		resultMap.put("eventElevateSeq", eventElevateModel.getEventElevateSeq());
		resultMap.put("eventQuizList", eventQuizList);
		
		return resultMap;
	}
	
	public Map<String, Object> selectEventCertificationQuiz(EventUserModel eventUserModel){
		EventUserDao eventUserDaoOra = oraSqlSession.getMapper(EventUserDao.class);
		EventMovieDao eventMovieDaoOra = oraSqlSession.getMapper(EventMovieDao.class);
		EventQuizDao eventQuizDaoOra = oraSqlSession.getMapper(EventQuizDao.class);
		EventElevateDao eventElevateDaoOra = oraSqlSession.getMapper(EventElevateDao.class);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		EventUserModel eventUserInfo = eventUserDaoOra.selectEventUser(eventUserModel);
		resultMap.put("eventUserInfo", eventUserInfo);
		
		//이전 이벤트 문법 목록 랜덤으로 가져오기
		EventMovieModel eventMovieModel = new EventMovieModel();
		eventMovieModel.setEventSeq(eventUserModel.getEventPrevSeq());
		List<EventMovieModel> eventMovieList = eventMovieDaoOra.selectEventRandomMovieList(eventMovieModel);
		resultMap.put("eventMovieList", eventMovieList);
		
		String quizArr = "";
		List<EventQuizModel> eventQuizList = new ArrayList<EventQuizModel>();
		for(int i=0; i<eventUserInfo.getLevelQuizCnt(); i++) {
			EventMovieModel eventMovieInfo = eventMovieList.get(i);
			
			EventQuizModel eventQuizModel = new EventQuizModel();
			eventQuizModel.setEventSeq(eventUserModel.getEventPrevSeq());
			eventQuizModel.setEventMovieSeq(eventMovieInfo.getEventMovieSeq());
			EventQuizModel eventQuizInfo = eventQuizDaoOra.selectEventQuiz(eventQuizModel);
			eventQuizList.add(eventQuizInfo);

			if(i > 0) quizArr += ",";
			quizArr += eventQuizInfo.getEventQuizSeq();
		}
		
		//승급히스토리 저장
		EventElevateModel eventElevateModel = new EventElevateModel();
		eventElevateModel.setEventUserSeq(eventUserInfo.getEventUserSeq());
		eventElevateModel.setOldLevelSeq(eventUserInfo.getEventLevelSeq());
		eventElevateModel.setEventLevelSeq(eventUserInfo.getNextLevelSeq());
		eventElevateModel.setQuizCnt(eventUserInfo.getLevelQuizCnt());
		eventElevateModel.setQuizArr(quizArr);
		eventElevateModel.setStatus(0);
		eventElevateModel.setRegUserSeq(eventUserModel.getRegUserSeq());
		eventElevateModel.setRegUserNm(eventUserModel.getRegUserNm());
		eventElevateDaoOra.insertEventElevate(eventElevateModel);	//레벨 업 업데이트

		resultMap.put("eventElevateSeq", eventElevateModel.getEventElevateSeq());
		resultMap.put("eventQuizList", eventQuizList);
		
		return resultMap;
	}
}

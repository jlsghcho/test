package com.gojls.h1k.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gojls.h1k.dao.H1KDao;
import com.gojls.h1k.model.H1KTimeModel;
import com.gojls.h1k.model.StampModel;
import com.gojls.h1k.model.SurveyModel;
import com.gojls.h1k.model.UserModel;

@Service
public class H1KServiceImpl implements H1KService {
	private static final Logger logger = LoggerFactory.getLogger(H1KServiceImpl.class);
	
	@Autowired
	@Qualifier("orasql")
	private SqlSession sqlSession;

	public UserModel selectUserInfo(UserModel usermodel){
		H1KDao h1kdao = sqlSession.getMapper(H1KDao.class);		
		usermodel  = h1kdao.selectUserInfo(usermodel);
		return usermodel;		
	}	
	
	public List<UserModel> selectChildList(String userSeq) {
		H1KDao h1kdao = sqlSession.getMapper(H1KDao.class);		
		List<UserModel> list = h1kdao.selectChildList(userSeq);
		return list;
	}
	
	public Map<String, Object> selectH1KEventInfo(H1KTimeModel timemodel){
		H1KDao h1kdao = sqlSession.getMapper(H1KDao.class);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userSeq", timemodel.getUserSeq());
		map.put("h1kEventSeq", timemodel.getH1kEventSeq());
		
		timemodel = h1kdao.selectH1KTimeInfo(timemodel);
		
		returnMap.put("timeInfo", timemodel);
		
		List<StampModel> list = h1kdao.selectUserStampInfo(map);

		returnMap.put("stampList", list);
		/*
		Map<String, Object> objmap = null;
		int selTerm = 0;
		for (int i = 0; i < list.size(); i++) {
			objmap = list.get(i);
			if(objmap.get("state").equals("1")){
				selTerm = (int)objmap.get("term"); 
				switch (selTerm) {
				case 1:
					timemodel.setTerm1Yn("Y");					
					break;
				case 2:
					timemodel.setTerm2Yn("Y");					
					break;
				case 3:
					timemodel.setTerm3Yn("Y");					
					break;
				case 4:
					timemodel.setTerm4Yn("Y");					
					break;
				}
			}
		}
		*/
		return returnMap;
	}
	
	public SurveyModel selectH1KSurveySave(SurveyModel surveymodel){
		H1KDao h1kdao = sqlSession.getMapper(H1KDao.class);		
		surveymodel  = h1kdao.selectH1KSurveySave(surveymodel);
		return surveymodel;
	}
	
	public int procH1KSurveySave(SurveyModel surveymodel){
		H1KDao h1kdao = sqlSession.getMapper(H1KDao.class);

		int returnVal = 0;
		
		int retSeq = h1kdao.selectH1KSurveySeq(surveymodel);
		surveymodel.setH1kSurveySeq(retSeq);
		 
		SurveyModel selsurvey = h1kdao.selectH1KSurveySave(surveymodel);
		System.out.println("userSeq::"+surveymodel.getUserSeq());		
		if(selsurvey != null && selsurvey.getH1kSurveySaveSeq() > 0){
			System.out.println("selsurvey getH1kSurveySaveSeq::"+selsurvey.getH1kSurveySaveSeq());
			/* 등록삭제  */
			int cnt = h1kdao.deleteH1KSurveySave(selsurvey);
			System.out.println("delete surveysave cnt::"+cnt);
			/* 타임포인트-처리  */
			if(cnt > 0){
				selsurvey.setGtStatsType("1K1009");
				selsurvey.setAddTime(selsurvey.getAddTimeSec()*-1);
				selsurvey.setRegUserSeq(surveymodel.getRegUserSeq());
				selsurvey.setRegUserNm(surveymodel.getRegUserNm());
				returnVal  = h1kdao.insertH1KTimeDay(selsurvey);				
			}
			
			if(returnVal > 0){
				/* survey save */
				int hssseq  = h1kdao.insertH1KSurveySave(surveymodel);
				surveymodel.setGtStatsType("1K1009");
				
				/* time point save */
				returnVal  = h1kdao.insertH1KTimeDay(surveymodel);
				System.out.println("returnVal ::"+returnVal);
			}else{
				returnVal  = -1;
				System.out.println("처리중 오류::"+selsurvey.getH1kSurveySaveSeq());
			}
		}else{			
			/* survey save */
			int hssseq  = h1kdao.insertH1KSurveySave(surveymodel);
			System.out.println("surveysave seq ::"+hssseq);
			System.out.println("surveysave seq ::"+surveymodel.getH1kSurveySaveSeq());
			//surveymodel.setH1kSurveySaveSeq(hssseq);
			surveymodel.setGtStatsType("1K1009");
			

			System.out.println("addtime ::"+surveymodel.getAddTime());
			System.out.println("regUserSeq ::"+surveymodel.getRegUserSeq());
			/* time point save */
			returnVal  = h1kdao.insertH1KTimeDay(surveymodel);
			System.out.println("returnVal ::"+returnVal);
		}		
		return returnVal;
	}
}

package com.gojls.h1k.dao;

import java.util.List;
import java.util.Map;

import com.gojls.h1k.model.H1KTimeModel;
import com.gojls.h1k.model.StampModel;
import com.gojls.h1k.model.SurveyModel;
import com.gojls.h1k.model.UserModel;

public interface H1KDao {
	
	public UserModel selectUserInfo(UserModel usermodel);
	
	public List<UserModel> selectChildList(String userSeq);
	
	public List<StampModel> selectUserStampInfo(Map<String, Object> map);
		
	public H1KTimeModel selectH1KTimeInfo(H1KTimeModel timeModel);

	public SurveyModel selectH1KSurveySave(SurveyModel surveyModel);
	
	public int insertH1KSurveySave(SurveyModel surveyModel);

	public int insertH1KTimeDay(SurveyModel surveyModel);
	
	public int selectH1KSurveySeq(SurveyModel surveyModel);

	public int deleteH1KSurveySave(SurveyModel surveyModel);
	
	
	
}

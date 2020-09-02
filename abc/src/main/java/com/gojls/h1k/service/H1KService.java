package com.gojls.h1k.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.h1k.model.H1KTimeModel;
import com.gojls.h1k.model.SurveyModel;
import com.gojls.h1k.model.UserModel;

@Transactional
public interface H1KService {

	public UserModel selectUserInfo(UserModel usermodel);
	
	public List<UserModel> selectChildList(String userSeq);
	
	public Map<String, Object> selectH1KEventInfo(H1KTimeModel timemodel);

	public SurveyModel selectH1KSurveySave(SurveyModel surveymodel);
	
	public int procH1KSurveySave(SurveyModel surveymodel);
	
	
}

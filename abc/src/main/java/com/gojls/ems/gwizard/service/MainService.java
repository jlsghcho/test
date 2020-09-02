package com.gojls.ems.gwizard.service;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.ems.gwizard.model.EventQuizModel;
import com.gojls.ems.gwizard.model.EventUserModel;

@Transactional
public interface MainService {
	public Map<String, Object> getMain(Map<String, Object> map);
	public Map<String, Object> selectEventUserNickNmCheck(EventUserModel eventUserModel);
	public void updateEventUserNickNm(EventUserModel eventUserModel);
	public Map<String, Object> selectEventQuiz(EventQuizModel eventQuizModel);
	public Map<String, Object> selectEventLevelUpQuiz(EventUserModel eventUserModel);
	public Map<String, Object> selectEventCertificationQuiz(EventUserModel eventUserModel);
}

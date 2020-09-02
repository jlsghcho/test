package com.gojls.ems.storyknight.service;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.ems.gwizard.model.EventQuizModel;
import com.gojls.ems.gwizard.model.EventUserModel;

@Transactional
public interface StoryKnightService {
	public Map<String, Object> getMain(Map<String, Object> map);
	public Map<String, Object> selectEventQuiz(String userSeq, EventQuizModel eventQuizModel);
	public Map<String, Object> selectEventLevelUpQuiz(EventUserModel eventUserModel);
	public Map<String, Object> selectEventCertificationQuiz(EventUserModel eventUserModel);
}

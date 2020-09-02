package com.gojls.event.service;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.event.model.H1kModel;

@Transactional
public interface H1kService {
	
	H1kModel selectH1kEventInfo(H1kModel h1kModel);
		
	int selectMissionCnt(H1kModel h1kModel);	
	int insertMission(H1kModel h1kModel);
}

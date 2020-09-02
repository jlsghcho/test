package com.gojls.ace.service;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.ace.model.MapModel;

@Transactional
public interface MapService {
	
//	List<MapModel> selectUserMissionInfo(MapModel mapModel);
	MapModel selectMapInfo(MapModel mapModel);
	MapModel selectUserMissionInfo(MapModel mapModel);
	
	MapModel selectMission1Info(MapModel mapModel);	
	int selectMissionCnt(MapModel mapModel);	
	
	int insertMapMission(MapModel mapModel);
	int updateMissionView(MapModel mapModel);
}

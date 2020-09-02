package com.gojls.ace.dao;

import com.gojls.ace.model.MapModel;

public interface MapDao {
	
//	public List<MapModel> selectUserMissionInfo(MapModel mapModel);
	public MapModel selectMapInfo(MapModel mapModel);
	public MapModel selectUserMissionInfo(MapModel mapModel);
	
	public MapModel selectMission1Info(MapModel mapModel);	
	public int selectMissionCnt(MapModel mapModel);
	
	public int insertMapMission(MapModel mapModel);
	public int updateMissionView(MapModel mapModel);
	
}

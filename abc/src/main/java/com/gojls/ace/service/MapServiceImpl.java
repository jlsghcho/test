package com.gojls.ace.service;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.gojls.ace.dao.MapDao;
import com.gojls.ace.model.MapModel;

public class MapServiceImpl implements MapService {
	private static final Logger LOGGER = LoggerFactory.getLogger(MapServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public MapServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }
 
	@Override
	public MapModel selectMapInfo(MapModel mapModel) {
		MapDao mapDao = SQL_SESSION.getMapper(MapDao.class);

		MapModel map = new MapModel();
		map = mapDao.selectMapInfo(mapModel);  
 
		return map;
	} 

	@Override
	public MapModel selectUserMissionInfo(MapModel mapModel) {
		MapDao mapDao = SQL_SESSION.getMapper(MapDao.class);

		MapModel map = new MapModel();
		map = mapDao.selectUserMissionInfo(mapModel);  
 
		return map;
	} 

	@Override
	public MapModel selectMission1Info(MapModel mapModel) {
		MapDao mapDao = SQL_SESSION.getMapper(MapDao.class);

		MapModel map = new MapModel();
		map = mapDao.selectMission1Info(mapModel);  
  
		return map;
	} 
	
	@Override
	public int selectMissionCnt(MapModel mapModel){

		MapDao mapDao = SQL_SESSION.getMapper(MapDao.class);
		return mapDao.selectMissionCnt(mapModel);
	} 
	
	@Override
	public int insertMapMission(MapModel mapModel){
		MapDao mapDao = SQL_SESSION.getMapper(MapDao.class);
 
		int cnt = mapDao.insertMapMission(mapModel); 
		return cnt;
	}
	
	@Override
	public int updateMissionView(MapModel mapModel){
		MapDao mapDao = SQL_SESSION.getMapper(MapDao.class);
 
		int cnt = mapDao.updateMissionView(mapModel); 
		return cnt;
	}
	
}

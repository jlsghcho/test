package com.gojls.event.service;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.gojls.event.dao.H1kDao;
import com.gojls.event.model.H1kModel;

public class H1kServiceImpl implements H1kService {
	private static final Logger LOGGER = LoggerFactory.getLogger(H1kServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public H1kServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }
 
	@Override
	public H1kModel selectH1kEventInfo(H1kModel h1kModel) {
		H1kDao h1kDao = SQL_SESSION.getMapper(H1kDao.class);

		H1kModel map = new H1kModel();
		map = h1kDao.selectH1kEventInfo(h1kModel);  
 
		return map;
	} 
 
	@Override
	public int selectMissionCnt(H1kModel h1kModel){
		H1kDao h1kDao = SQL_SESSION.getMapper(H1kDao.class);
		return h1kDao.selectMissionCnt(h1kModel);
	} 
	
	@Override
	public int insertMission(H1kModel h1kModel){
		H1kDao h1kDao = SQL_SESSION.getMapper(H1kDao.class);
 
		int cnt = h1kDao.insertMission(h1kModel); 
		return cnt;
	}
	
}

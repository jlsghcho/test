package com.gojls.chess.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.gojls.chess.dao.MsUccDao;
import com.gojls.chess.model.MsUccModel;
import com.gojls.h1k.dao.H1KDao;
import com.gojls.h1k.model.SurveyModel;

public class MsUccServiceImpl implements MsUccService {
	private static final Logger LOGGER = LoggerFactory.getLogger(MsUccServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public MsUccServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }
 
	@Override
	public List<MsUccModel> selectMsUccList(MsUccModel msUccModel) {
		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);

		List<MsUccModel> msUccList = new ArrayList<MsUccModel>();
		msUccList = msUccDao.selectMsUccList(msUccModel);  
 
		return msUccList;
	} 
	
	@Override
	public List<MsUccModel> selectMsUccTop3(MsUccModel msUccModel) {
		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);

		List<MsUccModel> msUccTop3 = new ArrayList<MsUccModel>();
		msUccTop3 = msUccDao.selectMsUccTop3(msUccModel);  
 
		return msUccTop3;
	} 
	
	@Override
	public MsUccModel selectMsUccInfo(MsUccModel msUccModel) {
		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);

		MsUccModel msUcc = new MsUccModel();
		msUcc = msUccDao.selectMsUccInfo(msUccModel);  
 
		return msUcc;
	} 
	
	@Override
	public int selectTotRecomCnt(MsUccModel msUccModel){

		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);
		return msUccDao.selectTotRecomCnt(msUccModel);
	} 
	
	@Override
	public int selectRecomUccCnt(MsUccModel msUccModel){

		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);
		return msUccDao.selectRecomUccCnt(msUccModel);
	} 

	public int insertRecomUcc(MsUccModel msUccModel){
		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);
 
		int cnt = msUccDao.insertRecomUcc(msUccModel); 
		return cnt;
	}

	public int insertViewUcc(MsUccModel msUccModel){
		MsUccDao msUccDao = SQL_SESSION.getMapper(MsUccDao.class);
 
		int cnt = msUccDao.insertViewUcc(msUccModel); 
		return cnt;
	}
}

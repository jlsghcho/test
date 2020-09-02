package com.gojls.ems.event.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.gojls.ems.event.dao.EmsEventDao;
import com.gojls.ems.event.model.EmsEventModel;
import com.gojls.ems.event.model.EmsEventSongModel;
import com.gojls.ems.event.model.EmsEventSongUserDataModel;


public class EmsEventServiceImpl implements EmsEventService{
	
	private final SqlSession SQL_SESSION;
	
	@Autowired
	public EmsEventServiceImpl(SqlSession sqlSession){SQL_SESSION = sqlSession;}
	
	@Override
	public int selectChessUser(String userSeq){	
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		int cnt = eventDao.selectChessUser(userSeq);
		return cnt;	
	}
	
	
	@Override
	public EmsEventModel selectEventInfo(int emsEventSeq)
	{			
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		EmsEventModel eventInfo = eventDao.selectEventInfo(emsEventSeq);
		return eventInfo;
	}
	
	@Override
	public int selectTotSongPlayCnt(int emsEventSeq)
	{			
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		int cnt = eventDao.selectTotSongPlayCnt(emsEventSeq);
		return cnt;
	}
	
	/* 특정 사용자 플레리 개수 */
	@Override
	public EmsEventSongUserDataModel selectSongPlayCnt(int emsEventSeq, String userSeq, String songType)
	{
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		EmsEventSongUserDataModel userData = new EmsEventSongUserDataModel();
		userData = eventDao.selectSongPlayCnt(emsEventSeq, userSeq, songType);
		return userData;
	}
	
	/* 사용자 노래  리스트  */
	@Override
	public List<EmsEventSongModel> selectSongList(int emsEventSeq, String userSeq, String songType)
	{
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		List<EmsEventSongModel> list = new ArrayList<EmsEventSongModel>();
		list = eventDao.selectSongList(emsEventSeq, userSeq, songType);
		return list;
	}
	
	
	@Override
	public int mergeSongPlay(int eventSongSeq, String userSeq)
	{
				
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		int cnt = eventDao.mergeSongPlay(eventSongSeq, userSeq);
		return cnt;
		
	}
	
	@Override
	public int selectSongPlayCnt2(int eventSongSeq, String userSeq)
	{
		EmsEventDao eventDao = SQL_SESSION.getMapper(EmsEventDao.class);
		int cnt = eventDao.selectSongPlayCnt2(eventSongSeq, userSeq);
		return cnt;
	}
	
}

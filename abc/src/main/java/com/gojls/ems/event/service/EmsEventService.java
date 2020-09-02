package com.gojls.ems.event.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;
import com.gojls.ems.event.model.EmsEventModel;
import com.gojls.ems.event.model.EmsEventSongModel;
import com.gojls.ems.event.model.EmsEventSongUserDataModel;

@Transactional
public interface EmsEventService {
	
	public EmsEventModel selectEventInfo(int emsEventSeq);
	public int selectTotSongPlayCnt(int emsEventSeq);
	public int selectSongPlayCnt2(int eventSongSeq, String userSeq);
	
	public int selectChessUser(String userSeq);
	public EmsEventSongUserDataModel selectSongPlayCnt(int emsEventSeq, String userSeq, String songType);
	public List<EmsEventSongModel> selectSongList(int emsEventSeq, String userSeq, String songType); 
	public int mergeSongPlay(int eventSongSeq, String userDeq);
	
}

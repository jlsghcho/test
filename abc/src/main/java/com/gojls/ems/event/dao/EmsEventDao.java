package com.gojls.ems.event.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.gojls.ems.event.model.EmsEventModel;
import com.gojls.ems.event.model.EmsEventSongModel;
import com.gojls.ems.event.model.EmsEventSongUserDataModel;

public interface EmsEventDao {

	EmsEventModel selectEventInfo(@Param("emsEventSeq") int emsEventSeq);
	int selectTotSongPlayCnt(@Param("emsEventSeq") int emsEventSeq);
	int selectSongPlayCnt2(@Param("eventSongSeq") int eventSongSeq, @Param("userSeq") String userSeq);
	int selectChessUser(@Param("userSeq") String userSeq);
	
	EmsEventSongUserDataModel selectSongPlayCnt(@Param("emsEventSeq") int empEventSeq, @Param("userSeq") String userSeq, @Param("songType") String songType);
	List<EmsEventSongModel> selectSongList(@Param("emsEventSeq") int empEventSeq, @Param("userSeq") String userSeq, @Param("songType") String songType);	
	int mergeSongPlay(@Param("eventSongSeq") int eventSongSeq, @Param("userSeq") String userSeq);
	
	
}

package com.gojls.ems.gwizard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gojls.ems.gwizard.model.EventSwearFilterModel;
import com.gojls.ems.gwizard.model.EventUserModel;

public interface EventUserDao {
	public int selectUserCheck(@Param("userSeq") String userSeq);
	public int selectChessUserQuizKrCheck(@Param("userSeq") String userSeq);
	public List<EventUserModel> selectEventTopUserList(EventUserModel eventUserModel);
	public EventUserModel selectEventUser(EventUserModel eventUserModel);
	public int selectEventUserNickNmCnt(EventUserModel eventUserModel);
	public List<EventSwearFilterModel> selectEventSwearFilterCheck(EventUserModel eventUserModel);
	public int insertEventUser(EventUserModel eventUserModel);
	public void updateEventUserNickNm(EventUserModel eventUserModel);
	public void updateEventUserMovie(EventUserModel eventUserModel);
	public void updateEventUserLevel(EventUserModel eventUserModel);
}

package com.gojls.event.dao;

import com.gojls.event.model.H1kModel;

public interface H1kDao {
	 
	public H1kModel selectH1kEventInfo(H1kModel h1kModel);
		
	public int selectMissionCnt(H1kModel h1kModel);	
	public int insertMission(H1kModel h1kModel);
	
}

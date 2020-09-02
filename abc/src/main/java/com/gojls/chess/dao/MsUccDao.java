package com.gojls.chess.dao;

import java.util.List;

import com.gojls.chess.model.MsUccModel;
import com.gojls.h1k.model.SurveyModel;

public interface MsUccDao {
	
	public List<MsUccModel> selectMsUccList(MsUccModel msUccModel);
	public List<MsUccModel> selectMsUccTop3(MsUccModel msUccModel);
	public MsUccModel selectMsUccInfo(MsUccModel msUccModel);
	public int selectTotRecomCnt(MsUccModel msUccModel);
	public int selectRecomUccCnt(MsUccModel msUccModel);
	public int insertRecomUcc(MsUccModel msUccModel);
	public int insertViewUcc(MsUccModel msUccModel);
	
}

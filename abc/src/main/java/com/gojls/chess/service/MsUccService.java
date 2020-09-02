package com.gojls.chess.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.chess.model.MsUccModel;

@Transactional
public interface MsUccService {
	
	List<MsUccModel> selectMsUccList(MsUccModel msUccModel);
	
	List<MsUccModel> selectMsUccTop3(MsUccModel msUccModel);
	
	MsUccModel selectMsUccInfo(MsUccModel msUccModel);
	
	int selectTotRecomCnt(MsUccModel msUccModel);
	
	int selectRecomUccCnt(MsUccModel msUccModel);

    int insertRecomUcc(MsUccModel msUccModel);

    int insertViewUcc(MsUccModel msUccModel);
}

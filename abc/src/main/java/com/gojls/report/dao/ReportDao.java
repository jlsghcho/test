package com.gojls.report.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gojls.report.model.EmpModel;
import com.gojls.report.model.DeptModel;
import com.gojls.report.model.ClassModel;
import com.gojls.report.model.DliveReportModel ;
import com.gojls.report.model.DeptRnkingModel ;
import com.gojls.report.model.EventSearchModel;

import com.gojls.report.model.MsuccReportModel;
import com.gojls.report.model.MsuccRankingModel;
import com.gojls.report.model.RouletteReportModel;

public interface ReportDao {

	EmpModel authEmp(EmpModel empInfo);
	List<DeptModel> selectEmpDeptList(EmpModel empInfo);
	List<EmpModel> selectDeptTeacherList(DeptModel deptModel);
	List<ClassModel> selectDeptClassList(@Param("deptSeq") String deptSeq, @Param("empSeq") String empSeq);
	List<DliveReportModel> selectDliveList(EventSearchModel searchModel);
	List<DeptRnkingModel> selectDliveRankingList(@Param("eventSeq") int eventSeq );
	
	List<MsuccRankingModel> selectMsuccRankingList(EventSearchModel searchModel);
	List<MsuccReportModel> selectMsuccList(EventSearchModel searchModel);
	List<RouletteReportModel> selectRouletteList(EventSearchModel searchModel);
	
	
	
	
	
}

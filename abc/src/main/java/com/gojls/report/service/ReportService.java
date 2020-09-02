package com.gojls.report.service;

import java.util.Map;
import org.springframework.transaction.annotation.Transactional;

import com.gojls.report.model.DeptModel;
import com.gojls.report.model.EmpModel;
import com.gojls.report.model.EventSearchModel;

@Transactional
public interface ReportService {

	public EmpModel authEmp(EmpModel empModel);
	public Map<String, Object> selectEmpDeptList(EmpModel empModel);
	public Map<String, Object> selectDeptTeacherList(DeptModel deptModel);
	public Map<String, Object> selectDeptClassList(String deptModel, String empModel);
	public Map<String, Object> getDliveList(EventSearchModel searchModel);
	public Map<String, Object> selectDliveRankingList(int eventSeq);
	
	public Map<String, Object> getMsuccRankingList(EventSearchModel searchModel);
	public Map<String, Object> getMsuccList(EventSearchModel searchModel);
	public Map<String, Object> getRouletteList(EventSearchModel searchModel);
	
}

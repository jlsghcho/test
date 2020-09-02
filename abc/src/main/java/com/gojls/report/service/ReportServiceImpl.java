package com.gojls.report.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.gojls.report.dao.ReportDao;
import com.gojls.report.model.DeptModel;
import com.gojls.report.model.EmpModel;
import com.gojls.report.model.ClassModel;
import com.gojls.report.model.DliveReportModel;
import com.gojls.report.model.EventSearchModel;
import com.gojls.report.model.MsuccRankingModel;
import com.gojls.report.model.MsuccReportModel;
import com.gojls.report.model.RouletteReportModel;
import com.gojls.report.service.ReportServiceImpl;
import com.gojls.report.model.DeptRnkingModel;

import org.apache.ibatis.session.SqlSession;

public class ReportServiceImpl  implements ReportService{

	private static final Logger LOGGER = LoggerFactory.getLogger(ReportServiceImpl.class);
	private final SqlSession SQL_SESSION;


	@Autowired
	public ReportServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }

	@Override
	public EmpModel authEmp(EmpModel empModel) {
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		return dlivedao.authEmp(empModel);
	}
	
	@Override
	public Map<String, Object> selectEmpDeptList(EmpModel empModel)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("deptList empList   >>>>>>>>>"  + empModel.getEmpSeq());
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<DeptModel> deptList = dlivedao.selectEmpDeptList(empModel);
		map.put("deptList", deptList);
		
		return map;
	}
	
	@Override
	public Map<String, Object>  selectDeptTeacherList(DeptModel deptModel)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<EmpModel> empList = dlivedao.selectDeptTeacherList(deptModel);
		map.put("teacherList", empList);

		return map;
	}
	
	@Override
	public Map<String, Object>  selectDeptClassList(String deptSeq, String empSeq)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<ClassModel> classList = dlivedao.selectDeptClassList(deptSeq, empSeq);
		map.put("classList", classList);
		return map;
		
	}	
	
	
	@Override
	public Map<String, Object>  getDliveList(EventSearchModel searchModel)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<DliveReportModel> dliveList = dlivedao.selectDliveList(searchModel);
		map.put("dliveList", dliveList);
		return map;
	}	
	
	@Override
	public Map<String, Object>  selectDliveRankingList(int eventSeq)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<DeptRnkingModel> dliveRankList = dlivedao.selectDliveRankingList(eventSeq);
		map.put("dliveRankList", dliveRankList);
		
		return map;
	}	
	
	
	@Override
	public Map<String, Object> getMsuccRankingList(EventSearchModel searchModel)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<MsuccRankingModel> msuccRank = dlivedao.selectMsuccRankingList(searchModel);
		map.put("msuccRank", msuccRank);
		
		return map;
	}
	
	@Override
	public Map<String, Object> getMsuccList(EventSearchModel searchModel)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<MsuccReportModel> msuccList = dlivedao.selectMsuccList(searchModel);
		map.put("msuccList", msuccList);
		
		return map;
	}
	
	@Override
	public Map<String, Object> getRouletteList(EventSearchModel searchModel)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		
		ReportDao dlivedao = SQL_SESSION.getMapper(ReportDao.class);
		List<RouletteReportModel> rouletteList = dlivedao.selectRouletteList(searchModel);
		map.put("rouletteList", rouletteList);
		
		return map;
	}

	
}

package com.gojls.math.index.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

//import com.gojls.math.common.controller._RssReader;
import com.gojls.math.index.dao.IndexDao;
import com.gojls.math.index.model.AdModel;
import com.gojls.math.index.model.DeptModel;
import com.gojls.math.index.model.NoticeModel;
import com.gojls.math.index.model.ReservationModel;
import com.gojls.math.index.model.TagModel;
import com.gojls.math.index.model.UserModel;
import com.gojls.util._Request;

import net.sf.json.JSONArray;

@Service
public class IndexServiceImpl implements IndexService  {
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Value("#{globalContext['NAVER_BLOG_RSS']?:'http://blog.rss.naver.com/gojlsblog.xml'}") protected String NAVER_BLOG_RSS;	
	
	@Autowired 
	@Qualifier("oracle")
	private SqlSession sqlSessionOracle;

	public ArrayList<DeptModel> selDeptList(DeptModel deptVo) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selDeptList(deptVo)");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		return indexDao.selDeptList(deptVo);
	}

	public ArrayList<ReservationModel> selReservationUserList(String param_user_seq) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selReservationUserList(param_user_seq)");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		return indexDao.selReservationUserList(param_user_seq);
	}

	public ArrayList<ReservationModel> selReservationDeptList(ReservationModel reservationVo) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selReservationDeptList(reservationVo)");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		
		//재원여부 cnt 가져오기
		UserModel userModel = new UserModel();
		userModel.setGtUserType("US6001");
		userModel.setUserSeq(reservationVo.getParam_user_seq());
		userModel.setDeptSeq(reservationVo.getParam_dept_seq());
		int clsUserCnt = indexDao.selClsUserCnt(userModel);
		reservationVo.setParam_cls_user_cnt(clsUserCnt);
		
		//회원정보 가져오기
		ArrayList<UserModel> userList = indexDao.selUserList(userModel);
		reservationVo.setParam_gt_grade(userList.get(0).getGtGrade());
		
		return indexDao.selReservationDeptList(reservationVo);
	}

	public ArrayList<UserModel> selUserList(UserModel userVo) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selUserList(userVo)");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		return indexDao.selUserList(userVo);
	}

	public Map<String, Object> insReservationAccept(ReservationModel reservationVo) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selReservationDeptList(reservationVo)");}
		Map<String, Object> resultMap = new HashMap<String,Object>();
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		try {
			if(reservationVo.isParam_reserv_tf()) { //예약신청 
				if(indexDao.selReservationLimitChk(reservationVo) == 0) {
					resultMap = _Request.setResult("error", "1003: 예약정원이 초과 되었습니다. 예약을 원하실 경우 분원으로 문의해 주세요.", null);
				}else {
					if(indexDao.selReservationUserChk(reservationVo) == 0) {
						reservationVo.setParam_dept_seq(indexDao.selReservationDept(reservationVo));

						//해당분원에 학생이 없다면 저장 
						if(indexDao.selReservationDeptChk(reservationVo) == 0) { indexDao.insReservationDept(reservationVo); }
						// 예약 저장 
						indexDao.insReservationUser(reservationVo);
						// 만약 전형료가 있다면 수강료쪽에서도 저장해 줘야 함. 
						ReservationModel reservationVos = new ReservationModel();
						reservationVos = indexDao.selReservationPayChk(reservationVo);
						
						reservationVo.setAmount(reservationVos.getAmount());
						reservationVo.setStartDt(reservationVos.getStartDt());
						reservationVo.setGtReservationTypeNm(reservationVos.getGtReservationTypeNm());
						
						if( reservationVo.getAmount() > 0 && indexDao.selReservationPayIs(reservationVo) == 0) {
							reservationVo.setParam_charge_nm("["+ reservationVo.getStartDt().substring(0, 6) +"] "+ reservationVo.getGtReservationTypeNm() +" 전형료");
							reservationVo.setParam_charge_month(reservationVo.getStartDt().substring(0, 6));
							
							indexDao.insReservationPay(reservationVo); 
						} 
						resultMap = _Request.setResult("success", "", null);
					}else {
						resultMap = _Request.setResult("error", "1001:이미 예약된 이력이 있습니다. 관리자에게 문의 바랍니다.", null);
					}
				}
			}else { //예약취소 
				if(indexDao.selReservationUserChk(reservationVo) > 0) {
					ReservationModel reservVo = new ReservationModel();
					reservVo = indexDao.selReservationPayList(reservationVo);
					if(reservVo.getUserChargeSeq() > 0) { // 전형료가 있으니 삭제하고 가라  
						if(reservVo.getGtChargeChk().equals("PA2001")) { indexDao.delUserCharge(reservVo); } 
					}
					indexDao.delReservation(reservVo);
					resultMap = _Request.setResult("success", "", null);
				}else {
					resultMap = _Request.setResult("error", "1002: 예약된 이력이 없습니다. 관리자에게 문의 바랍니다.", null);
				}
			}
		}catch(Exception ex) {
			logger.error(ex.getMessage());
			resultMap = _Request.setResult("error", "9999:"+ ex.getMessage(), null);
		}
		return resultMap;
	}

	public Map<String, Object> insRssAccept(String param_get_code) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] insRssAccept(param_get_code)");}
		Map<String, Object> resultMap = new HashMap<String,Object>();
		try {
			String param_rss_url = "";
			if(param_get_code.equals("naver")) { param_rss_url = NAVER_BLOG_RSS; }
			
			if(!param_rss_url.equals("")) {
				//_RssReader reader = _RssReader.getInstance();
				//reader.setURL(new URL(param_rss_url));
				//int getCount = 2; // Rss 몇개가지고 올건지 
				//resultMap = _Request.setResult("success", "", JSONArray.fromObject(reader.writeFeed(getCount)).toString());
			}else {
				resultMap = _Request.setResult("error", "9001:RSS URL이 없습니다.", null);
			}
			
		}catch(Exception ex) {
			logger.error(ex.getMessage());
			resultMap = _Request.setResult("error", "9999:"+ ex.getMessage(), null);
		}
		return resultMap;
	}

	public NoticeModel selNoticeView(int param_notice_seq) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selNoticeView(param_notice_seq)");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		indexDao.upNoticeView(param_notice_seq);
		return indexDao.selNoticeView(param_notice_seq);
	}

	public Map<String, Object> insAdCheck(AdModel adVo) {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] insAdCheck(map)");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		Map<String, Object> resultMap = new HashMap<String,Object>();
		try {
			if(indexDao.insAd(adVo) > 0) {
				Map<String, Object> resultMap1 = new HashMap<String,Object>();
				resultMap1.put("count", indexDao.selAdCount(adVo));
				resultMap = _Request.setResult("success", "", JSONArray.fromObject(resultMap1).toString());
			}else {
				resultMap = _Request.setResult("error", "데이터 저장 실패", null);
			}
		}catch(Exception ex) {
			logger.error(ex.getMessage());
			resultMap = _Request.setResult("error", "데이터 저장 실패", null);
		}
		return resultMap;
	}

	public ArrayList<TagModel> selTagList() {
		if (logger.isDebugEnabled()) {	logger.debug("[jls-math/IndexServiceImpl] selTagList()");}
		IndexDao indexDao = sqlSessionOracle.getMapper(IndexDao.class);
		return indexDao.selTagList();
	}
}

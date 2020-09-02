package com.gojls.math.index.dao;

import java.util.ArrayList;

import com.gojls.math.index.model.AdModel;
import com.gojls.math.index.model.DeptModel;
import com.gojls.math.index.model.NoticeModel;
import com.gojls.math.index.model.ReservationModel;
import com.gojls.math.index.model.TagModel;
import com.gojls.math.index.model.UserModel;

public interface IndexDao {
	public ArrayList<DeptModel> selDeptList(DeptModel deptVo);
	public ArrayList<UserModel> selUserList(UserModel userVo);
	public int selClsUserCnt(UserModel userVo);
	public ArrayList<ReservationModel> selReservationUserList(String param_user_seq);
	public ArrayList<ReservationModel> selReservationDeptList(ReservationModel reservationVo);
	public int selReservationUserChk(ReservationModel reservationVo);
	public int selReservationLimitChk(ReservationModel reservationVo); //예약인원체크 
	
	public int selReservationDept(ReservationModel reservationVo);
	public int selReservationDeptChk(ReservationModel reservationVo);
	public int insReservationDept(ReservationModel reservationVo);
	
	public ReservationModel selReservationPayChk(ReservationModel reservationVo);
	public int insReservationUser(ReservationModel reservationVo);
	public int selReservationPayIs(ReservationModel reservationVo);
	public int insReservationPay(ReservationModel reservationVo);
	
	public ReservationModel selReservationPayList(ReservationModel reservationVo);
	public int delUserCharge(ReservationModel reservationVo);
	public int delReservation(ReservationModel reservationVo);
	
	public NoticeModel selNoticeView(int param_notice_seq);
	public int upNoticeView(int param_notice_seq);

	// 광고관련 소스 
	public int selAdCount(AdModel adVo);
	public int insAd(AdModel adVo);
	
	public ArrayList<TagModel> selTagList();
}

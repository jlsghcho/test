package com.gojls.math.index.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.gojls.math.index.model.AdModel;
import com.gojls.math.index.model.DeptModel;
import com.gojls.math.index.model.NoticeModel;
import com.gojls.math.index.model.ReservationModel;
import com.gojls.math.index.model.TagModel;
import com.gojls.math.index.model.UserModel;

@Transactional
public interface IndexService {
	public ArrayList<DeptModel> selDeptList(DeptModel deptVo);
	public ArrayList<UserModel> selUserList(UserModel userVo);
	public ArrayList<ReservationModel> selReservationUserList(String param_user_seq);
	public ArrayList<ReservationModel> selReservationDeptList(ReservationModel reservationVo);
	
	public Map<String, Object> insReservationAccept(ReservationModel reservationVo);
	public Map<String, Object> insRssAccept(String param_get_code); 
	
	public NoticeModel selNoticeView(int param_notice_seq);
	public Map<String, Object> insAdCheck(AdModel adVo);

	public ArrayList<TagModel> selTagList();
}

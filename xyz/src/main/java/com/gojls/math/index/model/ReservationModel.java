package com.gojls.math.index.model;

public class ReservationModel {
	private int reservationSeq;
	private String gtReservationType;
    private String deptNm;
    private String title;
    private String startDt;
    private String endDt;
    private String gtTimeHH;
    private String gtTimeMM;
    private int runTime;
    private String position;
    private int amount;
    private int userReservationSeq;
    private String gtChargeChk;
    private String oldYn;
    private int deptSeq;
    private String onlineStartDt;
    private String onlineEndDt;
    private String agendaNote;
    private String announceNote;
    private String arrCompare;
    private String param_user_seq;
    private int param_dept_seq;
    private boolean param_reserv_tf;
    
    private String param_reg_seq;
    private String param_reg_nm;
    
    private String param_charge_nm;
    private String param_charge_month;
	private String gtReservationTypeNm;
	private long userChargeSeq;
	
	private int param_cls_user_cnt;
	private String param_gt_grade;
	private String startTime;
	private String endTime;
	
	public int getReservationSeq() {
		return reservationSeq;
	}
	public void setReservationSeq(int reservationSeq) {
		this.reservationSeq = reservationSeq;
	}
	public int getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(int deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getOnlineStartDt() {
		return onlineStartDt;
	}
	public void setOnlineStartDt(String onlineStartDt) {
		this.onlineStartDt = onlineStartDt;
	}
	public String getOnlineEndDt() {
		return onlineEndDt;
	}
	public void setOnlineEndDt(String onlineEndDt) {
		this.onlineEndDt = onlineEndDt;
	}
	public String getAgendaNote() {
		return agendaNote;
	}
	public void setAgendaNote(String agendaNote) {
		this.agendaNote = agendaNote;
	}
	public String getAnnounceNote() {
		return announceNote;
	}
	public void setAnnounceNote(String announceNote) {
		this.announceNote = announceNote;
	}
    public String getGtReservationType() {
		return gtReservationType;
	}
	public void setGtReservationType(String gtReservationType) {
		this.gtReservationType = gtReservationType;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getGtTimeHH() {
		return gtTimeHH;
	}
	public void setGtTimeHH(String gtTimeHH) {
		this.gtTimeHH = gtTimeHH;
	}
	public String getGtTimeMM() {
		return gtTimeMM;
	}
	public void setGtTimeMM(String gtTimeMM) {
		this.gtTimeMM = gtTimeMM;
	}
	public int getRunTime() {
		return runTime;
	}
	public void setRunTime(int runTime) {
		this.runTime = runTime;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getUserReservationSeq() {
		return userReservationSeq;
	}
	public void setUserReservationSeq(int userReservationSeq) {
		this.userReservationSeq = userReservationSeq;
	}
	public String getGtChargeChk() {
		return gtChargeChk;
	}
	public void setGtChargeChk(String gtChargeChk) {
		this.gtChargeChk = gtChargeChk;
	}
	public String getOldYn() {
		return oldYn;
	}
	public void setOldYn(String oldYn) {
		this.oldYn = oldYn;
	}
	public String getParam_user_seq() {
		return param_user_seq;
	}
	public void setParam_user_seq(String param_user_seq) {
		this.param_user_seq = param_user_seq;
	}
	public int getParam_dept_seq() {
		return param_dept_seq;
	}
	public void setParam_dept_seq(int param_dept_seq) {
		this.param_dept_seq = param_dept_seq;
	}
	public String getArrCompare() {
		return arrCompare;
	}
	public void setArrCompare(String arrCompare) {
		this.arrCompare = arrCompare;
	}
	public boolean isParam_reserv_tf() {
		return param_reserv_tf;
	}
	public void setParam_reserv_tf(boolean param_reserv_tf) {
		this.param_reserv_tf = param_reserv_tf;
	}
	public String getParam_reg_seq() {
		return param_reg_seq;
	}
	public void setParam_reg_seq(String param_reg_seq) {
		this.param_reg_seq = param_reg_seq;
	}
	public String getParam_reg_nm() {
		return param_reg_nm;
	}
	public void setParam_reg_nm(String param_reg_nm) {
		this.param_reg_nm = param_reg_nm;
	}
	public String getParam_charge_nm() {
		return param_charge_nm;
	}
	public void setParam_charge_nm(String param_charge_nm) {
		this.param_charge_nm = param_charge_nm;
	}
	public String getParam_charge_month() {
		return param_charge_month;
	}
	public void setParam_charge_month(String param_charge_month) {
		this.param_charge_month = param_charge_month;
	}
	public String getGtReservationTypeNm() {
		return gtReservationTypeNm;
	}
	public void setGtReservationTypeNm(String gtReservationTypeNm) {
		this.gtReservationTypeNm = gtReservationTypeNm;
	}
	public long getUserChargeSeq() {
		return userChargeSeq;
	}
	public void setUserChargeSeq(long userChargeSeq) {
		this.userChargeSeq = userChargeSeq;
	}
	public int getParam_cls_user_cnt() {
		return param_cls_user_cnt;
	}
	public void setParam_cls_user_cnt(int param_cls_user_cnt) {
		this.param_cls_user_cnt = param_cls_user_cnt;
	}
	public String getParam_gt_grade() {
		return param_gt_grade;
	}
	public void setParam_gt_grade(String param_gt_grade) {
		this.param_gt_grade = param_gt_grade;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}

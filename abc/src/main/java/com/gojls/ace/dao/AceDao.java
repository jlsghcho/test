package com.gojls.ace.dao;

import com.gojls.ace.model.Content;
import com.gojls.ace.model.Event;
import com.gojls.ace.model.Ranking;
import com.gojls.ace.model.RegionCountPair;
import com.gojls.ace.model.User;
import com.gojls.ace.model.UserInfo;
import com.gojls.ace.model.Teacher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AceDao {
	
	List<Event> selectEvents();
	User selectUser(@Param("userSequence") String userSequence);
	
	int selectIfAttending(@Param("userSequence") String userSequence);
	List<RegionCountPair> selectTopReportingRegions(@Param("eventSequence") int eventSequence);
	List<RegionCountPair> selectTopArrestingRegions(@Param("eventSequence") int eventSequence);

	int selectMyReportCount(@Param("eventSequence") int eventSequence, @Param("userSequence") String userSequence);
	int selectTotalReportCount(@Param("eventSequence") int eventSequence);
	int selectMyArrestCount(@Param("eventSequence") int eventSequence, @Param("userSequence") String userSequence);
	int selectTotalArrestCount(@Param("eventSequence") int eventSequence);

	List<Content> selectReports(@Param("eventSequence") int eventSequence, @Param("userSequence") String userSequence, @Param("numberOfLeadingRows") int numberOfLeadingRows, @Param("page") int page, @Param("rowsPerPage") int rowsPerPage);
	List<Content> selectArrests(@Param("eventSequence") int eventSequence, @Param("userSequence") String userSequence, @Param("numberOfLeadingRows") int numberOfLeadingRows, @Param("page") int page, @Param("rowsPerPage") int rowsPerPage);

	int selectReportCountByNumber(@Param("eventSequence") int eventSequence, @Param("userSequence") String userSequence, @Param("questionType") String questionType, @Param("questionNumber") int questionNumber);
	int selectArrestCountByNumber(@Param("eventSequence") int eventSequence, @Param("userSequence") String userSequence, @Param("questionType") String questionType,  @Param("questionNumber") int questionNumber);

	int hideContent(@Param("sequence") int sequence);
	
	int insertArrest(Content content);
	int insertReport(Content content);
	
	
	Event selectLastEvent();   // New
	Event selectTargetEvent(int eventSequence);
	UserInfo selectUserInfo(@Param("userSequence") String userSequence);   // New
	Teacher selectTeacher(@Param("userSequence") String userSequence);
	List<Teacher> selectTeachers(@Param("userSequence") String userSequence);   // New
	
	
	int insertReportNew( 
			@Param("eventSequence") int eventSequence, @Param("questionType") String  questionType ,@Param("questionNumber") int questionNumber, 
			@Param("pathToImage1") String pathToImage1, @Param("pathToImage2") String pathToImage2, 
			@Param("userSequence") String userSequence,	@Param("userId") String userId, @Param("userName") String userName,	
			@Param("schoolName") String schoolName,	@Param("grade") String grade,  
			@Param("departmentSequence") String departmentSequence,	@Param("departmentName") String departmentName, 
			@Param("teacherSequence") String teacherSequence, @Param("teacherName")  String teacherName, @Param("comment") String comment);
	
	int insertArrestNew( 
			@Param("eventSequence") int eventSequence, @Param("questionType") String  questionType ,@Param("questionNumber") int questionNumber, 
			@Param("pathToImage1") String file1, @Param("pathToImage2") String file2, 
			@Param("userSequence") String userSequence,	@Param("userId") String userId, @Param("userName") String userName,	
			@Param("schoolName") String schoolName, @Param("grade") String grade, 
			@Param("departmentSequence") String departmentSequence,	@Param("departmentName") String departmentName, 
			@Param("teacherSequence") String teacherSequence, @Param("teacherName")  String teacherName);
	
	List<Ranking> selectUserRanking(@Param("eventSequence") int eventSequence);
	List<Ranking> selectTeacherRanking(@Param("startdate") String startdate, @Param("enddate") String enddate);
	
	
}

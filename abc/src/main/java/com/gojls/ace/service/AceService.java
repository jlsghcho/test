package com.gojls.ace.service;

import com.gojls.ace.model.Content;
import com.gojls.ace.model.Event;
import com.gojls.ace.model.Ranking;
import com.gojls.ace.model.User;
import com.gojls.ace.model.UserInfo;
import com.gojls.common.helpers.encoding.EncodingHelper;
import com.gojls.ace.model.Teacher;
import com.gojls.secret.UploadResult;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

public interface AceService {
	Event getEvent();
	User getUser(String userSequence);
	
	AceServiceImpl.ContentMetadata getReports(int eventSequence, String userSequence, int page, int contentsPerPage);
	AceServiceImpl.ContentMetadata getArrests(int eventSequence, String userSequence, int page, int contentsPerPage);
	UploadResult uploadContent(int eventSequence, MultipartFile file1, MultipartFile file2, Content content, boolean hasComment);
	int hideContent(int sequence);
		
	Event getLastEvent();
	Event getTargetEvent(int eventSequence);
	UserInfo getUserInfo(String userSequence);
	List<Teacher> getTeacherList(String userSequence);
	Teacher getTeacher(String userSequence);
	
	UploadResult uploadContentsNew(int eventSequence, String contentsType, String questionType, int questionNumber,   
			String userSequence, String userId, String userName,String schoolName, String grade, 
			String departmentSequence, String departmentName, String teacherSequence, String teacherName, 
			MultipartFile file1, MultipartFile file2, boolean hasComment,	String comment);
	
	
	List<Ranking> getTeacherRanking(String startdate, String enddate);
	List<Ranking> getUserRanking(int eventSequence);
	
}

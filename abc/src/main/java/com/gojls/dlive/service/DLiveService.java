package com.gojls.dlive.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gojls.dlive.UploadResult;
import com.gojls.dlive.model.Content;
import com.gojls.dlive.model.EventList;
import com.gojls.dlive.model.EventModel;
import com.gojls.dlive.model.StudentModel;

@Transactional
public interface DLiveService {
	
	void setAddPageCount(String eventNum);
	
	EventModel getCurrentEventInfo();
	EventModel getEventInfo(String eventSeq); 
	List<EventList> getEventList(String eventSeq);
	
	public List<StudentModel> getStudentInfo(String userSeq, String h1kEventSeq);
	public List<StudentModel> getCildrenList(String userSeq, String h1kEventSeq);

	int getUserTimeInfo(String userSeq, String h1kEventSeq);
	
	int getTotalUploadCount(String eventNum);
	int getOwnUploadCount(String userSequence, String eventSeq);	
	
	List<Content> getContents(int page, int contentsPerPage, String eventSeq);	
	List<Content> getOwnContents(String userSequence, String eventSeq);

	UploadResult uploadText(String text, String userSeq, String userName, String eventSeq);
	UploadResult uploadImage(MultipartFile file,  String text, String userSeq, String userName, String eventSeq);
	
	boolean changeDLiveUseInfo(String userSeq, String userName,  int dliveSeq);
	


}

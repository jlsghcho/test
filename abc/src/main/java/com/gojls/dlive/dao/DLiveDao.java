package com.gojls.dlive.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.gojls.dlive.model.Content;
import com.gojls.dlive.model.EventList;
import com.gojls.dlive.model.EventModel;
import com.gojls.dlive.model.StudentModel;

public interface DLiveDao {
	
	void addPageCount(@Param("eventSeq") String eventSeq);
	
	EventModel selectEventInfo(@Param("eventSeq") String eventSeq);
	List<EventList> selectEventList(@Param("eventSeq") String eventSeq);
	EventModel selectCurrentEventInfo(); 
	
	
	List<StudentModel> selectStudentInfo( @Param("userSeq") String userSeq, @Param("h1kEventSeq") String h1kEventSeq);
	List<StudentModel> selectCildrenList( @Param("userSeq") String userSeq, @Param("h1kEventSeq") String h1kEventSeq);
	
	int selectUserTimeInfo(@Param("userSeq") String userSeq, @Param("h1kEventSeq") String h1kEventSeq);
	int selectTotalUploadCount(@Param("eventSeq") String eventSeq);
	int selectOwnUploadCount(@Param("userSeq") String userSeq, @Param("eventSeq") String eventSeq);
	
	List<Content> selectContents(@Param("page") int page, @Param("rowsPerPage") int rowsPerPage, @Param("eventSeq") String eventSeq);
	List<Content> selectOwnContents(@Param("userSeq") String userSeq, @Param("eventSeq") String eventSeq);
		
	int insertIntoTimeDay(@Param("userSeq") String userSeq, @Param("userName") String userName, @Param("timeCount") int timeCount);
	int insertText(@Param("text") String text, @Param("userSeq") String userSeq, @Param("userName") String userName, @Param("eventSeq") String eventSeq);
	int insertImage(@Param("imageUrl") String imageUrl, @Param("text") String text,	@Param("userSeq") String userSeq, @Param("userName") String userName, @Param("eventSeq") String eventSeq);
	
	int updateDLiveUseInfo(@Param("userSeq") String userSeq, @Param("dliveSeq") int dliveSeq);
	
	
}

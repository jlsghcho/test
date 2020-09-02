package com.gojls.dlive.service;

import com.gojls.Global;
import com.gojls.common.helpers.upload.Uploader;
import com.gojls.dlive.UploadResult;
import com.gojls.dlive.dao.DLiveDao;
import com.gojls.dlive.model.Content;
import com.gojls.dlive.model.EventList;
import com.gojls.dlive.model.StudentModel;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gojls.dlive.model.EventModel;

public class DLiveServiceImpl implements DLiveService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DLiveServiceImpl.class);
	private final SqlSession SQL_SESSION;
	
	@Autowired
	public DLiveServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }
	
	@Override
	public void setAddPageCount(String eventNum)
	{
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);	
		dlivedao.addPageCount(eventNum);
	}
	
	@Override
	public EventModel getCurrentEventInfo()
	{
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);	
		return dlivedao.selectCurrentEventInfo();
	}

	@Override
	public EventModel getEventInfo(String eventSeq) {
		
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		return dlivedao.selectEventInfo(eventSeq);		
	}
		
	@Override 
	public List<EventList> getEventList(String eventSeq)
	{
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		List<EventList> eventList = new ArrayList<EventList>();
		List<EventList> allList = dlivedao.selectEventList(eventSeq);
		for(EventList listToADD : allList) {
			eventList.add(listToADD); 
		}
		return eventList;
	}
	
	@Override
	public List<StudentModel> getStudentInfo(String userSeq, String h1kEventSeq){
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);		
		List<StudentModel> list = dlivedao.selectStudentInfo(userSeq, h1kEventSeq);
		return list;		
	}	
	
	@Override
	public List<StudentModel> getCildrenList(String userSeq, String h1kEventSeq) {
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);		
		List<StudentModel> list = dlivedao.selectCildrenList(userSeq, h1kEventSeq);
		return list;
	}
	
	@Override
	public int getUserTimeInfo(String userSeq, String h1kEventSeq) {
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		return dlivedao.selectUserTimeInfo(userSeq, h1kEventSeq);		
	}
	
	@Override
	public int getTotalUploadCount(String eventSeq) {
		
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		return dlivedao.selectTotalUploadCount(eventSeq);		
	}

	@Override
	public int getOwnUploadCount(String userSequence, String eventSeq) {
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		return dlivedao.selectOwnUploadCount(userSequence, eventSeq);
	}
	
	@Override
	public boolean changeDLiveUseInfo(String userSeq, String userName, int dliveSeq)
	{
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		
		int result = 0;
		try {
			result = dlivedao.updateDLiveUseInfo(userSeq, dliveSeq);
			if(result == 1) {
				result = dlivedao.insertIntoTimeDay(userSeq, userName, -300);
				if(result < 1) {  }
				
			} else {}
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);
			
		}

		
		return (result == 1);
	}
	
	public List<Content> getContents(int page, int contentsPerPage, String eventSeq) {
		
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		List<Content> contents = new ArrayList<Content>();
		contents = dlivedao.selectContents(page, contentsPerPage, eventSeq);
		return contents;
	}
	
	public List<Content> getOwnContents(String userSequence, String eventSeq){	
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);
		List<Content> contents = new ArrayList<Content>();
		if(userSequence != null) { contents = dlivedao.selectOwnContents(userSequence, eventSeq);}
		return contents;
	}
	
	
	@Override
	public UploadResult uploadText(String text, String userSeq, String userName, String eventSeq) {
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);

		boolean success = false;
		List<String> messages = new ArrayList<String>();

			int uploadCount;
			
			try {
				uploadCount = dlivedao.selectOwnUploadCount(userSeq, eventSeq);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);
				uploadCount = 0;
			}

			String totUploadCountStr  = String.valueOf(Global.Secret.getMaximumUploadCount());
			if(uploadCount < Global.Secret.getMaximumUploadCount()) {
				int affectedRows;
							
				try {
				
					affectedRows = dlivedao.insertText(text, userSeq, userName, eventSeq);
					
					if(affectedRows >= 1) {
					
						success = true;
						messages.add("             " + userName + "학생의\n " + "DreamTree 인증이 완료 되었습니다.\n\n           " + (uploadCount + 1) + "회 /총" + totUploadCountStr +"회 인증완료 \n영어노출 시간 적용은 다음 날 적용됩니다.");
						affectedRows = dlivedao.insertIntoTimeDay(userSeq, userName, 300);
						
						if(affectedRows < 1) { LOGGER.warn("Succeeded in uploading text but not increasing hours."); }
						
					} else {
						success = false;
						messages.add("DreamTree 후기인증에 실패했습니다.");
					}
					
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
				}
				
			} else {
				success = false;
				messages.add("             " + userName + "학생의\n" + "DreamTree 인증 횟수를 초과하였습니다.\n\n     최대 " + totUploadCountStr + "건까지 인증이 가능합니다.");
			}
		
		return new UploadResult(success, messages);
	}
	
	@Override
	public UploadResult uploadImage(MultipartFile file, String text, String userSeq, String userName, String eventSeq) {
		DLiveDao dlivedao = SQL_SESSION.getMapper(DLiveDao.class);

		boolean success = false;
		List<String> messages = new ArrayList<String>();
		
			int uploadCount;
			
			try {
				uploadCount = dlivedao.selectOwnUploadCount(userSeq, eventSeq);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);
				uploadCount = 0;
				System.out.println("exception:" + eventSeq);
			}

			String totUploadCountStr  = String.valueOf(Global.Secret.getMaximumUploadCount());
			if(uploadCount < Global.Secret.getMaximumUploadCount()) {
				long size;
				try {
					
					System.out.println("############################# Save Image");
					size = file.getSize();					
					
				} catch(Exception exception) {
					size = -1;
					messages.add(exception.getMessage());
					LOGGER.error(exception.getMessage(), exception);
				}

				if(size >= Global.getImageSizeLimit() && size > 0) {
					messages.add("인증에 사용하는 사진은 10MB를 넘을 수 없습니다.");
				} else {
					
					Uploader uploader = null;					
					try {
						uploader = new Uploader();
						String filePath = uploader.upload(file, userSeq, Uploader.EventType.SECRET).replace("\\", "/");
						System.out.println(filePath);
						int affectedRows = dlivedao.insertImage(filePath, text, userSeq, userName, eventSeq);
						if(affectedRows >= 1) {
							success = true;
							messages.add("             " + userName + "학생의\n " + "DreamTree 인증이 완료 되었습니다.\n\n           " + (uploadCount + 1) + "회 /총" + totUploadCountStr +"회 인증완료 \n영어노출 시간 적용은 다음 날 적용됩니다.");
							affectedRows = dlivedao.insertIntoTimeDay(userSeq, userName, 300);
							if(affectedRows < 1) { LOGGER.warn("Succeeded in uploading image but not increasing hours."); }
						} else {
							throw new SQLException();
						}

						success = true;
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);

						if(uploader != null) { uploader.undoStoring(); }
						messages.add("DreamTree 후기인증에 실패했습니다.");
					}
					
				}
			} else {
				success = false;
				messages.add("             " + userName + "학생의\n" + "DreamTree 인증 횟수를 초과하였습니다.\n\n     최대 " + totUploadCountStr + "건까지 인증이 가능합니다.");
			}
		
		return new UploadResult(success, messages);
	}

}

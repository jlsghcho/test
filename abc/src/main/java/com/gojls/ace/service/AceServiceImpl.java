package com.gojls.ace.service;

import com.gojls.Global;
import com.gojls.ace.dao.AceDao;
import com.gojls.ace.model.Content;
import com.gojls.ace.model.Event;
import com.gojls.ace.model.Ranking;
import com.gojls.ace.model.RegionCountPair;
import com.gojls.ace.model.User;
import com.gojls.ace.model.UserInfo;
import com.gojls.ace.model.Teacher;
import com.gojls.common.helpers.upload.Uploader;
import com.gojls.secret.UploadResult;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class AceServiceImpl implements AceService {
	private static final Logger LOGGER = LoggerFactory.getLogger(AceServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public AceServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }

	@Override
	public Event getEvent() {
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		List<Event> events = aceDao.selectEvents();
		Optional<Event> eventOptional = events.stream()
			.filter(Event::isItPeriod)
			.sorted(Comparator.comparingInt(Event::getSequence))
			.findFirst();

		Event result = eventOptional.orElse(null);
		if(result == null) {
			eventOptional = events.stream()
				.filter(Event::isAfterPeriod)
				.sorted(Comparator.comparingInt(Event::getSequence))
				.findFirst();
			result = eventOptional.orElse(null);
		}

		return result;
	}
	
	@Override
	public Event getLastEvent()
	{	
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		Event event= aceDao.selectLastEvent();
		return event;
	}
	
	
	@Override
	public Event getTargetEvent(int eventSequence)
	{	
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		Event event= aceDao.selectTargetEvent(eventSequence);
		return event;
	}
	
	
	
	@Override
	public User getUser(String userSequence) {
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		User user = aceDao.selectUser(userSequence);
		boolean isAttending = (aceDao.selectIfAttending(userSequence) == 1);
		if(user != null) { 
			user.setAttending(isAttending); 
		}
		return user;
	}
	
	@Override
	public UserInfo getUserInfo(String userSequence)
	{
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		UserInfo user = aceDao.selectUserInfo(userSequence);
		return user;
	}

	
	@Override
	public List<Teacher> getTeacherList(String userSequence)
	{
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		List<Teacher> teachers = aceDao.selectTeachers(userSequence);
		return teachers;
	}
	
	@Override
	public Teacher getTeacher(String userSequence)
	{
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		Teacher teacher = aceDao.selectTeacher(userSequence);
		return teacher;
	}
	
	@Override
	public ContentMetadata getReports(int eventSequence, String userSequence, int page, int contentsPerPage) {
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);

		int numberOfReports = aceDao.selectTotalReportCount(eventSequence);
		int numberOfMyReports = aceDao.selectMyReportCount(eventSequence, userSequence);
		List<Content> reports = aceDao.selectReports(eventSequence, userSequence, numberOfMyReports, page, contentsPerPage);
		decideOwnership(reports, userSequence);
		List<RegionCountPair> regionCountPairs = aceDao.selectTopReportingRegions(eventSequence);

		return new ContentMetadata(numberOfMyReports, numberOfReports, reports, regionCountPairs);
	}
	
	@Override
	public ContentMetadata getArrests(int eventSequence, String userSequence, int page, int contentsPerPage) {
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);

		int numberOfArrests = aceDao.selectTotalArrestCount(eventSequence);
		int numberOfMyArrests = aceDao.selectMyArrestCount(eventSequence, userSequence);
		List<Content> arrests = aceDao.selectArrests(eventSequence, userSequence, numberOfMyArrests, page, contentsPerPage);
		decideOwnership(arrests, userSequence);
		List<RegionCountPair> regionCountPairs = aceDao.selectTopArrestingRegions(eventSequence);
		return new ContentMetadata(numberOfMyArrests, numberOfArrests, arrests, regionCountPairs);
	}

	@Override
	public UploadResult uploadContent(int eventSequence, MultipartFile file1, MultipartFile file2, Content content, boolean hasComment) {
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);

		boolean success = true;
		List<String> messages = new ArrayList<String>();

		int uploadCount = 0;

		String userSequence = content.getUserSequence();
		LocalDateTime startDateTime = Global.Secret.getStartDate();
		LocalDateTime endDateTime = Global.Secret.getEndDate();
		boolean isItEventPeriod = (LocalDateTime.now().isAfter(startDateTime)) && (LocalDateTime.now().isBefore(endDateTime));
		if(isItEventPeriod) {
			try {
				if(hasComment) {
					uploadCount = aceDao.selectMyReportCount(eventSequence, content.getUserSequence());
				} else {
					uploadCount = aceDao.selectMyArrestCount(eventSequence, content.getUserSequence());
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				uploadCount = 0;
			}

			int maximumUploadCount = (hasComment? Global.Wanted.getMaximumReportCount(): Global.Wanted.getMaximumArrestCount());
			if(uploadCount < maximumUploadCount) {
				int contentCountByNumber;
				if(hasComment) {
					contentCountByNumber = aceDao.selectReportCountByNumber(eventSequence, userSequence, content.getQuestionType(), content.getQuestionNumber());
				} else {
					contentCountByNumber = aceDao.selectArrestCountByNumber(eventSequence, userSequence, content.getQuestionType(),  content.getQuestionNumber());
				}

				if(contentCountByNumber < 1) {
					long size1, size2;
					try {
						size1 = file1.getSize();
					} catch(Exception exception) {
						size1 = -1;
						messages.add(exception.getMessage());
						LOGGER.error(exception.getMessage(), exception);
					}
					try {
						size2 = file2.getSize();
					} catch(Exception exception) {
						size2 = -1;
						messages.add(exception.getMessage());
						LOGGER.error(exception.getMessage(), exception);
					}

					if(size1 >= Global.getImageSizeLimit() || size2 >= Global.getImageSizeLimit()) {
						messages.add("업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.");
					} else if(size1 <= 0 || size2 <= 0) {
						messages.add("파일에 문제가 있습니다. 다른 파일로 다시 시도해 보세요.");
					} else {
						Uploader uploader = null;
						try {
							uploader = new Uploader();
							String filePath1 = uploader.upload(file1, userSequence, Uploader.EventType.WANTED).replace("\\", "/");
							String filePath2 = uploader.upload(file2, userSequence, Uploader.EventType.WANTED).replace("\\", "/");
							content.setPathToImage1(filePath1);
							content.setPathToImage2(filePath2);

							if(hasComment) {
								aceDao.insertReport(content);
							} else {
								aceDao.insertArrest(content);
							}
						} catch(Exception exception) {
							LOGGER.error(exception.getMessage(), exception);

							if(uploader != null) { uploader.undoStoring(); }
							messages.add((hasComment? "신고": "검거") + "에 실패했습니다.");
						}
					}
				} else {
					success = false;
					if(hasComment) {
						messages.add("문항 번호 당 1건의 유사문제 신고가 가능합니다.");
					} else {
						messages.add("문항 번호 당 1건의 문제 풀이 검거가 가능합니다.");
					}
				}
			} else {
				success = false;
				if(hasComment) {
					messages.add(maximumUploadCount + "건의 신고 등록을 초과하였습니다.\n포상선물 추첨 및 선착순 결과는 6월8일(목) 발표 됩니다.");
				} else {
					messages.add(maximumUploadCount + "건의 검거 등록을 초과하였습니다.\n포상선물 추첨 및 선착순 결과는 6월8일(목) 발표 됩니다.");
				}
			}
		} else {
			success = false;
			messages.add("현재 접수 기간이 아닙니다.\\n접수 기간: 5월18일 ~ 5월31일");
		}

		if(success) {
			if(hasComment) {
				messages.add("유사문제 신고가 완료 되었습니다.\n나의 신고 실적 현재 " + (uploadCount + 1) + "건/ 최대 " + Global.Wanted.getMaximumReportCount() + "건 신고 접수완료");
			} else {
				messages.add("난이도 상 문제가 검거 완료 되었습니다.\n나의 검거 실적 현재 " + (uploadCount + 1) + "건/ 최대 " + Global.Wanted.getMaximumReportCount() + "건 검거 완료");
			}
		}

		return new UploadResult(success, messages);
	}
	
	
	
	@Override
	public UploadResult uploadContentsNew(int eventSequence, String contentsType, String questionType, int questionNumber,   
				String userSequence, String userId, String userName, String schoolName, String grade, 
				String departmentSequence, String departmentName, String teacherSequence, String teacherName,
				MultipartFile file1, MultipartFile file2, boolean hasComment, String comment)
	{
		
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);

		boolean success = true;
		List<String> messages = new ArrayList<String>();

		 
		int uploadCount = 0;
		
		try {
			if(hasComment) {
				uploadCount = aceDao.selectMyReportCount(eventSequence, userSequence);
			} else {
				uploadCount = aceDao.selectMyArrestCount(eventSequence, userSequence);
			}
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);
			uploadCount = 0;
		}
			
		int maximumUploadCount = (hasComment? Global.Wanted.getMaximumReportCount(): Global.Wanted.getMaximumArrestCount());
		if(uploadCount < maximumUploadCount) {
			int contentCountByNumber;
			if(hasComment) {
				contentCountByNumber = aceDao.selectReportCountByNumber(eventSequence, userSequence, questionType, questionNumber);
			} else {
				contentCountByNumber = aceDao.selectArrestCountByNumber(eventSequence, userSequence, questionType, questionNumber);
			}

			if(contentCountByNumber < 1) {
				long size1, size2;
				try {
					size1 = file1.getSize();
				} catch(Exception exception) {
					size1 = -1;
					messages.add(exception.getMessage());
					LOGGER.error(exception.getMessage(), exception);
				}
				try {
					size2 = file2.getSize();
				} catch(Exception exception) {
					size2 = -1;
					messages.add(exception.getMessage());
					LOGGER.error(exception.getMessage(), exception);
				}

				if(size1 >= Global.getImageSizeLimit() || size2 >= Global.getImageSizeLimit()) {
					messages.add("업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.");
				} else if(size1 <= 0 || size2 <= 0) {
					messages.add("파일에 문제가 있습니다. 다른 파일로 다시 시도해 보세요.");
				} else {
					Uploader uploader = null;
					try {
						uploader = new Uploader();
						String filePath1 = uploader.upload(file1, userSequence, Uploader.EventType.WANTED).replace("\\", "/");
						String filePath2 = uploader.upload(file2, userSequence, Uploader.EventType.WANTED).replace("\\", "/");

						if(hasComment) {
							aceDao.insertReportNew(eventSequence, questionType, questionNumber, filePath1, filePath2, userSequence, userId, userName, 
									schoolName, grade, departmentSequence, departmentName, teacherSequence, teacherName, comment);
						} else {
							aceDao.insertArrestNew(eventSequence, questionType, questionNumber, filePath1, filePath2, userSequence, userId, userName, 
									schoolName, grade, departmentSequence, departmentName, teacherSequence, teacherName);
						}
													
													
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);

						if(uploader != null) { uploader.undoStoring(); }
						messages.add((hasComment? "신고": "검거") + "에 실패했습니다.");
					}
				}
			} else {
				success = false;
				if(hasComment) {
					messages.add("문항 번호 당 1건의 유사문제 신고가 가능합니다.");
				} else {
					messages.add("문항 번호 당 1건의 문제 풀이 검거가 가능합니다.");
				}
			}
		} else {
			success = false;
			if(hasComment) {
				messages.add(maximumUploadCount + "건의 신고 등록을 초과하였습니다.\n포상선물 추첨 및 선착순 결과는 10월26일(목) 발표 됩니다.");
			} else {
				messages.add(maximumUploadCount + "건의 검거 등록을 초과하였습니다.\n포상선물 추첨 및 선착순 결과는 10월26일(목) 발표 됩니다.");
			}
		}
	 
	
		if(success) {
			if(hasComment) {
				messages.add("유사문제 신고가 완료 되었습니다.\n나의 신고 실적 현재 " + (uploadCount + 1) + "건/ 최대 " + Global.Wanted.getMaximumReportCount() + "건 신고 접수완료");
			} else {
				messages.add("난이도 상 문제가 검거 완료 되었습니다.\n나의 검거 실적 현재 " + (uploadCount + 1) + "건/ 최대 " + Global.Wanted.getMaximumReportCount() + "건 검거 완료");
			}
		}

		return new UploadResult(success, messages);
	}

	@Override
	public List<Ranking> getTeacherRanking(String startdate, String enddate)
	{
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		List<Ranking> rank = null;
		rank = aceDao.selectTeacherRanking(startdate, enddate);
		return rank;
	}
	
	
	@Override
	public List<Ranking> getUserRanking(int eventSequence)
	{
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		List<Ranking> rank = null;
		rank = aceDao.selectUserRanking(eventSequence);
		return rank;
	}
	
	
	@Override
	public int hideContent(int sequence) {
		AceDao aceDao = SQL_SESSION.getMapper(AceDao.class);
		return aceDao.hideContent(sequence);
	}

	private static void decideOwnership(List<Content> contents, String userSequence) {
		for(Content content : contents) { content.decideOwnership(userSequence); }
	}

	public static class ContentMetadata {
		private int myContentCount;
		private int totalContentCount;
		private List<Content> contents;
		private List<RegionCountPair> regionCountPairs;

		private ContentMetadata(int myContentCount, int totalContentCount, List<Content> contents, List<RegionCountPair> regionCountPairs) {
			this.myContentCount = myContentCount;
			this.totalContentCount = totalContentCount;
			this.contents = contents;
			this.regionCountPairs = regionCountPairs;
		}

		public int getMyContentCount() { return myContentCount; }
		public int getTotalContentCount() { return totalContentCount; }
		public List<Content> getContents() { return contents; }
		public List<RegionCountPair> getRegionCountPairs() { return regionCountPairs; }
	}
}

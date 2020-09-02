package com.gojls.ace.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import com.gojls.common.controller.BaseController;
import com.gojls.secret.UploadResult;

import gojlslib.util.CustomProp;

import com.gojls.common.helpers.encoding.EncodingHelper;
import com.gojls.common.helpers.encryption.Encryption;

import com.gojls.ace.model.Content;
import com.gojls.ace.model.Event;
import com.gojls.ace.model.Ranking;
import com.gojls.ace.model.RegionCountPair;
import com.gojls.ace.model.User;
import com.gojls.ace.model.UserInfo;
import com.gojls.ace.model.Teacher;
import com.gojls.ace.service.AceServiceImpl;
import com.gojls.ace.service.AceService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
public class AceController extends BaseController {

	private static final int NUMBER_OF_CONTENTS_PER_PAGE = 5;
	private AceService aceService;

	@Autowired
	public void setAceService(AceService aceService) { this.aceService = aceService; }

	
	@GetMapping( {"/ace", "/ace/wanted1"})
	public ModelAndView getHome() {
		
		
		Event event = aceService.getTargetEvent(1);
		if(event == null) { return new ModelAndView("ace/wanted1-preview"); }

		if(event.isItPeriod()) {
			return new ModelAndView("ace/wanted1");
		} else {
			return new ModelAndView("ace/wanted1-over");
		}
		
	}
	
	@GetMapping( { "/ace/wanted2", "/ace/wanted2" })
	public ModelAndView getHome2(HttpServletRequest request, HttpServletResponse response)	
	{	
		ModelAndView modelAndView = new ModelAndView("ace/wanted2");
		
		//U001192223   sinseo1004  jls123
		// 학생 리스트
		User user = null;
		List<Teacher> teachers = null; 
		int signedInAsStudent = 0;
		
		CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
		
		// 실제 적용
		if(cookieProp != null)	// 회원 정보 세팅
		{	
			String userSeq = cookieProp.get("USER_SEQ");
			System.out.println(cookieProp.get("GT_USER_TYPE"));
			if(cookieProp.get("GT_USER_TYPE").equals("US6001"))
			{		
				user = aceService.getUser(userSeq);
				if(user != null )
				{
					if(user.isAttending() == true)
					{						
						signedInAsStudent = 1;
						teachers = aceService.getTeacherList(userSeq);
						
						String seq1, seq2;
						for(int i = 0; i < teachers.size(); i++ )
						{
							seq1 = teachers.get(i).getSequence();
							
							if( i> 0)
							{
								seq2 = teachers.get(i-1).getSequence();
								
								
								if(seq1.equals(seq2))
								{
									teachers.remove(i);
									i--;
								}
							}
						}
					}
				}
				
			}
			modelAndView.addObject("isCookies", 1);
		}
		else
		{	
			modelAndView.addObject("isCookies", 0);
		}
		
		modelAndView.addObject("signedInAsStudent", signedInAsStudent);
		
		System.out.println("#####################################/ace/wanted2");
		modelAndView.addObject("user", user);
		modelAndView.addObject("teachers", teachers);
		
		// 최종 이벤트 정보 읽어 오기
		Event event = aceService.getLastEvent();
		
		if(event == null)
		System.out.println("#####################################/event null");
		
		// 현재 날자 읽어 오기
		java.util.Date today  = Calendar.getInstance().getTime();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat simpleDate2 = new SimpleDateFormat("yyyy년 MM월 dd일");
		DateTimeFormatter dTF = DateTimeFormatter.ofPattern("yyyyMMdd");
		
		// 현재 진행 위치 가져오기
		int processState = 0;  // 0 : wait upload 1: uploading, 2: close upload 3: announced winner
		long todayDate = Long.parseLong(simpleDate.format(today));
		
		long startDate = Long.parseLong(event.getStartDateTime().format(dTF));
		long closeDate = Long.parseLong(event.getEndDateTime().format(dTF));
		long announceWinnerDate = Long.parseLong(event.getAnnouncedDateTime().format(dTF));
		
		if(todayDate < startDate){processState = 0;}
		else if(todayDate <= closeDate){processState = 1;}
		else if(todayDate < announceWinnerDate){processState = 2;}
		else{processState = 3;}
			
		modelAndView.addObject("currentSeq", event.getSequence());
		modelAndView.addObject("currentProcessState", processState);
		modelAndView.addObject("todayDateStr", simpleDate2.format(today));
		
		modelAndView.addObject("announceWinnerDate", announceWinnerDate);
		modelAndView.addObject("startDate", startDate);
		modelAndView.addObject("closeDate", closeDate);
		
		return modelAndView;
	}
	
	
	@SuppressWarnings("Duplicates")
	@PostMapping("/ace/load-contents")
	public ResponseEntity<HashMap<String, Object>> postLoadContents(@RequestParam(value = "encryptedUserSequence", required = false) String encryptedUserSequence, @RequestParam(value = "reportPage", required = false) String reportPage, @RequestParam(value = "arrestPage", required = false) String arrestPage) {

		
		Event event = aceService.getTargetEvent(1);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		User user = null;
		int myReportCount = 0;
		int myArrestCount = 0;
		int reportCount = 0;
		int arrestCount = 0;
		List<Content> reports = null;
		List<Content> arrests = null;
		List<RegionCountPair> regionReportCountPair = null;
		List<RegionCountPair> regionArrestCountPair = null;

		HttpStatus httpStatus = HttpStatus.OK;
		if(event == null) {
			LOGGER.error("No current event!", new Throwable());

			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} else {
			try {
				String userSequence;
				if(encryptedUserSequence == null) {
					userSequence = "no-one";
				} else {
					userSequence = Encryption.decryptUserSequence(encryptedUserSequence);
				}

				int reportPageInteger;
				if(reportPage == null) {
					reportPageInteger = 1;
				} else {
					try {
						reportPageInteger = Integer.parseInt(reportPage);
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);

						reportPageInteger = 1;
					}
				}
				int arrestPageInteger;
				if(arrestPage == null) {
					arrestPageInteger = 1;
				} else {
					try {
						arrestPageInteger = Integer.parseInt(arrestPage);
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);

						arrestPageInteger = 1;
					}
				}

				user = aceService.getUser(userSequence);

				try {
					AceServiceImpl.ContentMetadata contentMetadata = aceService.getReports(event.getSequence(), userSequence, reportPageInteger, NUMBER_OF_CONTENTS_PER_PAGE);
					myReportCount = contentMetadata.getMyContentCount();
					reportCount = contentMetadata.getTotalContentCount();
					reports = contentMetadata.getContents();
					regionReportCountPair = contentMetadata.getRegionCountPairs();
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 신고 현황을 불러오지 못했습니다.");
				}

				try {
					AceServiceImpl.ContentMetadata contentMetadata = aceService.getArrests(event.getSequence(), userSequence, arrestPageInteger, NUMBER_OF_CONTENTS_PER_PAGE);
					myArrestCount = contentMetadata.getMyContentCount();
					arrestCount = contentMetadata.getTotalContentCount();
					arrests = contentMetadata.getContents();
					regionArrestCountPair = contentMetadata.getRegionCountPairs();
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 검거 현황을 불러오지 못했습니다.");
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		}

		hashMap.put("messages", messages);
		hashMap.put("user", user);
		hashMap.put("myReportCount", myReportCount);
		hashMap.put("myArrestCount", myArrestCount);
		hashMap.put("reportCount", reportCount);
		hashMap.put("arrestCount", arrestCount);
		hashMap.put("reports", reports);
		hashMap.put("arrests", arrests);
		hashMap.put("regionReportCountPair", regionReportCountPair);
		hashMap.put("regionArrestCountPair", regionArrestCountPair);

		return new ResponseEntity<HashMap<String, Object>>(hashMap, httpStatus);
	}

	@PostMapping("/ace/report")
	public ResponseEntity<HashMap<String, Object>> postReport(HttpServletRequest request,
	                                                          @RequestParam("encryptedUserSequence") String encryptedUserSequence,
	                                                          @RequestParam("file1") MultipartFile file1,
	                                                          @RequestParam("file2") MultipartFile file2,
	                                                          @RequestParam("questionType") String questionType,
	                                                          @RequestParam("questionNumber") int questionNumber,
	                                                          @RequestParam("region") String region,
	                                                          @RequestParam("comment") String comment) {
		
		
		Event event = aceService.getTargetEvent(1);
		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		HttpStatus httpStatus = HttpStatus.OK;

		User user = null;
		if(event == null) {
			LOGGER.error("No current event!", new Throwable());

			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} else {
			try {
				String userSequence = Encryption.decryptUserSequence(encryptedUserSequence);
				try {
					user = aceService.getUser(userSequence);
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				messages.add("오류가 발생하여 신고하기에 실패했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}

			if(user != null) {
				try {
					int eventSequence = event.getSequence();
					Content content = new Content(eventSequence, Content.Type.REPORT, EncodingHelper.convert(questionType), questionNumber, EncodingHelper.convert(region), EncodingHelper.convert(comment), user.getUserSequence(), user.getUserId(), user.getUserName(), user.getGrade(), user.getSchoolName());
					UploadResult uploadResult = aceService.uploadContent(eventSequence, file1, file2, content, true);

					messages.addAll(uploadResult.getMessages());
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 신고하기에 실패했습니다.");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
			}

			hashMap.put("messages", messages);
		}

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.TEXT_HTML);

		return ResponseEntity.status(httpStatus).headers(httpHeaders).body(hashMap);
	}
	
	
	@PostMapping("/ace/arrest")
	public ResponseEntity<HashMap<String, Object>> postReport(HttpServletRequest request,
	                                                          @RequestParam("encryptedUserSequence") String encryptedUserSequence,
	                                                          @RequestParam("file3") MultipartFile file3,
	                                                          @RequestParam("file4") MultipartFile file4,
	                                                          @RequestParam("questionType") String questionType,
	                                                          @RequestParam("questionNumber") int questionNumber,
	                                                          @RequestParam("region") String region) {
		
		
		Event event = aceService.getTargetEvent(1);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		HttpStatus httpStatus = HttpStatus.OK;

		User user = null;
		if(event == null) {
			
			LOGGER.error("No current event!", new Throwable());
			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			
		} else {
			
			try {
				
				int eventSequence = event.getSequence();
				String userSequence = (eventSequence == 1)?Encryption.decryptUserSequence(encryptedUserSequence): encryptedUserSequence;
				
				try {
					user = aceService.getUser(userSequence);
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
				}
				
			} catch(Exception exception) {
				
				LOGGER.error(exception.getMessage(), exception);

				messages.add("오류가 발생하여 검거하기에 실패했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				
			}

			if(user != null) {
				
				try {
					int eventSequence = event.getSequence();
					Content content = new Content(eventSequence, Content.Type.ARREST, EncodingHelper.convert(questionType), questionNumber, EncodingHelper.convert(region), user.getUserSequence(), user.getUserId(), user.getUserName(), user.getGrade(), user.getSchoolName());
					UploadResult uploadResult = aceService.uploadContent(eventSequence, file3, file4, content, false);

					messages.addAll(uploadResult.getMessages());
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 검거하기에 실패했습니다.");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
				
			}

			hashMap.put("messages", messages);
			
		}

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.TEXT_HTML);

		return ResponseEntity.status(httpStatus).headers(httpHeaders).body(hashMap);
		
	}
	
	@SuppressWarnings("Duplicates")
	@PostMapping("/ace/load-contents-new")
	public ResponseEntity<HashMap<String, Object>> postLoadContentsNew(@RequestParam(value = "eventSequence", required = false) int eventSequence,
			@RequestParam(value = "userSequence", required = false) String userSequence, 
			@RequestParam(value = "reportPage", required = false) String reportPage, 
			@RequestParam(value = "arrestPage", required = false) String arrestPage) {
		
		
		Event event = aceService.getTargetEvent(eventSequence);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		User user = null;
		int myReportCount = 0;
		int myArrestCount = 0;
		int reportCount = 0;
		int arrestCount = 0;
		List<Content> reports = null;
		List<Content> arrests = null;
		List<RegionCountPair> regionReportCountPair = null;
		List<RegionCountPair> regionArrestCountPair = null;

		HttpStatus httpStatus = HttpStatus.OK;
		if(event == null) {
			LOGGER.error("No current event!", new Throwable());
			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} else {
			try {
				
				if(userSequence == null) {
					userSequence = "no-one";
				}
				
				int reportPageInteger;
				if(reportPage == null) {
					reportPageInteger = 1;
				} else {
					try {
						reportPageInteger = Integer.parseInt(reportPage);
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
						reportPageInteger = 1;
					}
				}
				int arrestPageInteger;
				if(arrestPage == null) {
					arrestPageInteger = 1;
				} else {
					try {
						arrestPageInteger = Integer.parseInt(arrestPage);
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
						arrestPageInteger = 1;
					}
				}

				user = aceService.getUser(userSequence);

				try {
					AceServiceImpl.ContentMetadata contentMetadata = aceService.getReports(
							event.getSequence(), 
							userSequence, 
							reportPageInteger, 
							NUMBER_OF_CONTENTS_PER_PAGE);
					
					myReportCount = contentMetadata.getMyContentCount();
					reportCount = contentMetadata.getTotalContentCount();
					reports = contentMetadata.getContents();
					regionReportCountPair = contentMetadata.getRegionCountPairs();
					
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
					messages.add("오류가 발생하여 신고 현황을 불러오지 못했습니다.");
				}

				try {
					AceServiceImpl.ContentMetadata contentMetadata = aceService.getArrests(event.getSequence(), 
							userSequence, arrestPageInteger, NUMBER_OF_CONTENTS_PER_PAGE);
					myArrestCount = contentMetadata.getMyContentCount();
					arrestCount = contentMetadata.getTotalContentCount();
					arrests = contentMetadata.getContents();
					regionArrestCountPair = contentMetadata.getRegionCountPairs();
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
					messages.add("오류가 발생하여 검거 현황을 불러오지 못했습니다.");
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		}

		hashMap.put("messages", messages);
		hashMap.put("user", user);
		hashMap.put("myReportCount", myReportCount);
		hashMap.put("myArrestCount", myArrestCount);
		hashMap.put("reportCount", reportCount);
		hashMap.put("arrestCount", arrestCount);
		hashMap.put("reports", reports);
		hashMap.put("arrests", arrests);
		hashMap.put("regionReportCountPair", regionReportCountPair);
		hashMap.put("regionArrestCountPair", regionArrestCountPair);

		return new ResponseEntity<HashMap<String, Object>>(hashMap, httpStatus);
	}
	
	
	@SuppressWarnings("Duplicates")
	@PostMapping("/ace/load-ranking")
	public ResponseEntity<HashMap<String, Object>> postRanking(@RequestParam(value = "eventSequence", required = false) int eventSequence ) {
		

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		List<String> messages = new ArrayList<String>();
		
		int tRankingCount = 0;
		int uRankingCount = 0;
		List<Ranking> teacherRanking = null;
		List<Ranking> userRanking = null;
		
		HttpStatus httpStatus = HttpStatus.OK;
		
		Event event = aceService.getTargetEvent(eventSequence);
				
		if(event == null)
		{
			LOGGER.error("No current event!", new Throwable());
			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			
		} else {
		
			
			java.util.Date today  = Calendar.getInstance().getTime();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
			DateTimeFormatter dTF = DateTimeFormatter.ofPattern("yyyyMMdd");
			long todayDate = Long.parseLong(simpleDate.format(today));
			long firstDate = 20171009;
			long secondDate = 20171015;

			
			try {
				String strStartDate = event.getStartDateTime().format(dTF);
				String strEndDate = event.getEndDateTime().format(dTF);
							
				if(eventSequence == event.getSequence() )
				{
					if(todayDate <= firstDate)
					{
						strStartDate = "20170901";
						strEndDate = "20171009";
					}
					else if(todayDate <= secondDate)
					{
						strStartDate = "20171010";
						strEndDate = "20171015";
					}
					else 
					{
						strStartDate = "20171016";
						strEndDate = "20171022";
					}
				}
				
				try {
					
					teacherRanking = aceService.getTeacherRanking(strStartDate, strEndDate);
					if(teacherRanking != null)
					{
						tRankingCount = teacherRanking.size();
					}
					
					
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
					messages.add("오류가 발생하여 신고 현황을 불러오지 못했습니다.");
				}

				try {
					
					userRanking = aceService.getUserRanking(eventSequence);
					if(userRanking != null)
					{
						uRankingCount = userRanking.size();
					}
					
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 검거 현황을 불러오지 못했습니다.");
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);
				messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		}

		hashMap.put("messages", messages);		
		hashMap.put("tRankingCount", tRankingCount);
		hashMap.put("uRankingCount", uRankingCount);
		hashMap.put("teacherRanking", teacherRanking);
		hashMap.put("userRanking", userRanking);
		
		return new ResponseEntity<HashMap<String, Object>>(hashMap, httpStatus);
		
	}
	
	
	@PostMapping("/ace/report2")
	public ResponseEntity<HashMap<String, Object>> postReport(HttpServletRequest request,
	                                                          @RequestParam("userSeq") String userSequence,
	                                                          @RequestParam("eventSeq") int eventSequence,
	                                                          @RequestParam("teacher") String teacherSequence,
	                                                          @RequestParam("file1") MultipartFile file1,
	                                                          @RequestParam("file2") MultipartFile file2,
	                                                          @RequestParam("questionType") String questionType,
	                                                          @RequestParam("questionNumber") int questionNumber,
	                                                          @RequestParam("comment") String comment) {
		
		
		System.out.println("########################### /dlive/upload-image");
		System.out.println("userSequence: " + userSequence);
		System.out.println("teacherSeq: " + teacherSequence);
		System.out.println("questionType: " + EncodingHelper.convert(questionType));
		System.out.println("questionNumber: " + questionNumber);
		System.out.println("comment: " + EncodingHelper.convert(comment));
		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		HttpStatus httpStatus = HttpStatus.OK;
		
		UserInfo user = null;
		Teacher teacher = null;
		Event event = aceService.getTargetEvent(eventSequence);
		boolean isItEventPeriod = false; 
			

		if(event == null) {
			LOGGER.error("No current event!", new Throwable());
			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			
		} else {
			
			java.util.Date today  = Calendar.getInstance().getTime();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
			DateTimeFormatter dTF = DateTimeFormatter.ofPattern("yyyyMMdd");
			long todayDate = Long.parseLong(simpleDate.format(today));
			long startDate = Long.parseLong(event.getStartDateTime().format(dTF));
			long closeDate = Long.parseLong(event.getEndDateTime().format(dTF));
			
			if( todayDate < startDate ||   closeDate < todayDate)
			{
				LOGGER.error("No current event!", new Throwable());
				messages.add("현재 접수 기간이 아닙니다.\\n접수 기간: 9월20일 ~ 10월22일");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
			else
			{
				isItEventPeriod = true;
			
				try {
					try {
						user = aceService.getUserInfo(userSequence);
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
						messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
					}
					
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
	
					messages.add("오류가 발생하여 신고하기에 실패했습니다.");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
				
				try {
					try {
						teacher = aceService.getTeacher(teacherSequence);
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
						messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
					}
					
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
					messages.add("오류가 발생하여 신고하기에 실패했습니다.");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
				
	
				if(user != null &&  teacher != null && isItEventPeriod == true ) {
					try {
						
						UploadResult uploadResult = aceService.uploadContentsNew(
								eventSequence, "1", 
								EncodingHelper.convert(questionType), questionNumber, 
								userSequence, user.getUserId(), user.getUserName(), user.getSchoolName(), user.getGrade(),
								user.getDeptSeq(), user.getDeptName(), teacherSequence, teacher.getTeacherName(),
								file1, file2, true, EncodingHelper.convert(comment));
						
						messages.addAll(uploadResult.getMessages());
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
	
						messages.add("오류가 발생하여 신고하기에 실패했습니다.");
						httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
					}
				}
	
				hashMap.put("messages", messages);
			}
		}

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.TEXT_HTML);

		return ResponseEntity.status(httpStatus).headers(httpHeaders).body(hashMap);
	}
	
	
	@PostMapping("/ace/arrest2")
	public ResponseEntity<HashMap<String, Object>> postReport(HttpServletRequest request,
			@RequestParam("userSeq") String userSequence,
	        @RequestParam("eventSeq") int eventSequence,
	        @RequestParam("teacher") String teacherSequence, 
	        @RequestParam("file3") MultipartFile file3,
	        @RequestParam("file4") MultipartFile file4,
	        @RequestParam("questionType") String questionType,
	        @RequestParam("questionNumber") int questionNumber) {
		
		
		System.out.println("########################### /ace/arrest2");
		System.out.println("userSequence: " + userSequence);
		System.out.println("teacherSeq: " + teacherSequence);
		System.out.println("questionType: " + EncodingHelper.convert(questionType));
		System.out.println("questionNumber: " + questionNumber);
		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		
		List<String> messages = new ArrayList<String>();
		HttpStatus httpStatus = HttpStatus.OK;
		
		UserInfo user = null;
		Teacher teacher = null;
		Event event = aceService.getTargetEvent(eventSequence);
		boolean isItEventPeriod = false; 
			

		if(event == null) {
			
			LOGGER.error("No current event!", new Throwable());
			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			
		} else {
			
				java.util.Date today  = Calendar.getInstance().getTime();
				SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
				DateTimeFormatter dTF = DateTimeFormatter.ofPattern("yyyyMMdd");
				long todayDate = Long.parseLong(simpleDate.format(today));
				long startDate = Long.parseLong(event.getStartDateTime().format(dTF));
				long closeDate = Long.parseLong(event.getEndDateTime().format(dTF));
				
				if( todayDate < startDate ||   closeDate < todayDate)
				{
					LOGGER.error("No current event!", new Throwable());
					messages.add("현재 접수 기간이 아닙니다.\\n접수 기간: 9월20일 ~ 10월22일");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
				else
				{
					isItEventPeriod = true;
					try {
						try {
							user = aceService.getUserInfo(userSequence);
						} catch(Exception exception) {
							LOGGER.error(exception.getMessage(), exception);
							messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
						}
						
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
						messages.add("오류가 발생하여 신고하기에 실패했습니다.");
						httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
					}
				
					try {
						try {
							teacher = aceService.getTeacher(teacherSequence);
						} catch(Exception exception) {
							LOGGER.error(exception.getMessage(), exception);
							messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
						}
						
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);
						messages.add("오류가 발생하여 신고하기에 실패했습니다.");
						httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
					}
				
	
					if(user != null &&  teacher != null && isItEventPeriod == true ) {
					
						try {
								
								UploadResult uploadResult = aceService.uploadContentsNew(
										eventSequence, "2", 
										EncodingHelper.convert(questionType), questionNumber, 
										userSequence, user.getUserId(), user.getUserName(), user.getSchoolName(), user.getGrade(),
										user.getDeptSeq(), user.getDeptName(), teacherSequence, teacher.getTeacherName(), 
										file3, file4, false, null);
								
								messages.addAll(uploadResult.getMessages());
								
						} catch(Exception exception) {
								LOGGER.error(exception.getMessage(), exception);
			
								messages.add("오류가 발생하여 검거하기에 실패했습니다.");
								httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
						}
					}
					
					hashMap.put("messages", messages);
				}
		}

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.TEXT_HTML);
		return ResponseEntity.status(httpStatus).headers(httpHeaders).body(hashMap);
		
	}
	
	
	
	@PostMapping("/ace/delete")
	ResponseEntity<HashMap<String, Object>> postDelete(HttpServletRequest request, 
			@RequestParam("encryptedUserSequence") String encryptedUserSequence, 
			@RequestParam("sequence") int sequence) {
		
		Event event = aceService.getTargetEvent(1);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		HttpStatus httpStatus = HttpStatus.OK;

		User user = null;
		if(event == null) {
			LOGGER.error("No current event!", new Throwable());

			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} else {
			try {
				String userSequence = Encryption.decryptUserSequence(encryptedUserSequence);
				try {
					user = aceService.getUser(userSequence);
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				messages.add("오류가 발생하여 업로드에 실패했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}

			if(user != null) {
				try {
					aceService.hideContent(sequence);

					messages.add("삭제되었습니다.");
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 삭제하기에 실패했습니다.");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
			}
		}

		hashMap.put("messages", messages);

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);

		return ResponseEntity.status(httpStatus).headers(httpHeaders).body(hashMap);
	}
	
	@PostMapping("/ace/delete2")
	ResponseEntity<HashMap<String, Object>> postDelete2(HttpServletRequest request, 
			@RequestParam("userSequence") String userSequence,
			@RequestParam("eventSequence") int eventSequence,
			@RequestParam("sequence") int sequence) {
		
		Event event = aceService.getTargetEvent(eventSequence);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		List<String> messages = new ArrayList<String>();
		HttpStatus httpStatus = HttpStatus.OK;

		User user = null;
		if(event == null) {
			LOGGER.error("No current event!", new Throwable());
			messages.add("오류가 발생하여 데이터를 불러오지 못했습니다.");
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} else {
			try {
				
				try {
					user = aceService.getUser(userSequence);
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 사용자 정보를 불러오지 못했습니다.");
				}
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				messages.add("오류가 발생하여 업로드에 실패했습니다.");
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}

			if(user != null) {
				try {
					aceService.hideContent(sequence);

					messages.add("삭제되었습니다.");
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);

					messages.add("오류가 발생하여 삭제하기에 실패했습니다.");
					httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				}
			}
		}

		hashMap.put("messages", messages);

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);

		return ResponseEntity.status(httpStatus).headers(httpHeaders).body(hashMap);
	}
	


}

package com.gojls.dlive.controller;


import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.io.OutputStreamWriter;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gojls.Global;
import com.gojls.common.controller.BaseController;
import com.gojls.common.controller.HttpReader;
import com.gojls.common.helpers.encoding.EncodingHelper;
import com.gojls.dlive.UploadResult;
import com.gojls.dlive.model.Content;
import com.gojls.dlive.model.EventList;
import com.gojls.dlive.model.EventModel;
import com.gojls.dlive.model.StudentModel;
import com.gojls.dlive.service.DLiveService;

import gojlslib.util.CustomProp;


@RestController
	public class DLiveController extends BaseController {

		//private static final String currentEcvent = Global.Secret.getCurrentEvent();
		@Value("#{globalContext['JLSHOME_REFRESH_ONE']?:''}") private String jlsurl_ONE;
		@Value("#{globalContext['JLSHOME_REFRESH_TWO']?:''}") private String jlsurl_TWO;
		@Value("#{globalContext['JLSHOME_REFRESH_THREE']?:''}") private String jlsurl_THREE;
		@Value("#{globalContext['H1KEVENT_NUM']?:''}") private String H1KEVENT_NUM;
		
		private static final Logger LOGGER = LoggerFactory.getLogger(DLiveController.class);
		private static final int NUMBER_OF_CONTENTS_PER_PAGE = 15;
		private DLiveService dliveService;

		@Autowired
		public void setDLiveService(DLiveService dliveService) { this.dliveService = dliveService; }
		
		@GetMapping(value = { "/dlive", "/dlive/main" })
		public ModelAndView getHome(HttpServletRequest request, HttpServletResponse response)
		{
			
			ModelAndView modelAndView = new ModelAndView("dlive/main");
			
			// 학생 리스트
			List<StudentModel> studentList = null;
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			//String h1kEventSeq = "2";
			
			// 실제 적용
			if(cookieProp != null)	// 회원 정보 세팅
			{	
				String userSeq = cookieProp.get("USER_SEQ");
				if(cookieProp.get("GT_USER_TYPE").equals("US6001"))
				{				
					studentList = dliveService.getStudentInfo(userSeq, H1KEVENT_NUM);	
				}
				else if(cookieProp.get("GT_USER_TYPE").equals("US6002"))
				{
					studentList = dliveService.getCildrenList(userSeq, H1KEVENT_NUM);
				}	
				
				modelAndView.addObject("isCookies", 1);
			}
			else
				modelAndView.addObject("isCookies", 0);
			
			modelAndView.addObject("studentList", studentList);
			
			int studentCount = 0;
			if(studentList!=null ){studentCount = studentList .size();}
			modelAndView.addObject("studentCount", studentCount);
			
			String curEvent = Global.Secret.getCurrentEvent();
			// 이벤트 리스트 가져오기
			List<EventList> eventList = dliveService.getEventList(curEvent);
			modelAndView.addObject("eventList", eventList);
			
			// 최종 이벤트 정보 읽어 오기
			EventModel currentEventObj = dliveService.getCurrentEventInfo();
			
			// 현재 날자 읽어 오기
			java.util.Date today  = Calendar.getInstance().getTime();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat simpleDate2 = new SimpleDateFormat("yyyy년 MM월 dd일");
			
			// 현재 진행 위치 가져오기
			int processState = 0;  // 0 : wait upload 1: uploading, 2: close upload 3: announced winner
			long todayDate = Long.parseLong(simpleDate.format(today));
		    long uploadStartDate = Long.parseLong(currentEventObj.getUploadStartDate());
			long uploadCloseDate = Long.parseLong(currentEventObj.getUploadEndDate());
			long announceWinnerDate = Long.parseLong(currentEventObj.getWinnerAnnDate());

			modelAndView.addObject("tap", 1);
			
			if(todayDate < uploadStartDate){processState = 0;}
			else if(todayDate <= uploadCloseDate){processState = 1;}
			else if(todayDate < announceWinnerDate){processState = 2;}
			else{processState = 3;}
			
			DecimalFormat df = new DecimalFormat("#,##0");	
			modelAndView.addObject("currentSeq", currentEventObj.getEventSeq());
			modelAndView.addObject("currentVisitCount", df.format(Long.parseLong(currentEventObj.getVisitCount())));		
			modelAndView.addObject("currentPrizeURL", currentEventObj.getPrizeURL());
			modelAndView.addObject("currentProcessState", processState);
			modelAndView.addObject("todayDateStr", simpleDate2.format(today));
			
			modelAndView.addObject("announceWinnerDate", currentEventObj.getWinnerAnnDate());
			modelAndView.addObject("startDate", currentEventObj.getUploadStartDate());
			modelAndView.addObject("closeDate", currentEventObj.getUploadEndDate());
			return modelAndView;
		}
		
		
		@GetMapping(value = { "/dlivedirect" })
		public ModelAndView getHome2(HttpServletRequest request, HttpServletResponse response)
		{
			
			ModelAndView modelAndView = new ModelAndView("dlive/main");
			
			// 학생 리스트
			List<StudentModel> studentList = null;
			CustomProp cookieProp = (CustomProp)request.getAttribute("cookieProp");
			//String h1kEventSeq = "2";
			
			// 실제 적용
			if(cookieProp != null)	// 회원 정보 세팅
			{	
				String userSeq = cookieProp.get("USER_SEQ");
				if(cookieProp.get("GT_USER_TYPE").equals("US6001"))
				{				
					studentList = dliveService.getStudentInfo(userSeq, H1KEVENT_NUM);	
				}
				else if(cookieProp.get("GT_USER_TYPE").equals("US6002"))
				{
					studentList = dliveService.getCildrenList(userSeq, H1KEVENT_NUM);
				}	
				
				modelAndView.addObject("isCookies", 1);
			}
			else
				modelAndView.addObject("isCookies", 0);
			
			modelAndView.addObject("studentList", studentList);
			
			int studentCount = 0;
			if(studentList!=null ){studentCount = studentList .size();}
			modelAndView.addObject("studentCount", studentCount);
			
			String curEvent = Global.Secret.getCurrentEvent();
			// 이벤트 리스트 가져오기
			List<EventList> eventList = dliveService.getEventList(curEvent);
			modelAndView.addObject("eventList", eventList);
			
			// 최종 이벤트 정보 읽어 오기
			EventModel currentEventObj = dliveService.getCurrentEventInfo();
			
			// 현재 날자 읽어 오기
			java.util.Date today  = Calendar.getInstance().getTime();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat simpleDate2 = new SimpleDateFormat("yyyy년 MM월 dd일");
			
			// 현재 진행 위치 가져오기
			int processState = 0;  // 0 : wait upload 1: uploading, 2: close upload 3: announced winner
			long todayDate = Long.parseLong(simpleDate.format(today));
		    long uploadStartDate = Long.parseLong(currentEventObj.getUploadStartDate());
			long uploadCloseDate = Long.parseLong(currentEventObj.getUploadEndDate());
			long announceWinnerDate = Long.parseLong(currentEventObj.getWinnerAnnDate());

			modelAndView.addObject("tap", 2);
			
			if(todayDate < uploadStartDate){processState = 0;}
			else if(todayDate <= uploadCloseDate){processState = 1;}
			else if(todayDate < announceWinnerDate){processState = 2;}
			else{processState = 3;}
			
			DecimalFormat df = new DecimalFormat("#,##0");	
			modelAndView.addObject("currentSeq", currentEventObj.getEventSeq());
			modelAndView.addObject("currentVisitCount", df.format(Long.parseLong(currentEventObj.getVisitCount())));		
			modelAndView.addObject("currentPrizeURL", currentEventObj.getPrizeURL());
			modelAndView.addObject("currentProcessState", processState);
			modelAndView.addObject("todayDateStr", simpleDate2.format(today));
			
			modelAndView.addObject("announceWinnerDate", currentEventObj.getWinnerAnnDate());
			modelAndView.addObject("startDate", currentEventObj.getUploadStartDate());
			modelAndView.addObject("closeDate", currentEventObj.getUploadEndDate());
			return modelAndView;
		}
		
				
		// 페이지 수 증가
		@PostMapping(value = "/dlive/addPageCount")
		public void 
		addPageCount(HttpServletRequest request, HttpServletResponse response, 
				@RequestParam("eventSeq") String eventSeq) {
			dliveService.setAddPageCount(eventSeq);
		}  
		
		// 선택한 이벤트 인증 업로드 개수
		@PostMapping(value = "/dlive/getEventInfo")
		public ResponseEntity<HashMap<String, Object>> 
		getWinnerURL(HttpServletRequest request, HttpServletResponse response, 
				@RequestParam("eventSeq") String eventSeq) {
			
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			EventModel event = dliveService.getEventInfo(eventSeq);		
			hashMap.put("winnerAnnURL", event.getWinnerAnnURL());
			hashMap.put("startEventDate", event.getUploadStartDate());
			hashMap.put("endEventDate", event.getUploadEndDate());
			
			return new ResponseEntity<HashMap<String, Object>>(hashMap, HttpStatus.OK);
		}  	
				
		// 학생의 영어 노출 시간
		@PostMapping(value = "/dlive/getUserTimeInfo")
		public ResponseEntity<String> 
		getUserTimeInfo(HttpServletRequest request, HttpServletResponse response,
				@RequestParam("userSeq") String userSeq	) {
			
			//String h1kEventSeq = "2";
			int totTime = dliveService.getUserTimeInfo(userSeq, H1KEVENT_NUM);
			DecimalFormat df = new DecimalFormat("#,##0");		
			return new ResponseEntity<String>(df.format(totTime), HttpStatus.OK);
		}
		
		@PostMapping("/dlive/load-contents")
		public ResponseEntity<HashMap<String, Object>> 
		postLoadContents(@RequestParam(value = "page", required = false) String page,
						 @RequestParam(value = "eventSeq", required = false) String eventSeq) {
						
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			int uploadCount = dliveService.getTotalUploadCount(eventSeq);
			hashMap.put("uploadCount", uploadCount);
			
			int pageInteger;
			if(page == null) {
				pageInteger = 1;
			} else {
				try {
					pageInteger = Integer.parseInt(page);
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
					pageInteger = 1;
				}
			}

			List<Content> contents = dliveService.getContents(pageInteger, NUMBER_OF_CONTENTS_PER_PAGE, eventSeq);
			int size = contents.size();		
			for(int i = 0; i < size; i++) { hashMap.put(String.valueOf(i), contents.get(i)); }
			return new ResponseEntity<HashMap<String, Object>>(hashMap, HttpStatus.OK);
			
		}
		
		@PostMapping("/dlive/load-owncontents")
		public ResponseEntity<HashMap<String, Object>> 
		postOwnLoadContents(@RequestParam(value = "userSeq",	required = false) String userSeq,
						 @RequestParam(value = "eventSeq", required = false) String eventSeq) {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			
			int uploadCount = dliveService.getOwnUploadCount(userSeq, eventSeq);
			hashMap.put("uploadCount", uploadCount);
			
			List<Content> contents = dliveService.getOwnContents(userSeq, eventSeq);
			int size = contents.size();
			for(int i = 0; i < size; i++) { hashMap.put(String.valueOf(i), contents.get(i)); }
			return new ResponseEntity<HashMap<String, Object>>(hashMap, HttpStatus.OK);
		}

		@PostMapping("/dlive/upload-text")
		public ResponseEntity<HashMap<String, Object>> postUploadText(HttpServletRequest request, 
				@RequestParam("text") String text, 
				@RequestParam("userSeq") String userSeq, 
				@RequestParam("userName") String userName,
				@RequestParam("eventSeq") String eventSeq) {
			
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			UploadResult uploadResult = dliveService.uploadText(text, userSeq, userName, eventSeq);

			hashMap.put("success", uploadResult.isSuccessful());
			hashMap.put("messages", uploadResult.getMessages());

			return new ResponseEntity<HashMap<String, Object>>(hashMap, HttpStatus.OK);
		}
	
		
		@PostMapping("/dlive/upload-image")
		public ResponseEntity<HashMap<String, Object>> postUploadImage(HttpServletRequest request, 
				@RequestParam("file") MultipartFile multipartFile, 
				@RequestParam("inputImageDescription") String imageDescription, 
				@RequestParam("inputUserSequence") String userSeq, 
				@RequestParam("inputUserName") String userName,
				@RequestParam("inputEventSeq") String eventNum) {
			
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			
			String text = EncodingHelper.convert(imageDescription);
			String userNM = EncodingHelper.convert(userName);
		
			String uploadPath = request.getSession().getServletContext().getRealPath("/");
			UploadResult uploadResult = dliveService.uploadImage(multipartFile, text, userSeq, userNM, eventNum);
			
			hashMap.put("success", uploadResult.isSuccessful());
			hashMap.put("messages", uploadResult.getMessages());

			HttpHeaders httpHeaders = new HttpHeaders();
			httpHeaders.setContentType(MediaType.TEXT_HTML);
			
			updateJLSHome();
			return ResponseEntity.ok().headers(httpHeaders).body(hashMap);
		}
		
		
		public void updateJLSHome()
		{
			
			try{
				
				if(!jlsurl_ONE.equals(""))
				{
					HttpReader http1 =  new HttpReader();
					http1.connectServer(jlsurl_ONE, "", "GET", "");
					String msg = http1.readMessage();
				}
				
				if(!jlsurl_TWO.equals(""))
				{
					HttpReader http2 =  new HttpReader();
					http2.connectServer(jlsurl_TWO, "", "GET", "");
					String msg2 = http2.readMessage();
				}
				
				if(!jlsurl_THREE.equals(""))
				{
					HttpReader http3 =  new HttpReader();
					http3.connectServer(jlsurl_THREE, "", "GET", "");
					String msg3 = http3.readMessage();
				}
				
			}catch(Exception exception) {
				System.out.println("############");
				System.out.println(exception);
				
				LOGGER.error(exception.getMessage(), exception);
			}
		}
				
		
		@PostMapping("/dlive/delete-content")
		public ResponseEntity<Boolean> 
		postDeleteDLiverow(HttpServletRequest request, HttpServletResponse response,
				@RequestParam("userSeq") String userSeq,
				@RequestParam("userName") String userName,
				@RequestParam("dliveSeq") String dliveSeq){
			
			boolean isChange = false;
			int dliveInteger;
			
			if(dliveSeq == null) {
				isChange = false;
			} else {
				
				try {
					dliveInteger = Integer.parseInt(dliveSeq);
					isChange = (dliveSeq != null && dliveService.changeDLiveUseInfo(userSeq, userName, dliveInteger));
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
					isChange = false;
				}
			}
			return new ResponseEntity<Boolean>(isChange, HttpStatus.OK);
		}

}
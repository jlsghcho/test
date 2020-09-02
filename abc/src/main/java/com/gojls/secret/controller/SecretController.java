package com.gojls.secret.controller;

import com.gojls.Global;
import com.gojls.common.controller.BaseController;
import com.gojls.common.helpers.encryption.Encryption;
import com.gojls.secret.UploadResult;
import com.gojls.secret.model.Content;
import com.gojls.secret.service.SecretService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

@Controller
public class SecretController extends BaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(SecretController.class);

	private static final int NUMBER_OF_CONTENTS_PER_PAGE = 15;

	private SecretService secretService;

	@Autowired
	public void setSecretService(SecretService secretService) { this.secretService = secretService; }

	//@GetMapping(value = { "/", "/home" })
	@GetMapping(value = { "/secret01", "/secret01" })
	public ModelAndView getHome(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView();
		//modelAndView.setViewName("secret");
		modelAndView.setViewName("secret01");

		LocalDateTime startDateTime = Global.Secret.getStartDate();
		LocalDateTime endDateTime = Global.Secret.getEndDate();
		boolean isItEventPeriod = (LocalDateTime.now().isAfter(startDateTime)) && (LocalDateTime.now().isBefore(endDateTime));

		modelAndView.addObject("isItEventPeriod", isItEventPeriod);

		return modelAndView;
	}

	@PostMapping(value = "/home/post-class-data")
	public ResponseEntity<Boolean> getClassData(HttpServletRequest request, HttpServletResponse response, @RequestParam("encryptedUserSequence") String encryptedUserSequence) {
		String userSequence = Encryption.decryptUserSequence(encryptedUserSequence);
		boolean attending = (userSequence != null && secretService.getIfAttending(userSequence));

		return new ResponseEntity<Boolean>(attending, HttpStatus.OK);
	}

	@PostMapping("/home/load-contents")
	public ResponseEntity<HashMap<String, Object>> postLoadContents(@RequestParam(value = "encryptedUserSequence", required = false) String encryptedUserSequence, @RequestParam(value = "page", required = false) String page) {		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		int uploadCount = secretService.getTotalUploadCount();
		hashMap.put("uploadCount", uploadCount);

		String userSequence = Encryption.decryptUserSequence(encryptedUserSequence);

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

		List<Content> contents = secretService.getContents(userSequence, pageInteger, NUMBER_OF_CONTENTS_PER_PAGE);
		int size = contents.size();
		for(int i = 0; i < size; i++) { hashMap.put(String.valueOf(i), contents.get(i)); }

		return new ResponseEntity<HashMap<String, Object>>(hashMap, HttpStatus.OK);
	}

	@PostMapping("/home/upload-text")
	public ResponseEntity<HashMap<String, Object>> postUploadText(HttpServletRequest request, @RequestParam("text") String text, @RequestParam("encryptedUserSequence") String encryptedUserSequence, @RequestParam("userName") String userName) {
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		String userSequence = Encryption.decryptUserSequence(encryptedUserSequence);
		UploadResult uploadResult = secretService.uploadText(text, userSequence, userName);

		hashMap.put("success", uploadResult.isSuccessful());
		hashMap.put("messages", uploadResult.getMessages());

		return new ResponseEntity<HashMap<String, Object>>(hashMap, HttpStatus.OK);
	}
	@PostMapping("/home/upload-image")
	public ResponseEntity<HashMap<String, Object>> postUploadImage(HttpServletRequest request, @RequestParam("file") MultipartFile file, @RequestParam("imageDescription") String imageDescription, @RequestParam("encryptedUserSequence") String encryptedUserSequence, @RequestParam("userName") String userName) {
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		String userSequence = Encryption.decryptUserSequence(encryptedUserSequence);
		UploadResult uploadResult = secretService.uploadImage(file, imageDescription, userSequence, userName);

		hashMap.put("success", uploadResult.isSuccessful());
		hashMap.put("messages", uploadResult.getMessages());

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.TEXT_HTML);
		return ResponseEntity.ok().headers(httpHeaders).body(hashMap);
	}
}

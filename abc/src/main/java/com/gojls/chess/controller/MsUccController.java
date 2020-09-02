package com.gojls.chess.controller;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gojls.chess.model.MsUccModel;
import com.gojls.chess.service.MsUccService;
import com.gojls.common.controller.BaseController;
import com.gojls.util._Cookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MsUccController extends BaseController {
	private static final String EVENT_SEQ = "30";
	private static final LocalDate STARTS_AT = LocalDate.of(2019, 5, 30);
	private static final LocalDate ENDS_AT = LocalDate.of(2019, 6, 12);

	private MsUccService msUccService;

	@Autowired
	public void setMsUccService(MsUccService msUccService) { this.msUccService = msUccService; }

	@GetMapping({ "/chess/msucc" })
	public ModelAndView getHome(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /chess/msucc");
		}

		ModelAndView modelAndView = new ModelAndView("chess/msucc" + EVENT_SEQ);

		Boolean cookieJLS_YN = _Cookie.isTokenCookie(request, "jls");

		// 이벤트 리스트 가져오기
		MsUccModel msUccModel = new MsUccModel();
		if(cookieJLS_YN) {
			// 회원 정보 세팅
			modelAndView.addObject("userSeq", request.getAttribute("cookieUserSeq"));
			modelAndView.addObject("userNm", request.getAttribute("cookieUserNm"));
			modelAndView.addObject("isCookies", 1);

			msUccModel.setUserSeq((String)request.getAttribute("cookieUserSeq"));
		} else {
			modelAndView.addObject("userSeq", "");
			modelAndView.addObject("userNm", "");
			modelAndView.addObject("isCookies", 0);
			msUccModel.setUserSeq("");
		}

		modelAndView.addObject("eventSeq", EVENT_SEQ);
		msUccModel.setEventSeq(EVENT_SEQ);
		//UCC목록
		List<MsUccModel> msUccList = msUccService.selectMsUccList(msUccModel);
		modelAndView.addObject("msUccList", msUccList);
		String defaultUccSeq = "";
		if(msUccList.size() > 0) {
			defaultUccSeq = msUccList.get(0).getEventUccSeq();
		}
		modelAndView.addObject("msUccList", msUccList);
		modelAndView.addObject("defaultUccSeq", defaultUccSeq);

		//UCC TOP3
		List<MsUccModel> msUccTop3 = msUccService.selectMsUccTop3(msUccModel);
		modelAndView.addObject("msUccTop3", msUccTop3);
		//추천건수
		int totCnt = msUccService.selectTotRecomCnt(msUccModel);

		DecimalFormat decimalFormat = new DecimalFormat("#,##0");
		modelAndView.addObject("totCnt", decimalFormat.format(totCnt));

		return modelAndView;
	}

	@PostMapping(value = { "/chess/msucc/info" }, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String selectMsUccInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /chess/msucc/info");
		}

		String eventUccSeq = request.getParameter("eventUccSeq");

		LOGGER.debug("////////// eventUccSeq//////" + eventUccSeq);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			MsUccModel msUccModel = new MsUccModel();
			msUccModel.setEventUccSeq(eventUccSeq);
			msUccModel.setEventSeq(EVENT_SEQ);
			MsUccModel msUcc = msUccService.selectMsUccInfo(msUccModel);

			map.put("RESULT", "SUCCESS");
			map.put("msUcc", msUcc);
		} catch(Exception e) {
			LOGGER.error(e.getMessage());

			map.put("RESULT", "ERROR");
			map.put("MSG", e.getMessage());
		}

		return GSON.toJson(map);
	}

	@PostMapping(value = { "/chess/msucc/recomCnt" }, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String selectRecomUccCnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /chess/msucc/recomCnt");
		}

		Boolean cookieJLS_YN = _Cookie.isTokenCookie(request, "jls");

		Map<String, Object> map = new HashMap<String, Object>();
		String result;
		String msg = null;
		int cnt;
		try {
			if(cookieJLS_YN != null) {
				// 회원 정보 세팅
				MsUccModel msUccModel = new MsUccModel();
				msUccModel.setUserSeq((String)request.getAttribute("cookieUserSeq"));
				msUccModel.setEventSeq(EVENT_SEQ);

				cnt = msUccService.selectRecomUccCnt(msUccModel);
				result = "SUCCESS";
			} else {
				cnt = 0;
				result = "ERROR";
				msg = "로그인이 되어있지 않습니다.";
			}
		} catch(Exception e) {
			LOGGER.error(e.getMessage());

			cnt = 0;
			result = "ERROR";
			msg = e.getMessage();
		}

		map.put("cnt", cnt);
		map.put("RESULT", result);
		if(msg != null) { map.put("MSG", msg); }

		return GSON.toJson(map);
	}

	@PostMapping(value = { "/chess/msucc/recom" }, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String insertRecomUcc(HttpServletRequest request, HttpServletResponse response, String params) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /chess/msucc/recom");
		}

		Boolean cookieJLS_YN = _Cookie.isTokenCookie(request, "jls");

		String eventUccSeq = request.getParameter("eventUccSeq");

		Map<String, Object> map = new HashMap<String, Object>();
		String result;
		String msg = null;
		int cnt;
		try {
			if(cookieJLS_YN) {
				DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("M/d");

				if(LocalDate.now().isBefore(STARTS_AT)) {
					cnt = 0;
					result = "ERROR";
					msg = String.format("%s-%s 투표기간이 아닙니다.", dateTimeFormatter.format(STARTS_AT), dateTimeFormatter.format(ENDS_AT));
				} else if(LocalDate.now().isAfter(ENDS_AT)) {
					cnt = 0;
					result = "ERROR";
					msg = String.format("%s-%s 투표기간이 종료되었습니다.", dateTimeFormatter.format(STARTS_AT), dateTimeFormatter.format(ENDS_AT));
				} else {
					// 회원 정보 세팅
					MsUccModel msUccModel = new MsUccModel();
					msUccModel.setUserSeq((String)request.getAttribute("cookieUserSeq"));
					msUccModel.setUserNm((String)request.getAttribute("cookieUserNm"));
					msUccModel.setEventUccSeq(eventUccSeq);

					cnt = msUccService.insertRecomUcc(msUccModel);
					result = "SUCCESS";
				}
			} else {
				cnt = 0;
				result = "ERROR";
				msg = "로그인이 되어있지 않습니다.";
			}
		} catch(Exception e) {
			LOGGER.error(e.getMessage());

			cnt = 0;
			result = "ERROR";
			msg = e.getMessage();
		}

		map.put("cnt", cnt);
		map.put("RESULT", result);
		if(msg != null) { map.put("MSG", msg); }

		return GSON.toJson(map);
	}

	@PostMapping(value = { "/chess/msucc/view" }, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String insertViewUcc(HttpServletRequest request, HttpServletResponse response, String params) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("////////// Welcome POST /chess/msucc/view");
		}

		Boolean cookieJLS_YN = _Cookie.isTokenCookie(request, "jls");

		String eventUccSeq = request.getParameter("eventUccSeq");

		Map<String, Object> map = new HashMap<String, Object>();
		String result;
		String msg = null;
		int cnt;
		try {
			if(cookieJLS_YN) {
				// 회원 정보 세팅
				MsUccModel msUccModel = new MsUccModel();
				msUccModel.setUserSeq((String)request.getAttribute("cookieUserSeq"));
				msUccModel.setEventUccSeq(eventUccSeq);

				cnt = msUccService.insertViewUcc(msUccModel);
				result = "SUCCESS";
			} else {
				cnt = 0;
				result = "ERROR";
				msg = "로그인이 되어있지 않습니다.";
			}
		} catch(Exception e) {
			LOGGER.error(e.getMessage());

			cnt = 0;
			result = "ERROR";
			msg = e.getMessage();
		}

		map.put("cnt", cnt);
		map.put("RESULT", result);
		if(msg != null) { map.put("MSG", msg); }

		return GSON.toJson(map);
	}
}
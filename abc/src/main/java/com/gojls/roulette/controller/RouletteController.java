package com.gojls.roulette.controller;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gojls.common.controller.BaseController;
import com.gojls.roulette.model.Event;
import com.gojls.roulette.model.Reward;
import com.gojls.roulette.model.User;
import com.gojls.roulette.service.EventService;
import com.gojls.roulette.service.RewardService;
import com.gojls.roulette.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class RouletteController extends BaseController {
	private UserService userService;
	private EventService eventService;
	private RewardService rewardService;
	
	@Value("#{globalContext['GOJLS_URL']?:''}") private String gojls_url;
	
	@Value("#{globalContext['ROULETTE_SMS_ST']?:''}") private String roulette_sms;
	@Value("#{globalContext['ROULETTE_STUDY_START']?:''}") private String roulette_study_start;
	@Value("#{globalContext['ROULETTE_STUDY_END']?:''}") private String roulette_study_end;
	
	@Autowired
	public void setUserService(UserService userService) { this.userService = userService; }
	@Autowired
	public void setEventService(EventService eventService) { this.eventService = eventService; }
	@Autowired
	public void setRewardService(RewardService rewardService) { this.rewardService = rewardService; }

	@GetMapping(value = { "/roulette" }, produces = (MediaType.TEXT_HTML_VALUE + ";charset=UTF-8"))
	public ModelAndView getRoulette(HttpServletRequest request, HttpServletResponse response) {
		String log = entryLog(request);
		LOGGER.debug(log);

		
	//	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> " + roulette_sms);
	//	System.out.println(roulette_study_start + "~" + roulette_study_end);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("roulette/roulette");

		String resultMessage = "참여 대상자가 아닙니다.";
		String messageToAlert = null;
		String messageToConsole = null;
		
		Event event = eventService.getUpcomingEvent();
		
		if(event == null) {
			messageToConsole = "event == null";
		} else {
			com.gojls.common.model.User commonUser = (com.gojls.common.model.User)request.getAttribute("commonUser");
			if(commonUser == null) {
				
				
				String redirectTo = gojls_url + "/login?preURL=" + siteUrl + request.getRequestURI();
				System.out.println("redirectTo= " +  redirectTo);
				
				messageToAlert = "로그인 후 이용 가능합니다.";
				modelAndView.addObject("redirectTo", redirectTo);
			} else {
				
				User user = userService.getUser(commonUser);
				Reward reward = rewardService.getReward(event, user);
				
			
				if(reward == null) {
					if(user.isChessStudent()) {
						resultMessage = "시크릿 선물 추첨 대상자가 아닙니다.";
						messageToAlert = user.getName() + "학생, 이번엔 아쉽게도 기간 내 달성하지 못했네요~\\n1000시간을 이루는 CHESS 프로그램들을 잊지 마세요!\\n" + roulette_study_start +"월~" + roulette_study_end + "월 250시간 달성을 응원합니다!";
						messageToConsole = "The SID \\\"" + user.getSequence() + "\\\" is missing from the roulette-reward table.";
					} else {
						messageToAlert = "CHESS 재학생만 참여할 수 있습니다.";
						messageToConsole = "The SID \\\"" + user.getSequence() + "\\\" is not a CHESS student.";
					}
				} else {
					resultMessage = "시크릿 선물 추첨 대상자입니다.";
					if(reward.getConfirmationDateTime() == null) {
						// Hannibal: 뭔가 잘못 하고 있는 것 같다... (2018.06.05)
						messageToAlert = "1000시간 영어노출 달성을 응원합니다. \\n상품은 " + roulette_sms + " 발송 예정입니다.";
					}
				}

				modelAndView.addObject("user", user);
				modelAndView.addObject("reward", reward);
			}
		}

	//	System.out.println("event:" + event);
	//	System.out.println("resultMessage:" + resultMessage);
	//	System.out.println("messageToAlert:" + messageToAlert);
	//	System.out.println("messageToConsole:" + messageToConsole);
		
		modelAndView.addObject("event", event);
		modelAndView.addObject("resultMessage", resultMessage);
		modelAndView.addObject("messageToAlert", messageToAlert);
		modelAndView.addObject("messageToConsole", messageToConsole);

		return modelAndView;
	}

	@PostMapping(value = { "/roulette/confirmReward" }, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String postConfirmReward(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "sequence", defaultValue = "1") int eventSequence) {
		String log = entryLog(request);
		LOGGER.debug(log);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		boolean success = false;
		String messageToAlert = null;
		String messageToConsole = null;

		Event event = eventService.getEvent(eventSequence);
		if(event != null) {
			com.gojls.common.model.User commonUser = (com.gojls.common.model.User)request.getAttribute("commonUser");
			if(commonUser == null) {
				messageToAlert = "로그인이 필요합니다.";
				messageToConsole = "commonUser == null";
			} else {
				User user = userService.getUser(commonUser);
				Reward reward = rewardService.getReward(event, user);
				if(reward == null) {
					messageToAlert = "잘못된 요청입니다.";
					messageToConsole = "reward == null";
				} else {
					int affectedRows = rewardService.updateRewardConfirmation(event, user);
					if(affectedRows < 1) {
						LOGGER.warn("affectedRows < 1. 어째서?", new Throwable());

						messageToAlert = "선물 받기 버튼이 정상 작동하지 않았습니다.\n다시 한 번 버튼을 눌러 주세요.";
					} else if(affectedRows > 1) {
						LOGGER.warn("affectedRows > 1. 왜?", new Throwable());

						success = true;
					} else {
						success = true;
					}

					messageToConsole = ("affectedRows: " + affectedRows);
				}
			}
		}

		hashMap.put("success", success);
		if(messageToAlert != null) { hashMap.put("messageToAlert", messageToAlert); }
		if(messageToConsole != null) { hashMap.put("messageToConsole", messageToConsole); }

		return GSON.toJson(hashMap);
	}
	
	
}
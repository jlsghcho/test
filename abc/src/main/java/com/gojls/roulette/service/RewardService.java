package com.gojls.roulette.service;

import com.gojls.roulette.model.Event;
import com.gojls.roulette.model.Reward;
import com.gojls.roulette.model.User;
//import com.sun.istack.internal.Nullable;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface RewardService {
	//@Nullable
	Reward getReward(Event event, User user);
	int updateRewardConfirmation(Event event, User user);
}
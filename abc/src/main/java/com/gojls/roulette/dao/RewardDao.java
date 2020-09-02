package com.gojls.roulette.dao;

import java.util.List;

import com.gojls.roulette.model.Event;
import com.gojls.roulette.model.Reward;
import com.gojls.roulette.model.User;
import org.apache.ibatis.annotations.Param;

public interface RewardDao {
	List<Reward> selectRewards();
	List<Reward> selectReward(@Param("event") Event event, @Param("user") User user);
	int updateRewardConfirmation(@Param("event") Event event, @Param("user") User user);
}
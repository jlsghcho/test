package com.gojls.roulette.service;

import java.util.List;

import com.gojls.roulette.dao.RewardDao;
import com.gojls.roulette.model.Event;
import com.gojls.roulette.model.Reward;
import com.gojls.roulette.model.User;
//import com.sun.istack.internal.Nullable;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RewardServiceImpl implements RewardService {
	private static final Logger LOGGER = LoggerFactory.getLogger(RewardServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public RewardServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }

	@Override
	//@Nullable
	public Reward getReward(Event event, User user) {
		RewardDao rewardDao = SQL_SESSION.getMapper(RewardDao.class);
		List<Reward> rewards = rewardDao.selectReward(event, user);

		switch(rewards.size()) {
			case 0:
				LOGGER.warn("No matching reward for event sequence " + event.getSequence() + ",  \"" + user + "\".");
				return null;
			default:
				LOGGER.warn("Multiple rewards for event sequence " + event.getSequence() + ",  \"" + user + "\".");
			case 1:
				return rewards.get(0);
		}
	}

	@Override
	public int updateRewardConfirmation(Event event, User user) {
		RewardDao rewardDao = SQL_SESSION.getMapper(RewardDao.class);
		int affectedRows = rewardDao.updateRewardConfirmation(event, user);

		if(affectedRows == 0) {
			LOGGER.warn("No rows are affected for event sequence " + event.getSequence() + ",  \"" + user.getSequence() + "\".");
		} else if(affectedRows > 1) {
			LOGGER.warn("Multiple rows are affected for event sequence " + event.getSequence() + ",  \"" + user.getSequence() + "\".");
		}

		return affectedRows;
	}
}
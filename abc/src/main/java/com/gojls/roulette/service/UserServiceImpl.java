package com.gojls.roulette.service;

import java.util.List;

import com.gojls.roulette.dao.UserDao;
import com.gojls.roulette.model.User;
//import com.sun.istack.internal.NotNull;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public UserServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }

	@Override
	
	public User getUser(com.gojls.common.model.User commonUser) {
		UserDao userDao = SQL_SESSION.getMapper(UserDao.class);
		List<User> users = userDao.selectUser(commonUser);
		if(users.size() == 0) {
			return new User(commonUser);
		} else {
			if(users.size() > 1) { LOGGER.warn("selectUser returned multiple rows; returning the first.", new Throwable()); }

			return users.get(0);
		}
	}
}
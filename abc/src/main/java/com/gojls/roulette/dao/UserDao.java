package com.gojls.roulette.dao;

import java.util.List;

import com.gojls.roulette.model.User;

public interface UserDao {
	List<User> selectUser(com.gojls.common.model.User user);
}
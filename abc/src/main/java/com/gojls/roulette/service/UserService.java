package com.gojls.roulette.service;

import com.gojls.roulette.model.User;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface UserService {
	User getUser(com.gojls.common.model.User commonUser);
}
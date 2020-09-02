package com.gojls.roulette.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class User extends com.gojls.common.model.User {
	private static final Logger LOGGER = LoggerFactory.getLogger(User.class);

	private boolean chessStudent;
	private boolean toBeRewarded;

	public User(com.gojls.common.model.User commonUser) { super(commonUser.getSequence(), commonUser.getId(), commonUser.getName(), commonUser.getType()); }
	public User(String sequence, String id, String name, String typeCode, boolean chessStudent, boolean toBeRewarded) { this(sequence, id, name, Type.byCode(typeCode), chessStudent, toBeRewarded); }
	public User(String sequence, String id, String name, com.gojls.common.model.User.Type typeCode, boolean chessStudent, boolean toBeRewarded) {
		super(sequence, id, name, typeCode);

		this.chessStudent = chessStudent;
		this.toBeRewarded = toBeRewarded;

		if(!this.chessStudent && toBeRewarded) {
			/*
			 * Hannibal: 체스 학생이 아니라고 판단했는데 수상자 명단에 있다?
			 * 체스 학생인지를 판별하는 기준이 잘못되었거나 분원/반 등이 잘못 배정되었을 가능성이 있음. (2018.06.04)
			 */
			LOGGER.warn("!this.chessStudent && toBeRewarded; check out \"" + id + "\" (" + sequence + ").");
		}
	}

	public boolean isChessStudent() { return chessStudent; }
	public boolean isToBeRewarded() { return toBeRewarded; }
}
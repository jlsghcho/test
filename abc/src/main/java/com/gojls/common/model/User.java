package com.gojls.common.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class User {
	protected String sequence;
	protected String id;
	protected String name;
	protected Type type;

	public User(String sequence, String id, String name, String typeCode) { this(sequence, id, name, Type.byCode(typeCode)); }
	public User(String sequence, String id, String name, Type type) {
		this.sequence = sequence;
		this.id = id;
		this.name = name;
		this.type = type;
	}

	public String getSequence() { return sequence; }
	public void setSequence(String sequence) { this.sequence = sequence; }
	public String getId() { return id; }
	public void setId(String id) { this.id = id; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public Type getType() { return type; }
	public void setType(Type type) { this.type = type; }

	public enum Type {
		STUDENT("US6001", "학생"),
		PARENT("US6002", "학부모"),
		EMPLOYEE("US6003", "직원"),
		TEACHER("US6004", "선생님"),
		OTHER("US6005", "일반회원");

		private static final Logger LOGGER = LoggerFactory.getLogger(Type.class);

		private final String CODE;
		private final String NAME;

		Type (String code, String name) {
			CODE = code;
			NAME = name;
		}

		public String getCode() { return CODE; }
		public String getName() { return NAME; }

		public static Type byCode(String code) {
			if(code == null) {
				LOGGER.warn(Type.class.getName() + ".byCode(null) → OTHER");
				return OTHER;
			}

			for(Type type : values()) {
				if(code.equals(type.CODE)) { return type; }
			}

			LOGGER.warn("No " + Type.class.getName() + " instance found for code \"" + code + "\"; returning OTHER.");
			return OTHER;
		}
	}
}
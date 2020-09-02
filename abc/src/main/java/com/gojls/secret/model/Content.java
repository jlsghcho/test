package com.gojls.secret.model;

import com.gojls.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Objects;

public class Content {
	private static final Logger LOGGER = LoggerFactory.getLogger(Content.class);

	private long sequence;
	private String uploaderSequence;
	private String text;
	private String imageUrl;
	private boolean hasImage;

	public Content(long H1K_DLIVE_SEQ, String DLIVE_TEXT, String IMG_PATH, String USER_SEQ, String GT_DLIVE_TYPE) {
		sequence = H1K_DLIVE_SEQ;
		uploaderSequence = USER_SEQ;
		text = DLIVE_TEXT;

		imageUrl = Global.getRootDirectoryToDownload() + IMG_PATH;
		hasImage = GT_DLIVE_TYPE.equals("1K3001");
	}

	@Override
	public int hashCode() { return Objects.hash(sequence); }
	@Override
	public boolean equals(Object obj) {
		if(obj == null) { return false; }
		if(!(obj instanceof Content)) { return false; }

		Content comparee = (Content)obj;
		return sequence == comparee.sequence;
	}

	public long getSequence() { return sequence; }
	public String getUploaderSequence() { return uploaderSequence; }
	public String getText() { return text; }
	public String getImageUrl() { return imageUrl; }
	public boolean hasImage() { return hasImage; }
}

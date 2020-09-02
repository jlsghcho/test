package com.gojls.roulette.model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

//import com.sun.istack.internal.Nullable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Reward {
	private static final Logger LOGGER = LoggerFactory.getLogger(Reward.class);

	private long sequence;
	private long eventSequence;
	private String name;
	private String imageUrl;
	//@Nullable
	private LocalDateTime confirmationDateTime;

	public Reward(long sequence, long eventSequence, String name, String imageUrl, Date confirmationDateTime) {
		this.sequence = sequence;
		this.eventSequence = eventSequence;
		this.name = name;
		this.imageUrl = imageUrl;

		if(confirmationDateTime != null) {
			try {
				this.confirmationDateTime = LocalDateTime.ofInstant(confirmationDateTime.toInstant(), ZoneId.systemDefault());
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);
			}
		}
	}

	public long getSequence() { return sequence; }
	public long getEventSequence() { return eventSequence; }
	public String getName() { return name; }
	public String getImageUrl() { return imageUrl; }
//	@Nullable
	public LocalDateTime getConfirmationDateTime() { return confirmationDateTime; }
}
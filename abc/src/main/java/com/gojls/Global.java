package com.gojls;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@Configuration
//@PropertySource("classpath:/properties/global-context.properties")
@PropertySource("classpath:/properties/global-context.dev.properties")

public class Global {
	private static final Logger LOGGER = LoggerFactory.getLogger(Global.class);

	private static Environment environment;

	@Autowired
	public void setEnvironment(Environment environment) { Global.environment = environment; }

	public static String getRootDirectoryToDownload() {
		try {
			String rootDirectoryToDownload = environment.getProperty("ROOT_DIRECTORY_TO_DOWNLOAD");
			return rootDirectoryToDownload;
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);
			return "https://tube.gojls.com/gojls";
		}
	}

	public static long getImageSizeLimit() {
		try {
			String imageSizeLimitString = environment.getProperty("IMAGE_SIZE_LIMIT");

			return Long.parseLong(imageSizeLimitString);
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);

			return 10485760;
		}
	}

	public static class Secret {
		
		public static String getCurrentEvent() {
			try {
				String currentEvent = environment.getProperty("SECRET_CURRENT_EVENT");
				return currentEvent;
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);
				return "3";
			}
		}
		
		public static String getDirectoryToUpload() {
			try {
				String directoryToUpload = environment.getProperty("SECRET_DIRECTORY_TO_UPLOAD");
				return directoryToUpload;
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return "/EVENT/H1K";
			}
		}
		public static LocalDateTime getStartDate() {
			try {
				String startDateString = environment.getProperty("SECRET_EVENT_START_DATE");
				DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("uuuuMMdd");

				LocalDate localDate = LocalDate.parse(startDateString, dateTimeFormatter);
				LocalTime localTime = LocalTime.of(0, 0);

				return LocalDateTime.of(localDate, localTime);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return LocalDateTime.of(2017, 4, 24, 0, 0);
			}
		}
		public static LocalDateTime getEndDate() {
			try {
				String endDateString = environment.getProperty("SECRET_EVENT_END_DATE");
				DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("uuuuMMdd");

				LocalDate localDate = LocalDate.parse(endDateString, dateTimeFormatter).plusDays(1);
				LocalTime localTime = LocalTime.of(0, 0);

				return LocalDateTime.of(localDate, localTime);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return LocalDateTime.of(2017, 5, 15, 0, 0);
			}
		}
		public static int getMaximumUploadCount() {
			try {
				String maximumUploadCountString = environment.getProperty("SECRET_MAXIMUM_UPLOADE_COUNT");

				return Integer.parseInt(maximumUploadCountString);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return 10485760;
			}
		}
		public static int getImageSideLength() {
			try {
				String imageSideLengthString = environment.getProperty("SECRET_IMAGE_SIDE_LENGTH");

				return Integer.parseInt(imageSideLengthString);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return 178;
			}
		}
	}

	public static class Wanted {
		
		public static String getCurrentEvent() {
			try {
				String currentEvent = environment.getProperty("WANTED_CURRENT_EVENT");
				return currentEvent;
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);
				return "3";
			}
		}

		
		public static String getDirectoryToUpload() {
			try {
				String directoryToUpload = environment.getProperty("WANTED_DIRECTORY_TO_UPLOAD");
				return directoryToUpload;
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return "/EVENT/WANTED";
			}
		}

		public static int getMaximumReportCount() {
			try {
				String maximumReportCount = environment.getProperty("WANTED_MAXIMUM_REPORT_COUNT");
				return Integer.parseInt(maximumReportCount);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return 10;
			}
		}
		public static int getMaximumArrestCount() {
			try {
				String maximumArrestCount = environment.getProperty("WANTED_MAXIMUM_ARREST_COUNT");
				return Integer.parseInt(maximumArrestCount);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return 5;
			}
		}
		public static int getImageWidth() {
			try {
				String imageSideLengthString = environment.getProperty("WANTED_IMAGE_WIDTH");

				return Integer.parseInt(imageSideLengthString);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return 178;
			}
		}
		public static int getImageHeight() {
			try {
				String imageSideLengthString = environment.getProperty("WANTED_IMAGE_HEIGHT");

				return Integer.parseInt(imageSideLengthString);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				return 178;
			}
		}
	}
}

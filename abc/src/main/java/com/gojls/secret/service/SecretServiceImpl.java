package com.gojls.secret.service;

import com.gojls.Global;
import com.gojls.common.helpers.encoding.EncodingHelper;
import com.gojls.common.helpers.upload.Uploader;
import com.gojls.secret.UploadResult;
import com.gojls.secret.dao.SecretDao;
import com.gojls.secret.model.Content;
import com.gojls.secret.model.ContentToUpload;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class SecretServiceImpl implements SecretService {
	private static final Logger LOGGER = LoggerFactory.getLogger(SecretServiceImpl.class);

	private final SqlSession SQL_SESSION;

	@Autowired
	public SecretServiceImpl(SqlSession sqlSession) { SQL_SESSION = sqlSession; }

	@Override
	public int getTotalUploadCount() {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);
		return secretDao.selectTotalUploadCount();
	}

	@Override
	public List<Content> getContents(String userSequence, int page, int contentsPerPage) {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);

		List<Content> contents = new ArrayList<Content>();
		if(userSequence != null) { contents = secretDao.selectOwnContents(userSequence); }

		List<Content> allContents = secretDao.selectContents(page, contentsPerPage);
		for(Content contentToAdd : allContents) {
			if(!contents.contains(contentToAdd)) { contents.add(contentToAdd); }
		}

		return contents;
	}
	@Override
	public List<Content> getRandomContents(String userSequence, int totalCount) {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);

		List<Content> contents = new ArrayList<Content>();
		if(userSequence != null) { contents = secretDao.selectOwnContents(userSequence); }

		int count = contents.size();
		if(count > totalCount) {
			LOGGER.warn("count > totalCount!?", new Throwable());

			return contents;
		} else {
			List<Content> randomContents = secretDao.selectRandomContents((totalCount - count));
			for(Content contentToAdd : randomContents) {
				if(!contents.contains(contentToAdd)) { contents.add(contentToAdd); }
			}

			return contents;
		}
	}
	@Override
	public int getUploadCount(String userSequence) {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);
		return secretDao.selectUploadCount(userSequence);
	}

	@Override
	public boolean getIfAttending(String userSequence) {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);
		int result = secretDao.selectIfAttending(userSequence);

		return (result == 1);
	}

	@Override
	public UploadResult uploadText(String text, String userSequence, String userName) {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);

		boolean success = false;
		List<String> messages = new ArrayList<String>();

		LocalDateTime startDateTime = Global.Secret.getStartDate();
		LocalDateTime endDateTime = Global.Secret.getEndDate();
		boolean isItEventPeriod = (LocalDateTime.now().isAfter(startDateTime)) && (LocalDateTime.now().isBefore(endDateTime));
		if(isItEventPeriod) {
			int uploadCount;
			try {
				uploadCount = secretDao.selectUploadCount(userSequence);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				uploadCount = 0;
			}

			if(uploadCount < Global.Secret.getMaximumUploadCount()) {
				int affectedRows;
				try {
					ContentToUpload contentToUpload = new ContentToUpload(userSequence, userName, text);
					affectedRows = secretDao.insertText(contentToUpload);
					long id = contentToUpload.getId();
					if(affectedRows >= 1) {
						success = true;
						messages.add("DreamTree 인증이 완료 되었습니다.\n" + (uploadCount + 1) + "회 /총3회 인증완료 ㅣ 영어노출시간 + 5시간\n영어노출시간 적용은 5월 18일(목) 일괄 적용됩니다.");

						affectedRows = secretDao.insertIntoTimeDay(userSequence, userName, id);
						if(affectedRows < 1) { LOGGER.warn("Succeeded in uploading text but not increasing hours."); }
					} else {
						success = false;
						messages.add("DreamTree 후기인증에 실패했습니다.");
					}
				} catch(Exception exception) {
					LOGGER.error(exception.getMessage(), exception);
				}
			} else {
				success = false;
				messages.add("DreamTree 인증 횟수를 초과하였습니다.\n3회/총 3회 인증 완료 | 영어노출시간 + 15시간\n영어노출시간은 5월 18일(목) 일괄 적용됩니다.");
			}
		} else {
			success = false;
			messages.add("\"현재 Mission 인증기간이 아닙니다.\\nMission 인증 기간: 4월 24일(월) ~ 5월 14일(일)\"");
		}

		return new UploadResult(success, messages);
	}
	@Override
	public UploadResult uploadImage(MultipartFile file, String imageDescription, String userSequence, String userName) {
		SecretDao secretDao = SQL_SESSION.getMapper(SecretDao.class);

		boolean success = false;
		List<String> messages = new ArrayList<String>();

		LocalDateTime startDateTime = Global.Secret.getStartDate();
		LocalDateTime endDateTime = Global.Secret.getEndDate();
		boolean isItEventPeriod = (LocalDateTime.now().isAfter(startDateTime)) && (LocalDateTime.now().isBefore(endDateTime));
		if(isItEventPeriod) {
			int uploadCount;
			try {
				uploadCount = secretDao.selectUploadCount(userSequence);
			} catch(Exception exception) {
				LOGGER.error(exception.getMessage(), exception);

				uploadCount = 0;
			}

			if(uploadCount < Global.Secret.getMaximumUploadCount()) {
				long size;
				try {
					size = file.getSize();
				} catch(Exception exception) {
					size = -1;
					messages.add(exception.getMessage());
					LOGGER.error(exception.getMessage(), exception);
				}

				if(size >= Global.getImageSizeLimit() && size > 0) {
					messages.add("인증에 사용하는 사진은 10MB를 넘을 수 없습니다.");
				} else {
					Uploader uploader = null;
					try {
						uploader = new Uploader();
						String filePath = uploader.upload(file, userSequence, Uploader.EventType.SECRET).replace("\\", "/");

						String convertedImageDescription = EncodingHelper.convert(imageDescription);
						String convertedUserName = EncodingHelper.convert(userName);
						ContentToUpload contentToUpload = new ContentToUpload(userSequence, convertedUserName, convertedImageDescription, filePath);
						int affectedRows = secretDao.insertImage(contentToUpload);
						long id = contentToUpload.getId();
						if(affectedRows >= 1) {
							success = true;
							messages.add("DreamTree 인증이 완료 되었습니다.\n" + (uploadCount + 1) + "회 /총3회 인증완료 ㅣ 영어노출시간 + 5시간\n영어노출시간 적용은 5월 18일(목) 일괄 적용됩니다.");

							affectedRows = secretDao.insertIntoTimeDay(userSequence, convertedUserName, id);
							if(affectedRows < 1) { LOGGER.warn("Succeeded in uploading image but not increasing hours."); }
						} else {
							throw new SQLException();
						}

						success = true;
					} catch(Exception exception) {
						LOGGER.error(exception.getMessage(), exception);

						if(uploader != null) { uploader.undoStoring(); }
						messages.add("DreamTree 후기인증에 실패했습니다.");
					}
				}
			} else {
				success = false;
				messages.add("DreamTree 인증 횟수를 초과하였습니다.\n3회/총 3회 인증 완료 | 영어노출시간 + 15시간\n영어노출시간은 5월 18일(목) 일괄 적용됩니다.");
			}
		} else {
			success = false;
			messages.add("\"현재 Mission 인증기간이 아닙니다.\\nMission 인증 기간: 4월 24일(월) ~ 5월 14일(일)\"");
		}

		return new UploadResult(success, messages);
	}
}

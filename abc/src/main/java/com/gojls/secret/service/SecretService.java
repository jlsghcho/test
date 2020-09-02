package com.gojls.secret.service;

import com.gojls.secret.UploadResult;
import com.gojls.secret.model.Content;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Transactional
public interface SecretService {
	int getTotalUploadCount();

	List<Content> getContents(String userSequence, int page, int contentsPerPage);
	List<Content> getRandomContents(String userSequence, int count);

	int getUploadCount(String userSequence);
	boolean getIfAttending(String userSequence);

	UploadResult uploadText(String text, String userSequence, String userName);
	UploadResult uploadImage(MultipartFile file,  String imageDescription, String userSequence, String userName);
}

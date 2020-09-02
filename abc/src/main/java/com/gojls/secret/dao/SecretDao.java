package com.gojls.secret.dao;

import com.gojls.secret.model.Content;
import com.gojls.secret.model.ContentToUpload;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SecretDao {
	int selectTotalUploadCount();

	List<Content> selectContents(@Param("page") int page, @Param("rowsPerPage") int rowsPerPage);
	List<Content> selectRandomContents(int count);
	List<Content> selectOwnContents(@Param("userSequence") String userSequence);

	int selectIfAttending(@Param("userSequence") String userSequence);

	int selectUploadCount(@Param("userSequence") String userSequence);
	int insertIntoTimeDay(@Param("userSequence") String userSequence, @Param("userName") String userName, @Param("dliveSequence") long dliveSequence);

	int insertText(ContentToUpload contentToUpload);
	int insertImage(ContentToUpload contentToUpload);
}

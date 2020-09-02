package com.gojls.common.helpers.upload;

import com.gojls.Global;
import com.gojls.common.helpers.encoding.EncodingHelper;
import com.gojls.common.helpers.image.Transformation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

public class Uploader {
	private static final Logger LOGGER = LoggerFactory.getLogger(Uploader.class);
	private static final String PREFIX_FOR_SCALED_IMAGES = "_";
	private static final Path TARGET_DIRECTORY_FOR_SECRET = Paths.get(Global.Secret.getDirectoryToUpload());
	private static final Path TARGET_DIRECTORY_FOR_WANTED = Paths.get(Global.Wanted.getDirectoryToUpload());
	//private static final Path TARGET_DIRECTORY_FOR_DLIVE = Paths.get(Global.DLive.getDirectoryToUpload());

	private static boolean initialized;

	private Path recentPath;
	private Path recentPathScaled;

	public String upload(MultipartFile multipartFile, String userSequence, EventType eventType) throws IOException {
		if(!initialized) { initialize(); }

		if(multipartFile.isEmpty()) { throw new UploadingException("Failed to upload empty file " + multipartFile.getOriginalFilename()); }

		String originalFilename = EncodingHelper.convert(multipartFile.getOriginalFilename());
		String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1, originalFilename.length());

		int width, height;
		Path targetDirectory;
		switch(eventType) {
		case SECRET:
			targetDirectory = TARGET_DIRECTORY_FOR_SECRET;
			width = Global.Secret.getImageSideLength();
			height = Global.Secret.getImageSideLength();
			break;
		case WANTED:
			targetDirectory = TARGET_DIRECTORY_FOR_WANTED;
			width = Global.Wanted.getImageWidth();
			height = Global.Wanted.getImageHeight();
			break;
		default:
			throw new IllegalArgumentException("UNKNOWN EVENT TYPE \"" + eventType.name() + "\".");
		}
		
		Path directory = targetDirectory.resolve(userSequence);
		if(!Files.exists(directory)) { Files.createDirectories(directory); }

		String fileName = UUID.randomUUID().toString() + '.' + extension;
		recentPath = directory.resolve(fileName);
		if(Files.exists(recentPath)) {
			LOGGER.warn("\"" + recentPath + "\" already exists; deleting.");
			Files.delete(recentPath);
		}
		Files.copy(multipartFile.getInputStream(), recentPath);

		String fileNameForScaledImage = (PREFIX_FOR_SCALED_IMAGES + fileName);
		recentPathScaled = directory.resolve(fileNameForScaledImage);
		if(Files.exists(recentPathScaled)) {
			LOGGER.warn("\"" + recentPathScaled + "\" already exists; deleting.");
			Files.delete(recentPathScaled);
		}

		try {
			BufferedImage strippedImage = Transformation.stripAndTransform(new File(recentPath.toString()), true, width, height);
			ImageIO.write(strippedImage, extension, new File(recentPathScaled.toString()));

			System.out.println("#########################  save success:");
			return recentPathScaled.toString();
			
			
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);

			return recentPath.toString();
		}
	}

	public void undoStoring() {
		if(!initialized) { initialize(); }

		try {
			Files.delete(recentPath);
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);
		} finally {
			recentPath = null;
		}

		try {
			Files.delete(recentPathScaled);
		} catch(Exception exception) {
			LOGGER.error(exception.getMessage(), exception);
		} finally {
			recentPathScaled = null;
		}
	}

	public static void initialize() {
		try {
			Files.createDirectories(TARGET_DIRECTORY_FOR_SECRET);
			initialized = true;
		} catch(FileAlreadyExistsException fileAlreadyExistsException) {
			initialized = true;
		} catch(IOException e) {
			throw new UploadingException("Could not initialize storage", e);
		}
	}

	public enum EventType {
		SECRET, WANTED/*, DLIVE*/
	}
}

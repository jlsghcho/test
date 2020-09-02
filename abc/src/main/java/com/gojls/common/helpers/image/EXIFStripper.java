package com.gojls.common.helpers.image;

//import com.drew.imaging.ImageMetadataReader;
//import com.drew.imaging.ImageProcessingException;
//import com.drew.metadata.Directory;
//import com.drew.metadata.Metadata;
//import com.drew.metadata.Tag;
//import com.drew.metadata.exif.ExifIFD0Directory;
import com.gojls.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class EXIFStripper {
	private static final int TAG_FOR_ORIENTATION = 0x0112;

	private static final Logger LOGGER = LoggerFactory.getLogger(EXIFStripper.class);

	public static void main(String... args) throws IOException {
		//File file = new File(args[0]);
		//File output = new File("D:/Hannibal/temp/result.jpg");

		//BufferedImage result = Transformation.stripAndTransform(file, true, 100, 100);
		//ImageIO.write(result, "jpg", output);
	}

	/*public static Orientation readImageInformation(File file) throws IOException, ImageProcessingException {
		Metadata metadata = ImageMetadataReader.readMetadata(file);
		Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);

		if(directory == null) { return Orientation.HORIZONTAL; }

		int orientation = 1;
		try {
			for(Tag tag : directory.getTags()) {
				Object value = tag.getValue();
				if(tag.getTagType() == TAG_FOR_ORIENTATION) {
					orientation = (int)value;
					break;
				}
			}
		} catch(Exception ignored) { return Orientation.HORIZONTAL; }

		return Orientation.byOrdinal(orientation);
	}*/
	public static AffineTransform getExifTransformation(Orientation orientation, int sourceWidth, int sourceHeight, boolean toScale) {
		AffineTransform affineTransform = new AffineTransform();

		if(toScale) {
			double scaleX = (Global.Secret.getImageSideLength() / (double)sourceWidth);
			double scaleY = (Global.Secret.getImageSideLength() / (double)sourceHeight);

			affineTransform.scale(scaleX, scaleY);
		}

		switch(orientation.getOrdinal()) {
		case 2: // Flip X
			affineTransform.scale(-1.0, 1.0);
			affineTransform.translate(-sourceWidth, 0);
			break;
		case 3: // PI rotation
			affineTransform.translate(sourceWidth, sourceHeight);
			affineTransform.rotate(Math.PI);
			break;
		case 4: // Flip Y
			affineTransform.scale(1.0, -1.0);
			affineTransform.translate(0, -sourceHeight);
			break;
		case 5: // - PI/2 and Flip X
			affineTransform.rotate(-Math.PI / 2);
			affineTransform.scale(-1.0, 1.0);
			break;
		case 6: // -PI/2 and -width
			affineTransform.translate(sourceHeight, 0);
			affineTransform.rotate(Math.PI / 2);
			break;
		case 7: // PI/2 and Flip
			affineTransform.scale(-1.0, 1.0);
			affineTransform.translate(-sourceHeight, 0);
			affineTransform.translate(0, sourceWidth);
			affineTransform.rotate(3 * Math.PI / 2);
			break;
		case 8: // PI / 2
			affineTransform.translate(0, sourceWidth);
			affineTransform.rotate(3 * Math.PI / 2);
			break;
		default:
			break;
		}

		return affineTransform;
	}

	public enum Orientation {
		UNKNOWN(0, "UNKNOWN"), HORIZONTAL(1, "Horizontal (normal)"), MIRROR_HORIZONTAL(2, "Mirror horizontal"), ROTATE_180(3, "Rotate 180"),
		MIRROR_VERTICAL(4, "Mirror vertical"), MIRROR_HORIZONTAL_AND_ROTATE_270_CW(5, "Mirror horizontal and rotate 270 CW"),
		ROTATE_90_CW(6, "Rotate 90 CW"), MIRROR_HORIZONTAL_AND_ROTATE_90_CW(7, "Mirror horizontal and reotate 90 CW"), ROTATE_270_CW(8, "Rotate 270 CW");

		private final int ORDINAL;
		private final String DESCRIPTION;

		Orientation(int ordinal, String description) {
			ORDINAL = ordinal;
			DESCRIPTION = description;
		}

		public int getOrdinal() { return ORDINAL; }
		public String getDescription() { return DESCRIPTION; }

		public static Orientation byOrdinal(int ordinal) {
			for(Orientation orientation : Orientation.values()) {
				if(orientation.ORDINAL == ordinal) { return orientation; }
			}

			throw new IllegalArgumentException(ordinal + " isn't a valid value for \"" + Orientation.class.getName() + "\".");
		}
	}
}

package com.gojls.common.helpers.image;

import com.gojls.Global;
import com.gojls.common.helpers.image.EXIFStripper.Orientation;

import javax.imageio.ImageIO;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Transformation {
	public static BufferedImage stripAndTransform(File file, boolean toScale, int width, int height) throws IOException {
		BufferedImage bufferedImage = ImageIO.read(file);

		EXIFStripper.Orientation orientation = EXIFStripper.Orientation.HORIZONTAL;
		try {
			orientation = Orientation.HORIZONTAL;//EXIFStripper.readImageInformation(file);
		} catch(Exception exception) {
			exception.printStackTrace();
		}

		AffineTransform affineTransform = null;
		int sourceWidth = bufferedImage.getWidth();
		int sourceHeight = bufferedImage.getHeight();
		BufferedImage result;
		if(orientation == EXIFStripper.Orientation.HORIZONTAL) {
			if(toScale) {
				affineTransform = new AffineTransform();
				double scaleX = (width / (double)sourceWidth);
				double scaleY = (height / (double)sourceHeight);

				affineTransform.scale(scaleX, scaleY);
			}
		} else {
			affineTransform = EXIFStripper.getExifTransformation(orientation, sourceWidth, sourceHeight, toScale);
		}

		if(affineTransform == null) {
			result = bufferedImage;
		} else {
			AffineTransformOp affineTransformOp = new AffineTransformOp(affineTransform, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
			result = affineTransformOp.createCompatibleDestImage(bufferedImage, (bufferedImage.getType() == BufferedImage.TYPE_BYTE_GRAY)? bufferedImage.getColorModel(): null);

			Graphics2D graphics2D = result.createGraphics();
			graphics2D.clearRect(0, 0, result.getWidth(), result.getHeight());
			result = affineTransformOp.filter(bufferedImage, result);
		}

		return result;
	}
}

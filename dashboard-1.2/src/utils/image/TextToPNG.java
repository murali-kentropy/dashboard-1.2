package utils.image;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.text.WordUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONTokener;

import java.awt.*;

public class TextToPNG {
	
	public static void creatBlankImage(String file, String message,int width,int height)
	{
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_INDEXED);
		 
        Graphics2D graphics = image.createGraphics();
         
        // Set back ground of the generated image to white
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, width, height);
 
        // set gradient font of text to be converted to image
        GradientPaint gradientPaint = new GradientPaint(10, 5, Color.BLACK, 20, 10, Color.LIGHT_GRAY, true);
        graphics.setPaint(gradientPaint);
        Font fontHeader = new Font("Comic Sans MS", Font.BOLD, 40);
       
        graphics.setFont(fontHeader);
        graphics.drawString(message, 20, 120);
 
        File outputfile = new File(file);
        try {
       	ImageIO.write(image, "png", outputfile);
       } catch (IOException e) {
       	// TODO Auto-generated catch block
       	e.printStackTrace();
       }
	}

	public static void convertToPNG(String text, String file,String header)
	{
		BufferedImage image = new BufferedImage(725, 1280, BufferedImage.TYPE_BYTE_INDEXED);
		 
        Graphics2D graphics = image.createGraphics();
         
        // Set back ground of the generated image to white
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, 725, 1280);
 
        // set gradient font of text to be converted to image
        GradientPaint gradientPaint = new GradientPaint(10, 5, Color.BLACK, 20, 10, Color.BLACK, true);
        graphics.setPaint(gradientPaint);
        Font fontHeader = new Font("Comic Sans MS", Font.BOLD, 40);
       
        graphics.setFont(fontHeader);
        graphics.drawString(header, 20, 120);
        Font font = new Font("Comic Sans MS", Font.BOLD, 17);
        graphics.setFont(font);
        int x=20;
        int y=490;
        int lineHeight = graphics.getFontMetrics().getHeight();
        for (String line : text.split("\n"))
            graphics.drawString(line, x, y += lineHeight);
        // write 'Hello World!' string in the image
        
 
        // release resources used by graphics context
        graphics.dispose();
 //FileOutputStream out = new FileOutputStream(file);
        // encode the image as a JPEG data stream and write the same to servlet output stream   
 File outputfile = new File(file);
 try {
	ImageIO.write(image, "png", outputfile);
} catch (IOException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
        //JPEGCodec.createJPEGEncoder(out).encode(image);
	}
	public TextToPNG() {
		// TODO Auto-generated constructor stub
	}
	public static void convertToPNG(JSONArray ja,String study)
	{
		for (int i = 0; i < ja.length(); i++) {
			String text=WordUtils.wrap(ja.getJSONObject(i).getString("open_response"), 80);
			String id=ja.getJSONObject(i).getString("cghr_id");
			
			convertToPNG(text, "d:/cghr/phmrc/01_"+study+"_"+id+"_1_blank.png"," Narrative Image "+study+"_"+id);
			creatBlankImage("d:/cghr/phmrc/01_"+study+"_"+id+"_0_blank.png", "No first page",720,1280);
			creatBlankImage("d:/cghr/phmrc/01_"+study+"_"+id+"_cod.png", "No respondent Cod",755,297);
			
		}
	}

	public static void main(String [] args) throws JSONException, FileNotFoundException
	{
		String text="baby got rashes on the body and after 2 hours suffered with high fever. then baby was taken to the primary health center, [PLACE] where doctor gave medicine and given one injection and told to take back the baby to home. but fever did not came down. again baby was taken to the doctor, doctor told that fever will come down give her medicine continuously. rashes got dry but hole papered in the rashes. baby was suffering from fever till death.";
	text =WordUtils.wrap(text, 40);
	System.out.println(text);
	String study="PHMRC";
	JSONArray ja=new JSONArray(new JSONTokener(new FileInputStream("d:/cghr/PHMRC_narratives1.json")));
	convertToPNG(ja,study);
	}
}

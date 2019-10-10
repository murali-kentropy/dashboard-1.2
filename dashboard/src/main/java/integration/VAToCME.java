package integration;

import org.json.JSONArray;
import org.json.JSONObject;

public interface VAToCME {
	
	public String generateCMErecord(String study,JSONObject data  ) throws Exception;
	
	public String generateVAForm(String study,JSONObject data, String outputPath ) throws Exception;
	
	public void generateCMEImages(String study,JSONObject data,String outputPath) throws Exception;

}

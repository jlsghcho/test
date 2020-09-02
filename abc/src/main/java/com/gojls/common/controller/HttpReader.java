package com.gojls.common.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpReader {
	private static final int DEFAULT_CONNECTION_TIMEOUT = 5000;
	private static final int DEFAULT_READ_TIMEOUT = 5000;
	
	private HttpURLConnection conn = null;
	private URL url = null;
	
	private String resMsg = "";
	private int resCode = 0;
	
	public String getResMsg() {	return resMsg; }
	public int getResCode() { return resCode; }
	
	
	public void connectServer(String interfaceUrl, String queryString, String Method, String authKey) throws Exception {
		System.out.println("Http url=>"+ interfaceUrl);
		System.out.println("Http param=>"+ queryString);
		System.out.println("Http authKey=>"+ authKey);


		if ("POST".equals(Method)) {
			connectServerByPost(interfaceUrl, queryString, authKey);
		} else {
			connectServerByGet(interfaceUrl, queryString, authKey);
		}
	}
	
	public void connClose() throws Exception{
		conn.disconnect();
	}
	
	
	private void connectServerByGet(String interfaceUrl, String queryString, String authKey) throws Exception {
		try{
			if(queryString != null && !queryString.equals(""))	
				interfaceUrl += "?" + queryString;
			
			url = new URL(interfaceUrl);
			conn = (HttpURLConnection)url.openConnection();
			conn.setDoInput(true);
			conn.setUseCaches(false);
			//conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			/*if(!authKey.equals("")){
				conn.setRequestProperty("Authorization", "Basic "+ Tool.makeBase64noReverse(authKey));
			}*/
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(DEFAULT_CONNECTION_TIMEOUT);
			conn.setReadTimeout(DEFAULT_READ_TIMEOUT);
			conn.connect();
			
			resMsg = conn.getResponseMessage();
			resCode = conn.getResponseCode();
			if(resCode != 200) {
				throw new Exception("Http Connection resCode : " + resCode +"|"+ resMsg);
			}
		} catch (Exception ex) {
			throw ex;
		}
	}
	
	
	private void connectServerByPost(String interfaceUrl, String queryString, String authKey) throws Exception {
		try{
			url = new URL(interfaceUrl);
			conn = (HttpURLConnection)url.openConnection();
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setRequestProperty("Content-Type", "application/json");
			/*if(!authKey.equals("")){
				conn.setRequestProperty("Authorization", "Basic "+ Tool.makeBase64noReverse(authKey));
			}*/
			//System.out.println("auth encoding =>"+ Tool.makeBase64noReverse(authKey));
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(DEFAULT_CONNECTION_TIMEOUT);
			conn.setReadTimeout(DEFAULT_READ_TIMEOUT);
			
			OutputStream out_stream = null;
			try{
				out_stream = conn.getOutputStream();
				out_stream.write(queryString.getBytes("UTF-8"));
			} catch (Exception e) {
				throw e;
			} finally {
			   out_stream.flush();
			   out_stream.close();
			}
			resMsg = conn.getResponseMessage();
			resCode = conn.getResponseCode();
			if(resCode != 200) {
				throw new Exception("Http Connection resCode : " + resCode +"|"+ resMsg);
			}		
		} catch (Exception ex) { 
			throw ex;
		}
	}
	
	public String readMessage() throws Exception {
		BufferedReader buff = null;
		StringBuffer strBuff = new StringBuffer();
		
		try {
			buff = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line = null;
			while ((line = buff.readLine()) != null) {
				if (line.length() > 1) {
					strBuff.append(line);
				}
			}		
		} catch (Exception ex) {
			throw ex;
		} finally {
			try {
				buff.close();
		   } catch(Exception e) { 
		   	throw e;
		   }
		}
		return strBuff.toString();
	}
}

package com.braker.common.jdbc;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class FileUtil {
	
	/**
	 * 获得web-inf路径
	 * @return
	 */
	public static String getWebRoot() {
		   String path = getWebClassesPath();
		    path = path.substring(0, path.indexOf("classes"));
		   
		   return path;
		}
	
	public static String getPath(String dir){
		 String path = getWebClassesPath();
		 
		 path = path.substring(0, path.indexOf(dir));
		   
		 return path;
	}
	
	public static String getWebClassesPath() {
		   String path = FileUtil.class.getProtectionDomain().getCodeSource()
		     .getLocation().getPath();
		   return path;
		  
		}
	

	public static String readFileData(String filePath,String key){
		String fileData = "";
		Properties p = new Properties();
		FileInputStream fs = null;
		try {
			fs = new FileInputStream(filePath);
			try {
				p.load(fs);				
				fileData = p.getProperty(key);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();		
		}finally{
			if(fs!=null){
				try {
					fs.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
     return fileData;
	}
	
	

}

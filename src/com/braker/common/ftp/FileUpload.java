package com.braker.common.ftp;

import java.io.BufferedReader;
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;
import java.net.SocketException;
import java.util.Properties;

import org.apache.commons.net.ftp.FTPClient;  
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply; 

/**
 * 该类用于实现文件的ftp上传操作
 * @author zhangqiang
 * 2018-6-7
 *
 */
public class FileUpload {
    /*
     * Description: 文件上传（FTP）
     * @param url IP地址
     * @param port 端口 
     * @param username 账号 
     * @param password 密码 
     * @param path 文件保存目录 
     * @param filename 上传到FTP服务器上的文件名 
     * @param input 输入流 
     * @return 成功返回true，否则返回false * 
     */  
    public static boolean uploadFile(String url,int port,String username,String password,String path,String filename,InputStream input){  
        boolean success = false;  
        FTPClient ftp = new FTPClient();  
//        ftp.setControlEncoding("GBK");  
        try {  
            int reply;  
            ftp.connect(url, port);
            ftp.login(username, password);
            reply = ftp.getReplyCode();  
            if (!FTPReply.isPositiveCompletion(reply)) {  
                ftp.disconnect();  
                return success;  
            }  
            ftp.changeWorkingDirectory(path);
            ftp.setControlEncoding("ISO-8859-1"); // 中文支持
            ftp.setFileType(FTPClient.BINARY_FILE_TYPE);  
//            ftp.makeDirectory(path);  
//            ftp.enterLocalPassiveMode();
            
            //判断文件是否重名
            FTPFile[] files = ftp.listFiles();
            FileUpload fu = new FileUpload();
            boolean bool = fu.isReName(filename, files);
            if(bool==true){
            	System.out.println("上传的文件名重复，文件上传失败！");
            }else{
            	ftp.storeFile(new String(filename.getBytes("UTF-8"),"ISO-8859-1"), input);  
                ftp.logout();  
                success = true;  
            }
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
        	if(input !=null){
        		try {
					input.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
        	}
            if (ftp.isConnected()) {  
                try {  
                    ftp.disconnect();  
                } catch (IOException ioe) {  
                }  
            }  
        }  
        return success;  
    }  
  
    /*
     * 将本地文件上传到FTP服务器上
     */
    public static boolean upLoadFromProduction(String url,int port,String username,String password,String path,String filename,String orginfilename) {  
    	FileInputStream in =null;
    	try {  
            in = new FileInputStream(new File(orginfilename));  
            boolean flag = uploadFile(url, port, username, password, path,filename, in);  
            return true;
        } catch (Exception e) {
            e.printStackTrace(); 
            return false;
        }  finally{
        	if(in!=null){
        		try {
					in.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        	}
        }
    }  
    
    /*
     * 判定文件名是否重复
     */
    public boolean isReName(String file_name, FTPFile[] file){
    	boolean flag = false;
    	for(int a=0;a<file.length;a++){
    		if (file_name.equals(file[a].getName().toString())){
    			flag = true;
    		}
    	}
    	return flag;
    }
    
    /*
     * ftp服务器配置信息读取
     */
    public String getFtpConfig(String key){
    	String value = null;
    	InputStream in =null;
    	try {
	    	Properties properties = new Properties();
	  	  	in = FileUpload.class.getClassLoader().getResourceAsStream("ftp.properties");
	  	  
			properties.load(in);
			value = properties.getProperty(key);
    	} catch (Exception e) {
			// TODO: handle exception
		}finally{
			if(in !=null){
				try {
					in.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
    	return value;
    }
    
    
    /*
     * 获取FTPClient对象 
     * @param ftpHost FTP主机服务器 
     * @param ftpPassword FTP 登录密码 
     * @param ftpUserName FTP登录用户名 
     * @param ftpPort FTP端口 默认为21 
     * @return 
     */  
    public static FTPClient getFTPClient(String ftpHost, String ftpUserName,  
            String ftpPassword, int ftpPort) {  
        FTPClient ftpClient = new FTPClient();  
        try {  
            ftpClient = new FTPClient();  
            ftpClient.connect(ftpHost, ftpPort);// 连接FTP服务器  
            ftpClient.login(ftpUserName, ftpPassword);// 登陆FTP服务器  
            if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {  
                ftpClient.disconnect();  
            } else {  
            }  
        } catch (SocketException e) {  
            e.printStackTrace();
        } catch (IOException e) {  
            e.printStackTrace();
        }  
        return ftpClient;  
    }  
  
    /* 
     * 从FTP服务器下载文件 
     * @param ftpHost FTP IP地址 
     * @param ftpUserName FTP 用户名 
     * @param ftpPassword FTP用户名密码 
     * @param ftpPort FTP端口 
     * @param ftpPath FTP服务器中文件所在路径 格式： ftptest/aa 
     * @param localPath 下载到本地的位置 格式：H:/download 
     * @param fileName 文件名称 
     */  
    public static void downloadFtpFile(String ftpHost, String ftpUserName,  
            String ftpPassword, int ftpPort, String ftpPath, String localPath,  
            String fileName) {  
  
        FTPClient ftpClient = null;  
        OutputStream os=null;
        try {
            ftpClient = getFTPClient(ftpHost, ftpUserName, ftpPassword, ftpPort);  
            ftpClient.setControlEncoding("UTF-8"); // 中文支持  
            ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);  
            ftpClient.enterLocalPassiveMode();  
            ftpClient.changeWorkingDirectory(ftpPath);  
  
            File localFile = new File(localPath + File.separatorChar + fileName);  
            os = new FileOutputStream(localFile);  
            ftpClient.retrieveFile(fileName, os);  
        } catch (FileNotFoundException e) { 
            e.printStackTrace();  
        } catch (SocketException e) {
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace(); 
        }  finally{
        	if(os !=null){
        		try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
        	}
        	if(ftpClient!=null){
        		try {
					ftpClient.logout();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
        	}
        }
  
    }  
    
    /*
     * Description: 文件上传（FTP）
     * @param url IP地址
     * @param port 端口 
     * @param username 账号 
     * @param password 密码 
     * @param path 文件保存目录 
     * @param filename FTP服务器上要删除的文件名 
     * @return 成功返回true，否则返回false * 
     */  
    public static boolean delFile(String url,int port,String username,String password,String path,String filename){  
        boolean success = false;  
        FTPClient ftp = new FTPClient();  
        try {  
            int reply;  
            ftp.connect(url, port);
            ftp.login(username, password);
            reply = ftp.getReplyCode();  
            if (!FTPReply.isPositiveCompletion(reply)) {  
                ftp.disconnect();  
                return success;  
            }  
            ftp.changeWorkingDirectory(path);
            ftp.deleteFile(new String(filename.getBytes("utf-8"),"ISO-8859-1"));
            ftp.logout();  
            success = true;  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (ftp.isConnected()) {  
                try {  
                    ftp.disconnect();  
                } catch (IOException ioe) {  
                }  
            }  
        }  
        return success;  
    }  
    
    /*
     * main method
     */
    public static void main(String[] args) {  
    	FileUpload fu = new FileUpload();
    	
//        String url = fu.getFtpConfig("url");
//        int port = Integer.parseInt(fu.getFtpConfig("port"));
//        String username = fu.getFtpConfig("username");
//        String password = fu.getFtpConfig("password");
        
        String url = "127.0.0.1";
        int port = 21;
        String username = "admin";
        String password = "123456";
        String path = "GG";
        String filename = "图片.png";
//        String input = "D:/BTC_00_新员工入职说明-20170718.docx";
        
//        upLoadFromProduction(url, port,username,password,path,filename,input);
        
        delFile(url, port, username, password, path, filename);
        
    }  
}  
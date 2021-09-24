package com.braker.common.ftp;

import java.io.File;
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

public class FileDownload {

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
    		e.printStackTrace();
		}finally{
			if(in!=null){
    			try {
					in.close();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
    		}
		}
    	return value;
    }
    
	
    /**
     * 获取FTPClient对象
     *
     * @param ftpHost     FTP主机服务器
     * @param ftpPassword FTP 登录密码
     * @param ftpUserName FTP登录用户名
     * @param ftpPort     FTP端口 默认为21
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
                System.out.println("未连接到FTP，用户名或密码错误。");
                ftpClient.disconnect();
            } else {
                System.out.println("FTP连接成功。");
            }
        } catch (SocketException e) {
            e.printStackTrace();
            System.out.println("FTP的IP地址可能错误，请正确配置。");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("FTP的端口错误,请正确配置。");
        }
        return ftpClient;
    }

    /**
    * @author xh 测试成功 可以下载中文文件  ftp默认的编码为gbk
    * @param url
    * @param port
    * @param username
    * @param password
    * @param remotePath
    * @param fileName
    * @param localPath
    * @return
    */
    public static boolean downFtpFile(String url, int port, String username,  
                String password, String remotePath, String fileName,  
                String localPath) {  
            boolean success = false;  
            FTPClient ftp = new FTPClient();  
            try {  
                int reply;  
                ftp.connect(url, port);  
                // 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器  
                ftp.login(username, password);// 登录  
                reply = ftp.getReplyCode();  
                if (!FTPReply.isPositiveCompletion(reply)) {  
                    ftp.disconnect();  
                    return success;  
                }  
                ftp.changeWorkingDirectory(remotePath);// 转移到FTP服务器目录  
                FTPFile[] fs = ftp.listFiles();  
                for (FTPFile ff : fs) {  
                    String fname = new String(ff.getName().getBytes("iso-8859-1"),  
                            "UTF-8");  
                    if (fname.equals(fileName)) {  
                        File localFile = new File(localPath+fname);  
                        OutputStream out =null;
                        try {
                        	 out = new FileOutputStream(localFile);  
                             ftp.retrieveFile(ff.getName(), out);  
						} catch (Exception e) {
							// TODO: handle exception
						}finally{
							if(out!=null){
								out.close();  
							}
						}
                       
                        
                        break;  
                    }  
                }  
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
        String ftpPath = "XM"; //ftp文件路径
        String filename = "test.txt"; //要下载的文件名称
        String localPath = "D:/test/";  //本地文件路径
        downFtpFile(url,port, username,password,ftpPath,filename,localPath);
    }  
}  
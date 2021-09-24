package com.braker.core.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.doc2html.Word2Html;
import com.braker.common.ftp.FileUpload;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;

@Controller
@RequestMapping("/Office")
public class OfficeController extends BaseController{

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/lowlist")
	public String jump(ModelMap model){
		return "WEB-INF/view/assets/rece/rece_low_list";
	}
	/**
	 * 传文件路径到前台
	 * @param path
	 * @param model
	 * @return
	 * @throws ParserConfigurationException 
	 * @throws IOException 
	 * @throws TransformerException 
	 */
	@RequestMapping("/office")
	@ResponseBody
	public String office(String path,ModelMap model) throws TransformerException, IOException, ParserConfigurationException{
		try {
			path = java.net.URLDecoder.decode(path,"UTF-8");
			path=path.trim();
			String[] p=path.split("/");
			String filename=null;
			if((p[p.length-1].substring(p[p.length-1].length()-1)).equals("x")){
				filename = p[p.length-1].substring(0, p[p.length-1].length()-5);
			}else if((p[p.length-1].substring(p[p.length-1].length()-1)).equals("c")){
				filename = p[p.length-1].substring(0, p[p.length-1].length()-4);
			}
			String name =StringUtil.Random("")+".html";
			FileUpload fu = new FileUpload();
			String url = fu.getFtpConfig("url");
			String webport = fu.getFtpConfig("webport");
			String filepath = fu.getFtpConfig("filepath");
			String basepath = fu.getFtpConfig("basepath");
			//word读取路径
			String officePath=basepath+filepath+path;
			//转换成html文件的路径
			String outPutFile=p[0]+"/"+p[1]+"/"+name;
			//转换成html文件的输出路径
			String fileUrl=basepath+filepath+outPutFile;
			String wordUrl="http://"+url+":"+webport+filepath+outPutFile;
			//图片保存路径
			String images=basepath+filepath+p[0]+"/"+p[1]+"/images/";
			Word2Html w=new Word2Html();
			w.wordToHtml(officePath, fileUrl, images);
			return wordUrl;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	@RequestMapping("/doc")
	public String doc(@PathVariable String filurl,ModelMap model){
		System.out.println("dada");
		try {
			filurl = java.net.URLDecoder.decode(filurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return filurl;
	}
	
	
}

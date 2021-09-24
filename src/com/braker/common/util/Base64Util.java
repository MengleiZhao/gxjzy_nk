package com.braker.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.page.Result;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


/**
 * 将图片转成base64的控制层
 * @author 叶崇辉
 */
@Controller
@RequestMapping(value = "/base64")
public class Base64Util {
	
	/**
	 * 将图片转成base64
	 * @param file图片文件
	 * @return 图片的base64
	 */
	public static String getBase64(File file) {
		String imgStr = "";
		FileInputStream fis = null;
		try {
			//字符流转化
			fis = new FileInputStream(file);
			byte[] buffer = new byte[(int) file.length()];  
			int offset = 0;  
			int numRead = 0;  
			while (offset < buffer.length && (numRead = fis.read(buffer, offset, buffer.length - offset)) >= 0) {
				offset += numRead;
			}
			fis.close();  
			
			BASE64Encoder encoder = new BASE64Encoder();
			imgStr = encoder.encode(buffer);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		//加上base64的前缀
		imgStr = "data:image/png;base64," + imgStr;
		return imgStr;
	}
	
	/**
	 * 上传图片
	 * @author 叶崇晖
	 * @param model
	 * @param imageFile图片MultipartFile
	 * @param imageType图片类型1支付宝、2微信
	 * @return 图片的base64
	 */
	@RequestMapping("/uploadImage")
	@ResponseBody
	public String uploadAtt(ModelMap model, @RequestParam(value="imageFile",required=false) MultipartFile imageFile, String imageType){
		File file = null;
		String imgStr = "";
		try {
			file=File.createTempFile("tmp", null);//在项目中生成临时文件
			imageFile.transferTo(file);//MultipartFile转化为file
			imgStr = getBase64(file);//file转化为base64
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			file.deleteOnExit();     //使用完成删除文件
		}
		return imgStr;
	}

	public static MultipartFile base64ToMultipart(String base64) {
		try {
			String[] baseStrs = base64.split(",");
			BASE64Decoder decoder = new BASE64Decoder();
			byte[] b = new byte[0];
			;
			b = decoder.decodeBuffer(baseStrs[1]);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {
					b[i] += 256;
				}
			}
			return new Base64DecodeMultipartFile(b, baseStrs[0]);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
}

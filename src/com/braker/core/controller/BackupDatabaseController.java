package com.braker.core.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.web.BaseController;
import com.braker.core.manager.BackupDatabaseService;
import com.braker.core.manager.BackupDownloadRecordService;
import com.braker.core.model.BackupDatabase;
import com.braker.exception.ServiceException;

/**
 * 数据库备份、还原、下载Controller
 * @author: 焦广兴
 * @Date:2020年7月23日
 */
@Controller
@RequestMapping("/backups")
public class BackupDatabaseController  extends BaseController {
	@Autowired
	private BackupDatabaseService backupDatabaseService;
	@Autowired
	private BackupDownloadRecordService backupDownloadRecordService;
	
	@RequestMapping("/list")
	public String list(ModelMap model, String val){
		model.addAttribute("val", val);
		return "/WEB-INF/view/backup/backups_database_list";
		
	}
	
	
	@RequestMapping("/pageData")
	@ResponseBody
	public JsonPagination pageData(BackupDatabase bean, String sort, String order, Integer page, Integer rows){
		try {
			Pagination p = backupDatabaseService.findList(bean, getUser(), sort, order, page, rows);
			return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonPagination(null, 0);
		}
	}
	
	/**
	 * 填写描述
	 * @author  焦广兴
	 * @param model
	 * @param type
	 * @return
	 * @Date  2020年7月24日
	 */
	@RequestMapping("/addMsg")
	public String addMsg(ModelMap model, String type){
		model.addAttribute("type", type);
		return "/WEB-INF/view/backup/backups_msg";
	}
	
	
	/**
	 * 备份\还原 数据
	 * @author  焦广兴
	 * @param fileName 还原的文件名称
	 * @param type 操作类型（BFSJ\HYSJ）
	 * @param msg 描述
	 * @return
	 * @Date  2020年7月23日
	 */
	@RequestMapping(value="/saveBackups")
	@ResponseBody
	public Result saveBackups(String fileName, String type, String msg) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
//			System.out.println("开始执行-------"+sdf.format(new Date()));
			backupDatabaseService.saveBackups(fileName, msg, type, getYear() , getUser());
//			System.out.println("执行结束-------"+sdf.format(new Date()));
		}catch (ServiceException se) {
			se.printStackTrace();
			return getJsonResult(false,se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			if("BFSJ".equals(type)){
				return getJsonResult(false,"备份失败，请联系管理员！");
			}else{
				return getJsonResult(false,"还原失败，请联系管理员！");
			}
		}
		if("BFSJ".equals(type)){
			return getJsonResult(true,"备份成功！");
		}
		return getJsonResult(false,"还原成功！");
	}
	
	/**
	 * 下载
	 * @author  焦广兴
	 * @param id
	 * @param name
	 * @param response
	 * @return
	 * @Date  2020年7月24日
	 */
	@RequestMapping("/download")
	@ResponseBody
	public Result download(String id, String name, HttpServletResponse response){
		OutputStream out = null;
		InputStream in = null;
		try {
			BackupDatabase bean = null;
			File file = null;
			if(StringUtils.isNotEmpty(id)){
				bean = backupDatabaseService.findById(id);
				// 保存下载记录
				backupDownloadRecordService.saveBackupsRecord(bean, getUser());
				file = new File(bean.getfPath());
			}else{
				file = new File("D:\\WhxhSql\\"+name+".sql");
			}
			
			if(file.exists()){
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition", "attachment; filename=\""
								+ new String((bean.getfName()+".sql").getBytes("gbk"), "iso8859-1")
								+ "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a; 
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			}else{
				return getJsonResult(false,"文件不存在！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"下载失败,请联系管理员！");
		} finally {
			try {
				if (out != null)
					out.close();
				if (in != null)
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getJsonResult(true,"下载成功！");
	}

	
}

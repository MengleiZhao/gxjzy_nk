package com.braker.icontrol.expend.cashier.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.expend.cashier.manager.CashierCollectMng;
import com.braker.icontrol.expend.cashier.model.CashierCollectInfo;

/**
 * 出纳采集的控制层
 * @author 叶崇晖
 * @createtime 2018-08-27
 * @updatetime 2018-08-27
 */
@Controller
@RequestMapping(value = "/cashierCollect")
public class CashierCollectController extends BaseController {
	@Autowired
	private CashierCollectMng cashierCollectMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/cashier/cashier_robot_list";
	}
	
	
	/*
	 * 出纳采集分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	@RequestMapping(value = "/page")
	@ResponseBody
	public JsonPagination reimbursePage(CashierCollectInfo bean, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cashierCollectMng.pageList(bean, page, rows, getUser());
    	List<CashierCollectInfo> li = (List<CashierCollectInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 出纳采集文件导入
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	@RequestMapping(value = "/collect")
	@ResponseBody
	public Result collect(MultipartFile xlsx) {
		InputStream ins =null;
		OutputStream os =null;
		try {
			File f = null;
			if(xlsx.equals("")||xlsx.getSize()<=0){
				xlsx = null;
			}else{
				ins = xlsx.getInputStream();
			    f=new File(xlsx.getOriginalFilename());
			    os = new FileOutputStream(f);
				int bytesRead = 0;
				byte[] buffer = new byte[8192];
				while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
					os.write(buffer, 0, bytesRead);
				}
				File file = new File(f.toURI());
				
				cashierCollectMng.saveCashierCollect(file);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}finally{
			if(os!=null){
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ins!=null){
				try {
					ins.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return getJsonResult(true,"操作成功！");
	}
}

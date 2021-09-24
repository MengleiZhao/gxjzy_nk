package com.braker.core.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.SystemCenterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.User;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 制度中心管理的控制层
 * 本模块用于绩效自评的操作
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
@Controller               
@RequestMapping(value = "/systemcentergl")
public class SystemCenterController extends BaseController{
	@Autowired
	private SystemCenterMng systemCenterMng;
	
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private AttachmentMng attachmentMng;
	/*
	 * 跳转到制度中心列表页面
	 * @author 张迅
	 * @createtime 2018-09-03
	 * @updatetime 2019-04-16
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model, String menuMark,String typeStr) {
		
		if ("fromMenu".equals(menuMark)) {
			//菜单跳转
			return "/WEB-INF/gwideal_core/systemcenter/systemcenter_list_index";
		} else {
			//“制度索引”跳转
			//typeStr=StringUtil.setUTF8(typeStr);
			if("budget".equals(typeStr)){
				typeStr="预算管理";
			}else if("income".equals(typeStr)){
				typeStr="收入管理";
			}else if("expenditure".equals(typeStr)){
				typeStr="支出管理";
			}else if("procurement".equals(typeStr)){
				typeStr="采购管理";
			}else if("contract".equals(typeStr)){
				typeStr="合同管理";
			}else if("asset".equals(typeStr)){
				typeStr="资产管理";
			}else{
				typeStr="All";
			}
			if(!typeStr.equals("All")){
				List<CheterInfo> cheterListType = cheterMng.getCheterInfoList(typeStr);
				model.addAttribute("cheterListType", cheterListType);
			}
			List<CheterInfo> cheterListAll = systemCenterMng.getFileNamList(null,typeStr,null);
			model.addAttribute("cheterListAll", cheterListAll);
			return "/WEB-INF/gwideal_core/systemcenter/systemcenter_list";
		}
		
	}
	
	/**
	 * 制度索引界面查询数据
	 * @author 焦广兴
	 * @createtime 2019-04-30
	 * @updatetime 2019-04-30
	 */
	@RequestMapping("/systemList")
	@ResponseBody
	public List<CheterInfo> systemList(String fileName,String more){
		if(!StringUtil.isEmpty(fileName)){
//			fileName=StringUtil.setUTF8(fileName);
	    	List<CheterInfo> list = systemCenterMng.getFileNamList(fileName,null,null);
	    	if (list != null && list.size() > 0) {
				return list;
			}
		}
		if(!StringUtil.isEmpty(more)){
			more=StringUtil.setUTF8(more);
	    	List<CheterInfo> list = systemCenterMng.getFileNamList(null,null,more);
	    	if (list != null && list.size() > 0) {
				return list;
			}
		}
		return null;
	}
	/**
	 * 制度索引界面 下载
	 * @author 焦广兴
	 * @createtime 2019-04-30
	 * @updatetime 2019-04-30
	 */
	@RequestMapping("/systemDownload")
	public String systemDownload(String fileName,String systemId,HttpServletResponse response, HttpServletRequest request){
		InputStream input = null;
		ZipOutputStream zipOut =null;
		String []strArr=systemId.split(",");
		
		try {
			List<File>list=new ArrayList<>();
			List<String>listName=new ArrayList<>();
			//设置下载文件名称
			response.setHeader("Content-disposition","attachment; filename=" + new String("我下载的制度".getBytes("gbk"), "iso8859-1")+".zip");
			for (int i = 0; i < strArr.length; i++) {
				//查询基本信息
				CheterInfo bean = systemCenterMng.findById(Integer.valueOf(strArr[i]));
				//查询附件信息
				Attachment attac = attachmentMng.findById(bean.getAttachment().getId());
				File file = new File(attac.getFileName());
				list.add(file);
				listName.add(bean.getFileName());
	    	}
			//压缩导出文件并传到前台
			zipOut = new ZipOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream"); 
					for (int j = 0; j < list.size(); j++) {
						input = new FileInputStream(list.get(j));
						String s=listName.get(j)+".pdf";
						zipOut.putNextEntry(new ZipEntry(s));
						int temp = 0;
						while((temp = input.read()) != -1){
							zipOut.write(temp);
						}
						input.close();
					}
			zipOut.flush();
			zipOut.close();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(input!=null){
				try {
					input.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(zipOut!=null){
				try {
					zipOut.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	/**
	 * 制度索引界面 打印
	 * @author 焦广兴
	 * @createtime 2019-04-30
	 * @updatetime 2019-04-30
	 */
	@RequestMapping("/systemPrint")
	public String systemPrint(String fileName){
    	/*List<CheterInfo> li = systemCenterMng.getFileNamList(fileName);
    	System.out.println();*/
		return null;
	}
	/*
	 * 分页数据获得制度的信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value = "/systemcenterPageData")
	@ResponseBody
	public JsonPagination loanPage(CheterInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = systemCenterMng.pageList(bean, page, rows);
    	List<CheterInfo> li = (List<CheterInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	/*
	 * 新增制度信息
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2018-09-04
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		
		//加入默认字段:编码 上传人 上传时间
		CheterInfo bean = new CheterInfo();
		bean.setReleseTime(new Date());
		bean.setReleseUser(getUser()!=null? getUser().getName():"");
		bean.setHelpNum(systemCenterMng.getMaxCode());
		
		model.addAttribute("bean", bean);
		return "/WEB-INF/gwideal_core/systemcenter/systemcenter_add";
	}
	@RequestMapping("/test")
	public String test(ModelMap model){
		
		return "/WEB-INF/gwideal_core/systemcenter/systemcenter_add";
	}
	/*
	 * 制度保存
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2018-09-04
	 */
	
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(CheterInfo bean,String files,ModelMap model) {
		
		try {
			CheterInfo c=systemCenterMng.findByFileName(bean.getFileName());
			if ( c!= null && bean.getSystemId()==null) {
				return getJsonResult(false, "该文档名称已经存在，请修改！");
			}
			systemCenterMng.save(bean,files,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 查看制度信息
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2019-04-24
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model,String fromSy){//id是制度表的systemid
		//查询基本信息
		CheterInfo bean = systemCenterMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//是否来自首页
		model.addAttribute("fromSy", fromSy);
		//打开类型
		model.addAttribute("openType", "detail");

		return "/WEB-INF/gwideal_core/systemcenter/systemcenter_detail";
	}
	
	/*
	 * 使用PDF阅读器查看文件
	 * @author 张迅
	 * @createtime 2019-04-15
	 * @updatetime 2019-04-15
	 */
	@RequestMapping("/viewPDF")
	public String viewPDF(String systemId, String fileName, HttpServletResponse response, ModelMap model){
		//fileName=StringUtil.setUTF8(fileName);
		/*CheterInfo cheter = systemCenterMng.findByFileName(name);*/
		CheterInfo cheter = systemCenterMng.findById(Integer.valueOf(systemId));
		Attachment attachment = cheter.getAttachment();
		//更新查看记录
		systemCenterMng.recordViewLog(cheter);
		model.addAttribute("location", attachment.getFileName().replace("\\", "/"));
		model.addAttribute("originalName", attachment.getOriginalName());
		return "/WEB-INF/gwideal_core/systemcenter/systemcenter_pdf";
	}
	
	/*
	 * 制度修改
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2018-09-04
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		//查询基本信息
		CheterInfo bean=systemCenterMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		if(attac.size()!=0){
			model.addAttribute("edit", "edit");	//前端用来判断是否是修改还是新增
		}
		return "/WEB-INF/gwideal_core/systemcenter/systemcenter_add";
	}
	
	/*
	 * 制度删除
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			systemCenterMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
}

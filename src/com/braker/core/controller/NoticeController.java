package com.braker.core.controller;



import java.util.Date;
import java.util.List;

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
import com.braker.common.web.BaseController;
import com.braker.core.manager.NoticeAttacMng;
import com.braker.core.manager.NoticeMng;
import com.braker.core.model.Notice;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 公告中心的控制层
 * 本模块用于公告信息的增删改查
 * @author 叶崇晖
 * @createtime 2018-06-5
 * @updatetime 2018-06-5
 */
@SuppressWarnings("serial")
@Controller
@RequestMapping(value = "/notice")
public class NoticeController extends BaseController{
	@Autowired
	private NoticeMng noticeMng;
	@Autowired
	private NoticeAttacMng noticeAttacMng;
	@Autowired
	private AttachmentMng attachmentMng;
	
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model, String menuMark,String noticeId) {
		//model.addAttribute("listStreet", listStreet());
		if ("fromIndex".equals(menuMark)) {
			if ("0".equals(noticeId)) {
				return "/WEB-INF/gwideal_core/notice/notice_list_index_new";
			}
			return "/WEB-INF/gwideal_core/notice/notice_list_index";
		}
		return "/WEB-INF/gwideal_core/notice/notice_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping(value = "/noticePage")
	@ResponseBody
	public JsonPagination noticePage(Notice bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	//序号设置
		Pagination p = noticeMng.pageList(bean, page, rows,order);
		List<Notice> li = (List<Notice>) p.getList();
		for(int x=0; x<li.size(); x++) {
			li.get(x).setNum((x+1)+(page-1)*rows);
		}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping("/add")
	public String add(ModelMap model) {
		//获取当前登录对象获得发布人名称
		Notice bean = new Notice();
		bean.setReleaseUser(getUser().getName());
		bean.setReleaseTime(new Date());
		model.addAttribute("bean", bean);
		return "/WEB-INF/gwideal_core/notice/notice_add";
	}
	
	/*
	 * 跳转修改页面
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable Integer id, ModelMap model) {
		//传回来的id是主键
		Notice bean = noticeMng.findById(id);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		
		model.addAttribute("bean", bean);
		model.addAttribute("attac", attac);
		return "/WEB-INF/gwideal_core/notice/notice_add";
	}
	
	/*
	 * 公告新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(Notice bean, String contentString,String files,ModelMap model) {
		try {	
			bean.setContent(contentString);
			noticeMng.save(bean,files,getUser());
		
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 公告删除
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping(value = "/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable Integer id) {
		try {
			//传回来的id是主键
			noticeMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/*
	 * 公告查看 
	 */
	@RequestMapping(value = "/detail/{id}")
	public String detail(@PathVariable Integer id, ModelMap model) {
		//传回来的id是主键
				Notice bean = noticeMng.findById(id);
				//查询附件信息
				List<Attachment> attac = attachmentMng.list(bean);
				
				model.addAttribute("bean", bean);
				model.addAttribute("attac", attac);
		return "/WEB-INF/gwideal_core/notice/notice_detail";
	}
	
}

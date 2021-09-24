package com.braker.icontrol.budget.manager.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.icontrol.budget.manager.manager.ResolveMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 预算管理控制数分解（一下）控制层
 * 本模块用于控制数分解的控制
 * @author 叶崇晖
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
@Controller
@RequestMapping(value = "/resolve")
public class ResolveController extends BaseController {
	@Autowired
	private ResolveMng resolveMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private AttachmentMng attachmentMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		model.addAttribute("year",Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date()))+1);
		return "/WEB-INF/view/budget/manager/resolve/project-resolve-list";
	}
	
	/*
	 * 控制数分解项目列表
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/projectPage")
	@ResponseBody
	public List<TProBasicInfo> yssbProjectPage(TProBasicInfo bean, String type, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	List<TProBasicInfo> list = resolveMng.pageList(bean, page, rows, getUser(), type);
    	if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				//序号
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page*rows+i-9);
				
				//为待分解项目时，设置控制数和项目预算金额相同，方便用户操作
				if("0".equals(type)) {
					pro.setProvideAmount1(pro.getFProBudgetAmount());
				}
			}
		}
    	return list;
	}
			
	/*
	 * 控制数分解保存
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/projectResolve")
	@ResponseBody
	public Result projectResolve(String fproId, String provideAmount1, String fext12) {
		try {
			resolveMng.save(fproId, provideAmount1, fext12);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 跳转页面到附件上传页面
	 * @param id 项目基本信息主键
	 * @param model
	 * @return
	 */
	@RequestMapping("/filesjsp/{id}")
	public String filesUpdate(@PathVariable String id,String type, ModelMap model){
		model.addAttribute("id", id);
		TProBasicInfo bean = tProBasicInfoMng.findById(Integer.valueOf(id));
		//附件
		List<Attachment> attaList = attachmentMng.list(bean);
		//标记是否显示含有附件
		if (attaList != null && attaList.size() > 0) {
			model.addAttribute("hasFile", "true");
		}
		if("1".equals(type)){
			model.addAttribute("projectResolveAttaList", attaList);
			model.addAttribute("openType", "edit");
		}else {
			model.addAttribute("projectResolveAttaList", attaList);
			model.addAttribute("openType", "detail");
			
		}
		return "/WEB-INF/view/budget/manager/resolve/project-resolve-files-add";
	}
	
	/**
	 * 保存附件信息
	 * @param id 项目基本信息主键
	 * @param filesUpdate 附件
	 * @return
	 */
	@RequestMapping("/filesUpdate")
	@ResponseBody
	public Result filesUpdate(String FProId,String files){
		try {
			tProBasicInfoMng.filesUpdate(FProId, files);
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
}

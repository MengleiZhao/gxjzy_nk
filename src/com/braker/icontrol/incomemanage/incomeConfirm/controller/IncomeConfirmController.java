package com.braker.icontrol.incomemanage.incomeConfirm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.incomeConfirm.manager.IncomeConfirmMng;
import com.braker.icontrol.incomemanage.incomeConfirm.model.IncomeConfirmInfo;
import com.braker.icontrol.incomemanage.register.manager.RegisterMng;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping(value = "/incomeConfirm")
public class IncomeConfirmController extends BaseController{
	@Autowired
	private IncomeConfirmMng incomeConfirmMng;
	
	@Autowired
	private RegisterMng registerMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	
	/*
	 * 跳转到确认列表页面
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value = "/confirmList")
	public String confirmlist( ModelMap model) {
		return "/WEB-INF/view/income_manage/register/register_confirmlist";
	}
	
	
	/*
	 * 来款确认分页数据获得
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value = "/confirmPage")
	@ResponseBody
	public JsonPagination confirmPage(IncomeConfirmInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	User user = getUser();
    	Pagination p = incomeConfirmMng.confirmPageList(bean, page, rows,user);
    	List<IncomeConfirmInfo> li = (List<IncomeConfirmInfo>) p.getList();
    	for(int x=0; x<li.size(); x++){
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description: 跳转确认页面
	 * @author 方淳洲
	 * @param @param model
	 * @param @param id
	 * @param @return    
	 * @return String
	 */
	@RequestMapping("/confirm")
	public String confirm(ModelMap model, String id){
		//基本信息
		IncomeInfo bean=registerMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		List<Attachment> businessAttaList = attachmentMng.list(bean);
		model.addAttribute("businessAttaList", businessAttaList);

		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfReqUserid(), "FHTSRQR", bean.getFregisterDepartId(), bean.getBeanCode(), bean.getfNCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("FHTSRQR", bean.getFregisterDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getFregisterDepart(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/register/register_confirm";
	}
	
	
	@RequestMapping(value = "/saveConfirm")
	@ResponseBody	
	public Result saveConfirm(IncomeInfo bean,IncomeConfirmInfo icBean,String mingxiJson,String confirmFiles,ModelMap model) {
		try {
			List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
			boolean flag = false;
			for(int h = 0 ;h < rp.size();h++) {
				if("1".equals(rp.get(h).getPayStatus())) {
					flag = true;
				}
			}
			if(!flag) {
				return getJsonResult(false,"请选择已收款明细！");
			}
			List<IncomeConfirmInfo> ici = incomeConfirmMng.findByIncomeId(Integer.toString(bean.getFincomeId()),icBean.getFpId() == null?null:Integer.toString(icBean.getFpId()));
			for(int i = 0 ;i < ici.size();i++) {
				if(!"9".equals(ici.get(i).getFlowStatus())) {
					return getJsonResult(false,"该登记单存在进行中的确认计划，请完成后重试！");
				}
			}
			incomeConfirmMng.saveConfirm(bean,icBean,getUser(),mingxiJson,confirmFiles);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping("/choose")
	public String choose(ModelMap model){
		return "/WEB-INF/view/income_manage/register/register_choose";
	}
	
	/*
	 * 分页数据获得
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value = "/choosePage")
	@ResponseBody
	public JsonPagination choosePage(IncomeInfo bean, String sort, String order, Integer page, Integer rows,String fCode,String fProName,String fDeptName,String fType){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = registerMng.choosePageList(bean, page, rows,getUser(),fCode,fProName,fDeptName,fType);
    	List<IncomeInfo> li = (List<IncomeInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置
    		List<ReceiveMoneyDetail> list = registerMng.getMingxiList(Integer.toString(li.get(x).getFincomeId()),null);
    		if(list.size() == 0) {
    			li.remove(x);
    		}else {
    			li.get(x).setNum((x+1)+(page-1)*rows);	
    		}
		}
    	return getJsonPagination(p, page);
	}
	
	
	/*
	 * 查看收入详情信息
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		IncomeConfirmInfo icBean = incomeConfirmMng.findById(Integer.valueOf(id));
		IncomeInfo bean=registerMng.findById(icBean.getFincomeId());
		//查询基本信息
		model.addAttribute("bean", bean);	
		model.addAttribute("icBean", icBean);	
		List<Attachment> businessAttaList = attachmentMng.list(bean);
		model.addAttribute("businessAttaList", businessAttaList);
		List<Attachment> confirmAttaList = attachmentMng.list(icBean);
		model.addAttribute("confirmAttaList", confirmAttaList);

		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(icBean.getfReqUserid(), "FHTSRQR", icBean.getfReqDeptID(), icBean.getBeanCode(), icBean.getfNCode(), icBean.getJoinTable(), icBean.getBeanCodeField(), icBean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("FHTSRQR", icBean.getfReqDeptID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", icBean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(icBean.getfReqUser(), icBean.getfReqDept(), icBean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/register/register_confirm_detail";
	}
	
	
	/*
	 * 查看收入详情信息
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value ="/edit")
	public String v(String id,ModelMap model){
		IncomeConfirmInfo icBean = incomeConfirmMng.findById(Integer.valueOf(id));
		IncomeInfo bean=registerMng.findById(icBean.getFincomeId());
		//查询基本信息
		model.addAttribute("bean", bean);	
		model.addAttribute("icBean", icBean);	
		List<Attachment> businessAttaList = attachmentMng.list(bean);
		model.addAttribute("businessAttaList", businessAttaList);
		List<Attachment> confirmAttaList = attachmentMng.list(icBean);
		model.addAttribute("confirmAttaList", confirmAttaList);

		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(icBean.getfReqUserid(), "FHTSRQR", icBean.getfReqDeptID(), icBean.getBeanCode(), icBean.getfNCode(), icBean.getJoinTable(), icBean.getBeanCodeField(), icBean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("FHTSRQR", icBean.getfReqDeptID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", icBean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(icBean.getfReqUser(), icBean.getfReqDept(), icBean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/register/register_confirm_edit";
	}
	
	
	/**
	 * @Description: 撤回
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 方淳洲
	 * @date 2021-06-11
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			//传回来的id是主键
			incomeConfirmMng.reCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"撤回失败，请联系管理员！");
		}
		return getJsonResult(true,"撤回成功！");	
	}
	
	
	/*
	 * 删除收入信息
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			incomeConfirmMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	
	
	
	
	
	
	
	/*
	 * 跳转到确认列表页面
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value = "/confirmCheckList")
	public String confirmCheckList( ModelMap model) {
		return "/WEB-INF/view/income_manage/register/register_confirmCheckList";
	}
	
	/*
	 * 来款确认分页数据获得
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value = "/confirmCheckPage")
	@ResponseBody
	public JsonPagination confirmCheckPage(IncomeConfirmInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	User user = getUser();
    	Pagination p = incomeConfirmMng.confirmCheckPageList(bean, page, rows,user);
    	List<IncomeConfirmInfo> li = (List<IncomeConfirmInfo>) p.getList();
    	for(int x=0; x<li.size(); x++){
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 查看收入详情信息
	 * @author 方淳洲
	 * @createtime 2021-06-11
	 * @updatetime 2021-06-11
	 */
	@RequestMapping(value ="/check")
	public String check(String id,ModelMap model){
		IncomeConfirmInfo icBean = incomeConfirmMng.findById(Integer.valueOf(id));
		IncomeInfo bean=registerMng.findById(icBean.getFincomeId());
		//查询基本信息
		model.addAttribute("bean", bean);	
		model.addAttribute("icBean", icBean);	
		List<Attachment> businessAttaList = attachmentMng.list(bean);
		model.addAttribute("businessAttaList", businessAttaList);
		List<Attachment> confirmAttaList = attachmentMng.list(icBean);
		model.addAttribute("confirmAttaList", confirmAttaList);

		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(icBean.getfReqUserid(), "FHTSRQR", icBean.getfReqDeptID(), icBean.getBeanCode(), icBean.getfNCode(), icBean.getJoinTable(), icBean.getBeanCodeField(), icBean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("FHTSRQR", icBean.getfReqDeptID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", icBean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(icBean.getfReqUser(), icBean.getfReqDept(), icBean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/register/register_confirm_check";
	}
	
	
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean, IncomeConfirmInfo bean, String spjlFile){
		try {
			incomeConfirmMng.saveCheck(checkBean, bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(true, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
}

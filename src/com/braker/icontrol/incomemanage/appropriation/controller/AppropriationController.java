package com.braker.icontrol.incomemanage.appropriation.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Depart;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.ReceiveMoneyDetailMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsRegister;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.appropriation.manager.AppropriationMng;
import com.braker.icontrol.incomemanage.appropriation.model.AppropriationInfo;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 拨款类收入控制层
 * @author wanping
 *
 */
@Controller
@RequestMapping(value = "/appropriation")
public class AppropriationController extends BaseController {
	
	@Autowired
	private AppropriationMng appropriationMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private ReceiveMoneyDetailMng receiveMoneyDetailMng;

	/**
	 * 跳转到来款登记页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/income_manage/appropriation/appropriation_list";
	}
	
	/**
	 * 拨款类收入列表数据
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value = "/appropriationPage")
	@ResponseBody
	public JsonPagination appropriationPage(AppropriationInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = appropriationMng.pageList(bean, page, rows);
    	List<AppropriationInfo> info = (List<AppropriationInfo>) p.getList();
		for (int i = info.size() - 1; i >= 0; i--) {
			ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
			moneyDetail.setfType("3");
			moneyDetail.setfMSId(info.get(i).getaId());
			ReceiveMoneyDetail receiveMoneyDetail = receiveMoneyDetailMng.findByList(moneyDetail, getUser()).get(0);
			info.get(i).setUnitName(receiveMoneyDetail.getOppositeUnit());
			info.get(i).setAmount(receiveMoneyDetail.getPlanMoney());
			if(!StringUtil.isEmpty(bean.getfDeptName())){
				if(!info.get(i).getUnitName().contains(bean.getfDeptName())){
					info.remove(info.get(i));
				}
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到拨款类收入新增页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		//操作类型
		model.addAttribute("operation", "add");
		
		AppropriationInfo bean = new AppropriationInfo();
		//自动生成登记单号
		String registerCode = "BKSR";
		bean.setRegisterCode(StringUtil.Random(registerCode));
		//自动生成登记人
		bean.setfOperatorId(getUser().getId());
		bean.setfOperatorName(getUser().getName());
		//自动生成 登记部门
		bean.setfDeptId(getUser().getDepart().getId());
		bean.setfDeptName(getUser().getDepart().getName());
		model.addAttribute("bean", bean);
		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("收入登记");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(getUser().getId(), "BKLSRDJ", getUser().getDpID(), null, bean.getfNextCode(), null, null, null, null);
		model.addAttribute("nodeConf", nodeConfList);
		
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		
		return "/WEB-INF/view/income_manage/appropriation/appropriation_add";
	}
	
	/**
	 * 拨款类收入保存
	 * @param appropriationInfo
	 * @param files
	 * @return
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(AppropriationInfo appropriationInfo, String files,String registerJson) {
		try {
			appropriationMng.save(getUser(), appropriationInfo, files,registerJson);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 跳转到拨款类收入修改/查看页面
	 * @param id
	 * @param model
	 * @param editType
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		//获取需要修改的拨款类收入
		AppropriationInfo bean = appropriationMng.findById(id);
		//查询登记人信息
		User user = userMng.findById(bean.getfOperatorId());
		bean.setfOperatorName(user.getName());
		
		//查询附件信息
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		model.addAttribute("bean", bean);
		
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		//历史审批节点
		String historyNodes=tProcessCheckMng.getHistoryNodes("BKLSRDJ", bean.getfDeptId(), bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);

		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());	
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//根据修改还是查看跳转不同页面
		if("0".equals(editType)){
			model.addAttribute("detail", "0");
			model.addAttribute("operation", "detail");
			return "/WEB-INF/view/income_manage/appropriation/appropriation_detail";
		} else {
			model.addAttribute("operation", "edit");
			return "/WEB-INF/view/income_manage/appropriation/appropriation_add";
		}
	}
	
	/**
	 * 跳转到拨款类收入修改/查看页面
	 * @param id
	 * @param model
	 * @param editType
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(Integer id, ModelMap model) {
		//获取需要修改的拨款类收入
		AppropriationInfo bean = appropriationMng.findById(id);
		//查询登记人信息
		User user = userMng.findById(bean.getfOperatorId());
		bean.setfOperatorName(user.getName());
		
		//查询附件信息
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		model.addAttribute("bean", bean);
		
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		//历史审批节点
		String historyNodes=tProcessCheckMng.getHistoryNodes("BKLSRDJ", bean.getfDeptId(), bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);

		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());	
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//根据修改还是查看跳转不同页面
		model.addAttribute("detail", "0");
		model.addAttribute("operation", "detail");
		return "/WEB-INF/view/income_manage/appropriation/appropriation_detail";
	}
	
	/**
	 * 拨款类收入登记撤回
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			appropriationMng.reCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"撤回失败，请联系管理员！");
		}
		return getJsonResult(true,"撤回成功！");	
	}
	
	/**
	 * 拨款类收入登记删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			appropriationMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/**
	 * 跳转到登记审核列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/checkList")
	public String checkList( ModelMap model) {
		return "/WEB-INF/view/income_manage/appropriation/appropriation_check_list";
	}
	
	/**
	 * 登记审核列表数据
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value = "/appropriationCheckPage")
	@ResponseBody
	public JsonPagination appropriationCheckPage(AppropriationInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = appropriationMng.checkPageList(bean, page, rows, getUser());
    	List<AppropriationInfo> info = (List<AppropriationInfo>) p.getList();
		for (int i = info.size() - 1; i >= 0; i--) {
			ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
			moneyDetail.setfType("3");
			moneyDetail.setfMSId(info.get(i).getaId());
			ReceiveMoneyDetail receiveMoneyDetail = receiveMoneyDetailMng.findByList(moneyDetail, getUser()).get(0);
			info.get(i).setUnitName(receiveMoneyDetail.getOppositeUnit());
			info.get(i).setAmount(receiveMoneyDetail.getPlanMoney());
			if(!StringUtil.isEmpty(bean.getfDeptName())){
				if(!info.get(i).getUnitName().contains(bean.getfDeptName())){
					info.remove(info.get(i));
				}
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到登记审核页面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/check")
	public String check(ModelMap model, String id){
		//拨款类收入基本信息
		AppropriationInfo bean = appropriationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//拨款类收入附件
		List<Attachment> appropriationAttaList = attachmentMng.list(bean);
		model.addAttribute("attaList", appropriationAttaList);
		
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/appropriation/appropriation_check";
	}
	
	/**
	 * 登记审核
	 * @param checkBean
	 * @param bean
	 * @param spjlFile
	 * @return
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean, AppropriationInfo bean, String spjlFile){
		try {
			appropriationMng.saveCheck(checkBean, bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(true, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 跳转到来款确认列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/confirmList")
	public String confirmList( ModelMap model) {
		return "/WEB-INF/view/income_manage/appropriation/appropriation_confirm_list";
	}
	
	/**
	 * 来款确认数据
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value = "/appropriationConfirmPage")
	@ResponseBody
	public JsonPagination appropriationConfirmPage(AppropriationInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = appropriationMng.confirmPageList(bean, page, rows);
    	List<AppropriationInfo> info = (List<AppropriationInfo>) p.getList();
		for (int i = info.size() - 1; i >= 0; i--) {
			ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
			moneyDetail.setfType("3");
			moneyDetail.setfMSId(info.get(i).getaId());
			ReceiveMoneyDetail receiveMoneyDetail = receiveMoneyDetailMng.findByList(moneyDetail, getUser()).get(0);
			info.get(i).setUnitName(receiveMoneyDetail.getOppositeUnit());
			info.get(i).setAmount(receiveMoneyDetail.getPlanMoney());
			if(!StringUtil.isEmpty(bean.getfDeptName())){
				if(!info.get(i).getUnitName().contains(bean.getfDeptName())){
					info.remove(info.get(i));
				}
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到来款确认页面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/confirm")
	public String confirm(ModelMap model, String id){
		//拨款类收入基本信息
		AppropriationInfo bean = appropriationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//拨款类收入附件
		List<Attachment> appropriationAttaList = attachmentMng.list(bean);
		model.addAttribute("attaList", appropriationAttaList);
		
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/appropriation/appropriation_confirm";
	}
	
	/**
	 * 拨款类收入登记删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/confirmAppropriation")
	@ResponseBody
	public Result confirmAppropriation(AppropriationInfo bean) {
		try {
			appropriationMng.confirmAppropriation(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"确认失败，请联系管理员！");
		}
		return getJsonResult(true,"确认成功！");	
	}
}

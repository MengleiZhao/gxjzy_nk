package com.braker.icontrol.incomemanage.accountsCurrent.controller;

import java.util.ArrayList;
import java.util.Date;
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
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsRegisterMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.ReceiveMoneyDetailMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsRegister;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 往来款登记控制层
 * @author 赵孟雷
 *
 */
@Controller
@RequestMapping(value = "/registerAffirm")
public class RegisterAffirmController extends BaseController{

	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private AccountsRegisterMng accountsRegisterMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private ReceiveMoneyDetailMng receiveMoneyDetailMng;
	
	
	/**
	 * 跳转到list来款确认页面
	 * @author 赵孟雷
	 * @createTime 2020年11月10日
	 * @updateTime 2020年11月10日
	 */
	@RequestMapping("/listAffirm")
	public String listAffirm(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsAffirmList";
	}
	
	/*
	 * 来款确认 分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-11-13
	 * @updatetime 2020-11-13
	 */
	@RequestMapping(value = "/registerAffirmPage")
	@ResponseBody
	public JsonPagination registerAffirmPage(Integer applyType ,AccountsRegister bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = accountsRegisterMng.registerAffirmPage(bean, page, rows, applyType, getUser());
		List<AccountsRegister> accountsRegisters = (List<AccountsRegister>) p.getList();
		for (int i = accountsRegisters.size() - 1; i >= 0; i--){
			ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
			moneyDetail.setfType("2");
			moneyDetail.setfMSId(accountsRegisters.get(i).getfMSId());
			ReceiveMoneyDetail receiveMoneyDetail = receiveMoneyDetailMng.findByList(moneyDetail, getUser()).get(0);
			accountsRegisters.get(i).setOppositeUnit(receiveMoneyDetail.getOppositeUnit());
			accountsRegisters.get(i).setPlanMoney(receiveMoneyDetail.getPlanMoney());
		}
		return getJsonPagination(p, page);
	}
	/*
	 * 跳转修改页面
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/edit")
	public String edit(String id ,ModelMap model) {
		try {
			AccountsRegister bean = accountsRegisterMng.findById(Integer.valueOf(id));
			//获取默认值
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "detail");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKDJ", bean.getDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getRegisterCode(),"1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", bean.getDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getUserName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);	
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/add/register_affirm_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/register_affirm_add";
		}
	}
	/*
	 * 跳转修改页面
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/detail")
	public String detail(String id ,ModelMap model) {
		try {
			AccountsRegister bean = accountsRegisterMng.findById(Integer.valueOf(id));
			//获取默认值
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "detail");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKDJ", bean.getDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getRegisterCode(),"1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", bean.getDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getUserName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);	
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/register_affirm_detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/register_affirm_detail";
		}
	}
	
	/**
	 * 新增来往款登记
	 * @param bean
	 * @param files
	 * @param registerJson
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/saveRegisterAffirm")
	@ResponseBody
	public Result saveRegisterAffirm(AccountsRegister bean,ModelMap model){
		try {
			accountsRegisterMng.saveRegisterAffirm(bean,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 查询往来款登记中的来款明细
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	@RequestMapping(value = "/registerMX")
	@ResponseBody
	public List<Object> receptionOther(Integer id) {
		List<Object> list = new ArrayList<Object>();
		if(id != null) {
			//查询接待明细
			list = applyMng.getObjectList("ReceiveMoneyDetail", "fMSId", id);
		}
		return list;
	}
	
}
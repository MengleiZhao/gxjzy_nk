package com.braker.icontrol.incomemanage.accountsCurrent.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.CheckEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsRegisterMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.ReceiveMoneyDetailMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
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
@RequestMapping(value = "/accountsRegister")
public class AccountsRegisterController extends BaseController{

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
	private UserMng userMng;
	
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private ReceiveMoneyDetailMng receiveMoneyDetailMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	/**
	 * 跳转到list申请页面
	 * @author 赵孟雷
	 * @createTime 2020年11月10日
	 * @updateTime 2020年11月10日
	 */
	@RequestMapping("/registerList")
	public String registerList(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsRegisterList";
	}
	
	/*
	 * 分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-11-10
	 * @updatetime 2020-11-10
	 */
	@RequestMapping(value = "/registerPage")
	@ResponseBody
	public JsonPagination registerPage(Integer applyType ,AccountsRegister bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = accountsRegisterMng.pageList(bean, page, rows, applyType, getUser());
		List<AccountsRegister> accountsRegisters = (List<AccountsRegister>) p.getList();
		for (int i = accountsRegisters.size() - 1; i >= 0; i--) {
			ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
			moneyDetail.setfType("2");
			moneyDetail.setfMSId(accountsRegisters.get(i).getfMSId());
			ReceiveMoneyDetail receiveMoneyDetail = receiveMoneyDetailMng.findByList(moneyDetail, getUser()).get(0);
			accountsRegisters.get(i).setOppositeUnit(receiveMoneyDetail.getOppositeUnit());
			accountsRegisters.get(i).setPlanMoney(receiveMoneyDetail.getPlanMoney());
		}
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * 跳转到合同list页面
	 * @author 赵孟雷
	 * @createTime 2020年11月12日
	 * @updateTime 2020年11月12日
	 */
	@RequestMapping("/registerConList")
	public String registerConList(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsRegisterList_con";
	}
	
	/*
	 * 分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	@RequestMapping(value = "/contraPage")
	@ResponseBody
	public JsonPagination contraPage(ContractBasicInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = formulationMng.queryContraList(bean, getUser(), page, rows);
		return getJsonPagination(p, page);
	}	
	
	/*
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12           
	 */
	@RequestMapping("/add")
	public String add(Integer type ,ModelMap model) {
		try {
			AccountsRegister bean = new AccountsRegister();
			//获取默认值
			User user = getUser();
			String code = StringUtil.Random("LKDJ");
			bean.setRegisterCode(code);
			bean.setUserId(user.getId());//用户名ID
			bean.setUserName(user.getName());//用户名
			bean.setDeptId(user.getDepart().getId());//ID
			bean.setDeptName(user.getDepart().getName());//部门
			bean.setReqTime(new Date());
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "add");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"WLKDJ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);	
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("WLKDJ",getUser().getDpID(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		}
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
			User user = getUser();
			bean.setUserId(user.getId());//用户名ID
			bean.setUserName(user.getName());//用户名
			bean.setDeptId(user.getDepart().getId());//ID
			bean.setDeptName(user.getDepart().getName());//部门
			bean.setReqTime(new Date());
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "edit");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"WLKDJ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);	
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("WLKDJ",getUser().getDpID(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
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
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_register_detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_register_detail";
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
	@RequestMapping(value = "/saveRegister")
	@ResponseBody
	public Result saveRegister(AccountsRegister bean,String files,String registerJson,ModelMap model) {
		try {
			accountsRegisterMng.save(bean, files,getUser(),registerJson);
		} catch (ServiceException es) {
			es.printStackTrace();
			return getJsonResult(false,es.getMessage());
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
	public List<ReceiveMoneyDetail> receptionOther(Integer id,String type) {
		List<ReceiveMoneyDetail> list = new ArrayList<ReceiveMoneyDetail>();
		ReceiveMoneyDetail bean = new ReceiveMoneyDetail();
		if(id != null) {
			bean.setfType(type);
			bean.setfMSId(id);
			//查询接待明细
			list = receiveMoneyDetailMng.findByList(bean, getUser());
		}
		return list;
	}
	
	/**
	 * @Description: 收入管理中往来款登记撤回
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	@RequestMapping(value = "/registerReCall")
	@ResponseBody
	public Result registerReCall(Integer id) {
		try {
			accountsRegisterMng.registerAffirmReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"撤回失败，请联系管理员！");
		}
		return getJsonResult(true,"撤回成功！");	
	}
	
	/*
	 * 收入管理中的往来款登记删除
	 * @author 赵孟雷
	 * @createtime 2020-11-13
	 * @updatetime 2018-11-13
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//传回来的id是主键
			User user = getUser();
			accountsRegisterMng.delete(id,user,fId);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
}
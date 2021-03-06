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
 * ????????????????????????
 * @author ?????????
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
	 * ?????????list????????????
	 * @author ?????????
	 * @createTime 2020???11???10???
	 * @updateTime 2020???11???10???
	 */
	@RequestMapping("/registerList")
	public String registerList(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsRegisterList";
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
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
	 * ???????????????list??????
	 * @author ?????????
	 * @createTime 2020???11???12???
	 * @updateTime 2020???11???12???
	 */
	@RequestMapping("/registerConList")
	public String registerConList(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsRegisterList_con";
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
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
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12           
	 */
	@RequestMapping("/add")
	public String add(Integer type ,ModelMap model) {
		try {
			AccountsRegister bean = new AccountsRegister();
			//???????????????
			User user = getUser();
			String code = StringUtil.Random("LKDJ");
			bean.setRegisterCode(code);
			bean.setUserId(user.getId());//?????????ID
			bean.setUserName(user.getName());//?????????
			bean.setDeptId(user.getDepart().getId());//ID
			bean.setDeptName(user.getDepart().getName());//??????
			bean.setReqTime(new Date());
			model.addAttribute("bean", bean);
			//????????????
			model.addAttribute("operation", "add");
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"WLKDJ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????????????????????????????
			model.addAttribute("nodeConf", nodeConfList);
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);	
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes("WLKDJ",getUser().getDpID(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			//????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		}
	}
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/edit")
	public String edit(String id ,ModelMap model) {
		try {
			AccountsRegister bean = accountsRegisterMng.findById(Integer.valueOf(id));
			//???????????????
			User user = getUser();
			bean.setUserId(user.getId());//?????????ID
			bean.setUserName(user.getName());//?????????
			bean.setDeptId(user.getDepart().getId());//ID
			bean.setDeptName(user.getDepart().getName());//??????
			bean.setReqTime(new Date());
			model.addAttribute("bean", bean);
			//????????????
			model.addAttribute("operation", "edit");
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"WLKDJ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????????????????????????????
			model.addAttribute("nodeConf", nodeConfList);
			
			//??????????????????
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);	
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes("WLKDJ",getUser().getDpID(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			//????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
			//????????????
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_register_add";
		}
	}
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/detail")
	public String detail(String id ,ModelMap model) {
		try {
			AccountsRegister bean = accountsRegisterMng.findById(Integer.valueOf(id));
			//???????????????
			model.addAttribute("bean", bean);
			//????????????
			model.addAttribute("operation", "detail");
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKDJ", bean.getDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getRegisterCode(),"1");
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", bean.getDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????????????????????????????
			model.addAttribute("nodeConf", nodeConfList);
			//??????????????????
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			//?????????????????????????????????
			Proposer proposer = new Proposer(bean.getUserName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);	
			//????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
			//????????????
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_register_detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_register_detail";
		}
	}
	
	/**
	 * ?????????????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
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
			//??????????????????
			list = receiveMoneyDetailMng.findByList(bean, getUser());
		}
		return list;
	}
	
	/**
	 * @Description: ????????????????????????????????????
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author ?????????
	 * @date 2019???10???8???
	 */
	@RequestMapping(value = "/registerReCall")
	@ResponseBody
	public Result registerReCall(Integer id) {
		try {
			accountsRegisterMng.registerAffirmReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-11-13
	 * @updatetime 2018-11-13
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//????????????id?????????
			User user = getUser();
			accountsRegisterMng.delete(id,user,fId);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
}
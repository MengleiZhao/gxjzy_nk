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
 * ????????????????????????
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
	 * ???????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/income_manage/appropriation/appropriation_list";
	}
	
	/**
	 * ???????????????????????????
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
	 * ????????????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		//????????????
		model.addAttribute("operation", "add");
		
		AppropriationInfo bean = new AppropriationInfo();
		//????????????????????????
		String registerCode = "BKSR";
		bean.setRegisterCode(StringUtil.Random(registerCode));
		//?????????????????????
		bean.setfOperatorId(getUser().getId());
		bean.setfOperatorName(getUser().getName());
		//???????????? ????????????
		bean.setfDeptId(getUser().getDepart().getId());
		bean.setfDeptName(getUser().getDepart().getName());
		model.addAttribute("bean", bean);
		
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(getUser().getId(), "BKLSRDJ", getUser().getDpID(), null, bean.getfNextCode(), null, null, null, null);
		model.addAttribute("nodeConf", nodeConfList);
		
		//?????????????????????????????????
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		
		return "/WEB-INF/view/income_manage/appropriation/appropriation_add";
	}
	
	/**
	 * ?????????????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/**
	 * ??????????????????????????????/????????????
	 * @param id
	 * @param model
	 * @param editType
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		//????????????????????????????????????
		AppropriationInfo bean = appropriationMng.findById(id);
		//?????????????????????
		User user = userMng.findById(bean.getfOperatorId());
		bean.setfOperatorName(user.getName());
		
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		model.addAttribute("bean", bean);
		
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		
		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		//??????????????????
		String historyNodes=tProcessCheckMng.getHistoryNodes("BKLSRDJ", bean.getfDeptId(), bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);

		//????????????
		model.addAttribute("foCode",bean.getBeanCode());	
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//??????????????????????????????????????????
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
	 * ??????????????????????????????/????????????
	 * @param id
	 * @param model
	 * @param editType
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(Integer id, ModelMap model) {
		//????????????????????????????????????
		AppropriationInfo bean = appropriationMng.findById(id);
		//?????????????????????
		User user = userMng.findById(bean.getfOperatorId());
		bean.setfOperatorName(user.getName());
		
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		model.addAttribute("bean", bean);
		
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		
		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		//??????????????????
		String historyNodes=tProcessCheckMng.getHistoryNodes("BKLSRDJ", bean.getfDeptId(), bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);

		//????????????
		model.addAttribute("foCode",bean.getBeanCode());	
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//??????????????????????????????????????????
		model.addAttribute("detail", "0");
		model.addAttribute("operation", "detail");
		return "/WEB-INF/view/income_manage/appropriation/appropriation_detail";
	}
	
	/**
	 * ???????????????????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ???????????????????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ?????????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/checkList")
	public String checkList( ModelMap model) {
		return "/WEB-INF/view/income_manage/appropriation/appropriation_check_list";
	}
	
	/**
	 * ????????????????????????
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
	 * ???????????????????????????
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/check")
	public String check(ModelMap model, String id){
		//???????????????????????????
		AppropriationInfo bean = appropriationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//?????????????????????
		List<Attachment> appropriationAttaList = attachmentMng.list(bean);
		model.addAttribute("attaList", appropriationAttaList);
		
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode", bean.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/appropriation/appropriation_check";
	}
	
	/**
	 * ????????????
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
			return getJsonResult(true, "????????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * ?????????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/confirmList")
	public String confirmList( ModelMap model) {
		return "/WEB-INF/view/income_manage/appropriation/appropriation_confirm_list";
	}
	
	/**
	 * ??????????????????
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
	 * ???????????????????????????
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/confirm")
	public String confirm(ModelMap model, String id){
		//???????????????????????????
		AppropriationInfo bean = appropriationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//?????????????????????
		List<Attachment> appropriationAttaList = attachmentMng.list(bean);
		model.addAttribute("attaList", appropriationAttaList);
		
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "BKLSRDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode", bean.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfApplyDate());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/income_manage/appropriation/appropriation_confirm";
	}
	
	/**
	 * ???????????????????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
}

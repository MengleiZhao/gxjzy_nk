package com.braker.icontrol.cgmanage.cgreveive.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

/**
 * 采购验收台账的控制层
 * 本模块用于支出申请台账的审批及查看
 * @author 冉德茂
 * @createtime 2018-07-20
 * @updatetime 2018-07-20
 */
@Controller
@RequestMapping(value = "/cgreceiveLedger")
public class CgReceiveLedgerController  extends BaseController{

	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private CgReceiveMng cgreceiveMng;
	
	/**
	 * 验收时查看合同跳转界面
	 * @createtime 2019-05-28
	 * @author 焦广兴
	 * @return
	 */
	@RequestMapping("/receiveContractJSP")
	public String list(ModelMap model,String fpId){
		if(!StringUtil.isEmpty(fpId)){
			//PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(fpId));
			model.addAttribute("fPurchNo", fpId);	//采购ID 
		}
		return "/WEB-INF/view/purchase_manage/receive/receive_contract_list";
	}
	
	
		
	/*
	 * 跳转到列表页面
	 * @author  冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/receive/cgreceiveledger_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value = "/cgledgerPage")
	@ResponseBody
	public JsonPagination noticePage(PurchaseApplyBasic bean,String timea,String timeb, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = cgsqMng.receiveledgerPageList(bean,timea,timeb, page, rows, getUser());
		List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	
	
	/*
	 * 历史验收记录
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value = "/history")
	@ResponseBody
	public JsonPagination checkHistory(String id) {
		Pagination p = new Pagination();
		if(id != null) {
			p.setList(cgreceiveMng.checkHistory(Integer.valueOf(id)));
		}
		return getJsonPagination(p, 0);
	}
}

package com.braker.icontrol.purchase.apply.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.CgCheckMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/PurchaseApply")
public class PurchaseApplyController extends BaseController{

	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private CgCheckMng cgcheckMng;
	@Autowired
	private CgProcessMng processMng;
	
	/**
	 * 弹出页面（合同拟定使用）
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-10
	 */
	@RequestMapping("/PurchNoList")
	public String purchNoList(ModelMap model){
		return "/WEB-INF/view/contract/formulation/formulation_add_PurchNo";
	}
	
	/**
	 * 加载合同拟定里选择采购订单号的页面数据
	 * @param purchaseApplyBasic
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-10
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(PurchaseApplyBasic purchaseApplyBasic, String sign, Integer page, Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p = purchaseApplyMng.queryList(purchaseApplyBasic, page, rows, sign);
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 采购申请 查看详情
	 * @param id 采购单主键id
	 * @param model
	 * @return
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//bean.setFpAmount(Double.valueOf(new BigDecimal(bean.getFpAmount()).stripTrailingZeros().toPlainString()));
		//查询基本信息
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/formulation/formulation_cggl_detail";
	}
}

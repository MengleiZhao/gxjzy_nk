package com.braker.core.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Result;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.assets.handle.manager.HandleMng;
import com.braker.icontrol.assets.handle.model.Handle;
import com.braker.icontrol.assets.rece.manager.ReceMng;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;
import com.braker.icontrol.budget.adjust.manager.InsideAdjustMny;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProCheckInfoMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.CgCheckMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.contract.Formulation.manager.ApprovalMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.expend.apply.manager.ApplyCheckMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.loan.manager.LoanCheckMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;


/**
 * APP审批
 * 作用：接受APP后台发送的审批请求
 * 实现方式：请求转发
 * 返回请求端值的类型：由转发后方法定义
 * @author 张迅
 * @createtime 2020-04-13
 */

@Controller
@RequestMapping(value = "/appCheck")
public class AppCheckController extends BaseController{
	
	@Autowired
	private UserMng userMng;
	@Autowired
	private ApprovalMng approvalMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private ApplyMng applyMng;
	@Autowired
	private ApplyCheckMng applyCheckMng;
	@Autowired
	private CgCheckMng cgcheckMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private CgProcessMng cgProcessMng;
	@Autowired
	private CgReceiveMng cgReceiveMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProCheckInfoMng tProCheckInfoMng;
	@Autowired
	private InsideAdjustMny insideAdjustMny;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	@Autowired
	private ReceMng receMng;
	@Autowired
	private HandleMng handleMng;
	@Autowired
	private LoanCheckMng loanCheckMng;
	@Autowired
	private PaymentMng paymentMng;
	//项目审批
/*	@RequestMapping("/xmsp")
	public String xmsp(){
		return "forward:/project/saveVerdictApp";
//		return "forward:/project/checkResultApp";
	}*/
	@RequestMapping("/check_xmsb")
	@ResponseBody
	public Result check_xmsb(TProBasicInfo newBean, TProcessCheck checkBean, String fileId,
			String acco, String pwd,String fundJson,String outcomeJson) {
		try {
			User user = userMng.login(acco, pwd);
			//修改前的bean数据
			TProBasicInfo oldBean = projectMng.findById(newBean.getFProId());
//			//比较后返回用于审批的bean
//			TProBasicInfo resultBean = projectMng.compareFields(oldBean, newBean, null, null, null, totalityPerformanceJson, user);
			projectMng.saveCheck(oldBean,checkBean,fileId,user,fundJson,outcomeJson);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}

	//二上项目审批
	/*@RequestMapping("/essp")
	public String essp(){
		return "forward:/declare/esspApp";
	}*/
	
	@RequestMapping("/check_essb")
	@ResponseBody
	public Result check_essb(String fproIdLi,String result, String remake,String spjlFiles, ModelMap model,String fundJson,String outcomeJson,String hyjyFile,
			String acco, String pwd){
		try {
			User user = userMng.login(acco, pwd);
		//	tProCheckInfoMng.secondUpCheck(fproIdLi, result, remake, user, user.getRoles().get(0),spjlFiles, fundJson, outcomeJson,hyjyFile);
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
	}
	//预算编制
	@RequestMapping("/ysbz")
	public String ysbz(){
		return "forward:/declare/esspApp";
	}
	
/*	//指标调整
	@RequestMapping("/zbtz")
	public String zbtz(String acco, String pwd, String interfaceCode){
		
		return "forward:/insideCheck/checkResultApp";
	}*/
	
	@RequestMapping(value = "/check_zbtz")
	@ResponseBody
	public Result check_zbtz(TProcessCheck checkBean,TIndexInnerAd bean, String fileId,
			String acco, String pwd) {
		try {
			User user = userMng.login(acco, pwd);
			insideAdjustMny.saveCheckInfo(checkBean, bean, user, fileId);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	//采购计划
	@RequestMapping(value = "/check_cgjh")
	@ResponseBody
	public Result check_cgjh(String acco, String pwd,TProcessCheck checkBean,PurchaseApplyBasic bean, String fileId,String hyzgbmyjfiles,String czbmyjfiles) {
		try {

			User user = userMng.login(acco, pwd);
			PurchaseApplyBasic oldBean = cgsqMng.findById(bean.getFpId());
			if(!StringUtil.isEmpty(bean.getFpPype())){
				oldBean.setFpPype(bean.getFpPype());
			}
			if(!StringUtil.isEmpty(bean.getFpMethod())){
				oldBean.setFpMethod(bean.getFpMethod());
			}
			cgcheckMng.saveCheckInfo(checkBean, oldBean, user, fileId);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}

	@RequestMapping(value = "/check_cgys")
	@ResponseBody
	public Result check_cgys(String acco, String pwd,TProcessCheck checkBean, AcceptCheck bean, String fileId,String zjyjfiles) {
		try {
			User user = userMng.login(acco, pwd);
			cgReceiveMng.saveCheck(checkBean, bean,null, fileId, user,zjyjfiles);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}

}

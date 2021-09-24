package com.braker.icontrol.incomemanage.export.controller;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.braker.common.util.MoneyUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsRegisterMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.ReceiveMoneyDetailMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsRegister;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.businessService.manager.BusinessServiceMng;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.icontrol.incomemanage.register.manager.RegisterMng;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 收入打印单控制层
 * @author 赵孟雷
 *
 */
@Controller
@RequestMapping(value = "/incomeExport")
public class IncomeExportController extends BaseController{

	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private BusinessServiceMng businessServiceMng;
	
	@Autowired
	private AccountsRegisterMng accountsRegisterMng;
	
	@Autowired
	private RegisterMng registerMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private ReceiveMoneyDetailMng receiveMoneyDetailMng;
	
	@Autowired
	private UserMng userMng;
	
	/*
	 * 跳转往来款立项打印页面
	 * @author 赵孟雷
	 * @createtime 2020-12-03
	 * @updatetime 2020-12-03        
	 */
	@RequestMapping("/accounts")
	public String accounts(String id ,ModelMap model) {
		try {
			AccountsCurrent bean = accountsCurrentMng.findById(Integer.valueOf(id));
			//获取默认值
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "detail");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKLXSQ", bean.getDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getProCode(),"1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKLXSQ", bean.getDeptId());
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
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			for (TProcessCheck tProcessCheck : checkList) {
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDeptId())){
					model.addAttribute("role1", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("32")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}


				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
					model.addAttribute("role3", tProcessCheck.getFuserName());
				}
			}
			return "/WEB-INF/view/income_manage/export/accounts";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/export/accounts";
		}
	}
	
	
	/*
	 * 跳转往来款登记打印页面
	 * @author 赵孟雷
	 * @createtime 2020-12-03
	 * @updatetime 2020-12-03        
	 */
	@RequestMapping("/accountsRegister")
	public String accountsRegister(String id ,ModelMap model) {
		try {
			AccountsRegister bean = accountsRegisterMng.findById(Integer.valueOf(id));
			String registerMoneyCapital = MoneyUtil.toChinese(String.valueOf(bean.getRegisterMoney()));
			bean.setRegisterMoneyCapital(registerMoneyCapital);
			//获取默认值
			model.addAttribute("bean", bean);
			
			List<ReceiveMoneyDetail> list = new ArrayList<ReceiveMoneyDetail>();
			ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
			if(id != null) {
				moneyDetail.setfType("2");
				moneyDetail.setfMSId(bean.getfMSId());
				//查询接待明细
				list = receiveMoneyDetailMng.findByList(moneyDetail, getUser());
			}
			model.addAttribute("list", list);
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", bean.getDeptId());
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			for (TProcessCheck tProcessCheck : checkList) {
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDeptId())){
					model.addAttribute("role1", tProcessCheck.getFuserName());
				}



				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}
			}
			/*//操作类型
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
			model.addAttribute("foCode",bean.getBeanCode());*/
			return "/WEB-INF/view/income_manage/export/accountsRegister";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/export/accountsRegister";
		}
	}
	
	/*
	 * 跳转培训立项打印页面
	 * @author 赵孟雷
	 * @createtime 2020-12-03
	 * @updatetime 2020-12-03        
	 */
	@RequestMapping("/business")
	public String business(String id ,ModelMap model) {
		try {
			//经营性服务项目基本信息
			BusinessServiceInfo bean = businessServiceMng.findById(Integer.valueOf(id));
			model.addAttribute("bean", bean);
			//经营性服务项目附件
			List<Attachment> businessAttaList = attachmentMng.list(bean);
			model.addAttribute("businessAttaList", businessAttaList);
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfOperatorId(), "PXSRLXSQ", bean.getfDeptId(), bean.getBeanCode(), bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("PXSRLXSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode", bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfOperatorName(), bean.getfDeptName(), bean.getfBusiTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/income_manage/export/business";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/export/business";
		}
	}

	/*
	 * 查看培训收入登记详情信息
	 * @author 赵孟雷
	 * @createtime 2020-12-03
	 * @updatetime 2020-12-03
	 */
	@RequestMapping(value ="/businessRegister")
	public String businessRegister(String id,ModelMap model){
		IncomeInfo bean=registerMng.findById(Integer.valueOf(id));
		String fregisterAmountCapital = MoneyUtil.toChinese(String.valueOf(bean.getFregisterAmount()));
		bean.setFregisterAmountCapital(fregisterAmountCapital);
		//查询基本信息
		model.addAttribute("bean", bean);

		List<ReceiveMoneyDetail> list = new ArrayList<ReceiveMoneyDetail>();
		ReceiveMoneyDetail moneyDetail = new ReceiveMoneyDetail();
		if(id != null) {
			moneyDetail.setfType("1");
			moneyDetail.setfMSId(bean.getFincomeId());
			//查询接待明细
			list = receiveMoneyDetailMng.findByList(moneyDetail, getUser());
		}
		model.addAttribute("list", list);
		/*List<Attachment> businessAttaList = attachmentMng.list(bean);
		model.addAttribute("businessAttaList", businessAttaList);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("收入登记");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfReqUserid(), "PXSRLKDJ", bean.getFregisterDepartId(), bean.getBeanCode(), bean.getfNCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("PXSRLKDJ", bean.getFregisterDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getFregisterDepart(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);*/
		return "/WEB-INF/view/income_manage/export/businessRegister";
	}
	
}
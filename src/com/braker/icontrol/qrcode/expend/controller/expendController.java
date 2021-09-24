/**
 * <p>Title: expendController.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年11月16日
 */
package com.braker.icontrol.qrcode.expend.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * <p>Title: expendController</p>  
 * <p>Description: 扫描二维码跳转手机访问页面控制层</p>  
 * @author 陈睿超
 * @date 2020年11月16日  
 */
@Controller
@SuppressWarnings("serial")
public class expendController extends BaseController{

	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private ApplyMng applyMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	@Autowired
	private LoanMng loanMng;
	@Autowired
	private PaymentMng paymentMng;
	
	@RequestMapping(value="/expendPrintDetail", method = RequestMethod.GET)
	public String printDetail(String id, String type, ModelMap model){
		try {
			String foCode = new String();
			Integer fpId = 0;

			if("apply".equals(type)){//事前申请
				ApplicationBasicInfo bean = applyMng.findById(Integer.valueOf(id));
				
				ReceptionAppliInfo receptionBean =new ReceptionAppliInfo();
				//转换type选择流程
				String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
				if("GWCX".equals(bean.getTravelType())){
					strType = "GWCXSQ";
				}
				if(type.equals("5")&&receptionBean!=null){
					if("2".equals(receptionBean.getReceptionLevel1())){
						if(receptionBean.getIsForeign().equals("1")){
							strType = "GWJDSQ-WB";
						}else{
							strType = "GWJDSQ-YJYX";
						}
					}
				}

				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
				fpId = tProcessDefin.getFPId();
				//对象编码
				foCode = bean.getBeanCode();
				//审批记录
				List<TProcessCheck> checkHistoryList = tProcessCheckMng.checkHistory(fpId,foCode);
				Collections.reverse(checkHistoryList);
				
				model.addAttribute("checkHistoryList", checkHistoryList);//审批记录
				model.addAttribute("bean", bean);
				model.addAttribute("name", bean.getgName());
				model.addAttribute("reason", tProcessCheckMng.JudgmentProcessName(Integer.valueOf(bean.getType())));
				model.addAttribute("code", bean.getgCode());
				model.addAttribute("amount", bean.getAmount());
				model.addAttribute("userName", bean.getUserNames());
				model.addAttribute("deptName", bean.getDeptName());
				
			}else if("reimburse".equals(type)){//事后报销
				
				ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
				model.addAttribute("bean", bean);
				
				//转换type选择流程
				String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(bean.getType()));
				if("GWCX".equals(bean.getTravelType())){
					strType = "GWCXBX";
				}
				if(bean.getType().equals("5")){
					ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
					if(receptionBeans.getReceptionLevel1().equals("2")){
						if(receptionBeans.getIsForeign().equals("1")){
							strType = "GWJDBX-WB";
						}else{
							strType = "GWJDBX-YJYX";
						}
					}
				}
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
				fpId = tProcessDefin.getFPId();
				//对象编号
				foCode = bean.getBeanCode();
				//审批记录
				List<TProcessCheck> checkHistoryList = tProcessCheckMng.checkHistory(fpId,foCode);
				Collections.reverse(checkHistoryList);
				
				
				model.addAttribute("checkHistoryList", checkHistoryList);//审批记录
				model.addAttribute("bean", bean);
				model.addAttribute("name", bean.getgName());
				model.addAttribute("reason", tProcessCheckMng.JudgmentProcessOffName(bean.getType()));
				model.addAttribute("code", bean.getgCode());
				model.addAttribute("amount", bean.getAmount());
				model.addAttribute("userName", userMng.findById(bean.getUser()).getName());
				model.addAttribute("deptName", bean.getDeptName());
				
			}else if("directly".equals(type)){//直接报销
				
				DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(Integer.valueOf(id));
				User user = userMng.findById(bean.getUser());
				bean.setUserName(user.getName());
				bean.setDeptName(user.getDepartName());
				
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", bean.getDept());
				fpId = tProcessDefin.getFPId();
				//对象编号
				foCode = bean.getBeanCode();	
				//审批记录
				List<TProcessCheck> checkHistoryList = tProcessCheckMng.checkHistory(fpId,foCode);
				Collections.reverse(checkHistoryList);
				
				model.addAttribute("checkHistoryList", checkHistoryList);//审批记录
				model.addAttribute("bean", bean);
				model.addAttribute("name", bean.getSummary());
				model.addAttribute("reason", "直接报销");
				model.addAttribute("code", bean.getDrCode());
				model.addAttribute("amount", bean.getAmount());
				model.addAttribute("userName", userMng.findById(bean.getUser()).getName());
				model.addAttribute("deptName", bean.getDeptName());
			}else if("loan".equals(type)){//借款
				
				LoanBasicInfo bean = loanMng.findById(Integer.valueOf(id));
				User user = userMng.findById(bean.getUser());
				bean.setUserName(user.getName());
				bean.setDeptName(user.getDepartName());
				
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JKSQ", bean.getDept());
				fpId = tProcessDefin.getFPId();
				//对象编号
				foCode = bean.getBeanCode();	
				//审批记录
				List<TProcessCheck> checkHistoryList = tProcessCheckMng.checkHistory(fpId,foCode);
				Collections.reverse(checkHistoryList);
				
				model.addAttribute("checkHistoryList", checkHistoryList);//审批记录
				model.addAttribute("bean", bean);
				model.addAttribute("name", bean.getLoanPurpose());
				model.addAttribute("reason", "借款");
				model.addAttribute("code", bean.getlCode());
				model.addAttribute("amount", bean.getlAmount());
				model.addAttribute("userName", userMng.findById(bean.getUser()).getName());
				model.addAttribute("deptName", bean.getDeptName());
			}else if("payment".equals(type)){//还款
				Payment bean =  paymentMng.findByLId(Integer.valueOf(id));
				LoanBasicInfo loan = loanMng.findById(Integer.valueOf(id));
				User user = userMng.findById(loan.getUserId());
				loan.setDeptName(user.getDepartName());
				
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HKDJ", loan.getDept());
				fpId = tProcessDefin.getFPId();
				//对象编号
				foCode = bean.getBeanCode();	
				//审批记录
				List<TProcessCheck> checkHistoryList = tProcessCheckMng.checkHistory(fpId,foCode);
				Collections.reverse(checkHistoryList);
				
				model.addAttribute("checkHistoryList", checkHistoryList);//审批记录
				model.addAttribute("bean", bean);
				model.addAttribute("name", loan.getLoanPurpose());
				model.addAttribute("reason", "还款");
				model.addAttribute("code", bean.getCode());
				model.addAttribute("amount", bean.getPayAmount());
				model.addAttribute("userName", bean.getPayPerson());
				model.addAttribute("deptName", loan.getDeptName());
			}	
			return "/WEB-INF/view/expend/export/qrcode/qrcodeApply";
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}
	
	
}

package com.braker.icontrol.expend.loan.controller;

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
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.loan.manager.LoanCheckMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.LoanPayeeMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 借款审批控制层 
 */
@Controller
@RequestMapping(value = "/loanCheck")
public class LoanCheckController extends BaseController {
	@Autowired
	private LoanCheckMng loanCheckMng;
	
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng itfMng;

	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private LoanPayeeMng loanPayeeMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/loan/loan_check_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	@RequestMapping(value = "/loanPage")
	@ResponseBody
	public JsonPagination loanPage(LoanBasicInfo bean,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = loanMng.checkPageList(bean, page, rows, getUser());;
    	List<LoanBasicInfo> li = (List<LoanBasicInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);
			//设置申请人姓名（id查姓名）,申请人所属部门
			User user = userMng.findById(li.get(x).getUser());
			li.get(x).setUserName(user.getName());
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 跳转审批页面
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/check")
	public String check(Integer id ,ModelMap model, String cashier) {
		//传回来的id是主键
		LoanBasicInfo bean = loanMng.findById(id);
		//查询申请人信息
		User user = userMng.findById(bean.getUser());
		bean.setUserName(user.getName());
		model.addAttribute("bean", bean);
		
		//查询个人收款信息
		LoanPayeeInfo payeeBean = loanPayeeMng.findBylId(bean.getlId()).get(0);
		List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(user.getId());
		if(infoList.size()>0) {
			payeeBean.setBank(infoList.get(0).getBank());//银行
			payeeBean.setBankAccount(infoList.get(0).getBankAccount());//银行账户
			payeeBean.setZfbAccount(infoList.get(0).getZfbAccount());//支付宝账户
			payeeBean.setZfbQR(infoList.get(0).getZfbQR());//支付宝二维码地址
			payeeBean.setWxAccount(infoList.get(0).getWxAccount());//微信账户
			payeeBean.setWxQR(infoList.get(0).getWxQR());//微信二维码地址
		}
		model.addAttribute("payee", payeeBean);
		
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"JKSQ", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getlCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JKSQ", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象id
		model.addAttribute("foCode",bean.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("借款申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		model.addAttribute("detail","1");
		if(cashier.equals("1")){
			model.addAttribute("userInfo", getUser());
			return "/WEB-INF/view/expend/cashier/loan_cashier";
		} else {
			return "/WEB-INF/view/expend/loan/loan_check";
		}
	}
	
	/*
	 * 审批结果
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,LoanBasicInfo bean,String spjlFile) {
		try {
		//	List<Role> roleli = userMng.getUserRole(getUser().getId());
			//bean = loanMng.findById(bean.getlId());
			loanCheckMng.saveCheckInfo(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
}

package com.braker.icontrol.expend.loan.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.loan.manager.LoanCheckMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.LoanPayeeMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 借款申请控制层
 * 本模块用于借款申请审批的审批及查看
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
@Controller
@RequestMapping(value = "/loan")
public class LoanController extends BaseController{
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private LoanCheckMng loanCheckMng;
	
	@Autowired
	private LoanPayeeMng loanPayeeMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/expend/loan/loan_list";
	}
	/*
	 * 
	 */
	@RequestMapping(value = "/choose")
	public String choose(ModelMap model, String menuType) {
		
		model.addAttribute("menuType", menuType);
		return "/WEB-INF/view/expend/loan/loan_choose";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	@RequestMapping(value = "/loanPage")
	@ResponseBody
	public JsonPagination loanPage(LoanBasicInfo bean, Integer page, Integer rows,String sign){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = loanMng.pageList(bean, page, rows, getUser(),sign);;
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
	
	/**
	 * 
	 * @ToDo 出纳受理分页数据获得
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月5日
	 */
	@RequestMapping(value = "/CashierloanPage")
	@ResponseBody
	public JsonPagination CashierloanPage(LoanBasicInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = loanMng.cashierPageList(bean, page, rows, getUser());;
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
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@RequestMapping("/add")
	public String add(ModelMap model) {
		LoanBasicInfo bean = new LoanBasicInfo();
		//获取当前登录对象获得名称和所属部门
		User user = getUser();
		bean.setLoanPurpose(user.getName()+"-借款申请-"+DateUtil.formatDate(new Date()));
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "add");
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"JKSQ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), user.getDepartName(),null);
		model.addAttribute("proposer", proposer);
/*		File file = new File("D://baocun1.png");
		String ss = Base64Util.getBase64(file);
		model.addAttribute("ss", ss);*/
		
		
		//查询个人收款信息
		LoanPayeeInfo payeeBean = new LoanPayeeInfo();
		List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(user.getId());
		if(infoList.size()>0) {
			payeeBean.setPayeeIdCard(infoList.get(0).getPayeeIdCard());//身份证号
			payeeBean.setIdCard(infoList.get(0).getIdCard());//身份证号
			payeeBean.setBank(infoList.get(0).getBank());//银行
			payeeBean.setBankAccount(infoList.get(0).getBankAccount());//银行账户
			payeeBean.setBankName(infoList.get(0).getBankName());//银行名称
			payeeBean.setZfbAccount(infoList.get(0).getZfbAccount());//支付宝账户
			payeeBean.setZfbQR(infoList.get(0).getZfbQR());//支付宝二维码地址
			payeeBean.setWxAccount(infoList.get(0).getWxAccount());//微信账户
			payeeBean.setWxQR(infoList.get(0).getWxQR());//微信二维码地址
		}
		model.addAttribute("payee", payeeBean);
		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("借款申请");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/expend/loan/loan_add";
	}
	
	/*
	 * 跳转修改页面
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		LoanBasicInfo bean = loanMng.findById(id);
		//查询申请人信息
		User user = userMng.findById(bean.getUser());
		bean.setUserName(user.getName());
		//收款人信息
		LoanPayeeInfo payeeBean = loanPayeeMng.findBylId(bean.getlId()).get(0);
		List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(user.getId());
		if(infoList.size()>0) {
			payeeBean.setBank(infoList.get(0).getBank());//开户行
			payeeBean.setBankAccount(infoList.get(0).getBankAccount());//银行账户
			payeeBean.setBankName(infoList.get(0).getBankName());//银行名称
			payeeBean.setZfbAccount(infoList.get(0).getZfbAccount());//支付宝账户
			payeeBean.setZfbQR(infoList.get(0).getZfbQR());//支付宝二维码地址
			payeeBean.setWxAccount(infoList.get(0).getWxAccount());//微信账户
			payeeBean.setWxQR(infoList.get(0).getWxQR());//微信二维码地址
		}
		model.addAttribute("payee", payeeBean);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"JKSQ", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getlCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JKSQ", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编号
		model.addAttribute("foCode",bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("借款申请");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询四级指标信息
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//可用余额
				bean.setIndexAmount(detail.getSyAmount());
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//可用余额
			bean.setIndexAmount(index.getSyAmount());
		}		
		model.addAttribute("bean", bean);
		//根据修改还是查看跳转不同页面
		if(editType.equals("0")){
			model.addAttribute("openType", "detail");
			model.addAttribute("detail", "1");
			return "/WEB-INF/view/expend/loan/loan_detail";
		} else if(editType.equals("1")){
			model.addAttribute("openType", "edit");
			return "/WEB-INF/view/expend/loan/loan_add";
		} else {
			return null;
		}
	}
	
	/*
	 * 借款申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(LoanBasicInfo bean,LoanPayeeInfo payeeBean,ModelMap model) {
		try {
			loanMng.save(bean, payeeBean, getUser());
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
	}
	
	/*
	 * 借款申请删除
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//传回来的id是主键
			loanMng.delete(id,fId,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	
	/*
	 * 跳转到指标选择页面
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap model) {
		return "/WEB-INF/view/expend/loan/loanIndex";
	}
	

	/**
	 * 借款申请台账导出
	 * @author 叶崇晖
	 * @param model
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping("/export")
	public String export(ModelMap model, HttpServletResponse response, HttpServletRequest request, String lCode, Date estChargeTime1, Date estChargeTime2
			,String deptName,String loanString){
		OutputStream out = null;
		try {
			//初始化
			response.setHeader("Content-Disposition","attachment; filename="+new String("借款申请台账".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\借款申请导出模板.xls";
			//台账数据
		
			LoanBasicInfo bean = new LoanBasicInfo();
			bean.setlCode(lCode);
			bean.setEstChargeTime1(estChargeTime1);
			bean.setEstChargeTime2(estChargeTime2);
			bean.setDeptName(deptName);
			String userId = getUser().getId();
			List<LoanBasicInfo> ledgerData = loanMng.ledgerList(bean,loanString,userId);
			
			//生成excel并导出
			HSSFWorkbook workbook = loanMng.exportLedger(ledgerData, filePath);
			
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}  
			}
		}
		return null;
	}
	
	/**
	 * @Description: 借款申请退回
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	@RequestMapping(value = "/loanReCall")
	@ResponseBody
	public Result loanReCall(Integer id) {
		try {
			//传回来的id是主键
			
			loanMng.loanReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true,"撤回成功！");	
	}
}

package com.braker.icontrol.incomemanage.capital.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.LoanPayeeMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.icontrol.incomemanage.capital.manager.CapitalMng;
import com.braker.icontrol.incomemanage.capital.model.FundPayforInfo;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 资金垫支的控制层
 * 本模块用于收入登记的审批及查看
 * @author 冉德茂
 * @createtime 2018-10-08
 * @updatetime 2018-10-08
 */
@Controller
@RequestMapping(value = "/srcapital")
public class CapitalController extends BaseController{

	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private CapitalMng capitalMng;
	
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private LoanPayeeMng loanPayeeMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private PaymentMng paymentMng;
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/income_manage/capital/capital_list";
	}
	
	
	/*
	 * 分页数据获得（查询1已审批 未删除的借款单信息）
	 * @author 冉德茂
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@RequestMapping(value = "/srcapitalPage")
	@ResponseBody
	public JsonPagination loanPage(LoanBasicInfo bean, String sort, String order, Integer page, Integer rows, String type){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = loanMng.repayforpageList(bean, page, rows, type,getUser());
    	List<LoanBasicInfo> li = (List<LoanBasicInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 新增资金垫支
	 * @author 冉德茂
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		FundPayforInfo bean=new FundPayforInfo() ;
		//自动生成登记单号
		String str="DJ";
		bean.setFcoCode(StringUtil.Random(str));
		bean.setFoperateUser(getUser().getName());
		bean.setFoperateTime(new Date());
		model.addAttribute("bean", bean);
		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("资金垫支");
		model.addAttribute("cheterInfo", cheterInfo);
		
		model.addAttribute("splc", "1");
		
		return "/WEB-INF/view/income_manage/capital/capital_add";
	}
	
	/*
	 * 弹出选择借方项目的页面  
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping(value = "/proinfoa")
	public String checka(ModelMap model) {
		return "/WEB-INF/view/income_manage/capital/proinfo_list_a";
	}
	/*
	 * 弹出选择贷方项目的页面  
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping(value = "/proinfob")
	public String checkb(ModelMap model) {
		return "/WEB-INF/view/income_manage/capital/proinfo_list_b";
	}
	
	/*
	 * 
	 * 保存资金垫支信息
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(FundPayforInfo bean,LoanBasicInfo loanbean,String files,ModelMap model) {
		try {
			capitalMng.save(bean,loanbean,files,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 删除资金垫支
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			capitalMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/*
	 * 查看借款单详细信息     以及还款信息  若有
	 * @author 冉德茂
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		//id是借款单的主键id   lId
		//查询借款单信息
		LoanBasicInfo loanbean = loanMng.findById(Integer.valueOf(id));
		loanbean.setUserName(userMng.findById(loanbean.getUser()).getName());
		//查询借款人信息
		LoanPayeeInfo personbean = loanPayeeMng.findBylId(Integer.valueOf(id)).get(0);
		//查询还款信息
		List<FundPayforInfo> relist = capitalMng.findByloanId(Integer.valueOf(id));
		FundPayforInfo repaybean = new FundPayforInfo();
		if(relist.size()>0){//是否已经还款
			repaybean=relist.get(0);
			//查询附件信息
			List<Attachment> attac = attachmentMng.list(repaybean);
			model.addAttribute("attac", attac);
		}
		model.addAttribute("loanbean", loanbean);	
		model.addAttribute("payee", personbean);	
		model.addAttribute("repaybean", repaybean);	
		
		return "/WEB-INF/view/income_manage/capital/capital_detail";
	}
	
	/*
	 * 还款
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping(value = "/repayment")
	public String edit(String id, ModelMap model) {
		//id是借款单的主键id   lId
		//查询借款单信息
		LoanBasicInfo loanbean = loanMng.findById(Integer.valueOf(id));
		loanbean.setUserName(userMng.findById(loanbean.getUser()).getName());
		
		
		//查询借款人信息
		LoanPayeeInfo personbean = loanPayeeMng.findBylId(Integer.valueOf(id)).get(0);
		
		//查询还款信息
		List<FundPayforInfo> relist = capitalMng.findByloanId(Integer.valueOf(id));
		FundPayforInfo repaybean = new FundPayforInfo();
		if(relist.size()>0){//已经还款，则修改以后还款单
			repaybean=relist.get(0);
		}else{//未还款，新建还款单
			repaybean.setFoperateUser(getUser().getName());
			repaybean.setFoperateTime(new Date());
		}
		
		model.addAttribute("loanbean", loanbean);	
		model.addAttribute("payee", personbean);	
		model.addAttribute("repaybean", repaybean);	
		
		return "/WEB-INF/view/income_manage/capital/capital_add";

	}
	/*
	 * 附件上传AJAX
	 * @author 冉德茂
	 * @createtime 2018-10-10
	 * @updatetime 2018-10-10
	 */
	@RequestMapping(value = "/applyFile")
	@ResponseBody
	public boolean applyFile(String fileurl){
		try {
			fileurl = java.net.URLDecoder.decode(fileurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//获取文件名
		String[] names = fileurl.split("\\\\");
		String name = names[names.length-1];
		//保存附件文件
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		boolean flag = false;
		try {
			String path = "CG/CGSQ";
			String filename = name.trim();
			String input = fileurl.trim();
			flag=fu.upLoadFromProduction(url, port,username,password,path,filename,input);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	
	
}

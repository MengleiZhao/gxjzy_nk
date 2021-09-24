package com.braker.icontrol.expend.refund.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.MoneyUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.expend.apply.manager.StudentsListMng;
import com.braker.icontrol.expend.apply.model.StudentsList;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.refund.manager.RefundInfoMng;
import com.braker.icontrol.expend.refund.manager.RefundMoneyMng;
import com.braker.icontrol.expend.refund.model.RefundInfo;
import com.braker.icontrol.expend.refund.model.StudentRefundMoney;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping(value = "/refund")
public class RefundController extends BaseController{

	@Autowired
	private RefundInfoMng refundInfoMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired  
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private RefundMoneyMng refundMoneyMng;
	@Autowired
	private UserMng userMng;
	
	/**
	 * 跳转到
	 * @param fNewOrOld
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月27日
	 * @updateTime2019年11月27日
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, String fNewOrOld){
		model.addAttribute("fNewOrOld", fNewOrOld);
		return "/WEB-INF/view/expend/refund/refund_list";
	}
	
	/**
	 * 加载申请页面数据
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月27日
	 * @updateTime2019年11月27日
	 */
	@ResponseBody
	@RequestMapping("/jsonPagination")
	public JsonPagination jsonPagination(RefundInfo bean, Integer page, Integer rows, String sign){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = refundInfoMng.pageList(bean, page, rows, sign, getUser());
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到新增页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	@RequestMapping("/add")
	public String add(ModelMap model, Integer fNewOrOld){
		User user = getUser();
		//打开方式
		model.addAttribute("openType", "add");
		RefundInfo bean = new RefundInfo();
		//自动生成单号
		bean.setfInfoCode(StringUtil.Random("TF"));
		//自动生成申请人、申请部门、申请日期等
		bean.setfUserId(user.getId());
		bean.setfUserName(user.getName());
		bean.setfDeptId(user.getDpID());
		bean.setfDeptName(user.getDepartName());
		bean.setfReqTime(new Date());
		bean.setfNewOrOld(fNewOrOld);
		model.addAttribute("bean", bean);
		
		if(fNewOrOld == 0){	//新生
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(user.getId(), "XSTF", user.getDpID(), null, bean.getnCode(), null, null, null, null);
			model.addAttribute("nodeConf", nodeConfList);
			
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/expend/refund/newStudent/refund_add_new";
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(user.getId(), "LSTF", user.getDpID(), null, bean.getnCode(), null, null, null, null);
		model.addAttribute("nodeConf", nodeConfList);
		
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/oldStudent/refund_add_old";
	}
	
	/**
	 * 修改
	 * @param model
	 * @param id 主见ID
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model, @PathVariable String id){
		//打开方式
		model.addAttribute("openType", "edit");
		
		//退费基本信息
		RefundInfo bean = refundInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//退费附件
		List<Attachment> refundAttaList = attachmentMng.list(bean);
		model.addAttribute("refundAttaList", refundAttaList);
		
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		
		if(bean.getfNewOrOld() == 0){//新生
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"XSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			
			//得到工作流id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("XSTF", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			
			// 建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/expend/refund/newStudent/refund_add_new";
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"LSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("LSTF", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		// 建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/oldStudent/refund_add_old";
	}
	
	/**
	 * 
	 * @Description 查看
	 * @param @param model
	 * @param @param id
	 * @param @return
	 * @return String  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model, @PathVariable String id){
		//打开方式
		model.addAttribute("openType", "detail");
		
		//退费基本信息
		RefundInfo bean = refundInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//退费附件
		List<Attachment> refundAttaList = attachmentMng.list(bean);
		model.addAttribute("refundAttaList", refundAttaList);
		
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		//储存业务范围
		String busiArea = null;	
		if(bean.getfNewOrOld() == 0){
			busiArea = "XSTF";	//新生退费
		}else if(bean.getfNewOrOld() == 1){
			busiArea = "LSTF";	//老生退费
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),busiArea,bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		// 建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/refund_detail";
	}
	
	/**
	 * 
	 * @Description 删除
	 * @param @param id
	 * @param @return
	 * @return Result  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable Integer id) {
		try {
			refundInfoMng.delete(id);
		} catch (Exception e) {
			return getJsonResult(false, "删除失败，请联系管理员！");
		}
		return getJsonResult(true, "删除成功！");	
	}
	
	/**
	 * 
	 * @Description 退费明细
	 * @param @param id
	 * @param @return
	 * @return List<Object>  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public List<Object> mingxi(Integer id) {
		List<Object> mingxiList = new ArrayList<Object>();
		if(id != null) {		
			//查询申请明细
			mingxiList = refundInfoMng.getMingxi("StudentRefundMoney", "fRId", id);
		}
		return mingxiList;
	}
	
	/**
	 * 保存送审方法
	 * @param bean
	 * @param files
	 * @param mingxi
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(RefundInfo bean, String files, String mingxi){
		try {
			refundInfoMng.save(bean, files, mingxi, getUser());
		} catch (Exception e) {
			return getJsonResult(false, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 审批列表页面
	 * @param @param model
	 * @param @return
	 * @return String  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping(value = "/checkList")
	public String checkList(ModelMap model){
		return "/WEB-INF/view/expend/refund/refund_check_list";
	}
	
	/**
	 * 
	 * @Description 审批页面
	 * @param @param model
	 * @param @param id
	 * @param @return
	 * @return String  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping("/check/{id}")
	public String check(ModelMap model, @PathVariable String id){
		//打开方式
		model.addAttribute("openType", "check");
		
		//退费基本信息
		RefundInfo bean = refundInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//退费附件
		List<Attachment> refundAttaList = attachmentMng.list(bean);
		model.addAttribute("refundAttaList", refundAttaList);
		
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		//储存业务范围
		String busiArea = null;	
		if(bean.getfNewOrOld() == 0){
			busiArea = "XSTF";	//新生退费
		}else if(bean.getfNewOrOld() == 1){
			busiArea = "LSTF";	//老生退费
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),busiArea,bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);

		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
				
		// 建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/refund_check";
	}
	
	/**
	 * 
	 * @Description 进行审批
	 * @param @param checkBean
	 * @param @param bean
	 * @param @param spjlFile
	 * @param @return
	 * @return Result  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean, RefundInfo bean, String spjlFile){
		try {
			refundInfoMng.saveCheck(checkBean, bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(true, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 台账列表页面
	 * @param @param model
	 * @param @return
	 * @return String  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	@RequestMapping(value = "/ledgerList")
	public String ledgerList(ModelMap model){
		return "/WEB-INF/view/expend/refund/refund_ledger_list";
	}
	
	/**
	 * 
	 * <p>Title: export</p>  
	 * <p>Description: 跳转到打印页面</p>  
	 * @param model
	 * @param id RefundInfo主键id
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月2日
	 * @updator 陈睿超
	 * @updatetime 2020年12月2日
	 */
	@RequestMapping(value = "/export")
	public String export(ModelMap model, Integer id){
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			
			//退费基本信息
			RefundInfo bean = refundInfoMng.findById(id);
			model.addAttribute("bean", bean);
			
			//查询申请明细
			List<Object> mingxiList = refundInfoMng.getMingxi("StudentRefundMoney", "fRId", bean.getfRID());
			model.addAttribute("mingxiList",mingxiList);
			
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getfReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);
			
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"LSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
			
			//得到工作流id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("LSTF", bean.getfDeptId());
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
			for (int i = checkList.size()-1; i >= 0; i--) {
				model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
				model.addAttribute("date"+(i+1), fmt.format(checkList.get(i).getFcheckTime()));
				User checkuser = userMng.findById(checkList.get(i).getFbyUserId());
				if(i>(checkList.size()-4)&&"32".equals(checkuser.getDpID())){
					financeList.add(checkList.get(i));
				}
			}
			String financeCheck = new String();
			for (int i = 0; i < financeList.size(); i++) {
				financeCheck+=financeList.get(i).getFuserName()+",";
			}
			if(financeList.size()>0){
				model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
			}
			
			return "/WEB-INF/view/expend/refund/export/studentList";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/expend/refund/export/studentList";
		}
	}
	
	
	/**
	 * 
	 * <p>Title: studentExport</p>  
	 * <p>Description: 跳转导新生或老生打印页面</p>  
	 * @param model
	 * @param id StudentRefundMoney主键
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月3日
	 * @updator 陈睿超
	 * @updatetime 2020年12月3日
	 */
	@RequestMapping(value = "/studentExport")
	public String studentExport(ModelMap model, Integer id){
		
		try {
			StudentRefundMoney studentbean = refundMoneyMng.findById(id);
			RefundInfo bean = refundInfoMng.findById(studentbean.getfRId());
			model.addAttribute("bean", bean);
			model.addAttribute("studentbean", studentbean);
			
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getfReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);
			studentbean.setChineseSumMoney(MoneyUtil.toChinese(String.valueOf(studentbean.getSumMoney())));
			studentbean.setChinesePayedSumMoney(MoneyUtil.toChinese(String.valueOf(studentbean.getPayedTuition()+studentbean.getPayedRoom())));
			
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"LSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
			
			//得到工作流id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("LSTF", bean.getfDeptId());
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
			for (int i = checkList.size()-1; i >= 0; i--) {
				model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
				model.addAttribute("date"+(i+1), fmt.format(checkList.get(i).getFcheckTime()));
				User checkuser = userMng.findById(checkList.get(i).getFbyUserId());
				if(i>(checkList.size()-4)&&"32".equals(checkuser.getDpID())){
					financeList.add(checkList.get(i));
				}
			}
			String financeCheck = new String();
			for (int i = 0; i < financeList.size(); i++) {
				financeCheck+=financeList.get(i).getFuserName()+",";
			}
			if(financeList.size()>0){
				model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
			}
			
			if(0==bean.getfNewOrOld()){//新生
				return "/WEB-INF/view/expend/refund/export/newStudent";
			}else if(1==bean.getfNewOrOld()){//老生
				return "/WEB-INF/view/expend/refund/export/oldStudent";
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	/**
	 * 跳转页面到附件上传页面
	 * @param id 项目基本信息主键
	 * @param model
	 * @return
	 */
	@RequestMapping("/filesjsp/{id}")
	public String filesUpdate(@PathVariable String id,String type,String fliesType,String index,String val, ModelMap model){
		model.addAttribute("id", id);
		model.addAttribute("fliesType", fliesType);
		List<Attachment> attaList =null;
		if("".equals(val)){
			attaList=null;
		}else{
			attaList = attachmentMng.findByIdS(val);
		}
		//附件
		//标记是否显示含有附件
		if (attaList != null && attaList.size() > 0) {
			model.addAttribute("hasFile", "true");
		}
		model.addAttribute("index", index);
		if("1".equals(type)){
			model.addAttribute("projectResolveAttaList", attaList);
			model.addAttribute("openType", "edit");
		}else {
			model.addAttribute("projectResolveAttaList", attaList);
			model.addAttribute("openType", "detail");
		}
		return "/WEB-INF/view/expend/refund/files-add";
	}
	
	/**
	 * 撤回
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 崔敬贤
	 * @createtime 2019-10-08
	 * @updatetime 2018-10-08
	 */
	@ResponseBody
	@RequestMapping("/reCall")
	public Result reCall(String id,ModelMap model){
		try {
			refundInfoMng.reCall(id);
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
}

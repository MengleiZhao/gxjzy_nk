package com.braker.icontrol.incomemanage.accountsCurrent.controller;
import java.util.Date;
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
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 往来款登记控制层
 * @author 赵孟雷
 *
 */
@Controller
@RequestMapping(value = "/accountsCurrent")
public class AccountsCurrentController extends BaseController{

	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private UserMng userMng;
	
	/**
	 * 跳转到list申请页面
	 * @author 赵孟雷
	 * @createTime 2020年11月10日
	 * @updateTime 2020年11月10日
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsCurrentList";
	}
	
	/*
	 * 分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-11-10
	 * @updatetime 2020-11-10
	 */
	@RequestMapping(value = "/accountsPage")
	@ResponseBody
	public JsonPagination accountsPage(Integer applyType ,AccountsCurrent bean, ModelMap model, Integer page, Integer rows){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			Pagination p = accountsCurrentMng.pageList(bean, page, rows, getUser());
			return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-11-10
	 * @updatetime 2020-11-10
	 */
	@RequestMapping(value = "/affirmPage")
	@ResponseBody
	public JsonPagination affirmPage(Integer applyType ,AccountsCurrent bean, ModelMap model, Integer page, Integer rows){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			Pagination p = accountsCurrentMng.pageList(bean, page, rows, getUser());
			return getJsonPagination(p, page);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12           
	 */
	@RequestMapping("/add")
	public String add(Integer type ,ModelMap model) {
		try {
			AccountsCurrent bean = new AccountsCurrent();
			//获取默认值
			User user = getUser();
			String code = StringUtil.Random("LK");
			bean.setProCode(code);
			bean.setUserId(user.getId());//用户名ID
			bean.setUserName(user.getName());//用户名
			bean.setDeptId(user.getDepart().getId());//ID
			bean.setDeptName(user.getDepart().getName());//部门
			bean.setReqTime(new Date());
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "add");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"WLKLXSQ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKLXSQ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);	
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("WLKLXSQ",getUser().getDpID(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_current_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_current_add";
		}
	}
	/*
	 * 跳转修改页面
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/edit")
	public String edit(String id ,ModelMap model) {
		try {
			AccountsCurrent bean = accountsCurrentMng.findById(Integer.valueOf(id));
			//获取默认值
			User user = getUser();
			bean.setUserId(user.getId());//用户名ID
			bean.setUserName(user.getName());//用户名
			bean.setDeptId(user.getDepart().getId());//ID
			bean.setDeptName(user.getDepart().getName());//部门
			bean.setReqTime(new Date());
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "add");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"WLKLXSQ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKLXSQ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);	
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("WLKLXSQ",getUser().getDpID(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_current_add";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/add/accounts_current_add";
		}
	}
	/*
	 * 跳转修改页面
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/detail")
	public String detail(String id ,ModelMap model) {
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
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_current_detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_current_detail";
		}
	}
	
	@RequestMapping(value = "/saveAccounts")
	@ResponseBody
	public Result saveAccounts(AccountsCurrent bean,String files,ModelMap model) {
		try {
			accountsCurrentMng.save(bean, files,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 跳转到登记选择项目页面
	 * @author 赵孟雷
	 * @createTime 2020年11月12日
	 * @updateTime 2020年11月12日
	 */
	@RequestMapping("/proList")
	public String proList(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsCurrentList_pro";
	}
	
	/**
	 * @Description: 收入管理中往来款登记撤回
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	@RequestMapping(value = "/accountsReCall")
	@ResponseBody
	public Result accountsReCall(Integer id) {
		try {
			accountsCurrentMng.accountsCurrentReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"撤回失败，请联系管理员！");
		}
		return getJsonResult(true,"撤回成功！");	
	}
	
	/*
	 * 收入管理中的往来款登记删除
	 * @author 赵孟雷
	 * @createtime 2020-11-13
	 * @updatetime 2018-11-13
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//传回来的id是主键
			User user = getUser();
			accountsCurrentMng.delete(id,user,fId);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
}
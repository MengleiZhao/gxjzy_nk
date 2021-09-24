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
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
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
@RequestMapping(value = "/accountsCurrentCheck")
public class AccountsCurrentCheckController extends BaseController{

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
	 * @return
	 * @author 赵孟雷
	 * @createTime 2020年11月10日
	 * @updateTime 2020年11月10日
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/income_manage/accountsCurrent/accountsCurrentCheckList";
	}
	
	/*
	 * 分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020年11月10日
	 * @updatetime 2020年11月10日
	 */
	@RequestMapping(value = "/accountsPage")
	@ResponseBody
	public JsonPagination accountsPage(Integer applyType ,AccountsCurrent bean, ModelMap model, Integer page, Integer rows){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			Pagination p = accountsCurrentMng.pageCheckList(bean, page, rows, getUser());
			return getJsonPagination(p, page);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 跳转修改页面
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/check")
	public String check(String id ,ModelMap model) {
		try {
			AccountsCurrent bean = accountsCurrentMng.findById(Integer.valueOf(id));
			//获取默认值
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "check");
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
			return "/WEB-INF/view/income_manage/accountsCurrent/check/accounts_current_check";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/check/accounts_current_check";
		}
	}
	
	/*
	 * 审批结果
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,AccountsCurrent bean,String spjlFile) {
		try {
			accountsCurrentMng.check(checkBean,bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
}

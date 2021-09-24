package com.braker.icontrol.contract.Formulation.controller;

import java.math.BigDecimal;
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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.contract.Formulation.manager.ApprovalMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Approval")
public class ApprovalController extends BaseController{
	
	@Autowired
	private ApprovalMng approvalMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TBasicItfMng basicItfMng;
	@Autowired
	private TProItfMng proItfMng; 
	@Autowired
	private TProItfMng itfMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private FilingMng filingMng;
	/**
	 * 跳转主页面
	 * @param model
	 * @return
	 * @createtime 2018-06-12
	 * @author crc
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/contract/formulation/approval/approval_list";
	}
	
	/**
	 * 显示待审批信息
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2018-06-14
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=approvalMng.queryList(contractBasicInfo,getUser(),page,rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 显示待审批信息
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/approveList/{id}")
	public String approve_list(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "edit");
		//合同拟定的信息
		ContractBasicInfo contractBasicInfo = approvalMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		
		User user2 = getUser();
		if(user2.getRoleName().contains("合同法审岗")&&Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "1");
		}else{
			if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
				model.addAttribute("fsyjsFile", "0");
			}else{
				model.addAttribute("fsyjsFile", "");
			}
		}
		
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//签约方信息
		SignInfo signInfo = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(),  "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同审批");
		model.addAttribute("cheterInfo", cheterInfo);
		//审批信息
		if(contractBasicInfo.getFcId() !=null){
			model.addAttribute("CheckInfoHave", "1");
		}
		return "/WEB-INF/view/contract/formulation/approval/approval_add";
	}
	
	/**
	 * 更新审批状态
	 * @param stauts
	 * @param Id
	 * @param pid
	 * @param checkInfo
	 * @param model
	 * @return
	 */
	@RequestMapping("/approve")
	@ResponseBody
	public Result approve(String fFlowStauts,String Id,String fremark,String pid,String spjlFile,TProcessCheck checkBean,String fsyjsfiles) {
			try {
				if(fFlowStauts.equals("0")&&StringUtil.isEmpty(fFlowStauts)){
					return getJsonResult(false, "不通过请填写审批意见！");
				}
				fremark = checkBean.getFcheckRemake();
				checkBean =new TProcessCheck(fFlowStauts,fremark);
				approvalMng.updatefFlowStauts(Id, checkBean, getUser(), Id, spjlFile,fsyjsfiles);
			} catch (ServiceException es) {
				return getJsonResult(false, getException(es));
			}catch (Exception e) {
				return getJsonResult(false, getException(e));
			}
			return getJsonResult(true, "操作成功！");
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "detail");
		//合同拟定信息
		ContractBasicInfo contractBasicInfo = approvalMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",contractBasicInfo);
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		model.addAttribute("formulationAttaList", attaList);
		//签约方信息
		SignInfo signInfo = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同审批");
		model.addAttribute("cheterInfo", cheterInfo);
		//审批信息
		if(contractBasicInfo.getFcId() !=null){
			model.addAttribute("CheckInfoHave", "1");
		}
		return "/WEB-INF/view/contract/formulation/approval/approval_add";
	}
}

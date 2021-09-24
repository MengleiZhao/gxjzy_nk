package com.braker.icontrol.contract.Formulation.controller;

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
import com.braker.core.manager.DepartMng;
import com.braker.core.model.Proposer;
import com.braker.exception.ServiceException;
import com.braker.icontrol.contract.Formulation.manager.ApprovalMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.manager.SealInfoMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.Formulation.model.SealInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.contract.ledger.manager.LedgerMng;
import com.braker.icontrol.contract.ledger.manager.Impl.LedgerMngImpl;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 合同用印管理控制层
 * @author 陈睿超
 * @creatTime 2020.06.22
 */
@Controller
@RequestMapping("/sealInfo")
public class SealInfoController extends BaseController{

	
	@Autowired
	private SealInfoMng sealInfoMng;
	@Autowired
	private ApprovalMng approvalMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private LedgerMng ledgerMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private FilingMng filingMng;
	/*@Autowired
	private ContractRegisterListMng contractRegisterListMng;
	*/
	
	
	/**
	 * 跳转到list页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月22日
	 * @updator 陈睿超
	 * @updatetime 2020年6月22日
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/contract/sealInfo/sealinfo_list";
	}
	
	/**
	 * 加载用印管理list页面数据
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月22日
	 * @updator 陈睿超
	 * @updatetime 2020年6月22日
	 */
	@RequestMapping(value = "/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=ledgerMng.findAllCBI(contractBasicInfo, true, getUser(), page, rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 加载台账页面变更合同数据
	 * @param upt
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月22日
	 * @updator 陈睿超
	 * @updatetime 2020年6月22日
	 */
	@RequestMapping("/ChangeJsonPagination")
	@ResponseBody
	public JsonPagination ChangeJsonPagination(Upt upt,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = ledgerMng.uptList(upt, getUser(), page, rows);
		List<Upt> li= (List<Upt>) p.getList();
		if (li != null && li.size() > 0) {
			int i = 0;
			for (Upt tb: li) { 
				tb.setNumber(page * rows + i - 9);
				i++;
			}
		}
		p.setList(li);
		return getJsonPagination(p, page);
	}
	
	
	
	/**
	 * 
	 * @Title sealEdit
	 * @Description 合同盖章新增/修改
	 * @author 汪耀
	 * @Date 2020年3月1日 
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 */
	@RequestMapping(value = "/sealEdit")
	public String sealEdit(ModelMap model, Integer id,String type){
		model.addAttribute("fcId", id);
		model.addAttribute("type", type);
		ContractBasicInfo cbiBean = new ContractBasicInfo();
		Upt uptbean = new Upt();
		if("1".equals(type)){//变更
			uptbean = uptMng.findById(id);
			cbiBean = formulationMng.findById(uptbean.getfContId_U());
			//合同变更附件
			List<Attachment> uptAttaList = attachmentMng.list(uptbean);
			model.addAttribute("changeAttaList", uptAttaList);
			//判断是不是可以修改状态
			if("1".equals(uptbean.getfUptFlowStauts())||"9".equals(uptbean.getfUptFlowStauts())){
				model.addAttribute("uptOpenType", "Cedit");
			}else {
				model.addAttribute("uptOpenType", "Cdetail");
			}
			//付款计划变更
			ReceivPlan receivPlan = new ReceivPlan();
			receivPlan.setfUptId_R(Integer.valueOf(id));
			receivPlan.setDataType(1);
		}else if("0".equals(type)){//原合同
			//合同拟定信息
			cbiBean = approvalMng.findById(id);
		}
		if(Double.valueOf(cbiBean.getFcAmount())>=100000&&cbiBean.getFcType().equals("HTFL-03")){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(cbiBean);
		model.addAttribute("formulationAttaList", attaList);
		model.addAttribute("uptOpenType", "Cdetail");
		//签约方信息
		SignInfo signInfo = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(cbiBean);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		//签约方信息的附件
		List<Attachment> signInfoattaList = attachmentMng.list(signInfo);
		model.addAttribute("signInfoAttaList", signInfoattaList);
		//盖章信息
		Integer fsId = sealInfoMng.findFsIdByFcId(id);
		SealInfo siBean = new SealInfo();
		if (fsId == null) {
			//默认显示申请人、申请时间
			siBean.setFappUserName(getUser().getName());
			siBean.setFappTime(new Date());
		} else {
			siBean = sealInfoMng.findById(fsId);
		}
		model.addAttribute("siBean", siBean);
		model.addAttribute("bean", cbiBean);//原合同
		model.addAttribute("Upt", uptbean);//变更
		
		//根据申请人得到申请部门id
		String departId = departMng.findDeptByUserId(cbiBean.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(cbiBean.getUserId(), "HTND", departId, cbiBean.getBeanCode(), cbiBean.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", cbiBean.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
				
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(cbiBean.getfOperator(), cbiBean.getfDeptName(), cbiBean.getfReqtIME());
		model.addAttribute("proposer", proposer);
				
		
		//对象编码
		model.addAttribute("foCode", cbiBean.getBeanCode());
		if("1".equals(type)){//变更
			return "/WEB-INF/view/contract/formulation/approval/approval_seal_upt_edit";
		}else if("0".equals(type)){//原合同
			return "/WEB-INF/view/contract/formulation/approval/approval_seal_edit";
		}
		return null;
	}
	
	/**
	 * 
	 * @Title saveSeal 
	 * @Description 保存盖章信息
	 * @author 汪耀
	 * @Date 2020年3月1日 
	 * @param id
	 * @param siBean
	 * @return
	 * @return Result
	 * @throws
	 */
	@RequestMapping(value = "/saveSeal")
	@ResponseBody
	public Result saveSeal(Integer id, SealInfo siBean,String type,Integer infoid,String files,String time,String ygzhtwbfiles,String bgygzhtwbfiles) {
		try {
			ContractBasicInfo cbiBean = new ContractBasicInfo();
			Upt uptbean = new Upt();
			if("1".equals(type)){//变更
				uptbean = uptMng.findById(id);
				uptbean.setfSignTime(siBean.getfSignTime());
				cbiBean = formulationMng.findById(uptbean.getfContId_U());
			}else if("0".equals(type)){//原合同
				//合同拟定信息
				cbiBean = approvalMng.findById(id);
				cbiBean.setfSignTime(siBean.getfSignTime());
			}
			//保存盖章基本信息
			sealInfoMng.save(siBean, id, getUser(),type,cbiBean,uptbean,files,ygzhtwbfiles,bgygzhtwbfiles);
		} catch (ServiceException e) {
			return getJsonResult(false, getException(e));
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Title sealDetail 
	 * @Description 合同盖章查看
	 * @author 汪耀
	 * @Date 2020年3月6日 
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 */
	@RequestMapping(value = "/sealDetail")
	public String sealDetail(ModelMap model, Integer id){
		//合同拟定信息
		ContractBasicInfo cbiBean = approvalMng.findById(id);
		
		//盖章信息
		Integer fsId = sealInfoMng.findFsIdByFcId(id);
		SealInfo siBean = sealInfoMng.findById(fsId);
		model.addAttribute("siBean", siBean);
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(cbiBean);
		model.addAttribute("formulationAttaList", attaList);
		//根据申请人得到申请部门id
		String departId = departMng.findDeptByUserId(cbiBean.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(cbiBean.getUserId(), "HTND", departId, cbiBean.getBeanCode(), cbiBean.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", cbiBean.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
				
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(cbiBean.getfOperator(), cbiBean.getfDeptName(), cbiBean.getfReqtIME());
		model.addAttribute("proposer", proposer);
				
		//对象编码
		model.addAttribute("foCode", cbiBean.getBeanCode());
		return "/WEB-INF/view/contract/formulation/approval/approval_seal_detail";
	}
	
	/**
	 * 
	 * @Title queryFsId 
	 * @Description 查询盖章信息
	 * @author 汪耀
	 * @Date 2020年3月1日 
	 * @param id
	 * @return
	 * @return Result
	 * @throws
	 */
	@RequestMapping(value = "/queryFsId")
	@ResponseBody
	public Result queryFsId(Integer id){
		try {
			Integer fsId = sealInfoMng.findFsIdByFcId(id);
			if(fsId == null){
				return getJsonResult(false, "盖章信息未保存");
			} else {
				return getJsonResult(true, "盖章信息已保存");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
}

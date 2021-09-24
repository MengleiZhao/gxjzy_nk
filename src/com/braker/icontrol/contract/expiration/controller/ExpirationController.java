package com.braker.icontrol.contract.expiration.controller;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.Lookups;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.dispute.manager.DisputAttacMng;
import com.braker.icontrol.contract.dispute.manager.DisputeMng;
import com.braker.icontrol.contract.dispute.model.Dispute;
import com.braker.icontrol.contract.enforcing.manager.ChangeMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionAttacMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionMng;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.expiration.manager.ExpirationMng;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.contract.goldpay.manager.GoldPayMng;
import com.braker.icontrol.contract.goldpay.model.GoldPay;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Expiration")
public class ExpirationController extends BaseController{

	@Autowired
	private ExpirationMng expirationMng;
	@Autowired
	private SignInfoMng signInfoMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private ArchivingMng ArchivingMng;
	@Autowired
	private DisputeMng disputeMng;
	@Autowired
	private ChangeMng changeMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private UptClauseMng uptAttacMng;
	@Autowired
	private ConclusionMng conclusionMng;
	@Autowired
	private ConclusionAttacMng conclusionAttacMng;
	@Autowired
	private DisputAttacMng disputAttacMng;
	@Autowired
	private GoldPayMng goldPayMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/**
	 * 跳转到到期提醒页面
	 * @param model
	 * @return
	 * @createtime 2018-07-04
	 * @author 陈睿超
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/contract/expiration/expiration_list";
	}
	
	/**
	 * 加载到期提醒list数据
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2018-07-04
	 * @author 陈睿超
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = new Pagination();
		try {
			List<ContractBasicInfo> li = expirationMng.find(contractBasicInfo,getUser(), page, rows);
			for (int i = 0; i < li.size(); i++) {
				li.get(i).setNumber(i+1);
			}
			p.setList(li);
			p.setPageNo(page);
			p.setPageSize(rows);
			p.setTotalCount(li.size());
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return getJsonPagination(p, page);
	}
	
	/**
	 * 详情页跳转
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-07-04
	 * @author 陈睿超
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model ){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",contractBasicInfo);
		model.addAttribute("openType", "Edetail");
		//合同备案信息
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//合同备案合同正本附件
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//合同变更信息
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
		}
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//查询归档信息
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//查询纠纷记录
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//合同纠纷附件
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		//审批信息
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/expiration/expiration_detail";
	}
	
	/**
	 * 查询字典里付款性质
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = expirationMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
}

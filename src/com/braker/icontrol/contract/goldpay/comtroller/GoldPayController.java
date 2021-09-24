package com.braker.icontrol.contract.goldpay.comtroller;

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
import com.braker.core.model.CheterInfo;
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
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.contract.goldpay.manager.GoldPayMng;
import com.braker.icontrol.contract.goldpay.model.GoldPay;
import com.braker.icontrol.contract.ledger.manager.LedgerMng;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/GoldPay")
public class GoldPayController extends BaseController {

	@Autowired
	private GoldPayMng goldPayMng;
	@Autowired
	private SignInfoMng signInfoMng;
	@Autowired
	private DisputeMng disputeMng;
	@Autowired
	private LedgerMng LedgerMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private UptMng uptMng;
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
	private AttachmentMng attachmentMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/**
	 * 跳转保证金管理主页
	 * 
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	@RequestMapping("/list")
	public String list(ModelMap model) {

		return "/WEB-INF/view/contract/goldpay/goldpay_list";
	}

	/**
	 * 保证金管理主页数据加载显示
	 * 
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort, String order, Integer page, Integer rows,ModelMap model) {
		if (page == null) {
			page = 1;
		}
		if (rows == null) {
			rows = SimplePage.DEF_COUNT;
		}
		Pagination p = goldPayMng.find(contractBasicInfo, getUser(), page, rows);
		List<ContractBasicInfo> li = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i + 1);
		}
		p.setList(li);
		return getJsonPagination(p, page);
	}

	/**
	 * 跳转查看详情页
	 * 
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id, ModelMap model) {
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "Gdetail");
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
		/*//合同结项的附件
		if( conclusionAttacMng.findAllFile(id).size()>0){
			model.addAttribute("conclusionattac", conclusionAttacMng.findAllFile(id));
		}	*/
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
		//审批信息
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同合同质保金");
		model.addAttribute("cheterInfo", cheterInfo);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/goldpay/goldpay_detail";
	}

	/**
	 * 跳转到质保金退还页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	@RequestMapping("/returnGold/{id}")
	public String returnGold(@PathVariable String id, ModelMap model) {
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "Gedit");
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
		int n=1;
		//合同变更信息
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
			n=n+2;
		}
		//查询纠纷记录
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
			n=n+2;
		}
		//合同纠纷附件
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//查询归档信息
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		
		model.addAttribute("textClassNum", n);
		//审批信息
		//model.addAttribute("CheckInfo",checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同合同质保金");
		model.addAttribute("cheterInfo", cheterInfo);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/goldpay/goldpay_update";
	}

	/**
	 * 保存添加一个支付记录，并修改合同里的状态
	 * 
	 * @param goldPay
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(GoldPay goldPay, ContractBasicInfo contractBasicInfo,String fhtbzjFiles,ModelMap model) {
		try {
			if(StringUtil.isEmpty(goldPay.getfWarType())){
				return getJsonResult(false, "请选择保证金类型！");
			}else if(StringUtil.isEmpty(goldPay.getfPayAmount())){
				return getJsonResult(false, "没有付款金额！");
			}else{
				goldPayMng.save(contractBasicInfo, getUser(), goldPay,fhtbzjFiles);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}

}

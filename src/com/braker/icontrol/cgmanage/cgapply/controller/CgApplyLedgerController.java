package com.braker.icontrol.cgmanage.cgapply.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.hibernate.Finder;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * ??????????????????????????????
 * ???????????????????????????????????????????????????
 * @author ?????????
 * @createtime 2018-07-20
 * @updatetime 2018-07-20
 */

@Controller
@RequestMapping(value = "/cgsqLedger")
public class CgApplyLedgerController extends BaseController{
	
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CgReceiveMng reciveMng;
	@Autowired
	private CgProcessMng processMng;
	@Autowired
	private CgSelMng cgselMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	/*
	 * ?????????????????????
	 * @author  ?????????
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model,String proId) {
		if(!StringUtil.isEmpty(proId)){
			TProBasicInfo tpbi=tProBasicInfoMng.findById(Integer.valueOf(proId));
			TBudgetIndexMgr bim = budgetIndexMgrMng.findByIndexCode(tpbi.getFProCode());
			model.addAttribute("indexCode", bim.getbId());
		}
		return "/WEB-INF/view/purchase_manage/purchase/cgsqledger_list";
	}

	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value = "/cgledgerPage")
	@ResponseBody
	public JsonPagination noticePage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = cgsqMng.ledgerPageList(bean, page, rows, getUser());
		List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//????????????	
			li.get(x).setNumber((x+1)+(page-1)*rows);
			List<WinningBidder> bwlist = cgselMng.findByWid(li.get(x).getFpId());
			String name = "";
			for(int i=0; i<bwlist.size(); i++) {
				if(bwlist.size() > 1) {
					if(i != bwlist.size()-1) {
						name += bwlist.get(i).getFwName()+",";
					}else {
						name += bwlist.get(i).getFwName();
					}
				}else {
					name += bwlist.get(i).getFwName();
				}
			}
			li.get(x).setfOrgName(name);
			/*
			 * if("1".equals(li.get(x).getFbidStauts())){ //???????????????????????? BiddingRegist brList =
			 * processMng.getBiddingRegistByPId(li.get(x).getFpId()); //????????????????????? id????????????????????????
			 * ???????????????????????????????????? WinningBidder bwlist = cgselMng.findById(brList.getFwId());
			 * li.get(x).setfOrgName(bwlist.getFwName());
			 * li.get(x).setFbidAmount(brList.getFbidAmount()); }
			 */
		}
		return getJsonPagination(p, page);
	}
	
	
	
	/**
	 * 
	 * @Description: ??????????????????
	 * @author ??????
	 * @param @param id
	 * @param @param model
	 * @param @return    
	 * @return String
	 */
	@RequestMapping(value = "/detail")
	public String detail(String id,ModelMap model) {
		//????????????id????????? fpid
		//????????????????????????				
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		if("0".equals(bean.getfIsContract())){
			model.addAttribute("fIsContract", "");
		}else{
			model.addAttribute("fIsContract", "1");
		}
		//????????????????????????
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
				//????????????
				bean.setPfAmount(detail.getOutAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
			//????????????
			bean.setPfAmount(index.getPfAmount());		
			//????????????
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//????????????
			bean.setPfDepartName(index.getDeptName());			
			//????????????
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean", bean);
		//????????????????????????
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		if("1".equals(bean.getFbidStauts())){
			//??????????????????????????????
			BiddingRegist br=processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
			model.addAttribute("br", br);
			//??????????????????????????????
			List<Attachment> brAttac = attachmentMng.list(br);
			model.addAttribute("brAttac", brAttac);
			//?????????????????????????????????????????????
			List<WinningBidder> fwbean = cgselMng.findByWid(br.getFpId());
			model.addAttribute("fwbean", fwbean);
			model.addAttribute("bidStauts", 0);//????????????  0??????
		}else{
			model.addAttribute("bidStauts", "");//????????????  ????????????
		}
				
		//??????????????????
		AcceptCheck acptbean=reciveMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		model.addAttribute("acptbean", acptbean);
		//???????????????????????????
		List<Attachment> reciveattac=attachmentMng.list(acptbean);
		model.addAttribute("reciveattac", reciveattac);
				
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
				
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(acptbean.getUserId(), "HWCGYS", acptbean.getfDepartId(), acptbean.getBeanCode(), acptbean.getnCode(), acptbean.getJoinTable(), acptbean.getBeanCodeField(), acptbean.getFacpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGYS", acptbean.getfDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//?????????????????????????????????
		Proposer proposer = new Proposer(acptbean.getFacpUsername(), acptbean.getfDepartName(), acptbean.getFacpTime());
		model.addAttribute("proposer", proposer);
		//????????????
		model.addAttribute("foCode", acptbean.getBeanCode());
		if(bean.getfItems().equals("A20")){
			model.addAttribute("fItems", "A20");
		}else{
			model.addAttribute("fItems", "");
		}
		TProcessDefin tProcessDefinCG=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
		model.addAttribute("fpIdCG", tProcessDefinCG.getFPId());
		//????????????
		model.addAttribute("foCodeCG",bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/receive/receive_detail";		
	}
	
	/**
	 * ??????????????????
	 * @param model
	 * @param response
	 * @param request
	 * @param cb
	 * @param upt
	 * @param currentYear
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/export",method=RequestMethod.POST)
	public String export(ModelMap model, HttpServletResponse response, HttpServletRequest request, PurchaseApplyBasic bean){
		OutputStream out = null;
		try {

			//??????excel?????????
			HSSFWorkbook workbook = null;
			//?????????
			response.setHeader("Content-Disposition","attachment; filename="+new String("????????????".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\????????????????????????.xls";
			Pagination p = cgsqMng.ledgerPageList(bean, 0, 10000, getUser());
			List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
			for(int x=0; x<li.size(); x++) {
				if("1".equals(li.get(x).getFbidStauts())){
					//????????????????????????
					BiddingRegist brList = processMng.getBiddingRegistByPId(li.get(x).getFpId());
					//?????????????????????  id????????????????????????  ????????????????????????????????????
					WinningBidder bwlist = cgselMng.findById(brList.getFwId());
					li.get(x).setfOrgName(bwlist.getFwName());
					li.get(x).setFbidAmount(brList.getFbidAmount());
				}
			}
			//??????excel?????????
			workbook = cgsqMng.exportExcel(li, filePath);
			
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
}

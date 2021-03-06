package com.braker.icontrol.expend.reimburse.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbAttacMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbDetailMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbDetail;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * ??????????????????????????????
 * @author ?????????
 * @createtime 2018-08-03
 * @updatetime 2018-08-03
 */
@Controller
@RequestMapping(value = "/directlyReimburse")
public class DirectlyReimburseController extends BaseController {
	
	@Autowired
	private TProExpendDetailMng detailMng;
	
	@Autowired
	private BudgetIndexMgrMng indexMng;
	
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	
	@Autowired
	private DirectlyReimbDetailMng directlyReimbDetailMng;
	
	@Autowired
	private DirectlyReimbPayeeMng directlyReimbPayeeMng;
	
	@Autowired
	private DirectlyReimbAttacMng directlyReimbAttacMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AuditInfoMng auditInfoMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;
	
	@Autowired
	private InvoiceMng invoiceMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;

	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private ReimbPayeeMng reimbPayeeMng;
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	
	
	
	
	
	
	
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-08-03
	 * @updatetime 2018-08-03
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly_reimburse_list";
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-03
	 * @updatetime 2018-08-03
	 */
	@RequestMapping(value = "/reimbursePage")
	@ResponseBody
	public JsonPagination applyPage(DirectlyReimbAppliBasicInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = directlyReimbMng.pageList(bean, page, rows, getUser());
		List<DirectlyReimbAppliBasicInfo> li = (List<DirectlyReimbAppliBasicInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//????????????	
			li.get(x).setNum((x+1)+(page-1)*rows);	
			//????????????????????????id????????????,?????????????????????
			User user = userMng.findById(li.get(x).getUser());
			li.get(x).setUserName(user.getName());
		}
		return getJsonPagination(p, page);
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-03
	 * @updatetime 2018-08-03
	 */
	@RequestMapping("/add")
	public String add(ModelMap model) {
		//??????????????????
		DirectlyReimbAppliBasicInfo bean = new DirectlyReimbAppliBasicInfo();
		User user = getUser();
		bean.setSummary(user.getName()+"-????????????-"+DateUtil.formatDate(new Date()));
		bean.setUserName(user.getName());
		bean.setUser(user.getId());
		bean.setDeptName(user.getDepartName());
		bean.setDept(user.getDpID());
		bean.setReqTime(new Date());
		model.addAttribute("bean", bean);
		
		/*//????????????????????????
		DirectlyReimbPayeeInfo payeeBean = new DirectlyReimbPayeeInfo();
		List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(user.getId());
		if(infoList.size()>0) {
			payeeBean.setPayeeIdCard((infoList.get(0).getPayeeIdCard()));//????????????
			payeeBean.setBank(infoList.get(0).getBank());//??????
			payeeBean.setBankAccount(infoList.get(0).getBankAccount());//????????????
			payeeBean.setZfbAccount(infoList.get(0).getZfbAccount());//???????????????
			payeeBean.setZfbQR(infoList.get(0).getZfbQR());//????????????????????????
			payeeBean.setWxAccount(infoList.get(0).getWxAccount());//????????????
			payeeBean.setWxQR(infoList.get(0).getWxQR());//?????????????????????
			payeeBean.setBankName(infoList.get(0).getBankName());//????????????
			payeeBean.setIdCard(infoList.get(0).getIdCard());//????????????
			payeeBean.setPayeeName(infoList.get(0).getPayeeName());//??????
			
		}
		model.addAttribute("payee", payeeBean);*/
		
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"ZJBX", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		model.addAttribute("detail", "add");
		return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly_reimburse_add2";
	}
	

	/*
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public JsonPagination mingxi(Integer id) {
		Pagination p = new Pagination();
		List<DirectlyReimbDetail> li = directlyReimbDetailMng.getMingxi(id);
		p.setList(li);
		return getJsonPagination(p, 0);
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	@RequestMapping(value = "/invoice")
	@ResponseBody
	public JsonPagination invoice(Integer id) {
		Pagination p = new Pagination();
		/*List<InvoiceInfo> list = invoiceMng.findByRID("1", id);
		
		for (int i = 0; i < list.size(); i++) {
			List<InvoiceCouponInfo> couponList = invoiceCouponMng.findByIID(list.get(i).getiId());
			list.get(i).setCouponList(couponList);
		}
		
		
		p.setList(list);*/
		return getJsonPagination(p, 0);
	}
	/*
	 * ????????????,????????????
	 * @author ?????????
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		//????????????id?????????
		try {
			DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(id);
			User user = userMng.findById(bean.getUser());
			//TProBasicInfo findById = tProBasicInfoMng.findById(bean.getIndexId());
			/*if (("0").equals(findById.getIfScientificPro())) {
				model.addAttribute("ifScientificPro", "0");
			}else {
				model.addAttribute("ifScientificPro", "1");
			}*/
			
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			
			model.addAttribute("bean", bean);
			model.addAttribute("expItemCode", bean.getEconomicCode());
			List<DirectlyReimbPayeeInfo> listDirectlyReimbPayeeInfo = directlyReimbPayeeMng.getByDrId(id);
			
			//??????????????????
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			
			List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getDrId(),"directly-1");
			model.addAttribute("Invoicelist", list1);//??????
			

			TProcessDefin tProcessDefin = null;
			//???????????????id
			if (("0").equals(bean.getIsconvention())) {
				 tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("BXTYLC", bean.getDept());
			}else {
				 tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", bean.getDept());
			}
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//????????????
			model.addAttribute("foCode",bean.getBeanCode());
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), user.getDepartName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			//????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
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
						bean.setPfDate(index.getYears());				
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
					bean.setPfDate(index.getYears());				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(index.getSyAmount());			
			}
			//??????????????????
			List<CostDetailInfo> cost =reimbAppliMng.findByDrId(bean.getDrId());
			Integer x=0;
			Integer y=0;
			for(int i = 0;i <cost.size();i++){
				y=y+1;
				List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
				for(int j = 0;j <fp.size();j++){
					x=x+1;
					fp.get(j).setNum(x);
				}
				cost.get(i).setCouponList(fp);
				cost.get(i).setNum(y);
			}
			Integer index =cost.size();
			model.addAttribute("x", x);
			model.addAttribute("y", y);
			model.addAttribute("index", index);
			model.addAttribute("cost", cost);
			
			//???????????????
//			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJBX", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getDrCode(),"1");
			TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
			if(1==pro.getFProOrBasic()){
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"ZJBX", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getDrCode(),"1",bean.getIndexId());
			}else if(0==pro.getFProOrBasic()){
				if (("0").equals(bean.getIsconvention())) {
					nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"BXTYLC", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getDrCode(),"1");

				}else {
					nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJBX", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getDrCode(),"1");
				}
			}
			
			if("0".equals(bean.getIfDeptIndex())){
				for (int i = 0; i < nodeConfList.size(); i++) {
					if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
						if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
							TProBasicInfo basicInfo = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
							User user2 = userMng.findById(basicInfo.getFProHeadId());
							nodeConfList.get(i).setText(user2.getName());
							nodeConfList.get(i).setUserId(user2.getId());
							nodeConfList.get(i).setUser(user2);
						}
					}
				}
			}
			
			model.addAttribute("nodeConf", nodeConfList);
			
			if(editType.equals("1")){
				model.addAttribute("detail", "2");
				return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly_reimburse_add2";
			} else if(editType.equals("0")){
				model.addAttribute("detail", "1");
				return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly_reimburse_detail";
			} else {
				return null;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return editType; 
	}
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	@RequestMapping("/edit1")
	public String edit1(Integer id, ModelMap model ,String editType) {
		//????????????id?????????
		DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(id);
		User user = userMng.findById(bean.getUser());
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		
		model.addAttribute("bean", bean);
		
		//?????????????????????
		DirectlyReimbPayeeInfo payeeBean = directlyReimbPayeeMng.getByDrId(id).get(0);
		List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(user.getId());
		if(infoList.size()>0) {
			payeeBean.setBank(infoList.get(0).getBank());//??????
			payeeBean.setBankAccount(infoList.get(0).getBankAccount());//????????????
			payeeBean.setZfbAccount(infoList.get(0).getZfbAccount());//???????????????
			payeeBean.setZfbQR(infoList.get(0).getZfbQR());//????????????????????????
			payeeBean.setWxAccount(infoList.get(0).getWxAccount());//????????????
			payeeBean.setWxQR(infoList.get(0).getWxQR());//?????????????????????
		}
		model.addAttribute("payee", payeeBean);
		
		/*		//??????????????????
		List<DirectlyReimbAttac> attac = directlyReimbAttacMng.getByDrId(id);
		model.addAttribute("attac", attac);*/
		
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		//?????????????????????????????????????????????????????????????????????
		String strStype = "ZJBX";
		if (("0").equals(bean.getIsconvention())) {
			strStype = "BXTYLC";
		}
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),strStype, bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),bean.getBeanCodeField(), bean.getDrCode(),"1",bean.getIndexId());
		model.addAttribute("nodeConf", nodeConfList);
		
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strStype, bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepartName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		if(editType.equals("1")){
			return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly_reimburse_add2";
		} else if(editType.equals("0")){
			model.addAttribute("detail", "1");
			return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly_reimburse_detail1";
		} else {
			return null;
		}
	}
	
	/*
	 * ??????????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(DirectlyReimbAppliBasicInfo bean, DirectlyReimbPayeeInfo payeeBean,String mingxi,String fapiao,
					   String files,String form1,String payerinfoJson,ModelMap model,String arry,
					   String payerinfoStudentJson,//??????????????????json
					   String payerinfoCCBJson,//??????????????????json
					   String payerinfoNoCCBJson//?????????????????????json
					   ) {
		Lock lock = new ReentrantLock();
		lock.lock();
		try {
			//???????????????????????????????????????????????????????????????
			/*User user = getUser();
			Depart depart = departMng.findById(user.getDepart().getId());
			User usera = userMng.findById(depart.getManager().getId());
			if(usera.getRoleName().contains("??????????????????")){
				bean.setIfCfo("???");
			}else{
				bean.setIfCfo("???");
			}
			if (bean.getAmount().compareTo(BigDecimal.valueOf(5000))>1) {
				return getJsonResult(false,"???????????????????????????5000???");
			}*/
			TProBasicInfo findById = tProBasicInfoMng.findById(bean.getIndexId());
			if(("0").equals(findById.getIfScientificPro())){
				if (StringUtils.isEmpty(bean.getTaskname())) {
					return getJsonResult(false,"???????????????????????????????????????????????????");
				}
			}
			//??????????????????????????????????????????
			Boolean b= true;
			if("1".equals(bean.getFlowStauts())){
				b = indexMng.checkAmounts(String.valueOf(bean.getProDetailId()), bean.getAmount());
				TProExpendDetail expendDetail = detailMng.findById(bean.getProDetailId());
				bean.setIndexAmount(expendDetail.getSyAmount().subtract(bean.getAmount()));
			}else{
				if(StringUtils.isNotEmpty(String.valueOf(bean.getProDetailId()))){
					TProExpendDetail expendDetail = detailMng.findById(bean.getProDetailId());
					bean.setIndexAmount(expendDetail.getSyAmount());
				}
			}
			if(b){
				directlyReimbMng.save1(bean, payeeBean,files, getUser(),mingxi,form1,payerinfoJson,payerinfoStudentJson,payerinfoCCBJson,payerinfoNoCCBJson);
			}else {
				lock.unlock();
				return getJsonResult(false,"???????????????????????????????????????????????????");
			}
		}catch (ServiceException e1) {
			e1.printStackTrace();
			return getJsonResult(false,e1.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}finally{
			lock.unlock();
			
		}
		return getJsonResult(true,"???????????????");
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//????????????id?????????
			directlyReimbMng.delete(id,fId,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	
	/**
	 * @Description: ??????????????????
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author ?????????
	 * @date 2019???10???8???
	 */
	@RequestMapping(value = "/directlyReimburseReCall")
	@ResponseBody
	public Result directlyReimburseReCall(Integer id) {
		try {
			//????????????id?????????
			directlyReimbMng.directlyReimbReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ???????????????id????????????????????????
	 * @param payerbean
	 * @param bean
	 * @param reimburseType
	 * @param model
	 * @param page
	 * @param rows
	 * @return
	 * @author ?????????
	 * @createtime 2020???5???9???
	 * @updator ?????????
	 * @updatetime 2020???5???9???
	 */
	@ResponseBody
	@RequestMapping(value = "/payerInfojson")
	public JsonPagination payerInfojson(ReimbPayeeInfo payerbean,ReimbAppliBasicInfo bean, String reimburseType, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
		Pagination p = new Pagination();
		List<ReimbPayeeInfo> list = reimbPayeeMng.getByDrId(payerbean.getDrId());
		p.setList(list);
		p.setPageNo(1);
		p.setPageSize(list.size());
		p.setTotalCount(list.size());
		return getJsonPagination(p, page);
	}
	
	/**
	 * ???????????????????????????
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = directlyReimbMng.getLookupsJson(parentCode, blanked,selected);
		return getComboboxJson(list,selected);
	}
	
	
	
	/**
	 * ???????????????????????????????????????????????????
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021???8???6???
	 */
	@RequestMapping("/directRimDetailDownload")
	@ResponseBody
	public Result directRimDetailDownload(HttpServletResponse response,String type) {
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String name = "??????????????????.xlsx";
			String filePath = path + "\\download\\"+name;
			if("ccb".equals(type)){
				name = "??????????????????.xlsx";
				filePath = path + "\\download\\"+name;
			}
			if("noCCB".equals(type)){
				name = "?????????????????????.xlsx";
				filePath = path + "\\download\\"+name;
			}
			File file = new File(filePath);
			if (file.exists()) {
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition",
						"attachment; filename=\""
								+ new String(name.getBytes("gbk"),
										"iso8859-1") + "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a;
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			} else {
				return getJsonResult(false, "??????????????????");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return getJsonResult(false, "????????????,?????????????????????");
		} finally {
			try {
				if (out != null)
					out.close();
				if (in != null)
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getJsonResult(true, "???????????????");
	}

	
	/**
	 * ????????????????????????????????????
	 * 
	 * @author zml
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/imputDetailJsp")
	public String imputDetailJsp(ModelMap model,String type,String tabId) {
		model.addAttribute("tabId", tabId);
		model.addAttribute("type", type);
		return "/WEB-INF/view/expend/reimburse/directly_reimburse/directly-reim-student-imput";
	}
	
	

	/**
	 * ???????????????????????????
	 * 
	 * @author ?????????
	 * @param xlsx
	 * @return
	 */
	@RequestMapping(value = "/directlyReimCollect")
	@ResponseBody
	public List<ReimbPayeeInfo> directlyReimCollect(MultipartFile xlsx,String type) {
		List<ReimbPayeeInfo> list = new ArrayList<ReimbPayeeInfo>();
		InputStream ins = null;
		OutputStream os = null;
		try {
			File f = null;
			if (xlsx.equals("") || xlsx.getSize() <= 0) {
				xlsx = null;
			} else {
				ins = xlsx.getInputStream();
				f = new File(xlsx.getOriginalFilename());
				os = new FileOutputStream(f);
				int bytesRead = 0;
				byte[] buffer = new byte[8192];
				while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
					os.write(buffer, 0, bytesRead);
				}
				File file = new File(f.toURI());
				list = directlyReimbMng.directlyReimCollect(file,type);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (ins != null) {
				try {
					ins.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return list;

	}
}

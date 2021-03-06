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
	 * ?????????
	 * @param fNewOrOld
	 * @param model
	 * @return
	 * @author ?????????
	 * @createTime2019???11???27???
	 * @updateTime2019???11???27???
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, String fNewOrOld){
		model.addAttribute("fNewOrOld", fNewOrOld);
		return "/WEB-INF/view/expend/refund/refund_list";
	}
	
	/**
	 * ????????????????????????
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 * @author ?????????
	 * @createTime2019???11???27???
	 * @updateTime2019???11???27???
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
	 * ?????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createTime2019???11???28???
	 * @updateTime2019???11???28???
	 */
	@RequestMapping("/add")
	public String add(ModelMap model, Integer fNewOrOld){
		User user = getUser();
		//????????????
		model.addAttribute("openType", "add");
		RefundInfo bean = new RefundInfo();
		//??????????????????
		bean.setfInfoCode(StringUtil.Random("TF"));
		//??????????????????????????????????????????????????????
		bean.setfUserId(user.getId());
		bean.setfUserName(user.getName());
		bean.setfDeptId(user.getDpID());
		bean.setfDeptName(user.getDepartName());
		bean.setfReqTime(new Date());
		bean.setfNewOrOld(fNewOrOld);
		model.addAttribute("bean", bean);
		
		if(fNewOrOld == 0){	//??????
			//???????????????
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(user.getId(), "XSTF", user.getDpID(), null, bean.getnCode(), null, null, null, null);
			model.addAttribute("nodeConf", nodeConfList);
			
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/expend/refund/newStudent/refund_add_new";
		}
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(user.getId(), "LSTF", user.getDpID(), null, bean.getnCode(), null, null, null, null);
		model.addAttribute("nodeConf", nodeConfList);
		
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/oldStudent/refund_add_old";
	}
	
	/**
	 * ??????
	 * @param model
	 * @param id ??????ID
	 * @return
	 * @author ?????????
	 * @createTime2019???11???28???
	 * @updateTime2019???11???28???
	 */
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model, @PathVariable String id){
		//????????????
		model.addAttribute("openType", "edit");
		
		//??????????????????
		RefundInfo bean = refundInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//????????????
		List<Attachment> refundAttaList = attachmentMng.list(bean);
		model.addAttribute("refundAttaList", refundAttaList);
		
		//????????????
		model.addAttribute("foCode", bean.getBeanCode());
		
		
		if(bean.getfNewOrOld() == 0){//??????
			//???????????????
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"XSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			
			//???????????????id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("XSTF", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			
			// ?????????????????????????????????
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/expend/refund/newStudent/refund_add_new";
		}
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"LSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("LSTF", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		// ?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/oldStudent/refund_add_old";
	}
	
	/**
	 * 
	 * @Description ??????
	 * @param @param model
	 * @param @param id
	 * @param @return
	 * @return String  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model, @PathVariable String id){
		//????????????
		model.addAttribute("openType", "detail");
		
		//??????????????????
		RefundInfo bean = refundInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//????????????
		List<Attachment> refundAttaList = attachmentMng.list(bean);
		model.addAttribute("refundAttaList", refundAttaList);
		
		//????????????
		model.addAttribute("foCode", bean.getBeanCode());
		
		//??????????????????
		String busiArea = null;	
		if(bean.getfNewOrOld() == 0){
			busiArea = "XSTF";	//????????????
		}else if(bean.getfNewOrOld() == 1){
			busiArea = "LSTF";	//????????????
		}
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),busiArea,bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		
		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		// ?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/refund_detail";
	}
	
	/**
	 * 
	 * @Description ??????
	 * @param @param id
	 * @param @return
	 * @return Result  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable Integer id) {
		try {
			refundInfoMng.delete(id);
		} catch (Exception e) {
			return getJsonResult(false, "????????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");	
	}
	
	/**
	 * 
	 * @Description ????????????
	 * @param @param id
	 * @param @return
	 * @return List<Object>  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public List<Object> mingxi(Integer id) {
		List<Object> mingxiList = new ArrayList<Object>();
		if(id != null) {		
			//??????????????????
			mingxiList = refundInfoMng.getMingxi("StudentRefundMoney", "fRId", id);
		}
		return mingxiList;
	}
	
	/**
	 * ??????????????????
	 * @param bean
	 * @param files
	 * @param mingxi
	 * @return
	 * @author ?????????
	 * @createTime2019???11???28???
	 * @updateTime2019???11???28???
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(RefundInfo bean, String files, String mingxi){
		try {
			refundInfoMng.save(bean, files, mingxi, getUser());
		} catch (Exception e) {
			return getJsonResult(false, "????????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * 
	 * @Description ??????????????????
	 * @param @param model
	 * @param @return
	 * @return String  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping(value = "/checkList")
	public String checkList(ModelMap model){
		return "/WEB-INF/view/expend/refund/refund_check_list";
	}
	
	/**
	 * 
	 * @Description ????????????
	 * @param @param model
	 * @param @param id
	 * @param @return
	 * @return String  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping("/check/{id}")
	public String check(ModelMap model, @PathVariable String id){
		//????????????
		model.addAttribute("openType", "check");
		
		//??????????????????
		RefundInfo bean = refundInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//????????????
		List<Attachment> refundAttaList = attachmentMng.list(bean);
		model.addAttribute("refundAttaList", refundAttaList);
		
		//????????????
		model.addAttribute("foCode", bean.getBeanCode());
		
		//??????????????????
		String busiArea = null;	
		if(bean.getfNewOrOld() == 0){
			busiArea = "XSTF";	//????????????
		}else if(bean.getfNewOrOld() == 1){
			busiArea = "LSTF";	//????????????
		}
		//???????????????
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),busiArea,bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);

		//???????????????id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
				
		// ?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/expend/refund/refund_check";
	}
	
	/**
	 * 
	 * @Description ????????????
	 * @param @param checkBean
	 * @param @param bean
	 * @param @param spjlFile
	 * @param @return
	 * @return Result  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean, RefundInfo bean, String spjlFile){
		try {
			refundInfoMng.saveCheck(checkBean, bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(true, "????????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * 
	 * @Description ??????????????????
	 * @param @param model
	 * @param @return
	 * @return String  
	 * @throws
	 * @author ??????
	 * @date 2019???12???3???
	 */
	@RequestMapping(value = "/ledgerList")
	public String ledgerList(ModelMap model){
		return "/WEB-INF/view/expend/refund/refund_ledger_list";
	}
	
	/**
	 * 
	 * <p>Title: export</p>  
	 * <p>Description: ?????????????????????</p>  
	 * @param model
	 * @param id RefundInfo??????id
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???2???
	 * @updator ?????????
	 * @updatetime 2020???12???2???
	 */
	@RequestMapping(value = "/export")
	public String export(ModelMap model, Integer id){
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			
			//??????????????????
			RefundInfo bean = refundInfoMng.findById(id);
			model.addAttribute("bean", bean);
			
			//??????????????????
			List<Object> mingxiList = refundInfoMng.getMingxi("StudentRefundMoney", "fRId", bean.getfRID());
			model.addAttribute("mingxiList",mingxiList);
			
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getfReqTime());     // ????????? X???X???X???
			model.addAttribute("time",time);
			
			//???????????????
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"LSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
			
			//???????????????id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("LSTF", bean.getfDeptId());
			//????????????
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
	 * <p>Description: ????????????????????????????????????</p>  
	 * @param model
	 * @param id StudentRefundMoney??????
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???3???
	 * @updator ?????????
	 * @updatetime 2020???12???3???
	 */
	@RequestMapping(value = "/studentExport")
	public String studentExport(ModelMap model, Integer id){
		
		try {
			StudentRefundMoney studentbean = refundMoneyMng.findById(id);
			RefundInfo bean = refundInfoMng.findById(studentbean.getfRId());
			model.addAttribute("bean", bean);
			model.addAttribute("studentbean", studentbean);
			
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getfReqTime());     // ????????? X???X???X???
			model.addAttribute("time",time);
			studentbean.setChineseSumMoney(MoneyUtil.toChinese(String.valueOf(studentbean.getSumMoney())));
			studentbean.setChinesePayedSumMoney(MoneyUtil.toChinese(String.valueOf(studentbean.getPayedTuition()+studentbean.getPayedRoom())));
			
			//???????????????
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getfUserId(),"LSTF",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"1");
			
			//???????????????id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("LSTF", bean.getfDeptId());
			//????????????
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
			
			if(0==bean.getfNewOrOld()){//??????
				return "/WEB-INF/view/expend/refund/export/newStudent";
			}else if(1==bean.getfNewOrOld()){//??????
				return "/WEB-INF/view/expend/refund/export/oldStudent";
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	/**
	 * ?????????????????????????????????
	 * @param id ????????????????????????
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
		//??????
		//??????????????????????????????
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
	 * ??????
	 * @param id ??????id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-10-08
	 * @updatetime 2018-10-08
	 */
	@ResponseBody
	@RequestMapping("/reCall")
	public Result reCall(String id,ModelMap model){
		try {
			refundInfoMng.reCall(id);
			return getJsonResult(true,"???????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
	}
}

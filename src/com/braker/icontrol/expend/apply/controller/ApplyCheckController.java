package com.braker.icontrol.expend.apply.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.expend.apply.manager.ApplyAttacMng;
import com.braker.icontrol.expend.apply.manager.ApplyCheckMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.history.manager.CheckHistoryMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * ??????????????????????????????
 * ???????????????????????????????????????????????????
 * @author ?????????
 * @createtime 2018-06-29
 * @updatetime 2018-06-29
 */
@Controller
@RequestMapping(value = "/applyCheck")
public class ApplyCheckController extends BaseController{
	@Autowired
	private ApplyCheckMng applyCheckMng;
	
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private RoleMng roleMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng itfMng;
	
	@Autowired
	private ApplyAttacMng attacMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private CheckHistoryMng checkHistoryMng;
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/apply/check/apply_check_list";
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/applyPage")
	@ResponseBody
	public JsonPagination applyPage(ApplicationBasicInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = applyMng.checkPageList(bean, page, rows, getUser());
		List<ApplicationBasicInfo> li = (List<ApplicationBasicInfo>) p.getList();
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
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/check")
	public String check(Integer id ,ModelMap model) {
		//????????????id?????????
		ApplicationBasicInfo bean = applyMng.findById(id);
		
		User user = userMng.findById(bean.getUser());
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setUserLevel(user.getRoleslevel());//???????????????
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
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
		
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		User user2 = getUser();
		if(user2.getRoleName().contains("????????????????????????????????????")){
			model.addAttribute("xzbgsFile", "xzbgsFile");
		}
		if(user2.getRoleName().contains("??????????????????????????????")){
			model.addAttribute("dwhFile", "dwhFile");
		}
		ReceptionAppliInfo receptionBean =new ReceptionAppliInfo();
		//??????????????????
		String type = bean.getType();
		if(type.equals("1")){
			//??????????????????????????????????????????????????????????????????
			if(getUser().getRoleName().contains("?????????")){
				model.addAttribute("checkUser", "1");
			}
		} else if(type.equals("2")) {
			//??????????????????
			MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", id);
			model.addAttribute("meetingBean", meetingBean);
					
		} else if(type.equals("3")) {
			//??????????????????
			TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", id);
			model.addAttribute("trainingBean", trainingBean);
					
		} else if(type.equals("4")) {
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", id);
			model.addAttribute("travelBean", travelBean);
					
		} else if(type.equals("5")) {
			//??????????????????
			receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", id);
			model.addAttribute("receptionBean", receptionBean);
			
		} else if(type.equals("6")) {
			//????????????????????????
			OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "gId", id);
			model.addAttribute("officeCar", officeBean);
			
		} else if(type.equals("7")) {
			//????????????????????????
			AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "gId", id);
			model.addAttribute("abroad", abroadBean);
			
		}else if(type.equals("12")) {
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", id);
			model.addAttribute("travelBean", travelBean);
					
		} 
		model.addAttribute("bean", bean);
		//??????type????????????
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(type));
		if("4".equals(String.valueOf(type))){
			//??????type????????????
			if (StringUtil.isEmpty(bean.getExpenditureType())) {
				strType = "CLSQ";
			}else{
				strType = bean.getExpenditureType();
			}
		}
		//???????????????
		List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
		if(type.equals("1")){
			if ("1".equals(bean.getFcostType())) {
				strType = "RYJFJBGZ";
			}
			if ("2".equals(bean.getFcostType())) {
				strType = "RYJFJX";
			}
			if ("3".equals(bean.getFcostType())) {
				strType = "TYSXSQ";
			}
			if ("4".equals(bean.getFcostType())) {
				strType = "BMRCBG";
			}
			if ("5".equals(bean.getFcostType())) {
				strType = "BMRCLW";
			}
			if ("6".equals(bean.getFcostType())) {
				strType = "YGCGSG";
			}
			if ("7".equals(bean.getFcostType())) {
				strType = "YGCGKY";
			}
			if ("8".equals(bean.getFcostType())) {
				TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());
				if ("1".equals(basicInfo.getIfScientificPro())) {
					strType = "KYJF";
				}else {
					strType = "JYJF";
				}
			}
			if ("9".equals(bean.getFcostType())) {
				strType = "QTGYJF";
			}
		}
		//??????????????????
		String historyNodes=tProcessCheckMng.getHistoryNodes(strType,bean.getDept(),bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
		for (int i = 0; i < nodeConfList.size(); i++) {
			if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
				if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
					if (("KYJF").equals(strType) || ("JYJF").equals(strType)) {
						TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());//??????????????????????????????????????????????????????id???????????????????????????????????????
						User user3 = userMng.findById(Integer.valueOf(basicInfo.getFProHeadId()));
						nodeConfList.get(i).setText(user3.getName());
						nodeConfList.get(i).setUserId(user3.getId());
						nodeConfList.get(i).setUser(user3);
					}else {
						TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());//??????????????????????????????????????????????????????id???????????????????????????????????????
						User user3 = userMng.getUserByRoleNameAndDepartName("???????????????", basicInfo.getFProAppliDepart());
						nodeConfList.get(i).setText(user3.getName()+"|?????????????????????????????????");
						nodeConfList.get(i).setUserId(user3.getId());
						nodeConfList.get(i).setUser(user3);
					}
				}
			}
		}
		model.addAttribute("nodeConf", nodeConfList);

				
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());	

		model.addAttribute("type", bean.getType());
		model.addAttribute("detail", "0");
		if("2".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_meeting";
		}else if("3".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_train";
		}else if("4".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_travel";
		}else if("5".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_reception";
		}else if("6".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_car";
		}else if("7".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_abroad";
		}else if("12".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_attend_train";
		}else if("13".equals(bean.getType())){
			return "/WEB-INF/view/expend/apply/check/apply_check_travel_city";
		}else{
			return "/WEB-INF/view/expend/apply/check/apply_check";
		}
	}
	
	/*
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-07-05
	 * @updatetime 2018-07-05
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,ApplicationBasicInfo bean,String spjlFile,String xzbgsfiles,String dwhfiles) {
		try {
			List<Role> roleli = userMng.getUserRole(getUser().getId());
			ApplicationBasicInfo oldbean = applyMng.findById(bean.getgId());
			oldbean.setMeetingSummaryTime1(bean.getMeetingSummaryTime1());
			oldbean.setMeetingSummaryTime2(bean.getMeetingSummaryTime2());
			oldbean.setMeetingSummaryYear1(bean.getMeetingSummaryYear1());
			oldbean.setMeetingSummaryYear2(bean.getMeetingSummaryYear2());
			attachmentMng.joinEntity(oldbean,xzbgsfiles);
			attachmentMng.joinEntity(oldbean,dwhfiles);
			List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "gId", oldbean.getgId());
			applyCheckMng.saveCheckInfo(checkBean, oldbean, mingxiList, getUser(), roleli.get(0), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 */
	@RequestMapping(value = "/history/{id}")
	@ResponseBody
	public JsonPagination checkHistory(@PathVariable Integer id, ModelMap model) {
		Pagination p = new Pagination();
		if(id != null) {
			//????????????id?????????
			ApplicationBasicInfo bean = applyMng.findById(id);
			p.setList(checkHistoryMng.findCheckHistorys(bean.getType(),bean.getBeanCode(),null));
		}
		return getJsonPagination(p, 0);
	}
}

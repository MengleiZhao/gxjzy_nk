package com.braker.icontrol.contract.Formulation.manager.Impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.Formulation.model.ContractPlanList;
import com.braker.icontrol.contract.approval.manager.CheckInfoMng;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.Attac;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class FormulationMngImpl extends BaseManagerImpl<ContractBasicInfo> implements FormulationMng {

	@Autowired
	private CheckInfoMng checkInfoMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private CgApplysqMng applysqMng;
	@Autowired
	private CgConPlanListMng cgConPlanListMng;
	
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	
	@Autowired
	private CgProcessMng processMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	
	@Override
	public Pagination queryList(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE (fFlowStauts='0' or fFlowStauts='1' or fFlowStauts='-4' or fFlowStauts='9' or fFlowStauts='-1') AND fContStauts <> '99' AND (fhttype = '0' or fhttype is null) ");
		finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getName());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append(" AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append(" AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfFlowStauts())){
			/*if(contractBasicInfo.getfFlowStauts().equals("??????")){
				contractBasicInfo.setfFlowStauts("0");
			}
			if(contractBasicInfo.getfFlowStauts().equals("?????????")){
				contractBasicInfo.setfFlowStauts("1");
			}*/
			finder.append(" AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append(" AND fcAmount LIKE :fcAmount");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountBegin()))){
			finder.append(" AND fcAmount >='"+contractBasicInfo.getcAmountBegin()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountEnd()))){
			finder.append(" AND fcAmount <='"+contractBasicInfo.getcAmountEnd()+"'");
		}
		/*if(contractBasicInfo.getfReqtIME()!=null){
			finder.append(" and datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0 ");
		}*/
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getfPurchNo()))){
			finder.append(" AND fPurchNo = '"+contractBasicInfo.getfPurchNo()+"'");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	public Pagination queryListbg(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE (fFlowStauts='0' or fFlowStauts='1' or fFlowStauts='-4' or fFlowStauts='9' or fFlowStauts='-1') AND fContStauts <> '99' AND fhttype = '1' ");
		finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getName());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append(" AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append(" AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfFlowStauts())){
			/*if(contractBasicInfo.getfFlowStauts().equals("??????")){
				contractBasicInfo.setfFlowStauts("0");
			}
			if(contractBasicInfo.getfFlowStauts().equals("?????????")){
				contractBasicInfo.setfFlowStauts("1");
			}*/
			finder.append(" AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append(" AND fcAmount LIKE :fcAmount");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountBegin()))){
			finder.append(" AND fcAmount >='"+contractBasicInfo.getcAmountBegin()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountEnd()))){
			finder.append(" AND fcAmount <='"+contractBasicInfo.getcAmountEnd()+"'");
		}
		/*if(contractBasicInfo.getfReqtIME()!=null){
			finder.append(" and datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0 ");
		}*/
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getfPurchNo()))){
			finder.append(" AND fPurchNo = '"+contractBasicInfo.getfPurchNo()+"'");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public void save_CBI(ContractBasicInfo contractBasicInfo, User user, String files, SignInfo signInfo, String htwbfiles, String planJson,String mingxi,String proceedsJson) throws Exception{
		String aa = String.valueOf(contractBasicInfo.getFcId());
		if(StringUtil.isEmpty(aa) || aa=="null"){
			//???????????????id
			contractBasicInfo.setfOperatorId(user.getId());
			//??????????????????????????????????????????????????????????????????????????????
			if(StringUtil.isEmpty(contractBasicInfo.getfOperator())){
				contractBasicInfo.setfOperator(user.getAccountNo());
			}
			if ( null != contractBasicInfo.getfDeptName()) {
				String replaceAll = contractBasicInfo.getfDeptName().replaceAll(",", "");
				contractBasicInfo.setfDeptName(replaceAll);
			}
			//????????????????????????????????????????????????????????????????????????
			if(StringUtil.isEmpty(contractBasicInfo.getfDeptName())){
				contractBasicInfo.setfDeptName(user.getDepart().getName());
			}
			if(contractBasicInfo.getFcType().equals("HTFL-03")){
				contractBasicInfo.setFcAmount("100000");//?????????????????????????????????????????????
			}
			contractBasicInfo.setfDeptId(user.getDepart().getId());
			//????????????????????????1?????????
			contractBasicInfo.setfContStauts("1");
			//????????????
			contractBasicInfo.setfReqtIME(new Date());
			//???????????????????????????
			contractBasicInfo.setfPayStauts("0");
			//???????????????????????????
			contractBasicInfo.setCreator(user.getAccountNo());
			contractBasicInfo.setCreateTime(new Date());
			//???????????????????????????
			String fcCode=getFcCode();
			contractBasicInfo.setFcCode(fcCode);
			contractBasicInfo.setFhttype("0");
			if ( null != contractBasicInfo.getfRemark()) {
				String fRemark = contractBasicInfo.getfRemark().replaceAll(",", "");
				contractBasicInfo.setfRemark(fRemark);
			}
			
		}else{
			if(StringUtil.isEmpty(contractBasicInfo.getfOperator())){
				contractBasicInfo.setfOperator(user.getAccountNo());
				contractBasicInfo.setfOperatorId(user.getId());
			}
			if ( null != contractBasicInfo.getfDeptName()) {
				String replaceAll = contractBasicInfo.getfDeptName().replaceAll(",", "");
				contractBasicInfo.setfDeptName(replaceAll);
			}
			//????????????????????????????????????????????????????????????????????????
			if(StringUtil.isEmpty(contractBasicInfo.getfDeptName())){
				contractBasicInfo.setfDeptName(user.getDepart().getName());
			}
			if(contractBasicInfo.getFcType().equals("HTFL-03")){
				contractBasicInfo.setFcAmount("100000");//?????????????????????????????????????????????
			}
			if ( null != contractBasicInfo.getfRemark()) {
				String fRemark = contractBasicInfo.getfRemark().replaceAll(",", "");
				contractBasicInfo.setfRemark(fRemark);
			}
			contractBasicInfo.setfDeptId(user.getDepart().getId());
			contractBasicInfo.setfContStauts("1");
			contractBasicInfo.setUpdator(user.getAccountNo());
			contractBasicInfo.setUpdateTime(new Date());
			//????????????
			contractBasicInfo.setfReqtIME(new Date());
			contractBasicInfo.setFhttype("0");
		}
		//Lookups fContStyle = lookupsMng.findByLookCode(contractBasicInfo.getfContStyle().getCode());
		/*if(!"HTFL-03".equals(contractBasicInfo.getFcType()) || !"HTFL-02".equals(contractBasicInfo.getFcType())){
			Lookups fPayType = lookupsMng.findByLookCode(contractBasicInfo.getfPayType().getCode());
			contractBasicInfo.setfPayType(fPayType);
			contractBasicInfo.setIfFjjht(0);//?????????????????????
		}else{
			contractBasicInfo.setIfFjjht(1);//?????????????????????
		}*/
		//?????????????????? 
		//contractBasicInfo.setfContStyle(fContStyle);
		//????????????????????????
		if(!StringUtil.isEmpty(contractBasicInfo.getAssisDeptId())){
			contractBasicInfo.setAssisDeptName(departMng.findById(contractBasicInfo.getAssisDeptId()).getId());
		}else{
			contractBasicInfo.setAssisDeptName(null);
		}
		//??????????????????
		contractBasicInfo.setFsealedStatus(0);
		//?????????????????? 
		contractBasicInfo = (ContractBasicInfo) super.merge(contractBasicInfo);
		if(contractBasicInfo.getfFlowStauts().equals("1")){
			
			//???????????????????????????key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),contractBasicInfo.getJoinTable(),contractBasicInfo.getBeanCodeField(),contractBasicInfo.getBeanCode(), "HTND", user);
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			//??????????????????id
			User fzuser=userMng.getUserByRoleNameAndDepartName("???????????????", contractBasicInfo.getfDeptName());
			/*//???????????????????????????
			if(fzuser.getId().equals(node.getUserId())){
				//?????????????????????????????????????????????????????????????????????
				node=tProcessCheckMng.getNextCheckKey( node, contractBasicInfo.getJoinTable(),contractBasicInfo.getBeanCodeField(),contractBasicInfo.getBeanCode(), "1");
			}*/
			
			User nextUser=userMng.findById(node.getUserId());
			//?????????????????????????????????????????????????????????????????????/??????
			contractBasicInfo.setfUserCode(nextUser.getId());
			contractBasicInfo.setfUserName(nextUser.getName());
			//???????????????????????????
			contractBasicInfo.setfNCode(firstKey+"");
			//????????????????????????????????????1?????????????????????
			tProcessCheckMng.updateStauts(flowId,contractBasicInfo.getBeanCode());
			//???????????????????????????????????????
			PersonalWork work = new PersonalWork();
			work.setUserId(contractBasicInfo.getfUserCode());//???????????????ID????????????????????????ID
			work.setTaskId(contractBasicInfo.getFcId());//?????????ID
			work.setTaskCode(contractBasicInfo.getFcCode());//?????????????????????
			work.setTaskName("[????????????]"+contractBasicInfo.getFcTitle());//????????????????????????????????????+?????????????????????????????????????????????
			work.setUrl("/Approval/approveList/"+contractBasicInfo.getFcId());//??????????????????????????????url,???????????????????????????????????????
			work.setUrl1("/Formulation/detail/"+ contractBasicInfo.getFcId());//??????url
			work.setTaskStauts("0");//??????
			work.setType("1");//???????????????1-??????
			work.setBeforeUser(user.getName());//?????????????????????
			work.setBeforeDepart(user.getDepartName());//?????????????????????????????????
			work.setBeforeTime(new Date());//??????????????????
			personalWorkMng.merge(work);
			//?????????????????????????????????
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//???????????????ID????????????????????????ID
			minwork.setTaskId(contractBasicInfo.getFcId());//?????????ID
			minwork.setTaskCode(contractBasicInfo.getFcCode());//?????????????????????
			minwork.setTaskName("[????????????]"+contractBasicInfo.getFcTitle());//????????????????????????????????????+?????????????????????????????????????????????
			minwork.setUrl("/Formulation/edit/"+contractBasicInfo.getFcId());//????????????url
			minwork.setUrl1("/Formulation/detail/"+ contractBasicInfo.getFcId());//??????url
			minwork.setUrl2("/Formulation/delete/"+ contractBasicInfo.getFcId());//????????????url
			minwork.setTaskStauts("2");//??????
			minwork.setType("2");//???????????????2-??????
			minwork.setBeforeUser(user.getName());//?????????????????????
			minwork.setBeforeDepart(user.getDepartName());//?????????????????????????????????
			minwork.setBeforeTime(new Date());//??????????????????
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
		attachmentMng.joinEntity(contractBasicInfo,files);
		attachmentMng.joinEntity(contractBasicInfo,htwbfiles);
		contractBasicInfo.setUpdator(user.getName());
		merge(contractBasicInfo);
		//??????????????????
		//????????????????????????????????????????????????????????????
		if("HTFL-01".equals(contractBasicInfo.getFcType())){
			if(contractBasicInfo.getfFlowStauts().equals("1")){
				PurchaseApplyBasic applyBasic = applysqMng.findById(Integer.valueOf(contractBasicInfo.getfPurchNo()));
				if(applyBasic!=null){
					if("1".equals(applyBasic.getfContractSts()) || "2".equals(applyBasic.getfContractSts())){
						throw new ServiceException("?????????????????????????????????????????????????????????????????????");
					}
					applyBasic.setfContractSts("1");
					applyBasic.setfHtCode(contractBasicInfo.getFcCode());
					applysqMng.saveOrUpdate(applyBasic);
				}
			}
			
			//??????json??????
			if (StringUtils.isNotEmpty(planJson)) {
				List<DataEntity> list2 =(List<DataEntity>)JSONArray.toList(JSONArray.fromObject(planJson), DataEntity.class);
				//?????????ReceivPlan?????????list
				List<ReceivPlan> receivPlan = filingMng.getReceivPlan(list2, user, contractBasicInfo);
				List<ReceivPlan> Plan = filingMng.find_ReceivPlan_List(String.valueOf(contractBasicInfo.getFcId()));
				//?????????????????????
				if(Plan.size()>0){
					for (int i = 0; i < Plan.size(); i++) {
						receivPlanMng.deleteById(Plan.get(i).getfPlanId());
					}
				}
				//??????????????????????????????????????????
				if(receivPlan.size()>0){
					for (int i = 0; i < receivPlan.size(); i++) {
						receivPlan.get(i).setfUpateTime_R(new Date());
						receivPlan.get(i).setPayStauts(null);
						receivPlan.get(i).setfUpateUser_R(user.getAccountNo());
						receivPlan.get(i).setfContId_R(contractBasicInfo.getFcId());
						receivPlan.get(i).setDataType(0);//????????????
						receivPlanMng.merge(receivPlan.get(i));
					}
				}else if(Plan.size()==0){
					filingMng.save_ReceivPlan(receivPlan);
				}
			}
			
			//??????????????????   ?????????
			getSession().createSQLQuery("delete from T_CONTRACT_PLAN_LIST where F_P_ID ="+contractBasicInfo.getFcId()+" and F_TYPE=0").executeUpdate();
				if(!StringUtil.isEmpty(mingxi)){
				//??????Json??????
				List<ContractPlanList> ContractPlanLists = JSON.parseObject("["+mingxi.toString()+"]",new TypeReference<List<ContractPlanList>>(){});
				for (ContractPlanList contractPlanList: ContractPlanLists) {
					ContractPlanList info = new ContractPlanList();
					info.setMainId(contractPlanList.getMainId());
					info.setFplId(contractPlanList.getFplId());
					info.setFpId(contractPlanList.getFpId());
					info.setFconId(contractBasicInfo.getFcId());
					info.setFpurCode(contractPlanList.getFpurCode());
					info.setfIsImp(contractPlanList.getfIsImp());
					info.setfSiteAndPeriod(contractPlanList.getfSiteAndPeriod());
					info.setfManager(contractPlanList.getfManager());
					info.setFpurName(contractPlanList.getFpurName());
					info.setFpurBrand(contractPlanList.getFpurBrand());
					info.setfModel(contractPlanList.getfModel());
					info.setFspec(contractPlanList.getFspec());
					info.setFmeasureUnit(contractPlanList.getFmeasureUnit());
					info.setFnum(contractPlanList.getFnum());
					info.setFunitPrice(contractPlanList.getFunitPrice());
					info.setFsumMoney(contractPlanList.getFsumMoney());
					info.setfIfEdit(contractPlanList.getfIfEdit());
					info.setfType("0");
					super.merge(info);
				}
			}
		}
		if("HTFL-02".equals(contractBasicInfo.getFcType())){
			//??????????????????   ?????????
			if (StringUtils.isNotEmpty(proceedsJson)){
				getSession().createSQLQuery("delete from T_PROCEEDS_PLAN where F_CONT_ID ="+contractBasicInfo.getFcId()+" and F_DATA_TYPE=0").executeUpdate();
				if(!StringUtil.isEmpty(proceedsJson)){
					//??????Json??????
					List<ProceedsPlan> proceedsPlans = JSON.parseObject(proceedsJson,new TypeReference<List<ProceedsPlan>>(){});
					for (ProceedsPlan proceedsPlan: proceedsPlans) {
						ProceedsPlan info = new ProceedsPlan();
						//List<Lookups> lookupsJson = getLookupName(proceedsPlan.getfProceedsProperty());
						info.setfContId(contractBasicInfo.getFcId());
						info.setfProceedsProperty(proceedsPlan.getfProceedsProperty());
						info.setfProceedsCondition(proceedsPlan.getfProceedsCondition());
						info.setfProceedsTime(proceedsPlan.getfProceedsTime());
						info.setfProceedsAmount(proceedsPlan.getfProceedsAmount());
						info.setDataType(0);
						super.merge(info);
					}
				}
			}
		}
		List<String> files0 = new ArrayList<String>();
		/*files0.add(htwbfiles);*/
		filingMng.save_SignInfo(signInfo, user, contractBasicInfo, files0);
		
	}

	@Override
	public void delete_CBI(String fcId,User user) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sql="UPDATE T_CONTRACT_BASIC_INFO SET F_CONT_STAUTS='99',F_UPDATE_USER='"+user.getAccountNo()+"', F_UPDATE_TIME='"+sdf.format(new Date())+"'  WHERE F_CONT_ID ='"+fcId+"'";
		Query  contStauts=getSession().createSQLQuery(sql);
		contStauts.executeUpdate();
		//???????????????????????????
		ContractBasicInfo cbi = findById(Integer.valueOf(fcId));
		List<PersonalWork> worklost = personalWorkMng.findByCodeAndUser(cbi.getFcCode(), userMng.findById(cbi.getfOperatorId()));
		if(worklost.size()>0){
			for (int i = 0; i < worklost.size(); i++) {
				personalWorkMng.deleteById(Integer.valueOf(worklost.get(i).getfId()));
			}
		}
	}

	@Override
	public void save_attac(ContractBasicInfo contractBasicInfo,List<Attac> at, User user) {
		Query query =getSession().createSQLQuery("DELETE FROM T_CONTRACT_ATTAC WHERE F_CONT_CODE='"+contractBasicInfo.getFcCode()+"' AND F_ATTAC_TYPE='4'");
		query.executeUpdate();
		for (int i = 0; i < at.size(); i++) {
			if(!StringUtil.isEmpty(at.get(i).getfAttacName())){
				at.get(i).setfContId(contractBasicInfo.getFcId());
				at.get(i).setfContCode_A(contractBasicInfo.getFcCode());
				//????????????????????????
				at.get(i).setfAttacType("4");
				at.get(i).setfUploadTime(new Date());
				at.get(i).setfUpdateUser(user.getAccountNo());
				at.get(i).setfUpdateTime(new Date());
				super.saveOrUpdate(at.get(i));
			}
		}
	}
	
	@Override
	public List<Attac> findAttac(Integer id){
		Finder finder =Finder.create(" FROM Attac WHERE fAttacType='4' AND fContId="+id);
		return super.find(finder);
	}

	@Override
	public List<Attac> findAttacByName(String name) {
		Finder finder = Finder.create(" FROM Attac WHERE fAttacName='"+name+"'");
		return  super.find(finder);
	}

	@Override
	public void deleteAttac(List<Attac> attac) {
		for (int i = 0; i < attac.size(); i++) {
			super.delete(attac.get(i));
		}
	}
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked,String selected) {
		Finder hql=Finder.create("FROM Lookups WHERE flag='1' ");
		hql.append("  AND category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" AND code<>:code").setParam("code", blanked);
		}
		hql.append(" ORDER BY convert(orderNo,SIGNED)");
		return super.find(hql);
	}

	@Override
	public List<Lookups> getLookupName(String categoryCode) {
		Finder hql=Finder.create("FROM Lookups WHERE PID = '"+categoryCode+"'");
		return super.find(hql);
	}
	
	@Override
	public ContractBasicInfo findAttacByFPurchNo(String fPurchNo) {
		Finder finder=Finder.create(" FROM ContractBasicInfo WHERE fPurchNo='"+fPurchNo+"' and fContStauts <>99");
		List<ContractBasicInfo> list= super.find(finder);
		if(list==null || list.size()==0){
			return new ContractBasicInfo();
		}else{
			return (ContractBasicInfo) super.find(finder).get(0);
		}
	}

	@Override
	public Pagination find(ContractBasicInfo cbi,User user,Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM ContractBasicInfo WHERE fContStauts not in(-1,99) AND fFlowStauts='9'");
		finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getName());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		if(!StringUtil.isEmpty(cbi.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+cbi.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(cbi.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+cbi.getFcTitle()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public Pagination queryForChange(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE (fFlowStauts='9' "
				+ "AND fContStauts <> '99' AND fContStauts <> '-1' AND "
				+ "(fUpdateStatus='0' OR fUpdateStatus is null ) and fUpdateStatus = '0' and fhttype = '0') or "
				+ "(fFlowStauts='9' "
				+ "AND fContStauts <> '99' AND fContStauts <> '-1' AND "
				+ "(fUpdateStatus='0' OR fUpdateStatus is null ) and fhttype = '1') ");
		finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getName());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfFlowStauts())){
			finder.append("AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	
	@Override
	public Pagination queryForChangejf(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <> '99' AND fContStauts <> '-1'  AND fsealedStatus='1'");
		List<Role> roleList=user.getRoles();
		ArrayList<String> list = new ArrayList<>();
		for (Role role : roleList) {
			list.add(role.getName());
		}
		boolean b = list.contains("???????????????");
		if (b) {
			finder.append(" AND (F_DISPUTE_STATUS <> '1' or F_DISPUTE_STATUS is null) ");
		}else {
				finder.append("AND fOperator =:fOperator ");
				finder.setParam("fOperator", user.getName());
				finder.append("AND fDeptName =:fDeptName ");
				finder.setParam("fDeptName", user.getDepart().getName());
				finder.append(" AND (F_DISPUTE_STATUS <> '1' or F_DISPUTE_STATUS is null) ");
			}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfFlowStauts())){
			finder.append("AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Pagination queryForEnding(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <> (99,5)");
		finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getName());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfFlowStauts())){
			finder.append("AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountBegin()))){
			finder.append(" AND fcAmount >='"+contractBasicInfo.getcAmountBegin()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountEnd()))){
			finder.append(" AND fcAmount <='"+contractBasicInfo.getcAmountEnd()+"'");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public String reCall(String id) {
		// TODO Auto-generated method stub
		ContractBasicInfo bean = super.findById(Integer.valueOf(id));
		//????????????
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//???????????????????????????
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="?????????????????????????????????";
		String msg="??????????????????  "+bean.getFcTitle() +",???????????????("+bean.getBeanCode()+")???"+sdf.format(new Date())+"??????????????????,???????????????.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//??????
		bean=(ContractBasicInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		
		if("HTFL-01".equals(bean.getFcType())){
			PurchaseApplyBasic applyBasic = applysqMng.findById(Integer.valueOf(bean.getfPurchNo()));
			if(applyBasic!=null){
				applyBasic.setfContractSts(null);
				applysqMng.saveOrUpdate(applyBasic);
			}
		}
		return "????????????";
	}
	/**
	 * 
	* @author:??????
	* @Title: getFcCode 
	* @Description: ??????????????????
	* @return
	* @return String    ???????????? 
	* @date??? 2020???1???6?????????8:30:40 
	* @throws
	 */
	@Override
	public String getFcCode(){
		Finder finder =Finder.create(" FROM ContractBasicInfo where year(fReqtIME) = year(now())");
		int num= super.countQueryResult(finder);
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String fcCode="HT"+format.format(new Date())+StringUtil.autoGenericCode(num+"",4);
		return fcCode;
	}

	@Override
	public Pagination queryContraList(ContractBasicInfo contractBasicInfo,
			User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE (fFlowStauts='0' or fFlowStauts='1' or fFlowStauts='-4' or fFlowStauts='9' or fFlowStauts='-1') AND fContStauts <> '99'");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append(" AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append(" AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfFlowStauts())){
			finder.append(" AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public List<Object> registerOrApplymingxi(String id) {
		PurchaseApplyBasic purchaseApplyBasic = applysqMng.findById(Integer.valueOf(id));
		String type = "";
		String pId = "";
		String idName = "";
		List<Object> mingxiList =new ArrayList<Object>();
		if("1".equals(purchaseApplyBasic.getFbidStauts())){
			//??????????????????????????????
			BiddingRegist br = processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
			type = "2";
			pId = br.getFbId().toString();
			idName = "fbId";
		}else{
			type = "1";
			pId = id;
			idName = "fpId";
		}
		List<PurchaseApplyBasic> list = cgConPlanListMng.findbyIdPurchase(id);
		for (PurchaseApplyBasic purchaseApply : list) {
			/*String IfEdit = "";
			if("2".equals(type)){
				IfEdit = "0";//????????????????????????   0???????????????
			}else{
				IfEdit = "1";//????????????????????????   1????????????
			}*/
			//procurementPlanList.setfIfEdit(IfEdit);
			mingxiList.add(purchaseApply);
		}
		return mingxiList;
	}
	@Override
	public WinningBidder registerWinning(String id) {
		PurchaseApplyBasic purchaseApplyBasic = applysqMng.findById(Integer.valueOf(id));
		WinningBidder bwlist = null;
		if(purchaseApplyBasic.getFpAmount().compareTo(BigDecimal.valueOf(10000))>-1){
			//??????????????????????????????
			BiddingRegist br = processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
			
			//?????????????????????  id????????????????????????  ????????????????????????????????????
			bwlist = cgselMng.findById(br.getFwId());
		}
		
		return bwlist;
	}
	
	@Override
	public WinningBidder getGys(String id) {
		//?????????????????????  id????????????????????????  ????????????????????????????????????
		WinningBidder bwlist = cgselMng.findById(Integer.valueOf(id));
		return bwlist;
	}
	
	@Override
	public void save_CBIBG(ContractBasicInfo contractBasicInfo, User user, String files, SignInfo signInfo, String htwbfiles, String planJson,String mingxi,String proceedsJson,String openType) throws Exception{
		String aa = String.valueOf(contractBasicInfo.getFcId());
		if (openType.equals("Cadd")) {
			getSession().createSQLQuery("UPDATE T_CONTRACT_BASIC_INFO SET F_UPDATE_STATUS = '1' WHERE F_CONT_ID ="+aa).executeUpdate();
			contractBasicInfo.setFcId(null);
			signInfo.setfSignId(null);
		}
		//if (null == fhttype || ("0").equals(fhttype)) {
		//}
		if(openType.equals("Cadd")){
			//???????????????id
			contractBasicInfo.setfOperatorId(user.getId());
			//??????????????????????????????????????????????????????????????????????????????
			if(StringUtil.isEmpty(contractBasicInfo.getfOperator())){
				contractBasicInfo.setfOperator(user.getAccountNo());
			}
			//????????????????????????????????????????????????????????????????????????
			if ( null != contractBasicInfo.getfDeptName()) {
				String replaceAll = contractBasicInfo.getfDeptName().replaceAll(",", "");
				contractBasicInfo.setfDeptName(replaceAll);
			}
			/*if(StringUtil.isEmpty(contractBasicInfo.getfDeptName())){
				contractBasicInfo.setfDeptName(user.getDepart().getName());
			}*/
			if(contractBasicInfo.getFcType().equals("HTFL-03")){
				contractBasicInfo.setFcAmount("100000");//?????????????????????????????????????????????
			}
			contractBasicInfo.setfDeptId(user.getDepart().getId());
			//????????????????????????1?????????
			contractBasicInfo.setfContStauts("1");
			//????????????
			contractBasicInfo.setfReqtIME(new Date());
			//???????????????????????????
			contractBasicInfo.setfPayStauts("0");
			//???????????????????????????
			contractBasicInfo.setCreator(user.getAccountNo());
			contractBasicInfo.setCreateTime(new Date());
			//???????????????????????????
			//String fcCode=getFcCode();
			contractBasicInfo.setFcCode(contractBasicInfo.getFcCode());
			//?????????????????????????????????
			contractBasicInfo.setFhttype("1");
			contractBasicInfo.setFyhtid(Integer.valueOf(aa));
			if ( null != contractBasicInfo.getfRemark()) {
				String fRemark = contractBasicInfo.getfRemark().replaceAll(",", "");
				contractBasicInfo.setfRemark(fRemark);
			}

		}else{
			if(StringUtil.isEmpty(contractBasicInfo.getfOperator())){
				contractBasicInfo.setfOperator(user.getAccountNo());
				contractBasicInfo.setfOperatorId(user.getId());
			}
			//????????????????????????????????????????????????????????????????????????
			if ( null != contractBasicInfo.getfDeptName()) {
				String replaceAll = contractBasicInfo.getfDeptName().replaceAll(",", "");
				contractBasicInfo.setfDeptName(replaceAll);
			}
			if(StringUtil.isEmpty(contractBasicInfo.getfDeptName())){
				contractBasicInfo.setfDeptName(user.getDepart().getName());
			}
			if(contractBasicInfo.getFcType().equals("HTFL-03")){
				contractBasicInfo.setFcAmount("100000");//?????????????????????????????????????????????
			}
			if ( null != contractBasicInfo.getfRemark()) {
				String fRemark = contractBasicInfo.getfRemark().replaceAll(",", "");
				contractBasicInfo.setfRemark(fRemark);
			}
			contractBasicInfo.setfDeptId(user.getDepart().getId());
			contractBasicInfo.setfContStauts("1");
			contractBasicInfo.setUpdator(user.getAccountNo());
			contractBasicInfo.setUpdateTime(new Date());
			//????????????
			contractBasicInfo.setfReqtIME(new Date());
		}
		//Lookups fContStyle = lookupsMng.findByLookCode(contractBasicInfo.getfContStyle().getCode());
		/*if(!"HTFL-03".equals(contractBasicInfo.getFcType()) || !"HTFL-02".equals(contractBasicInfo.getFcType())){
			Lookups fPayType = lookupsMng.findByLookCode(contractBasicInfo.getfPayType().getCode());
			contractBasicInfo.setfPayType(fPayType);
			contractBasicInfo.setIfFjjht(0);//?????????????????????
		}else{
			contractBasicInfo.setIfFjjht(1);//?????????????????????
		}*/
		//?????????????????? 
		//contractBasicInfo.setfContStyle(fContStyle);
		//????????????????????????
		if(!StringUtil.isEmpty(contractBasicInfo.getAssisDeptId())){
			contractBasicInfo.setAssisDeptName(departMng.findById(contractBasicInfo.getAssisDeptId()).getId());
		}else{
			contractBasicInfo.setAssisDeptName(null);
		}
		//??????????????????
		contractBasicInfo.setFsealedStatus(0);
		//?????????????????? 
		contractBasicInfo = (ContractBasicInfo) super.saveOrUpdate(contractBasicInfo);
		if(contractBasicInfo.getfFlowStauts().equals("1")){
			
			//???????????????????????????key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),contractBasicInfo.getJoinTable(),contractBasicInfo.getBeanCodeField(),contractBasicInfo.getBeanCode(), "HTND", user);
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			//??????????????????id
			User fzuser=userMng.getUserByRoleNameAndDepartName("???????????????", contractBasicInfo.getfDeptName());
			/*//???????????????????????????
			if(fzuser.getId().equals(node.getUserId())){
				//?????????????????????????????????????????????????????????????????????
				node=tProcessCheckMng.getNextCheckKey( node, contractBasicInfo.getJoinTable(),contractBasicInfo.getBeanCodeField(),contractBasicInfo.getBeanCode(), "1");
			}*/
			
			User nextUser=userMng.findById(node.getUserId());
			//?????????????????????????????????????????????????????????????????????/??????
			contractBasicInfo.setfUserCode(nextUser.getId());
			contractBasicInfo.setfUserName(nextUser.getName());
			//???????????????????????????
			contractBasicInfo.setfNCode(firstKey+"");
			//????????????????????????????????????1?????????????????????
			tProcessCheckMng.updateStauts(flowId,contractBasicInfo.getBeanCode());
			//???????????????????????????????????????
			PersonalWork work = new PersonalWork();
			work.setUserId(contractBasicInfo.getfUserCode());//???????????????ID????????????????????????ID
			work.setTaskId(contractBasicInfo.getFcId());//?????????ID
			work.setTaskCode(contractBasicInfo.getFcCode());//?????????????????????
			work.setTaskName("[????????????]"+contractBasicInfo.getFcTitle());//????????????????????????????????????+?????????????????????????????????????????????
			work.setUrl("/Change/approvalChange/"+contractBasicInfo.getFcId());//??????????????????????????????url,???????????????????????????????????????
			work.setUrl1("/Change/detail/"+ contractBasicInfo.getFcId());//??????url
			work.setTaskStauts("0");//??????
			work.setType("1");//???????????????1-??????
			work.setBeforeUser(user.getName());//?????????????????????
			work.setBeforeDepart(user.getDepartName());//?????????????????????????????????
			work.setBeforeTime(new Date());//??????????????????
			personalWorkMng.merge(work);
			//?????????????????????????????????
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//???????????????ID????????????????????????ID
			minwork.setTaskId(contractBasicInfo.getFcId());//?????????ID
			minwork.setTaskCode(contractBasicInfo.getFcCode());//?????????????????????
			minwork.setTaskName("[????????????]"+contractBasicInfo.getFcTitle());//????????????????????????????????????+?????????????????????????????????????????????
			minwork.setUrl("/Change/edit/"+contractBasicInfo.getFcId());//????????????url
			minwork.setUrl1("/Change/detail/"+ contractBasicInfo.getFcId());//??????url
			minwork.setUrl2("/Change/delete/"+ contractBasicInfo.getFcId());//????????????url
			minwork.setTaskStauts("2");//??????
			minwork.setType("2");//???????????????2-??????
			minwork.setBeforeUser(user.getName());//?????????????????????
			minwork.setBeforeDepart(user.getDepartName());//?????????????????????????????????
			minwork.setBeforeTime(new Date());//??????????????????
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
		attachmentMng.joinEntity(contractBasicInfo,files);
		attachmentMng.joinEntity(contractBasicInfo,htwbfiles);
		contractBasicInfo.setUpdator(user.getName());
		saveOrUpdate(contractBasicInfo);
		//??????????????????
		//????????????????????????????????????????????????????????????
		if("HTFL-01".equals(contractBasicInfo.getFcType())){
			if(contractBasicInfo.getfFlowStauts().equals("1")){
				PurchaseApplyBasic applyBasic = applysqMng.findById(Integer.valueOf(contractBasicInfo.getfPurchNo()));
				if(applyBasic!=null){
					if (!applyBasic.getfHtCode().equals(contractBasicInfo.getFcCode())) {
						if("1".equals(applyBasic.getfContractSts()) || "2".equals(applyBasic.getfContractSts())){
							throw new ServiceException("?????????????????????????????????????????????????????????????????????");
						}
					}
					applyBasic.setfContractSts("1");
					applysqMng.saveOrUpdate(applyBasic);
				}
			}
			
			//??????json??????
			List<DataEntity> list2 =(List<DataEntity>)JSONArray.toList(JSONArray.fromObject(planJson), DataEntity.class);
			//?????????ReceivPlan?????????list
			List<ReceivPlan> receivPlan = filingMng.getReceivPlan(list2, user, contractBasicInfo);
			List<ReceivPlan> Plan = filingMng.find_ReceivPlan_List(String.valueOf(contractBasicInfo.getFcId()));
			//?????????????????????
			if(Plan.size()>0){
				for (int i = 0; i < Plan.size(); i++) {
					receivPlanMng.deleteById(Plan.get(i).getfPlanId());
				}
			}
			//??????????????????????????????????????????
			if(receivPlan.size()>0){
				for (int i = 0; i < receivPlan.size(); i++) {
					receivPlan.get(i).setfUpateTime_R(new Date());
					receivPlan.get(i).setPayStauts(null);
					receivPlan.get(i).setfUpateUser_R(user.getAccountNo());
					receivPlan.get(i).setfContId_R(contractBasicInfo.getFcId());
					receivPlan.get(i).setDataType(0);//????????????
					receivPlanMng.merge(receivPlan.get(i));
				}
			}else if(Plan.size()==0){
				filingMng.save_ReceivPlan(receivPlan);
			}
			
			//??????????????????   ?????????
			getSession().createSQLQuery("delete from T_CONTRACT_PLAN_LIST where F_P_ID ="+contractBasicInfo.getFcId()+" and F_TYPE=0").executeUpdate();
				if(!StringUtil.isEmpty(mingxi)){
				//??????Json??????
				List<ContractPlanList> ContractPlanLists = JSON.parseObject("["+mingxi.toString()+"]",new TypeReference<List<ContractPlanList>>(){});
				for (ContractPlanList contractPlanList: ContractPlanLists) {
					ContractPlanList info = new ContractPlanList();
					info.setMainId(contractPlanList.getMainId());
					info.setFplId(contractPlanList.getFplId());
					info.setFpId(contractPlanList.getFpId());
					info.setFconId(contractBasicInfo.getFcId());
					info.setFpurCode(contractPlanList.getFpurCode());
					info.setfIsImp(contractPlanList.getfIsImp());
					info.setfSiteAndPeriod(contractPlanList.getfSiteAndPeriod());
					info.setfManager(contractPlanList.getfManager());
					info.setFpurName(contractPlanList.getFpurName());
					info.setFpurBrand(contractPlanList.getFpurBrand());
					info.setfModel(contractPlanList.getfModel());
					info.setFspec(contractPlanList.getFspec());
					info.setFmeasureUnit(contractPlanList.getFmeasureUnit());
					info.setFnum(contractPlanList.getFnum());
					info.setFunitPrice(contractPlanList.getFunitPrice());
					info.setFsumMoney(contractPlanList.getFsumMoney());
					info.setfIfEdit(contractPlanList.getfIfEdit());
					info.setfType("0");
					super.merge(info);
				}
			}
		}
		if("HTFL-02".equals(contractBasicInfo.getFcType())){
			//??????????????????   ?????????
			getSession().createSQLQuery("delete from T_PROCEEDS_PLAN where F_CONT_ID ="+contractBasicInfo.getFcId()+" and F_DATA_TYPE=0").executeUpdate();
				if(!StringUtil.isEmpty(proceedsJson)){
				//??????Json??????
				List<ProceedsPlan> proceedsPlans = JSON.parseObject(proceedsJson,new TypeReference<List<ProceedsPlan>>(){});
				for (ProceedsPlan proceedsPlan: proceedsPlans) {
					ProceedsPlan info = new ProceedsPlan();
					//List<Lookups> lookupsJson = getLookupName(proceedsPlan.getfProceedsProperty());
					info.setfContId(contractBasicInfo.getFcId());
					info.setfProceedsProperty(proceedsPlan.getfProceedsProperty());
					info.setfProceedsCondition(proceedsPlan.getfProceedsCondition());
					info.setfProceedsTime(proceedsPlan.getfProceedsTime());
					info.setfProceedsAmount(proceedsPlan.getfProceedsAmount());
					info.setDataType(0);
					super.merge(info);
				}
			}
		}
		List<String> files0 = new ArrayList<String>();
		/*files0.add(htwbfiles);*/
		filingMng.save_SignInfo(signInfo, user, contractBasicInfo, files0);
		
	}

	@Override
	public ContractBasicInfo findByYhtId(int id) {
		// TODO Auto-generated method stub
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fcId = '"+id+"'");
		return (ContractBasicInfo) super.find(finder);
	}

	@Override
	public List<ContractBasicInfo> findbyPurchId(String id) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fPurchNo = '"+id+"' and fContStauts <> '99'");
		finder.append(" order by createTime desc");
		return super.find(finder);
	}
	
	public List<WinningBidder> findBysingName(String singName) {
		// TODO Auto-generated method stub
		Finder finder =Finder.create(" FROM WinningBidder WHERE fwName = '"+singName+"'");
		return super.find(finder);
	}
}

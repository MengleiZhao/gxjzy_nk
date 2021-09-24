package com.braker.icontrol.contract.filing.manager.Impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.DataEntity;
import com.braker.common.ftp.FileUpload;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.Attac;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class FilingMngImpl extends BaseManagerImpl<ContractBasicInfo> implements FilingMng{

	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private FormulationMng formulationMng;
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public Pagination list(ContractBasicInfo contractBasicInfo, User user, int pageNo, int pageSize) {
		Finder finder = Finder.create(" From ContractBasicInfo WHERE fFlowStauts = '9' ");
		/*finder.append(" AND fOperatorId =:fOperatorId ");
		finder.setParam("fOperatorId", user.getId());*/
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
		if(!StringUtil.isEmpty(contractBasicInfo.getfContStauts())){
			/*if(contractBasicInfo.getfFlowStauts().equals("暂存")){
				contractBasicInfo.setfFlowStauts("0");
			}
			if(contractBasicInfo.getfFlowStauts().equals("待审批")){
				contractBasicInfo.setfFlowStauts("1");
			}
			if(contractBasicInfo.getfFlowStauts().equals("已审批")){
				contractBasicInfo.setfFlowStauts("9");
			}*/
			finder.append("AND fContStauts LIKE :fContStauts ");
			finder.setParam("fContStauts",contractBasicInfo.getfContStauts());
		}
		if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}
		finder.append("order by updateTime desc");
		return super.find(finder,pageNo,pageSize);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public List<ReceivPlan> getReceivPlan(List<DataEntity> dataList, User user,ContractBasicInfo contractBasicInfo)throws ParseException {
		List<ReceivPlan> si=new ArrayList<ReceivPlan>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		
		
		for (int i = 0; i < dataList.size(); i++) {
			/*if(dataList.get(i).getCol1().equals("首款")){
				dataList.get(i).setCol1("FKXZ-01");
			}
			if(dataList.get(i).getCol1().equals("阶段款")){
				dataList.get(i).setCol1("FKXZ-02");
			}
			if(dataList.get(i).getCol1().equals("验收款")){
				dataList.get(i).setCol1("FKXZ-03");
			}
			if(dataList.get(i).getCol1().equals("质保款")){
				dataList.get(i).setCol1("FKXZ-04");
			}*/	
			dataList.get(i).setCol1(dataList.get(i).getCol1());
			ReceivPlan ReceivPlan=new ReceivPlan();
			ReceivPlan.setfContId_R(contractBasicInfo.getFcId());
			ReceivPlan.setfReceProperty(dataList.get(i).getCol1());
			ReceivPlan.setfRecStage(dataList.get(i).getCol2());
			ReceivPlan.setfReceCondition(dataList.get(i).getCol3());
			ReceivPlan.setfRecePlanTime(sdf.parse(dataList.get(i).getCol4()));
			ReceivPlan.setfRecePlanAmount(BigDecimal.valueOf(Double.valueOf(dataList.get(i).getCol5())));
			if(!StringUtil.isEmpty(dataList.get(i).getCol6())){
				ReceivPlan.setfReceTime(sdf.parse(dataList.get(i).getCol6()));
			}
			if(!StringUtil.isEmpty(dataList.get(i).getCol7())){
				ReceivPlan.setfReceAmount(BigDecimal.valueOf(Double.valueOf(dataList.get(i).getCol7())));
			}
			//序号自增
			//ReceivPlan.setfPlanId(Integer.valueOf(dataList.get(i).getCol8()));
			ReceivPlan.setfStauts_R("0");
			ReceivPlan.setfUpateUser_R(user.getAccountNo());
			ReceivPlan.setfUpateTime_R(new Date());
			si.add(i,ReceivPlan);
		}
		return si;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void save_ReceivPlan(List<ReceivPlan> receivPlan) {
		if(receivPlan.size()>0){
			for (int j = 0; j < receivPlan.size(); j++) {
				super.saveOrUpdate(receivPlan.get(j));
			}
		}
	}

	@Override
	public void save_SignInfo(SignInfo signInfo, User user,ContractBasicInfo contractBasicInfo,List<String> files) {
		signInfo.setfContId(contractBasicInfo.getFcId());
		signInfo=(SignInfo) super.saveOrUpdate(signInfo);
		//保存合同备案的附件
		for (int i = 0; i < files.size(); i++) {
			if(files.get(i)!=null){
				attachmentMng.joinEntity(signInfo,files.get(i));
			}
		}
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void save_Attac(List<Attac> at,List<Attac> otherAttac, User user,ContractBasicInfo contractBasicInfo) {
		if(!StringUtil.isEmpty(at.get(0).getfAttacName())){
			Query query =getSession().createSQLQuery("DELETE FROM T_CONTRACT_ATTAC WHERE F_CONT_CODE='"+contractBasicInfo.getFcCode()+"' AND F_ATTAC_TYPE='1'");
			query.executeUpdate();
			//保存合同文本
			for (int i = 0; i < at.size(); i++) {
				at.get(i).setfContId(contractBasicInfo.getFcId());
				at.get(i).setfContCode_A(contractBasicInfo.getFcCode());
				at.get(i).setfAttacType("1");
				at.get(i).setfUploadTime(new Date());
				at.get(i).setfUpdateUser(user.getAccountNo());
				at.get(i).setfUpdateTime(new Date());
				super.merge(at.get(i));
			}
		}
		if(!StringUtil.isEmpty(otherAttac.get(0).getfAttacName())){
			Query query =getSession().createSQLQuery("DELETE FROM T_CONTRACT_ATTAC WHERE F_CONT_CODE='"+contractBasicInfo.getFcCode()+"' AND F_ATTAC_TYPE='3'");
			query.executeUpdate();
			//保存其他附件
			for (int i = 0; i < otherAttac.size(); i++) {
				otherAttac.get(i).setfContId(contractBasicInfo.getFcId());
				otherAttac.get(i).setfContCode_A(contractBasicInfo.getFcCode());
				otherAttac.get(i).setfAttacType("3");
				otherAttac.get(i).setfUploadTime(new Date());
				otherAttac.get(i).setfUpdateUser(user.getAccountNo());
				otherAttac.get(i).setfUpdateTime(new Date());
				super.merge(otherAttac.get(i));
			}
		}
		
	}

	
	
	@Override
	public int find_Sign_number(ContractBasicInfo contractBasicInfo) {
		Finder finder =Finder.create(" FROM SignInfo WHERE 1=1");
		finder.append(" AND fContId=:fContId");
		finder.setParam("fContId", contractBasicInfo.getFcId());
		return super.find(finder).size();
	}

	@Override
	public Pagination find_ReceivPlan(String FcId, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ReceivPlan WHERE dataType='0'");
		finder.append(" AND fContId_R=:fContId_R");
		finder.setParam("fContId_R",Integer.valueOf(FcId));
		return super.find(finder,pageNo,pageSize);
	}
	
	@Override
	public List<ReceivPlan> find_ReceivPlan_List(String FcId) {
		Finder finder =Finder.create(" FROM ReceivPlan WHERE dataType='0'");
		finder.append(" AND fContId_R=:fContId_R");
		finder.setParam("fContId_R",Integer.valueOf(FcId));
		return super.find(finder);
	}

	@Override
	public List<Attac> findHTAttac(Integer id){
		Finder finder =Finder.create(" FROM Attac WHERE fAttacType='1' AND fContId="+id);
		return super.find(finder);
	}

	@Override
	public List<Attac> findOtherAttac(Integer id) {
		Finder finder =Finder.create(" FROM Attac WHERE fAttacType='3' AND fContId="+id);
		return super.find(finder);
	}

	@Override
	public void otherSave(ContractBasicInfo contractBasicInfo,User user,String planJson,String htwbfiles,SignInfo signInfo) throws ParseException {
		contractBasicInfo=formulationMng.findById(contractBasicInfo.getFcId());
		//是否为支出合同，不是支出合同没有付款计划
		if("HTFL-01".equals(contractBasicInfo.getFcType())){
			//转化json对象
			List<DataEntity> list2 =(List<DataEntity>)JSONArray.toList(JSONArray.fromObject(planJson), DataEntity.class);
			//转换成ReceivPlan类型的list
			List<ReceivPlan> receivPlan=getReceivPlan(list2, user, contractBasicInfo);
			List<ReceivPlan>  Plan=find_ReceivPlan_List(String.valueOf(contractBasicInfo.getFcId()));
			//比较数据库里的数据是否有相同的付款计划，如果页面上删除了，数据库也删除,如果有修改就相应的修改
			for (int i = Plan.size()-1; i>=0; i--) {
				Integer pid=Plan.get(i).getfPlanId();
				for (int j = 0; j < list2.size(); j++) {
					if(!StringUtil.isEmpty(list2.get(j).getCol8())){
						Integer col8=Integer.valueOf(list2.get(j).getCol8());
						if(pid.equals(col8)){
							Plan.remove(i);
							//Plan_Save.add(Plan.get(i));
						}
					}
				}
			}
			//删除不同的计划
			if(Plan.size()>0){
				for (int i = 0; i < Plan.size(); i++) {
					receivPlanMng.deleteById(Plan.get(i).getfPlanId());
				}
			}
			//保存新增的计划和更新旧的计划
			if(receivPlan.size()>0){
				for (int i = 0; i < receivPlan.size(); i++) {
					/*if(StringUtil.ifInt(receivPlan.get(i).getfRecePlanAmount())){
					receivPlan.get(i).setfRecePlanAmount("0.00");
				}*/
					receivPlan.get(i).setfUpateTime_R(new Date());
					receivPlan.get(i).setPayStauts("0");
					receivPlan.get(i).setfUpateUser_R(user.getAccountNo());
					receivPlanMng.merge(receivPlan.get(i));
				}
			}else if(Plan.size()==0){
				save_ReceivPlan(receivPlan);
			}
		}
		List<String> files=new ArrayList<String>();
		files.add(htwbfiles);
		//files.add(htwbfiles2);
		save_SignInfo(signInfo, user, contractBasicInfo,files);
		contractBasicInfo.setfContStauts("9");
		contractBasicInfo.setUpdator(user.getAccountNo());
		update(contractBasicInfo);
	}

	@Override
	public List<SignInfo> find_Sign(ContractBasicInfo contractBasicInfo) {
		Finder finder =Finder.create(" FROM SignInfo WHERE 1=1");
		finder.append(" AND fContId=:fContId");
		finder.setParam("fContId", contractBasicInfo.getFcId());
		return super.find(finder);
	}

	
}

package com.braker.icontrol.contract.dispute.manager.Impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.dispute.manager.DisputAttacMng;
import com.braker.icontrol.contract.dispute.manager.DisputeMng;
import com.braker.icontrol.contract.dispute.model.DisputAttac;
import com.braker.icontrol.contract.dispute.model.Dispute;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class DisputeMngImpl extends BaseManagerImpl<Dispute> implements DisputeMng{

	@Autowired
	private DisputAttacMng disputAttacMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private LookupsMng lookupsMng;
	
	@Override
	public Pagination list(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		/*StringBuilder sb = new StringBuilder("SELECT a.F_CONT_ID,a.F_CONT_CODE,a.F_CONT_TITLE,a.F_OPERATOR,"
				+ "a.F_REQ_TIME,a.F_AMOUNT,a.F_DISPUTE_STATUS,b.F_DIS_ID FROM T_CONTRACT_DISPUTE b "
				+ "LEFT JOIN T_CONTRACT_BASIC_INFO a ON a.F_CONT_ID = b.F_CONT_ID WHERE "
				+ "a.F_FLOW_STAUTS = '9' AND a.F_CONT_STAUTS <> '99' AND a.F_CONT_STAUTS <> '-1' AND (b.F_DIS_STATUS <>'99' or b.F_DIS_STATUS is null)");
		sb.append(" AND a.F_OPERATOR_ID = '"+user.getId()+"'");
		sb.append("AND a.F_DEPT_NAME = '"+user.getDepart().getName()+"'");*/
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <> '99' AND fContStauts <> '-1' AND fsealedStatus='1'"
				+ " AND fcId in (select fContId_D from Dispute)");
//		finder.append("AND fOperator =:fOperator ");
//		finder.setParam("fOperator", user.getName());
//		finder.append("AND fDeptName =:fDeptName ");
//		finder.setParam("fDeptName", user.getDepart().getName());
//		finder.append("AND F_DISPUTE_STATUS is not null ");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getfReqtIME()))){
			finder.append(" AND DATE_FORMAT(fReqtIME,'%Y-%m-%d') <= '"+contractBasicInfo.getfReqtIME()+"'");//日期去时分秒函数
			/*finder.append("AND fFlowStauts LIKE :fFlowStauts ");
			finder.setParam("fFlowStauts", "%"+contractBasicInfo.getfFlowStauts()+"%");*/
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
		/*List<Object[]> dataList = (List<Object[]>) p1.getList();
		List<Dispute>list=new ArrayList<>();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (Object[] obj: dataList) {
				Dispute t = new Dispute();
				t.setfContId_D(Integer.valueOf(String.valueOf(obj[0])));
				t.setFcCode(String.valueOf(obj[1]));
				t.setFcTitle(String.valueOf(obj[2]));
				t.setfOperator(String.valueOf(obj[3]));
				t.setfReqtIME((Date) obj[4]);
				t.setFcAmount(String.valueOf(obj[5]));
				t.setfDisputeStatus(String.valueOf(obj[6]));
				t.setfDisId(Integer.valueOf(String.valueOf(obj[7])));
				i++;
				list.add(t);
			}
			p1.setList(list);
		}
		return p1;*/
		
	
	
	@Override
	public void save(Dispute dispute,String fhtjffiles, User user,ContractBasicInfo contractBasicInfo) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(StringUtil.isEmpty(String.valueOf(dispute.getfDisId()))){
			dispute.setCreateTime(new Date());
			dispute.setCreator(user.getAccountNo());
			dispute.setfDisId(StringUtil.random8());
		}else {
			dispute.setUpdateTime(new Date());
			dispute.setUpdator(user.getAccountNo());
		}
		Lookups fDisType = lookupsMng.findByLookCode(dispute.getfDisType().getCode());
		dispute.setfDisType(fDisType);
		dispute.setfRecUser(user.getAccountNo());
		dispute.setfContId_D(contractBasicInfo.getFcId());
		dispute.setfRecTime(new Date());
		dispute=(Dispute) super.merge(dispute);
		//保存附件信息
		attachmentMng.joinEntity(dispute,fhtjffiles);
		String sql="update T_CONTRACT_BASIC_INFO set F_CONT_STAUTS='7',F_UPDATE_USER='"+user.getAccountNo()+"', F_UPDATE_TIME='"+sdf.format(new Date())+"' where F_CONT_ID="+contractBasicInfo.getFcId();
		Query query=getSession().createSQLQuery(sql);
		query.executeUpdate();
		//修改纠纷状态
		if (contractBasicInfo.getFjfStauts().equals("1")) {
		String sqljf="update T_CONTRACT_BASIC_INFO set F_DISPUTE_STATUS='0' where F_CONT_ID="+contractBasicInfo.getFcId();
		Query queryjf=getSession().createSQLQuery(sqljf);
		queryjf.executeUpdate();
		}
		if (contractBasicInfo.getFjfStauts().equals("2")) {
		String sqljf="update T_CONTRACT_BASIC_INFO set F_DISPUTE_STATUS='1' where F_CONT_ID="+contractBasicInfo.getFcId();
		Query queryjf=getSession().createSQLQuery(sqljf);
		queryjf.executeUpdate();
		}
		/*if(!StringUtil.isEmpty(disputFile.get(0).getfAttacName_DA())){
			disputAttacMng.saveDisputFile(dispute, disputFile, user);
		}*/
	}

	@Override
	public int findD(String id) {
		Finder finder = Finder.create(" FROM Dispute WHERE fContId_D = "+id);
		return super.find(finder).size();
	}

	@Override
	public List<Dispute> findByContId(String id) {
		Finder finder = Finder.create(" FROM Dispute WHERE fContId_D = "+id);
		return super.find(finder);
	}

	
	/**
	 * 合同纠纷删除
	 * @param id
	 * @param user
	 * @param fId
	 */
	public void deletejf(Integer id,User user,String fId) {
		//合同状态为99（删除）
			String sql="UPDATE T_CONTRACT_BASIC_INFO SET F_DISPUTE_STATUS = null WHERE F_CONT_ID="+id;
			Query query=getSession().createSQLQuery(sql);
			query.executeUpdate();
			String sqls="DELETE from t_contract_dispute WHERE F_CONT_ID="+id;
			Query querys=getSession().createSQLQuery(sqls);
			querys.executeUpdate();
		
	}
}

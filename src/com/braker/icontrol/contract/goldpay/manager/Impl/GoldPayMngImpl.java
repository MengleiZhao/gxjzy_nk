package com.braker.icontrol.contract.goldpay.manager.Impl;

import java.text.SimpleDateFormat;
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
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.goldpay.manager.GoldPayMng;
import com.braker.icontrol.contract.goldpay.model.GoldPay;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class GoldPayMngImpl extends BaseManagerImpl<GoldPay> implements GoldPayMng{

	@Autowired
	private AttachmentMng attachmentMng;
	
	@Override
	public Pagination find(ContractBasicInfo contractBasicInfo, User user,Integer pageNo,Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fContStauts<>'1' AND fFlowStauts='9' AND fContStauts in(5,7,9,11) ");
		/*finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getAccountNo());*/
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfPayStauts())){
			finder.append("AND fPayStauts = :fPayStauts ");
			finder.setParam("fPayStauts", contractBasicInfo.getfPayStauts());
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getfBudgetIndexCode()))){
			finder.append("AND fBudgetIndexCode = :fBudgetIndexCode ");
			finder.setParam("fBudgetIndexCode", contractBasicInfo.getfBudgetIndexCode());
		}
		if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}
		
		finder.append("ORDER BY updateTime DESC");
		Pagination p = super.find(finder, pageNo, pageSize);
		List<ContractBasicInfo> cbiList= (List<ContractBasicInfo>) p.getList();
		//查询登记时间
		for (int i = cbiList.size()-1; i >= 0 ; i--) {
			if(!"0".equals(cbiList.get(i).getfMarginAmount())&&!StringUtil.isEmpty(cbiList.get(i).getfMarginAmount())){
				String sql="select F_REC_TIME from T_WARRANTY_GOLD_P where F_CONT_ID='"+cbiList.get(i).getFcId()+"'";
				Query query=getSession().createSQLQuery(sql);
				List<Date> list = query.list();
				if(list.size()>0){
					cbiList.get(i).setfRecTime(list.get(0));
				}else{
					cbiList.get(i).setfRecTime(null);
				}
			}else{
				cbiList.remove(i);
			}
		
		}
		p.setList(cbiList);
		return p;
	}

	@Override
	public void save(ContractBasicInfo contractBasicInfo, User user,GoldPay goldPay,String fhtbzjFiles) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		goldPay.setCreateTime(new Date());
		goldPay.setCreator(user.getAccountNo());
		goldPay.setfContId_GP(contractBasicInfo.getFcId());
		goldPay.setfRecUser(user.getAccountNo());
		goldPay.setfRecTime(new Date());
		goldPay=(GoldPay) super.saveOrUpdate(goldPay);
		//保存附件信息
		attachmentMng.joinEntity(goldPay,fhtbzjFiles);
		String sql ="UPDATE T_CONTRACT_BASIC_INFO SET F_PAY_STAUTS='1',F_UPDATE_USER='"+user.getAccountNo()+"', F_UPDATE_TIME='"+sdf.format(new Date())+"' WHERE F_CONT_ID="+contractBasicInfo.getFcId();
		Query query=getSession().createSQLQuery(sql);
		query.executeUpdate();
		
	}

	@Override
	public List<GoldPay> findByContId(String id) {
		Finder finder =Finder.create(" FROM GoldPay WHERE fContId_GP ="+Integer.valueOf(id));
		return super.find(finder);
	}


}

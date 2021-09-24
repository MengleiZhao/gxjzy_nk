package com.braker.icontrol.contract.enforcing.manager.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.ConclusionAttacMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionMng;
import com.braker.icontrol.contract.enforcing.model.Conclusion;
import com.braker.icontrol.contract.enforcing.model.ConclusionAttac;
@Service
@Transactional
public class ConclusionMngImpl extends BaseManagerImpl<Conclusion> implements ConclusionMng{

	@Autowired
	private ConclusionAttacMng conclusionAttacMng;
	
	@Override
	public void saveConclusion(ContractBasicInfo contractBasicInfo,Conclusion conclusion, User user,List<ConclusionAttac> conclusionAttac) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(StringUtil.isEmpty(String.valueOf(conclusion.getfFiId()))){
			conclusion.setfFiId(StringUtil.random8());
		}
		conclusion.setfContId_F(contractBasicInfo.getFcId());
		conclusion.setCreator(user.getAccountNo());
		conclusion.setCreateTime(new Date());
		super.merge(conclusion);
		conclusionAttacMng.save(conclusion, user, conclusionAttac);
		String sql=" UPDATE T_CONTRACT_BASIC_INFO SET F_CONT_STAUTS='3',F_UPDATE_USER='"+user.getAccountNo()+"', F_UPDATE_TIME='"+sdf.format(new Date())+"' WHERE F_CONT_ID="+contractBasicInfo.getFcId();
		Query updateFCS =getSession().createSQLQuery(sql);
		updateFCS.executeUpdate();
		
	}

	@Override
	public List<Conclusion> findByfContId(String id) {
		Finder finder=Finder.create(" FROM Conclusion WHERE fContId_F="+Integer.valueOf(id));
		return super.find(finder);
	}
}

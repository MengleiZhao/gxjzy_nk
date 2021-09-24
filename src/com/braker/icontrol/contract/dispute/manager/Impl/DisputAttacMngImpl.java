package com.braker.icontrol.contract.dispute.manager.Impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import oracle.net.aso.d;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.core.model.User;
import com.braker.icontrol.contract.dispute.manager.DisputAttacMng;
import com.braker.icontrol.contract.dispute.manager.DisputeMng;
import com.braker.icontrol.contract.dispute.model.DisputAttac;
import com.braker.icontrol.contract.dispute.model.Dispute;

@Service
@Transactional
public class DisputAttacMngImpl extends BaseManagerImpl<DisputAttac> implements DisputAttacMng{

	@Autowired
	private DisputeMng disputeMng;
	@Override
	public void saveDisputFile(Dispute dispute,List<DisputAttac> disputFile,User user) {
		Query query =getSession().createSQLQuery("DELETE FROM T_CONTRACT_DISPUTE_ATTAC WHERE F_DIS_ID='"+dispute.getfDisId()+"' AND F_ATTAC_TYPE='1'");
		query.executeUpdate();
		for (int i = 0; i < disputFile.size(); i++) {
			disputFile.get(i).setfDisId_A(dispute.getfDisId());
			disputFile.get(i).setUpdator_DA(user.getAccountNo());
			disputFile.get(i).setUpdateTime_DA(new Date());
			disputFile.get(i).setfUploadTime_DA(new Date());
			super.merge(disputFile.get(i));
		}
		
	}

	@Override
	public List<DisputAttac> findFile(String id) {
		List<Dispute> d= disputeMng.findByContId(id);
		List<DisputAttac> dispute=new ArrayList<DisputAttac>();
		if(d.size()>0){
			Finder finder=Finder.create(" FROM DisputAttac WHERE fDisId_A="+d.get(0).getfDisId());
			dispute=super.find(finder);
		}
		return dispute;
	}

	@Override
	public List<DisputAttac> findByName(String name) {
		Finder finder=Finder.create(" FROM DisputAttac WHERE fAttacName_DA='"+name+"'");
		return super.find(finder);
	}

	@Override
	public void delete(List<DisputAttac> disputAttac) {
		for (int i = 0; i < disputAttac.size(); i++) {
			super.delete(disputAttac.get(i));
		}
	}

}

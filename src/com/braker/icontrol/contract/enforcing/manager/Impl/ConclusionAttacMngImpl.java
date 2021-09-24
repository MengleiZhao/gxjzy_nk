package com.braker.icontrol.contract.enforcing.manager.Impl;

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
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.manager.ConclusionAttacMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionMng;
import com.braker.icontrol.contract.enforcing.model.Conclusion;
import com.braker.icontrol.contract.enforcing.model.ConclusionAttac;

@Service
@Transactional
public class ConclusionAttacMngImpl extends BaseManagerImpl<ConclusionAttac> implements ConclusionAttacMng{

	@Autowired
	private ConclusionMng conclusionMng;
	
	@Override
	public void save(Conclusion conclusion, User user,List<ConclusionAttac> conclusionAttac) {
		Query query =getSession().createSQLQuery("delete from T_CONTRACT_FINISH_ATTAC where F_FI_ID='"+conclusion.getfFiId()+"' and F_ATTAC_TYPE='"+conclusion.getfFiType()+"'");
		query.executeUpdate();
		for (int i = 0; i < conclusionAttac.size(); i++) {
			
			conclusionAttac.get(i).setfUploadTime(new Date());
			conclusionAttac.get(i).setfFiId_A(conclusion.getfFiId());
			conclusionAttac.get(i).setUpdateTime_FA(new Date());
			conclusionAttac.get(i).setUpdator_FA(user.getAccountNo());
			super.saveOrUpdate(conclusionAttac.get(i));
			
			/*String sql="INSERT INTO T_CONTRACT_FINISH_ATTAC(F_FI_ID,F_ATTAC_NAME,F_ATTAC_TYPE,F_FILE_SRC,F_UPLOAD_TIME,F_UPDATE_USER,F_UPDATE_TIME)"
					+ " values("+conclusion.getfFiId()+",'"+conclusionAttac.get(i).getfAttacName_C()+"','1','"+conclusionAttac.get(i).getfFileSrc_C()+"','"+sdf.format(new Date())+"','"+user.getAccountNo()+"','"+sdf.format(new Date())+"');";
			Query query=getSession().createSQLQuery(sql);
			query.executeUpdate();*/
		}		
	}

	@Override
	public List<ConclusionAttac> findAllFile(String id) {
		List<Conclusion> conclusion = conclusionMng.findByfContId(id);
		List<ConclusionAttac> ca=new ArrayList<>();
		if(conclusion.size()>0){
			Finder finder =Finder.create(" FROM ConclusionAttac WHERE fFiId_A="+conclusion.get(0).getfFiId());
			ca=super.find(finder);
		}
		return ca;
	}

	@Override
	public List<ConclusionAttac> findByFileName(String name) {
		Finder finder=Finder.create(" FROM ConclusionAttac WHERE fAttacName_C='"+name+"'");
		return super.find(finder);
	}

	@Override
	public void deleteByName(List<ConclusionAttac> conclusionAttac) {
		for (int i = 0; i < conclusionAttac.size(); i++) {
			super.delete(conclusionAttac.get(i));
		}
	}

}

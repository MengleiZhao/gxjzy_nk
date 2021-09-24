package com.braker.icontrol.contract.enforcing.manager.Impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.ftp.FileUpload;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.enforcing.model.UptClause;

@Service
@Transactional
public class UptClauseMngImpl extends BaseManagerImpl<UptClause> implements UptClauseMng {

	@Autowired
	private UptMng uptMng;
	
	@Override
	public List<UptClause> findByfId_U_AU(Integer fId_U_AU) {
		Finder finder=Finder.create(" FROM UptClause WHERE fId_U_AU="+fId_U_AU); 
		
		return super.find(finder);
	}

	@Override
	public List<UptClause> findAllFile(String id) {
		List<Upt> li=uptMng.findByFContId_U(id);
		List<UptClause> ua=new ArrayList<>();
		if(li.size()>0){
			Finder finder =Finder.create(" FROM UptClause WHERE fId_U_AU="+li.get(0).getfId_U());
			 ua=super.find(finder);
		}
		return ua;
	}

	@Override
	public void deleteByName(List<UptClause> uptAttac) {
		for (int i = 0; i < uptAttac.size(); i++) {
			super.delete(uptAttac.get(i));
		}
	}

	@Override
	public List<UptClause> findAllFileByName(String name) {
		Finder finder=Finder.create(" FROM UptClause WHERE F_ATTAC_NAME='"+name+"'");
		return super.find(finder);
	}

	@Override
	public Pagination approvalJson(Upt upt, User user, Integer pageNo,Integer pageSize) {
		Finder finder =Finder.create(" FROM Upt where 1=1");
		
		
		return super.find(finder, pageNo, pageSize);
	}

}

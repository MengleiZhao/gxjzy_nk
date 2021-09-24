package com.braker.icontrol.assets.storage.manager.Impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.manager.AssetsAttacMng;
import com.braker.icontrol.assets.storage.model.AssetsAttac;
import com.braker.icontrol.assets.storage.model.Storage;

@Service
@Transactional
public class AssetsAttacMngImpl extends BaseManagerImpl<AssetsAttac> implements AssetsAttacMng{

	@Override
	public void save(Storage storage,String files, User user) {
		Finder finder=Finder.create(" from AssetsAttac where fStorageCode_A='"+storage.getfAssStorageCode()+"'");
		List<AssetsAttac> li=super.find(finder);
		if(li.size()>0){
			//入库单文件信息
			Query query =getSession().createSQLQuery("delete from T_ASSETS_ATTAC where F_ASS_STORAGE_CODE='"+storage.getfAssStorageCode()+"'");
			query.executeUpdate();
		}
		String gdzc="ZC/ZCRK/GDZC/";
		String wxzc="ZC/ZCRK/WXZC/";
		String dzyhp="ZC/ZCRK/DZYHP/";
		String path=null;
		/*if(!StringUtil.isEmpty(files)){
			String[] disputSrc = files.split(",");
			for (int i = 0; i < disputSrc.length; i++) {
				AssetsAttac aa = new AssetsAttac();
				String[] HT = disputSrc[i].split("\\\\");
				aa.setfAttacName(HT[HT.length - 1].trim());
				if(storage.getfAssType().equals("ZCLX-02")){
					path=gdzc+HT[HT.length - 1].trim();
				}else if(storage.getfAssType().equals("ZCLX-03")){
					path=wxzc+HT[HT.length - 1].trim();
				}else if(storage.getfAssType().equals("ZCLX-01")){
					path=dzyhp+HT[HT.length - 1].trim();
				}
				aa.setfFileSrc(path);
				aa.setfAttacType(storage.getfAssType());
				aa.setfStorageCode_A(storage.getfAssStorageCode());
				aa.setfUpdateTime(new Date());
				aa.setfUpdateUser(user.getAccountNo());
				aa.setfUploadTime(new Date());
				super.saveOrUpdate(aa);
			}
		}*/
		
	}

	@Override
	public List<AssetsAttac> findAttac(Storage storage) {
	/*	Finder finder =Finder.create(" FROM AssetsAttac WHERE fStorageCode_A='"+storage.getfAssStorageCode()+"' AND fAttacType='"+storage.getfAssType()+"'");
		return super.find(finder);*/
		return null;
	}

	@Override
	public void deleteAttac(List<AssetsAttac> li) {
		for (int i = 0; i < li.size(); i++) {
			super.delete(li.get(i));
		}
	}

	@Override
	public List<AssetsAttac> findbyfilename(String filename) {
		Finder finder =Finder.create(" FROM AssetsAttac WHERE fAttacName='"+filename+"'");
		return super.find(finder);
		
	}

	
	
}

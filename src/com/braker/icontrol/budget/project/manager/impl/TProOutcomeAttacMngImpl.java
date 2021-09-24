package com.braker.icontrol.budget.project.manager.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.ftp.FileUpload;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.braker.icontrol.budget.project.entity.TProOutcomeAttac;
import com.braker.icontrol.budget.project.manager.TProOutcomeAttacMng;

@Service
@Transactional
public class TProOutcomeAttacMngImpl extends BaseManagerImpl<TProOutcomeAttac> implements TProOutcomeAttacMng{

	@Override
	public void saveTProOutcomeAttac(String originPath, User user, TProBudget budget) {
		
		if (StringUtil.isEmpty(originPath)) return;
		
		TProOutcomeAttac att = new TProOutcomeAttac();
		String[] x = originPath.split("\\\\");
		
		String[] filenames = originPath.split("\\\\");
		String filename = filenames[filenames.length-1];
		
		att.setFAttacName(filename);
//		att.setFFileSrc(originPath);
		att.setFFileSrc("XM\\PROOUTCOME" + att.getFAttacName());
		att.setTProBudget(budget);
		if (att.getFNAId()==null) {
			//创建人、创建时间、发布时间
			att.setFCreateUser(user.getAccountNo());
			att.setFCreateTime(new Date());
		} else {
			//修改人、修改时间
			att.setFUpdateUser(user.getAccountNo());
			att.setFUpdateTime(new Date());
		}
		merge(att);
		uploadAtt(att,originPath);
		budget.setFAttacName(att.getFAttacName());
		merge(budget);
	}

	/**
	 * 上传文件
	 * @param att 附件信息表
	 * @param path 源文件地址
	 */
	public void uploadAtt (TProOutcomeAttac att, String originPath) {
		//获得ftp服务器参数
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");		
		//上传文件
		fu.upLoadFromProduction(url, port,username,password,"XM\\PROOUTCOME",att.getFAttacName(),originPath);
	}
	
	public File generateTempFile(MultipartFile file) {
		
		String path = "";
		try {
			file.transferTo(new File(path));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
        return new File(path);
//		CommonsMultipartFile cf= (CommonsMultipartFile)file; 
//        DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
//        File f = fi.getStoreLocation();
//        String diskPath = f.getPath();
	}

	@Override
	public void saveTProOutcomeAttac(String filesStr) {
		// TODO Auto-generated method stub
		
	}

}

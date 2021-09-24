package com.braker.icontrol.budget.project.manager.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.ftp.FileUpload;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicAccoAttac;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicPlanAttac;
import com.braker.icontrol.budget.project.manager.TProBasicPlanAttacMng;

@Service
@Transactional
public class TProBasicPlanAttacMngImpl extends BaseManagerImpl<TProBasicPlanAttac> implements TProBasicPlanAttacMng {

//	@Override
//	public void saveTProBasicPlanAttac(String originPath, User user, TProBasicInfo project) {
//		
//		TProBasicPlanAttac att = new TProBasicPlanAttac();
//		String[] x = originPath.split("\\\\");
//		
//		att.setFAttacName(x[x.length-1]);
////		att.setFFileSrc(originPath); 
//		att.setFFileSrc("XM\\PROPLAN" + att.getFAttacName()); 
//		att.setTProBasicInfo(project);
//		if (att.getFNAId()==null) {
//			//创建人、创建时间、发布时间
//			att.setFCreateUser(user.getAccountNo());
//			att.setFCreateTime(new Date());
//		} else {
//			//修改人、修改时间
//			att.setFUpdateUser(user.getAccountNo());
//			att.setFUpdateTime(new Date());
//		}
//		saveOrUpdate(att);
//		uploadAtt(att,originPath);
//		project.setFAccoAttName(att.getFAttacName());
//	}

	/**
	 * 上传文件
	 * @param att 附件信息表
	 * @param path 源文件地址
	 */
	public void uploadAtt (TProBasicPlanAttac att, String originPath) {
		//获得ftp服务器参数
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");		
		//上传文件
		fu.upLoadFromProduction(url, port,username,password,"XM\\PROPLAN",att.getFAttacName(),originPath);
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
	public void saveTProBasicPlanAttac(String filesStr, User user, TProBasicInfo project) {

		if(filesStr != null && filesStr.length() != 0){
			//删除原有的附件信息
			List<TProBasicPlanAttac> delList = findByProperty("TProBasicInfo.FProId", project.getFProId());
			if (delList != null && delList.size() > 0) {
				for (TProBasicPlanAttac acct: delList) {
					super.delete(acct);
				}
			}
			//保存现有的附件信息
			String[] fileli = filesStr.split(",");
			for (int i = 0; i < fileli.length; i++) {
				String[] filenames = fileli[i].split("\\\\");
				String filename = filenames[filenames.length-1];
				if (!StringUtil.isEmpty(filename)) {
					TProBasicPlanAttac attac = new TProBasicPlanAttac();
					attac.setTProBasicInfo(project);
					attac.setFAttacName(filename.trim());
					attac.setFFileSrc("XM/PROPLAN/"+filename.trim());
					attac.setFAttacType("");
					attac.setFUploadTime(new Date());
					attac.setFCreateUser(user.getAccountNo());
					attac.setFCreateTime(new Date());
					super.saveOrUpdate(attac);
				}
			}
			
		}
	
	}

	@Override
	public void batchDelete(List<TProBasicPlanAttac> list) {
		
		if (list != null && list.size() > 0) {
			for (TProBasicPlanAttac attc: list) {
				super.delete(attc);
			}
		}
	}

}

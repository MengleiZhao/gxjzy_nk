package com.braker.zzww.comm.manager.impl;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.entity.EntityDao;
import com.braker.common.ftp.FileUpload;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.Base64DecodeMultipartFile;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;
@SuppressWarnings("unchecked")
@Service
@Transactional
public class AttachmentMngImpl extends BaseManagerImpl<Attachment> implements AttachmentMng{
	
	@Override
	public void upload(EntityDao entityDao,String[] serviceTypes,MultipartFile[] file,String savePath,User user){
		// TODO Auto-generated method stub
		if(null!=file && 0!=file.length){
			int t=file.length;
			for (int i = 0; i < t; i++) {
				if(file[i].getSize()>0){
					String fileName=file[i].getOriginalFilename();
					String contentType=file[i].getContentType();
					String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
					String fn=UUID.randomUUID()+postfix;//系统文件名
					String dateRoot=new SimpleDateFormat("yyyyMM").format(new Date());//把年月作为图片的底层目录
					String root=savePath+"\\";//图片存放目录
					File fileRoot=new File(root);
					if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
						fileRoot.mkdirs();
					}
					String path=savePath+"\\"+fn;
					File f=new File(path);
					Attachment att=new Attachment();
					att.setCreator(user);
					att.setEntryId(entityDao.getEntryId());
					att.setJoinTable(entityDao.getJoinTable());
					att.setFileName(path);
					att.setFileType(contentType);
					att.setFileUrl("\\"+fn);
					att.setFileSize(getFileSize(file[i].getSize()));
					att.setOriginalName(fileName);
					if(serviceTypes!=null&&serviceTypes.length>0){
						att.setServiceType(serviceTypes[i]);
					}
					super.save(att);
					try {
						file[i].transferTo(f);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	/**
	 * 计算文件大小
	 * @param fileSize
	 * @return
	 */
	public String getFileSize(long fileSize){
		double size=0.0;
		String sizeStr="0";
		String unit="字节";
		if(fileSize>=1024){
			size=fileSize/1024;
			if(size<1024){
				unit="KB";
			}
			if(size>=1024){
				size=size/1024;
				unit="MB";
			}
			if(size>=1024){
				size=size/1024;
				unit="GB";
			}
			DecimalFormat df=new DecimalFormat("#.0");
			sizeStr=df.format(size);
		}else{
			sizeStr=String.valueOf(fileSize);
		}
		return sizeStr+" "+unit;
	}
	
	@Override
	public List<Attachment> list(EntityDao entityDao) {
		Finder hql=Finder.create("from Attachment where flag=1 and entryId=:entryId and joinTable=:joinTable");
		hql.setParam("entryId", entityDao.getEntryId());
		hql.setParam("joinTable", entityDao.getJoinTable());
		return super.find(hql);
	}
	
	@Override
	public List<Attachment> findByIdS(String ids) {
		String idStr=assemblyIds(ids);
		Finder hql=Finder.create("from Attachment where flag=1 and id in ( "+idStr+" )");
		return super.find(hql);
	}
	
	private String assemblyIds(String ids){
		String idStr="";
		if(StringUtils.isNotEmpty(ids)){
			String id[]=ids.split(",");
			for(String str:id){
				if("".equals(idStr)){
					idStr="'"+str+"'";
				}else{
					idStr=idStr+","+"'"+str+"'";
				}
			}
		}
		return idStr;
	}
	@Override
	public Attachment upload(String serviceType,MultipartFile file,String savePath,User user) {
		// TODO Auto-generated method stub
		if(null!=file && file.getSize()>0){
			String fileName=file.getOriginalFilename();//文件名
			String contentType=file.getContentType();//文件类型
			String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
			String fn=UUID.randomUUID()+postfix;//系统文件名
			String dateRoot=new SimpleDateFormat("yyyyMM").format(new Date());//把年月作为图片的底层目录
			String root=savePath+"\\"+dateRoot+"\\";//图片存放目录
			File fileRoot=new File(root);
			if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
				fileRoot.mkdirs();
			}
			String path=savePath+"\\"+dateRoot+"\\"+fn;
			File f=new File(path);
			Attachment att=new Attachment();
			att.setCreator(user);
			att.setFileName(path);
			att.setFileType(contentType);
			att.setFileUrl("\\"+dateRoot+"\\"+fn);
			att.setFileSize(getFileSize(file.getSize()));
			att.setOriginalName(fileName);
			att.setServiceType(serviceType);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return (Attachment)super.merge(att);
		}
		return null;
	}
	
	@Override
	public void uploadmp4(EntityDao entityDao,String[] serviceTypes,MultipartFile[] file,String savePath,User user)
	{
		// TODO Auto-generated method stub
		if(null!=file && 0!=file.length){
			int t=file.length;
			for (int i = 0; i < t; i++) {
				if(file[i].getSize()>0){
					String fileName=file[i].getOriginalFilename();
					String contentType=file[i].getContentType();
					String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
					String fn=UUID.randomUUID()+postfix;//系统文件名
					String dateRoot=new SimpleDateFormat("yyyyMM").format(new Date());//把年月作为图片的底层目录
					String root=savePath+"\\"+dateRoot+"\\";//图片存放目录
					File fileRoot=new File(root);
					if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
						fileRoot.mkdirs();
					}
					String path=null;
					if(!postfix.equals(".mp4"))
					{
					path=savePath+"\\"+dateRoot+"\\"+fn;
					}else
					{
						path=savePath.replace("file", "jyyw")+"\\"+dateRoot+"\\"+fn;	
					}
					File f=new File(path);
					Attachment att=new Attachment();
					att.setServiceType("MP4");
					att.setCreator(user);
					att.setEntryId(entityDao.getEntryId());
					att.setJoinTable(entityDao.getJoinTable());
					att.setFileName(path);
					att.setFileType(contentType);
					att.setFileUrl("\\"+dateRoot+"\\"+fn);
					att.setFileSize(getFileSize(file[i].getSize()));
					att.setOriginalName(fileName);
					if(serviceTypes!=null&&serviceTypes.length>0){
						att.setServiceType(serviceTypes[i]);
					}
					super.save(att);
					try {
						file[i].transferTo(f);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
		}
	}

	@Override
	public Attachment upload(EntityDao entityDao, String serviceType,
			MultipartFile file, String savePath, User user) {
		if(null!=file && file.getSize()>0){
			String fileName=file.getOriginalFilename();//文件名
			String contentType=file.getContentType();//文件类型
			String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
			String fn=UUID.randomUUID()+postfix;//系统文件名
			String dateRoot=new SimpleDateFormat("yyyyMM").format(new Date());//把年月作为图片的底层目录
			String root=savePath+"\\"+dateRoot+"\\";//图片存放目录
			File fileRoot=new File(root);
			if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
				fileRoot.mkdirs();
			}
			String path=savePath+"\\"+dateRoot+"\\"+fn;
			File f=new File(path);
			Attachment att=new Attachment();
			att.setCreator(user);
			att.setFileName(path);
			att.setEntryId(entityDao.getEntryId());
			att.setJoinTable(entityDao.getJoinTable());
			att.setFileType(contentType);
			att.setFileUrl("\\"+dateRoot+"\\"+fn);
			att.setFileSize(getFileSize(file.getSize()));
			att.setOriginalName(fileName);
			att.setServiceType(serviceType);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return (Attachment)super.merge(att);
		}
		return null;
	}

	@Override
	public void uploadToFtp(EntityDao entityDao,
			MultipartFile[] file, String savePath, User user) {
		// TODO Auto-generated method stub
		if(null!=file && 0!=file.length){
			int t=file.length;
			for (int i = 0; i < t; i++) {
				if(file[i].getSize()>0){
					String fileName = file[i].getOriginalFilename();
					String contentType = file[i].getContentType();
					String postfix = fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
					String fn = UUID.randomUUID() + postfix;//系统文件名
					String root = savePath + "\\";//图片存放目录
					File fileRoot = new File(root);
					if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
						fileRoot.mkdirs();
					}
					String path = savePath + "\\" + fn;
					File f = new File(path);
					//保存附件信息
					Attachment att = new Attachment();
					att.setCreator(user);
					att.setEntryId(entityDao.getEntryId());
					att.setJoinTable(entityDao.getJoinTable());
					att.setFileName(path);
					att.setFileType(contentType);
					att.setFileUrl("\\" + fn);
					att.setFileSize(getFileSize(file[i].getSize()));
					att.setOriginalName(fileName);
					super.save(att);
					try {
						//保存到tomcat服务器
						file[i].transferTo(f);
						//保存到ftp服务器
						FileUpload fu = new FileUpload();
						String url = fu.getFtpConfig("url");
						int port = Integer.parseInt(fu.getFtpConfig("port"));
						String username = fu.getFtpConfig("username");
						String password = fu.getFtpConfig("password");
						String path1 = "01-YSGL";
						String filename = att.getFileName();
						fu.upLoadFromProduction(url, port,username,password,path1,filename,att.getFileUrl());
						//删除tomcat服务器上的文件
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
		}
	}

	@Override
	public String uploadAjax(MultipartFile[] files, String serviceType, String savePath,
			User user) throws Exception {
		
		String ids = "";
		long size = 0;
		if(null!=files && 0!=files.length){
			int t = files.length;
			//判断文件总大小
			for (int i = 0; i < t; i++) {
				size = size + files[i].getSize();
			}
			if (size > 204800000) {
				throw new Exception("文件总大小不能超过200M");
			}
			//上传文件并记录
			for (int i = 0; i < t; i++) {
				if(files[i].getSize()>0){
					String fileName=files[i].getOriginalFilename();
					String contentType=files[i].getContentType();
					String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
					String fn=UUID.randomUUID()+postfix;//系统文件名
					String root=savePath+"\\";//图片存放目录
					File fileRoot=new File(root);
					if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
						fileRoot.mkdirs();
					}
					String path=savePath+"\\"+fn;
					File f=new File(path);
					Attachment att=new Attachment();
					att.setCreator(user);
					att.setFileName(path);
					att.setFileType(contentType);
					att.setServiceType(serviceType);
					att.setFileUrl("\\"+fn);
					att.setFileSize(getFileSize(files[i].getSize()));
					att.setOriginalName(fileName);
					att = (Attachment) super.saveOrUpdate(att);
					ids = ids + att.getId() + "@" + att.getOriginalName() + ",";
					//如果是图片生成缩略图
					if(contentType.contains("image/")){
						Base64DecodeMultipartFile.getThumb(path, root,files[i]);
					}
					try {
						files[i].transferTo(f);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
		}
		if (ids.length() > 0) {
			ids = ids.substring(0,ids.length() - 1);
		}
		return ids;
	}

	@Override
	public void joinEntity(EntityDao bean, String attIds) {

		if (!StringUtil.isEmpty(attIds) && bean != null) {
			attIds = attIds.substring(0,attIds.length() - 1);
			String[] ids = attIds.split(",");
			if (ids.length > 0) {
				for (String id: ids) {
					Attachment att = findById(id);
					if (att != null && StringUtil.isEmpty(att.getJoinTable())) {
						//如果该附件存在且未关联业务表
						att.setEntryId(bean.getEntryId());
						att.setJoinTable(bean.getJoinTable());
						super.saveOrUpdate(att);
					}
				}
			}
		}
	}

	@Override
	public List<Attachment> getAllMgrFile() {
		// TODO Auto-generated method stub
		Finder finder = Finder.create(" FROM Attachment WHERE PFLAG=1 ");
		finder.append(" AND joinTable = 'T_SYSTEM_CENTER_INFO' ");
		return super.find(finder);
	}
	
	@Override
	public Attachment joinEntity1(EntityDao bean, String attIds) {

		if (!StringUtil.isEmpty(attIds) && bean != null) {
			attIds = attIds.substring(0,attIds.length() - 1);
			String[] ids = attIds.split(",");
			if (ids.length > 0) {
				for (String id: ids) {
					Attachment att = findById(id);
					return att;
				}
			}
		}
		return null;
	}

	@Override
	public List<Attachment> findEntryIdS(String entryId) {
		Finder hql=Finder.create("from Attachment where flag=1 and entryId in ( "+entryId+" )");
		return super.find(hql);
	}

	
	@Override
	public String uploadAjax1(MultipartFile files, String serviceType, String savePath,String index,
			User user) throws Exception {
		
		String id = "";
		long size = files.getSize();
		if(null!=files){
			if (size > 204800000) {
				throw new Exception("文件总大小不能超过200M");
			}
			//上传文件并记录
				if(files.getSize()>0){
					String fileName=files.getOriginalFilename();
					String contentType=files.getContentType();
					String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
					String fn=UUID.randomUUID()+postfix;//系统文件名
					String root=savePath+"\\";//图片存放目录
					File fileRoot=new File(root);
					if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
						fileRoot.mkdirs();
					}
					String path=savePath+"\\"+fn;
					File f=new File(path);
					Attachment att=new Attachment();
					att.setCreator(user);
					att.setFileName(path);
					att.setFileType(contentType);
					att.setServiceType(serviceType);
					att.setFileUrl("\\"+fn);
					att.setFileSize(getFileSize(files.getSize()));
					att.setOriginalName(fileName);
					att = (Attachment) super.saveOrUpdate(att);
					id = att.getId()+"@"+index;
					try {
						files.transferTo(f);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
		}
		return id;
	}
	
	@Override
	public String uploadInvoiceImage(MultipartFile files, String serviceType, String savePath,
			User user) throws Exception {
		
		String id = "";
		long size = files.getSize();
		if(null!=files){
			if (size > 204800000) {
				throw new Exception("文件总大小不能超过200M");
			}
			//上传文件并记录
				if(files.getSize()>0){
					String fileName=files.getOriginalFilename();
					String contentType=files.getContentType();
					String postfix=fileName.substring(fileName.lastIndexOf("."),fileName.length());//文件后缀
					String fn=UUID.randomUUID()+postfix;//系统文件名
					String root=savePath+"\\";//图片存放目录
					File fileRoot=new File(root);
					if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
						fileRoot.mkdirs();
					}
					String path=savePath+"\\"+fn;
					File f=new File(path);
					Attachment att=new Attachment();
					att.setCreator(user);
					att.setFileName(path);
					att.setFileType(contentType);
					att.setServiceType(serviceType);
					att.setFileUrl("\\"+fn);
					att.setFileSize(getFileSize(files.getSize()));
					att.setOriginalName(fileName);
					att = (Attachment) super.saveOrUpdate(att);
					id = att.getId();
					try {
						files.transferTo(f);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
		}
		return id;
	}
}

package com.braker.zzww.comm.manager;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.braker.common.entity.EntityDao;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.zzww.comm.entity.Attachment;

public interface AttachmentMng extends BaseManager<Attachment> {
	/**
	 * 多个文件上传到tomcat服务器
	 * @param entityDao
	 * @param serviceTypes
	 * @param file
	 * @param getSavePath
	 */
	public void upload(EntityDao entityDao,String[] serviceTypes,MultipartFile[] file,String savePath,User user);
	/**
	 * 多个文件上传到ftp服务器
	 * @param entityDao
	 * @param serviceTypes
	 * @param file
	 * @param getSavePath
	 */
	public void uploadToFtp(EntityDao entityDao,MultipartFile[] file,String savePath,User user);
	/**
	 * 多个mp4文件上传
	 * @param entityDao
	 * @param serviceTypes
	 * @param file
	 * @param getSavePath
	 */
	public void uploadmp4(EntityDao entityDao,String[] serviceTypes,MultipartFile[] file,String savePath,User user);
	/**
	 * 获取实体对应的附件
	 * @param entityDao
	 * @return
	 */
	public List<Attachment> list(EntityDao entityDao);
	
	/**
	 * 单个文件上传
	 * @param serviceType
	 * @param file
	 * @param getSavePath
	 */
	public Attachment upload(String serviceType,MultipartFile file,String savePath,User user);
	/**
	 * 单个文件上传
	 * @param serviceType
	 * @param file
	 * @param getSavePath
	 */
	public Attachment upload(EntityDao entityDao,String serviceType,MultipartFile file,String savePath,User user);
	
	/**
	 * 单个文件ajax上传
	 */
	public String uploadAjax(MultipartFile[] file, String serviceType, String savePath, User user) throws IllegalStateException, IOException, Exception;
	
	/**
	 * 将附件表和实体表相关联
	 * 不会覆盖原有的关联
	 */
	public void joinEntity(EntityDao bean, String attIds);
	
	/**
	 * 获得制度索引的所有文件
	 * @author 张迅
	 * @createtime 2019-04-18
	 */
	public List<Attachment> getAllMgrFile();
	
	/**
	 * 将附件表和实体表相关联
	 * 不会覆盖原有的关联 (审批上传附件时使用)
	 * @param bean
	 * @param attIds
	 * @return 会返回一个最新的附件类
	 */
	Attachment joinEntity1(EntityDao bean, String attIds);
	
	/***
	 * 根据  有逗号间隔的 id 查询集合
	 * @param ids
	 * @return
	 */
	public List<Attachment> findByIdS(String ids) ;
	/**
	 * 
	 * @Description:  评审记录附件查询
	 * @param @param id
	 * @param @return   
	 * @return List<Attachment>  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月17日
	 */
	public List<Attachment> findEntryIdS(String entryId);
	
	public String uploadAjax1(MultipartFile files, String serviceType,
			String savePath, String index, User user) throws Exception;
	
	String uploadInvoiceImage(MultipartFile files, String serviceType,
			String savePath, User user) throws Exception;
}

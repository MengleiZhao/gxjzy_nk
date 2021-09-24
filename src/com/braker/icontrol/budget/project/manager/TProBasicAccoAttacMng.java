package com.braker.icontrol.budget.project.manager;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicAccoAttac;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

public interface TProBasicAccoAttacMng extends BaseManager<TProBasicAccoAttac>{

	/**
	 * 保存立项依据附件
	 * @param filesStr 保存文件
	 * @param User 操作人
	 * @param bean 关联项目
	 */
	public void saveTProBasicAccoAttac(String filesStr, User User, TProBasicInfo bean);
	
	/**
	 * 下载立项依据附件
	 * @param proId 项目id
	 */
	public void downloadAtta(String fileName, String savePath);
	
	/**
	 * 批量删除附件信息
	 * @param list 要删除的附件信息列表
	 */
	public void batchDelete(List<TProBasicAccoAttac> list);
		
	
}

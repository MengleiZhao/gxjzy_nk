package com.braker.icontrol.assets.storage.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.model.AssetsAttac;
import com.braker.icontrol.assets.storage.model.Storage;

public interface AssetsAttacMng extends BaseManager<AssetsAttac>{

	/**
	 * 保存入库单相应的附件
	 * @param storage
	 * @param files
	 * @param user
	 */
	void save(Storage storage,String files,User user);
	
	/**
	 * 根据入库单流水号查询相应附件
	 * @param id
	 * @return
	 */
	List<AssetsAttac> findAttac(Storage storage);
	
	/**
	 * 根据入库单流水号删除相应的附件
	 * @param storage
	 */
	void deleteAttac(List<AssetsAttac> li);
	
	/**
	 * 根据文件名称查询
	 * @param filename
	 */
	List<AssetsAttac> findbyfilename (String filename);
}

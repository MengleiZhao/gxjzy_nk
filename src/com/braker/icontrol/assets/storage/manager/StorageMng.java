package com.braker.icontrol.assets.storage.manager;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;
import com.braker.workflow.entity.TProcessCheck;

public interface StorageMng extends BaseManager<Storage>{

	/**
	 * 查询入库登记单
	 * @param Storage
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-06
	 */
	Pagination list(Storage storage,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 保存入库登记表
	 * @param Storage
	 * @param user
	 * @author 陈睿超
	 * @createtime 2018-07-07
	 */
	void save_fixed(List<Regist> rtorage,Storage storage,User user,String files)throws Exception;
	
	/**
	 * 删除信息（修改状态）
	 * @param id
	 * @param user
	 * @author 陈睿超
	 * @createtime 2018-07-07
	 */
	void delete(String id,User user );
	
	/**
	 * 保存低值易耗品
	 * @param rtorage
	 * @param storage
	 * @param user
	 * @param files
	 */
	void save_low(List<Regist> rtorage,Storage storage,User user,String files);
	
	/**
	 * 根据一个条件查询
	 * @param condition 条件 
	 * @param val 值
	 * @return
	 */
	Storage findbyCondition(String condition,String val);
	
	/**
	 * 查询加载固定资产增加审批页面的数据
	 * @param Storage 查询信息
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination approvalList(Storage storage,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 审批意见保存修改
	 * @param status 审批意见
	 * @param id 主键id
	 * @param spjlFile 附件
	 * @param user
	 */
	void updateStatus(String status,String id,String spjlFile,TProcessCheck checkBean,String planJson,User user)throws Exception;

	void saveFile(File file, User user) throws Exception;
	
	/**
	 * 撤回表单，修改数据
	 * @param id
	 */
	String reCall(String id);
	
}

package com.braker.icontrol.contract.enforcing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.enforcing.model.UptClause;
import com.braker.icontrol.contract.enforcing.model.UptClause;

public interface UptClauseMng extends BaseManager<UptClause>{

	
	/**
	 * 根据合同变更编号查询
	 * @param fId_U_AU
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	List<UptClause> findByfId_U_AU(Integer fId_U_AU);
	
	/**
	 * 根据合同的id查询所以变更信息
	 * @param id
	 * @return
	 */
	List<UptClause> findAllFile(String id);
	
	/**
	 * 根据名称删除
	 * @param name
	 */
	void deleteByName(List<UptClause> uptAttac);
	
	/**
	 * 根据合同的文件名称查询所以变更的附件
	 * @param id
	 * @return
	 */
	List<UptClause> findAllFileByName(String name);
	
	/**
	 * 加载审批数据，带查询
	 * @param upt 查询内容
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination approvalJson(Upt upt,User user,Integer pageNo, Integer pageSize);
	
}

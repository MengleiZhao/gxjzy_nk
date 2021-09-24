package com.braker.icontrol.budget.adjust.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;

/**
 * 外部指标调整明细表的service
 * @author 叶崇晖
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */
public interface TIndexExteAdLstMng extends BaseManager<TIndexExteAdLst> {
	
	/*
	 * 根据指标外部调整申报ID查找相应的明细
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	public List<TIndexExteAdLst> findByAid(String aId);
	
	/**
	 * 
	* @author:安达
	* @Title: pageList 
	* @Description: 查询选中以后的项目和指标
	* @param pids
	* @return
	* @return Pagination    返回类型 
	* @date： 2019年6月17日下午10:39:31 
	* @throws
	 */
	public List<TIndexExteAdLst> findList(String pids);
	
	/**
	* 
	* @Title: deleteByProId 
	* @Description: 根据外部指标调整id删除老的明细
	* @param aid  //关联外部指标调整的副键ID
	* @return void    返回类型 
	* @date： 2019年5月23日下午8:47:11 
	* @throws
	 */
	public void deleteByAId(Integer aid);
}

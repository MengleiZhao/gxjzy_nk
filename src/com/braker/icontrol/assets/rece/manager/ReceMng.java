package com.braker.icontrol.assets.rece.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.workflow.entity.TProcessCheck;

public interface ReceMng extends BaseManager<Rece>{

	/**
	 * 主页的查询显示
	 * @param rece 搜索条件
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(Rece rece,User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 保存
	 * @param rece
	 * @param rl
	 * @param user
	 */
	void save(Rece rece,String receFlies,List<ReceList> rl,User user) throws Exception;
	
	/**
	 * 根据id去修改领用单的状态
	 * @param id
	 */
	void delete(String id,User user) throws Exception;
	
	/**
	 * 低值易耗品待审批的列表信息
	 * @param rece 搜索条件
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination approvalList(Rece rece, User user, Integer pageNo,Integer pageSize);
	
	/**
	 * 保存固定資產
	 * @param rece
	 * @param user
	 * @param stauts
	 */
	void savefixed(Rece rece,User user,List<ReceList> rl,String stauts) throws Exception;
	/**
	 * 修改领用单状态（通过，不通过），并且添加一条审批记录
	 * @param stauts 前台传过来的状态
	 * @param user
	 * @param rece
	 * @param assetCheckInfo
	 */
	void updateStauts( User user, Rece rece,TProcessCheck checkBean,String file) throws Exception;
	
	/**
	 * 查看库存是否有这些货，数量还有多少（审批时）
	 * @param rece
	 * @return
	 */
	Rece storkNum(Rece rece);
	
	/**
	 * 查看库存是否有这些货，数量还有多少（保存提交申请时）
	 * @param List<ReceList>
	 * @return
	 */
	Rece storkNum(List<ReceList> receList);
	
	/**
	 * 资产调拨是选择原配置单（领用单）显示列表信息
	 * @param rece 搜索条件
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination allocalist(Rece rece, User user, Integer pageNo,Integer pageSize);
	
	/**
	 * 根据一个条件查询
	 * @param condition 条件 
	 * @param val 值
	 * @return
	 */
	Rece findbyCondition(String condition,String val);
	/**
	 * 根据一个条件查询
	 * @param condition 条件 
	 * @param val 值
	 * @return
	 */
	Rece finFId(String fcode);
	
	
	
}

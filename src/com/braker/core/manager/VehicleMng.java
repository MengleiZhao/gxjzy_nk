package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Vehicle;

/**
 * 交通工具的service抽象类
 * @author 叶崇晖
 * @createtime 2019-01-09
 * @updatetime 2019-01-09
 */
public interface VehicleMng extends BaseManager<Vehicle> {
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	public Pagination pageList(Vehicle bean, int pageNo, int pageSize, String parentCode);
	
	/*
	 * 查询总条数
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	public Integer getCount(String code);
	
	/*
	 * 保存
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	public void saveVehicle(Vehicle bean);
	
	/*
	 * 根据父节点编码查询
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	public List<Vehicle> findByParentCode(String parentCode);
	
	/*
	 * 根据父节点编码查询
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	public List<Vehicle> findByParentCodes(String parentCode,String level);
	
	/*
	 * 根据编码查询
	 * @author 叶崇晖
	 * @createtime 2019-01-11
	 * @updatetime 2019-01-11
	 */
	public List<Vehicle> findByCode(String code);
}

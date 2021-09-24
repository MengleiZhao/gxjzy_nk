package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.AreaBasicInfo;

/**
 * 省市地区的service抽象类
 * @author 叶崇晖
 * @createtime 2019-01-10
 * @updatetime 2019-01-10
 */
public interface AreaMng extends BaseManager<AreaBasicInfo> {
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	public Pagination pageList(AreaBasicInfo bean, int pageNo, int pageSize, String parentCode);
	
	/*
	 * 查询总条数
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	public Integer getCount(String code);
	
	/*
	 * 保存
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	public void saveArea(AreaBasicInfo bean);
	
	/*
	 * 批量保存
	 * @author 叶崇晖
	 * @createtime 2019-01-23
	 * @updatetime 2019-01-23
	 */
	public void saveBatchSave(String parentCode, String firstCode, String nameList);
	
	/*
	 * 下拉框查询
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	public List<AreaBasicInfo> comboboxFind(String parentCode);
	
	/*
	 * code查询
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	public List<AreaBasicInfo> findByCode(String code);
	
}

package com.braker.icontrol.cgmanage.cgexpert.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.model.ExtractRecordInfo;


/**
 * 专家库抽取的service抽象类
 * @author 焦广兴
 * @createtime 2019-06-27
 * @updatetime 2019-06-27
 */
public interface ExpertExtractMng extends BaseManager<ExtractRecordInfo>{
	
	/**
	 * 新增的保存
	 * @author 焦广兴
	 * @createtime 2019-06-27
	 * @updatetime 2019-06-27
	 */
	public void save(ExtractRecordInfo bean,User user) throws Exception;
	
	/**
	 * 分页查询
	 * @author 焦广兴
	 * @createtime 2019-06-27
	 * @updatetime 2019-06-27
	 */
	public Pagination pageList(ExtractRecordInfo bean, int pageNo, int pageSize);
	
}

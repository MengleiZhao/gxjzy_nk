package com.braker.icontrol.expend.apply.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;


/**
  * 培训统计的service抽象类
  * @author 焦广兴
  * @createtime 2019-03-27
  * @updatetime 2019-03-27
  */
public interface TrainingMng extends BaseManager<TrainingAppliInfo>{

	/**
	 * 各类型培训支出列表
	 * @author 焦广兴
	 * @param  indexType 类型
	 * @param  searchName 搜索条件 （培训名字）
	 * @param  searchContent （培训内容）
	 * @createtime 2019-03-？
	 * @updatetime 2019-04-2
	 */
	
}

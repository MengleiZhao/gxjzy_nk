package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.manager.TrainingMng;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;

/**
 * 培训统计的service实现类
 * @author 焦广兴
 * @createtime 2019-03-27
 * @updatetime 2019-03-27
 */
@Service
@Transactional
public class TrainingMngImpl extends BaseManagerImpl<TrainingAppliInfo> implements TrainingMng{

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

package com.braker.icontrol.expend.apply.manager;



import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.apply.model.TravelRecord;

/**
 * 人员差旅记录表的service抽象类
 * @author 叶崇晖
 * @createtime 2019-01-24
 * @updatetime 2019-01-24
 */
public interface TravelRecordMng extends BaseManager<TravelRecord> {
	/**
	 * 根据用户id查询该用户最常用的出发地和目的地编码
	 * @param userId
	 * @return String数组[出发地编码,目的地编码]
	 */
	public String[] findByUserId(String userId);
}

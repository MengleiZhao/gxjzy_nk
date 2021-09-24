package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.expend.apply.manager.TravelRecordMng;
import com.braker.icontrol.expend.apply.model.TravelRecord;

/**
 * 人员差旅记录表的service实现类
 * @author 叶崇晖
 * @createtime 2019-01-24
 * @updatetime 2019-01-24
 */
@Service
@Transactional
public class TravelRecordMngImpl extends BaseManagerImpl<TravelRecord> implements TravelRecordMng {

	@Override
	public String[] findByUserId(String userId) {
		//type=1出发
		Query query = getSession().createSQLQuery("select F_PLACE_CODE,count(*) as count from t_travel_record where F_USER_ID='"+userId+"' and F_TYPE=1 group by F_PLACE_CODE having count(1)>0 order by count(*) desc ");
		List<Object[]> list = query.list();
		String[] s = new String[2];
		if(list.size()>0){
			Object[] objs = list.get(0);
			s[0] = objs[0].toString();
		} else {
			s[0] = null;
		}
		//type=2到达
		query = getSession().createSQLQuery("select F_PLACE_CODE,count(*) as count from t_travel_record where F_USER_ID='"+userId+"' and F_TYPE=2 group by F_PLACE_CODE having count(1)>0 order by count(*) desc ");
		list = query.list();
		if(list.size()>0){
			Object[] objs = list.get(0);
			s[1] = objs[0].toString();
		} else {
			s[1] = null;
		}
		return s;
	}

}

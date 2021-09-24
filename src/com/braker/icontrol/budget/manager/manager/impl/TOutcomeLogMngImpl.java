package com.braker.icontrol.budget.manager.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TOutcomeLog;
import com.braker.icontrol.budget.manager.manager.TOutcomeLogMng;
import com.braker.icontrol.budget.release.entity.TIndexDetail;

@Service
public class TOutcomeLogMngImpl extends BaseManagerImpl<TOutcomeLog> implements TOutcomeLogMng {

	@Override
	public Pagination pageList(TOutcomeLog bean, User user, int pageNo,
			int pageSize,String searchUserName, String searchDeptName) {
		
		Finder finder = Finder.create(" from TOutcomeLog  where 1=1 ");
		if (!StringUtil.isEmpty(bean.getIndexName())) {
			finder.append(" and indexName =:indexName ").setParam("indexName", bean.getIndexName());
		} else if (!StringUtil.isEmpty(bean.getIndexCode())) {
			finder.append(" and indexCode =:indexCode ").setParam("indexCode", bean.getIndexCode());
		}
		if(!StringUtil.isEmpty(searchUserName)){
			finder.append(" and user.name=:userName").setParam("userName", searchUserName);
		}
		if(searchDeptName!=null && searchDeptName.length()>0){
			finder.append(" AND F_DEPARTMENT LIKE ('%"+searchDeptName+"%')");
		}
			
			//finder.append(" and user.name=:name1").setParam("name1", searchUserName);
		finder.append(" order by date desc ");
		Pagination page = super.find(finder, pageNo, pageSize);
		//加入序号
		List<TOutcomeLog> dataList =  (List<TOutcomeLog>) page.getList();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (TOutcomeLog log: dataList) {
				log.setPageOrder(pageNo * pageSize + i - (pageSize-1));
				i++;
			}
		}
		return page;
	}

}

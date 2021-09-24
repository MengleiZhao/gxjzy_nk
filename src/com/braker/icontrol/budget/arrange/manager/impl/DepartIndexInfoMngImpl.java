package com.braker.icontrol.budget.arrange.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.budget.arrange.entity.DepartArrange;
import com.braker.icontrol.budget.arrange.entity.DepartIndexInfo;
import com.braker.icontrol.budget.arrange.manager.DepartIndexInfoMng;

@Service
@Transactional
public class DepartIndexInfoMngImpl extends BaseManagerImpl<DepartIndexInfo> implements DepartIndexInfoMng {

	@Override
	public Pagination pageList(DepartIndexInfo bean, Integer pageNo, Integer pageSize) {
		
		Finder f = Finder.create(" from DepartIndexInfo ");
		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getYear())) {
				f.append(" and year=:year").setParam("year", bean.getYear());
			}
		}
		
		Pagination p = super.find(f, pageNo, pageSize);
		//加入排序号
		List<DepartIndexInfo> list = (List<DepartIndexInfo>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				DepartIndexInfo info = list.get(i);
				info.setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		return p;
	}

	@Override
	public void releaseById(String infoId, double money) {
		
		DepartIndexInfo info = findById(Integer.valueOf(infoId));
		info.setStatus("2");//状态 已下达
		if (info.getAmount() != 0) {//下达进度
			double total = info.getAmount();
			double process = money * 100 / total;//计算百分比
			info.setProcess(process);
		}
		saveOrUpdate(info);
	}

}

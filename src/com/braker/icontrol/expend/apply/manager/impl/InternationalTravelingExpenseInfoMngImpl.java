package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.InternationalTravelingExpenseInfoMng;
import com.braker.icontrol.expend.apply.model.InternationalTravelingExpense;

/**
 * 国际旅费service层
 * @author 赵孟雷
 *
 */
@Service
@Transactional
public class InternationalTravelingExpenseInfoMngImpl extends BaseManagerImpl<InternationalTravelingExpense> implements InternationalTravelingExpenseInfoMng {

	@Override
	public List<InternationalTravelingExpense> findbygId(Integer gId) {
		Finder finder = Finder.create("FROM InternationalTravelingExpense WHERE fStatus =0");
		if(!StringUtil.isEmpty(String.valueOf(gId))){
			finder.append(" AND gId = "+gId);
		}
		return super.find(finder);
	}

	@Override
	public List<InternationalTravelingExpense> rfindbygId(Integer rId) {
		Finder finder = Finder.create("FROM InternationalTravelingExpense WHERE fStatus =1");
		if(!StringUtil.isEmpty(String.valueOf(rId))){
			finder.append(" AND rId = "+rId);
		}
		return super.find(finder);
	}


}

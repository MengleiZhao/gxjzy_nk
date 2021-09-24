package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.FeteCostInfoMng;
import com.braker.icontrol.expend.apply.model.FeteCostInfo;

/**
 * 宴请费service实现层
 * @author 赵孟雷
 *
 */
@Service
@Transactional
public class FeteCostInfoMngImpl extends BaseManagerImpl<FeteCostInfo> implements FeteCostInfoMng {

	@Override
	public List<FeteCostInfo> findbygId(Integer gId) {
		Finder finder = Finder.create("FROM FeteCostInfo WHERE fStatus =0");
		if(!StringUtil.isEmpty(String.valueOf(gId))){
			finder.append(" AND gId = "+gId);
		}
		return super.find(finder);
	}

	@Override
	public List<FeteCostInfo> rfindbygId(Integer rId) {
		Finder finder = Finder.create("FROM FeteCostInfo WHERE fStatus =1");
		if(!StringUtil.isEmpty(String.valueOf(rId))){
			finder.append(" AND rId = "+rId);
		}
		return super.find(finder);
	}


}

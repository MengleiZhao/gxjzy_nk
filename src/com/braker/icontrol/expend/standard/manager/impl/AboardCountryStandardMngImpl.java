package com.braker.icontrol.expend.standard.manager.impl;

import java.util.List;

import org.apache.axis.utils.StringUtils;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.expend.standard.entity.AboardCountryStandard;
import com.braker.icontrol.expend.standard.entity.RecepStandard;
import com.braker.icontrol.expend.standard.manager.AboardCountryStandardMng;

/**
 * 公务出国国家及地区信息
 * @author 赵孟雷
 *
 */
@Service
public class AboardCountryStandardMngImpl extends BaseManagerImpl<AboardCountryStandard> implements AboardCountryStandardMng{
	/**
	 * 查询公务出国所有国家
	 * @param bean
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年5月15日
	 * @updator 赵孟雷
	 * @updatetime 2020年5月15日
	 */
	@Override
	public Pagination pageListAboard(AboardCountryStandard bean, User user,
		int pageNo, int pageSize) {
		//查询
		Finder finder = Finder.create(" from AboardCountryStandard WHERE flag=1  ");
		if(!StringUtils.isEmpty(bean.getCountry())){
			finder.append("and country like :country");
			finder.setParam("country", "%"+bean.getCountry()+"%");
		}
		//排序
		Pagination p = super.find(finder, pageNo, pageSize);
		List<AboardCountryStandard> list = (List<AboardCountryStandard>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if(StringUtil.isEmpty(list.get(i).getCurrency())){
					list.get(i).setCurrency("全部");
				}
				list.get(i).setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		p.setList(list);		
		return super.find(finder, pageNo, pageSize);
	}

}

package com.braker.icontrol.budget.adjust.manager.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.manager.TIndexAdItfMng;

/**
 * 内部指标调整明细表的service实现类
 * @author 叶崇晖
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
@Service
@Transactional
public class TIndexAdItfMngImpl extends BaseManagerImpl<TIndexAdItf> implements TIndexAdItfMng {
	
	/*
	 * 根据指标外部调整申报ID查找相应的明细
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@Override
	public List<TIndexAdItf> findByInId(String inId, String adType) {
		Finder finder = Finder.create(" FROM TIndexAdItf WHERE inId='"+inId+"'");
		if(adType != null) {
			finder.append(" AND adType='"+adType+"'");
		}
		return super.find(finder);
	}
	
	@Override
	public List<TIndexAdItf> findList(String pids) {
		if(pids.startsWith("\"")) {
			pids = pids.substring(0, pids.length()-1);
			pids = pids.substring(1, pids.length());
		}
		String sql = "select tbim.F_B_ID as bId, tbim.F_B_INDEX_NAME as indexName, tped.F_APPLI_AMOUNT as pfAmount, tped.F_EXP_ID as pid, "
				+ "tped.F_PRO_ACTIVITY as activity, tped.F_SY_AMOUNT as syAmount, tbim.F_DEPT_NAME as departName , tbim.F_INDEX_TYPE as indexType,tbim.F_DEPT_CODE AS departCode,tbim.T_PRO_USE_TYPE AS proUseType from T_BUDGET_INDEX_MGR tbim "
				+ "left join T_PRO_EXPEND_DETAIL tped on tbim.f_pro_id=tped.f_pro_id  where  F_EXP_ID in ("+pids+") ";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		List<TIndexAdItf> resultList=new ArrayList<TIndexAdItf>();
		for(Object[] obj:list){
			TIndexAdItf ta=new TIndexAdItf();
			ta.setBid(Integer.parseInt(obj[0].toString()));
			ta.setIndexName(obj[1].toString());
			ta.setPfAmount(BigDecimal.valueOf(Double.parseDouble(obj[2].toString())));
			ta.setPid(Integer.parseInt(obj[3].toString()));
			ta.setActivity(obj[4].toString());
			ta.setSyAmount(BigDecimal.valueOf(Double.parseDouble(obj[5].toString())));
			ta.setDeptName(obj[6].toString());
			ta.setIndexType(obj[7].toString());
			ta.setDeptCode(obj[8].toString());
			ta.setProUseType(String.valueOf(obj[9]));
			resultList.add(ta);
		}
		return resultList;
	}
	
	/**
	* 
	* @Title: deleteByProId 
	* @Description: 根据项目id删除老的明细
	* @param aId  //关联内部指标调整的副键ID
	* @return void    返回类型 
	* @date： 2019年5月23日下午8:47:11 
	* @throws
	 */
	@Override
	public void deleteByInId(Integer aId){
		Query query=getSession().createSQLQuery(" delete from T_INDEX_AD_ITF where F_IN_ID="+aId);
		query.executeUpdate();
	}
}

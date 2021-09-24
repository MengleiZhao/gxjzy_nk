package com.braker.icontrol.budget.adjust.manager.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;







import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;
import com.braker.icontrol.budget.adjust.manager.TIndexExteAdLstMng;

/**
 * 外部指标调整明细表的service实现类
 * @author 叶崇晖
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */
@Service
@Transactional
public class TIndexExteAdLstMngImpl extends BaseManagerImpl<TIndexExteAdLst> implements TIndexExteAdLstMng{
	
	
	/*
	 * 根据指标外部调整申报ID查找相应的明细
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@Override
	public List<TIndexExteAdLst> findByAid(String aId) {
		Finder finder = Finder.create(" FROM TIndexExteAdLst WHERE aId='"+aId+"'");
		return super.find(finder);
	}

	@Override
	public List<TIndexExteAdLst> findList(String pids) {
		String sql=" select tbim.F_B_ID as bId,tbim.F_B_INDEX_NAME as indexName,tped.F_APPLI_AMOUNT as pfAmount, tped.F_EXP_ID as pid,"
				+ "tped.F_PRO_ACTIVITY as activity,tped.F_SY_AMOUNT as syAmount   from T_BUDGET_INDEX_MGR tbim  "
				+ "left join T_PRO_EXPEND_DETAIL tped on tbim.f_pro_id=tped.f_pro_id  where  F_EXP_ID in ("+pids+") ";
		Query query = getSession().createSQLQuery(sql);
		//Query query = getSession().createSQLQuery(sql).addEntity(TIndexAdItf.class);
		List<Object[]> list = query.list();
		 List<TIndexExteAdLst> resultList=new ArrayList<TIndexExteAdLst>();
		 for(Object[] obj:list){
			 TIndexExteAdLst indexExteAd=new TIndexExteAdLst();
			 indexExteAd.setBid(Integer.parseInt(obj[0].toString()));
			 indexExteAd.setIndexName(obj[1].toString());
			 indexExteAd.setPfAmount(BigDecimal.valueOf(Double.parseDouble(obj[2].toString())/10000));
			 indexExteAd.setPid(Integer.parseInt(obj[3].toString()));
			 indexExteAd.setActivity(obj[4].toString());
			 indexExteAd.setSyAmount(BigDecimal.valueOf(Double.parseDouble(obj[5].toString())/10000));
			 resultList.add(indexExteAd);
		 }
		return resultList;
	}
	
	/**
	* 
	* @Title: deleteByProId 
	* @Description: 根据项目id删除老的明细
	* @param aid  //关联外部指标调整的副键ID
	* @return void    返回类型 
	* @date： 2019年5月23日下午8:47:11 
	* @throws
	 */
	@Override
	public void deleteByAId(Integer aid){
		Query query=getSession().createSQLQuery(" delete from T_INDEX_EXTE_AD_LST where F_A_ID="+aid);
		query.executeUpdate();
	}
}

package com.braker.icontrol.cgmanage.cgprocess.manager.impl;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidWinRefMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidWinningRef;


/**
 * 中标和供应商的映射service实现类
 * @author 冉德茂
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Service
@Transactional
public class CgBidWinRefMngImpl extends BaseManagerImpl<BidWinningRef> implements CgBidWinRefMng {

	/*
	 * 保存中标和供应商的映射信息
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */

	@Override
	public void save(BidWinningRef bean,Integer mainid, Integer wid) {
		bean.setFbIdId(mainid);
		bean.setFwId(wid);
		bean = (BidWinningRef) super.saveOrUpdate(bean);		
	}

/*	@Override
	public List<Object[]> findByBidid(Integer bidid) {

        String hql = " select fwId from BidWinningRef WHERE fbIdId ='"+bidid+"' ";    
        Query query = getSession().createQuery(hql);    
        List<Object[]> list = query.list();  
        System.out.println(list.size());

		return null;  
		
	}*/

	/*
	 * 根据中标的主id查询供应商信息  一对一   只有一条数据
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	@Override
	public List<BidWinningRef> findByBidid(Integer bidid) {
		Finder finder = Finder.create(" FROM BidWinningRef WHERE fbIdId="+bidid+" ");
		return super.find(finder);
	}




	


	



	
	


}

	
	
	



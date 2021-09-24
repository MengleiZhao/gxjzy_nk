package com.braker.icontrol.cgmanage.cgprocess.manager.impl;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidExpRefMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidExpertRef;



/**
 * 中标和评标专家的映射service实现类
 * @author 冉德茂
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Service
@Transactional
public class CgBidExpRefMngImpl extends BaseManagerImpl<BidExpertRef> implements CgBidExpRefMng {
	/**
	 * 保存中标和评标专家的对应信息
	 * @author 冉德茂
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */

	@Override
	public void save(Integer mainid, Integer eid) {
		BidExpertRef bean=new BidExpertRef();
		bean.setFbIdId(mainid);
		bean.setFeId(eid);
		bean = (BidExpertRef) super.saveOrUpdate(bean);		

	}




	


	



	
	


}

	
	
	



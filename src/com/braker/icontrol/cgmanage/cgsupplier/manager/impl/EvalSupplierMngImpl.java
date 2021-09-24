package com.braker.icontrol.cgmanage.cgsupplier.manager.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.EvalSupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierEvaluaInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

/**
 * 供应商评价的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-21
 * @updatetime 2018-09-21
 */
@Service
@Transactional
public class EvalSupplierMngImpl extends BaseManagerImpl<SupplierEvaluaInfo> implements EvalSupplierMng {
	@Autowired
	private CgApplysqMng cgApplySqMng;
	
	
	
	/*
	 * 保存供应商的评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@Override
	public void save(SupplierEvaluaInfo bean,User user,String fpid, String fwid, String fpcode, String fpname,String zonghe, String price, String rate, String quality,String service, String fremark,String isniming) {
		/*System.out.println("fpid-----"+fpid);
		System.out.println("fwid-----"+fwid);
		System.out.println("采购名称-----"+fpname);
		System.out.println("采购编码-----"+fpcode);
		System.out.println("综合评价-----"+zonghe);
		System.out.println("价格-----"+price);
		System.out.println("性价比-----"+rate);
		System.out.println("质量-----"+quality);
		System.out.println("服务-----"+service);
		System.out.println("评价-----"+fremark);
		System.out.println("匿名评价-----"+isniming);
		System.out.println(bean.getFeId());*/
		
		bean.setFpId(Integer.valueOf(fpid));
		bean.setFwId(Integer.valueOf(fwid));
		bean.setFpCode(fpcode);
		bean.setFpName(fpname);
		bean.setFcompScore(zonghe);
		bean.setFpriceScore(price);
		bean.setFcostPerf(rate);
		bean.setFquality(quality);
		bean.setFservice(service);
		bean.setFremark(fremark);
		if(isniming.equals("0")){//匿名评价
			bean.setFuserName(null);
			bean.setFdeptName(null);
		}else if(isniming.equals("1")){//非匿名评价
			bean.setFuserName(user.getName());
			bean.setFdeptName(user.getDepartName());
		}
		bean.setFsupTime(new Date());
		
		bean = (SupplierEvaluaInfo) super.saveOrUpdate(bean);//保存供应商的评价信息

		PurchaseApplyBasic purbean = cgApplySqMng.findById(Integer.valueOf(fpid));
		purbean.setFevalStauts("1");
		super.merge(purbean);//更改采购信息的评价状态 
		
	}
	/*
	 *通过fpid查询供应商的评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@Override
	public  List<SupplierEvaluaInfo> findEvalSupplierbyFpid(Integer pid) {
		Finder finder = Finder.create(" FROM SupplierEvaluaInfo WHERE fpId="+pid+"  ");	
		return super.find(finder);
	}
	/*
	 * 分页查询(查询供应商的评价记录信息  只读  评价在采购验收时操作根据供应商的id查询)
	 * @author 冉德茂
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	@Override
	public Pagination pageList(SupplierEvaluaInfo bean, String wid,int pageNo, int pageSize) {
		Finder finder =Finder.create("  FROM SupplierEvaluaInfo WHERE fwId="+wid+" ");
		if(!StringUtil.isEmpty(bean.getFpCode())){
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		finder.append(" order by feId desc");
		
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 *通过fwid查询该供应商的所有评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@Override
	public List<SupplierEvaluaInfo> findEvalSupplierbyFwid(Integer wid) {
		Finder finder = Finder.create(" FROM SupplierEvaluaInfo WHERE fwId="+wid+"  ");	
		return super.find(finder);
	}
	



	

}

	
	
	



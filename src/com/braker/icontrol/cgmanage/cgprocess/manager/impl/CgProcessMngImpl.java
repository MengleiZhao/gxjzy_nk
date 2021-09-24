package com.braker.icontrol.cgmanage.cgprocess.manager.impl;



import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidWinRefMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidWinningRef;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierTransactionHisMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierTransactionHis;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.expend.apply.model.MeetPlan;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 招标登记的service实现类
 * @author 冉德茂
 * @createtime 2018-07-23
 * @updatetime 2018-07-23
 */
@Service
@Transactional
public class CgProcessMngImpl extends BaseManagerImpl<BiddingRegist> implements CgProcessMng {
	@Autowired
	private CgApplysqMng cgApplysqMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private CgBidWinRefMng bwrefMng;
	@Autowired
	private SupplierMng supplierMng;
	@Autowired
	private SupplierTransactionHisMng supplierTransMng;
	@Autowired
	private RoleMng roleMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private CgConPlanListMng cgConPlanListMng;
	@Autowired
	private CgSelMng cgSelMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private CgReceiveMng reciveMng;
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@Override
	public Pagination pageList(BiddingRegist bean, String timea, String timeb, Integer pageNo, Integer pageSize) {		

		//Finder finder =Finder.create(" FROM BiddingRegist WHERE fstatus <>"+99+" AND fstartTime< :now ").setParam("now", new Date()); 查看开标时间小于当前系统时间的数据
		Finder finder =Finder.create(" FROM BiddingRegist WHERE fstatus <>"+99+" ");
		if(!StringUtil.isEmpty(bean.getFbiddingCode())){ //按采购编号模糊查询
			finder.append(" AND fbiddingCode LIKE :fbiddingCode");
			finder.setParam("fbiddingCode", "%"+bean.getFbiddingCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFbiddingName())){ //按采购名称模糊查询
			finder.append(" AND fbiddingName LIKE :fbiddingName");
			finder.setParam("fbiddingName", "%"+bean.getFbiddingName()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(timea)) && !StringUtil.isEmpty(String.valueOf(timeb))){
			finder.append(" AND DATE_FORMAT(fstartTime,'%Y-%m-%d') >='"+timea+"' AND DATE_FORMAT(fstartTime,'%Y-%m-%d') <= '"+timeb+"'");//日期去时分秒函数
		} else if(!StringUtil.isEmpty(String.valueOf(timea))){
			finder.append(" AND DATE_FORMAT(fstartTime,'%Y-%m-%d') >='"+timea+"'");//日期去时分秒函数
		} else if(!StringUtil.isEmpty(String.valueOf(timeb))){
			finder.append(" AND  DATE_FORMAT(fstartTime,'%Y-%m-%d') <= '"+timeb+"'");//日期去时分秒函数
		}
		finder.append(" order by fbId desc ");
		
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 中标页面选择  开标日期小于当前系统时间的数据进行中标登记
	 * @author 冉德茂
	 * @createtime 2018-10-19
	 * @updatetime 2018-10-19
	 */
	@Override
	public List<BiddingRegist> pickZBPage(BiddingRegist bean) {
		//中标页面选择  开标日期小于当前系统时间   未中标的数据进行中标登记  
		Finder finder =Finder.create(" FROM BiddingRegist WHERE fstatus <>"+99+" AND fbidStatus ="+0+" AND fstartTime< :now ").setParam("now", new Date()); 
		if(!StringUtil.isEmpty(bean.getFbiddingCode())){ //按采购编号模糊查询
			finder.append(" AND fbiddingCode LIKE :fbiddingCode");
			finder.setParam("fbiddingCode", "%"+bean.getFbiddingCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFbiddingName())){ //按采购名称模糊查询
			finder.append(" AND fbiddingName LIKE :fbiddingName");
			finder.setParam("fbiddingName", "%"+bean.getFbiddingName()+"%");
		}
		return super.find(finder);
	}
	
	
	
	/*
	 *获取所有的已审批的基本信息进行招标
	 * @author 冉德茂
	 * @createtime 2018-10-23
	 * @updatetime 2018-10-23
	 */
	@Override
	public List<PurchaseApplyBasic> pageBasicInfoList(PurchaseApplyBasic bean) {	
		//选择已审批  未删除  未招标过的数据进行招标（不存在流标 10月23更改   之前功能存在流标）
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fStauts <>"+99+" AND fCheckStauts="+9+" AND ftendingStauts="+0+" ");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		finder.append(" order by fpId desc ");
		return super.find(finder);
	}
	
	/*
	 *保存招标登记信息
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */	
	
	@Override
	public void save(String fbidStauts, BiddingRegist bean, String form, String files, User user) throws Exception{
		bean.setFstatus("0");	//新增和修改  数据的删除状态都是0
		Date date = new Date();	//当前时间
		//通过pid查询采购信息  给登记状态赋值
		PurchaseApplyBasic cgsqbean = cgsqMng.findById(bean.getFpId());
		cgsqbean.setFbidStauts(fbidStauts);
		
		if (bean.getFbId()==null) {//新增	暂存部分信息至供应商表
			//采购过程登记
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
			
		} else {//修改
			BiddingRegist oldbean = findById(bean.getFbId());
			//采购过程登记
			//修改人、修改时间
			oldbean.setUpdator(user.getName());
			oldbean.setUpdateTime(date);
			oldbean.setFbidAmount(bean.getFbidAmount());
			oldbean.setFbidTime(bean.getFbidTime());
		}
		cgsqbean.setBidTime(date);
		
		//删除旧供应商
		getSession().createSQLQuery("delete from T_WINNING_BIDDER where F_P_ID="+bean.getFpId()+"").executeUpdate();
		//新供应商
		List<WinningBidder> newBidderList =  JSON.parseObject(form, new TypeReference<List<WinningBidder>>(){});
		//保存新供应商
		for (int i = 0; i < newBidderList.size(); i++) {
			WinningBidder newBidder = newBidderList.get(i);
			newBidder.setFpabId(bean.getFpId());
			//保存新的明细
			super.merge(newBidder);
		}
		
		if("1".equals(fbidStauts) && StringUtil.isEmpty(cgsqbean.getBidAlready())) {
			cgsqbean.setBidAlready("1");
			AcceptCheck acceptCheck = new AcceptCheck();
			acceptCheck.setFpId(cgsqbean.getFpId());
			acceptCheck.setFpCode(cgsqbean.getFpCode());
			acceptCheck.setFacpName(cgsqbean.getFpName());
			acceptCheck.setFacpAmount(cgsqbean.getFpAmount().doubleValue());
			acceptCheck.setFacpName(cgsqbean.getFpName());
			acceptCheck.setCgUser(cgsqbean.getfUser());
			acceptCheck.setCgUserName(cgsqbean.getfUserName());
			acceptCheck.setCgDept(cgsqbean.getfDeptId());
			acceptCheck.setCgDeptName(cgsqbean.getfDeptName());
			acceptCheck.setCgTime(cgsqbean.getfReqTime());
			reciveMng.saveOrUpdate(acceptCheck);
		}
		
		
		
		//保存采购信息
		cgsqbean = (PurchaseApplyBasic) super.merge(cgsqbean);
		//保存基本信息(采购过程登记)
		bean.setFpId(cgsqbean.getFpId());
		bean = (BiddingRegist) super.merge(bean);
		

		Double fbidAmount = 0.00;
		
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		BigDecimal fbidAmounts = new BigDecimal(fbidAmount);
		BigDecimal amounts = cgsqbean.getFpAmount();
		
		//申请金额大于登记金额时    归还预算
		if("1".equals(fbidStauts)&&amounts.compareTo(fbidAmounts)>0){
			//采购送审时冻结金额
			budgetIndexMgrMng.deleteDjAmount(cgsqbean.getIndexId(), cgsqbean.getProDetailId(), amounts.subtract(fbidAmounts));
		}
		
	}


	/*
	 * 根据id删除
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@Override
	public void delete(Integer id) {
		BiddingRegist bean = super.findById(id);
		bean.setFstatus("99");
		super.saveOrUpdate(bean);
	}

	/**
	 *获取原有的中标和供应商信息
	 * @author 焦广兴
	 * @createtime 2019-05-30
	 * @updatetime 2019-05-30
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}
	
	@Override
	public BiddingRegist getBiddingRegistByPId(Integer pId) {
		Finder finder = Finder.create(" FROM BiddingRegist WHERE fpId='"+pId+"'");
		List<BiddingRegist> li = super.find(finder);
		if(li.size()>0){
			return li.get(0);
		}else{
			return null;
		}
		
	}
}

	
	
	



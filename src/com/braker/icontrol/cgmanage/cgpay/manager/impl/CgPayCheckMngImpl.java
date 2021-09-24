package com.braker.icontrol.cgmanage.cgpay.manager.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgpay.manager.CgPayCheckMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TProcessCheckMng;

/**
 * 付款申请审批的的service实现类
 * @author 冉德茂
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
@Service
@Transactional
public class CgPayCheckMngImpl extends BaseManagerImpl<PurchaseApplyBasic> implements CgPayCheckMng {
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private DepartMng departMng;
	/**
	 * 分頁查詢
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@Override
	public Pagination pageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user) {		
		//区分   采购审批和付款审批
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE  fUser='"+user.getId()+"' AND fDeptId='"+user.getDpID()+"'  AND fStauts <>"+99+" AND fpayStauts <>"+0+"  ");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpMethodStr()) ){//采购方式
			finder.append(" AND fpMethod = :fpMethod");
			finder.setParam("fpMethod", bean.getFpMethodStr());
		}
		if(!StringUtil.isEmpty(bean.getfCheckStauts()) ){//审批状态
			if("2".equals(bean.getfCheckStauts())){//审核中
				finder.append(" AND fCheckStauts >0 and fCheckStauts <9");
			}else{
				finder.append(" AND fCheckStauts = :fCheckStauts");
				finder.setParam("fCheckStauts", bean.getfCheckStauts());
			}
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按申报部门模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		finder.append(" order by fpId desc ");
		return super.find(finder,pageNo,pageSize);
	}
	
	
	
	/*
	 * 保存审核信息
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, PurchaseApplyBasic bean, User user ,Role role ,String files)  throws Exception{
		bean=this.findById(bean.getFpId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/cgpayforcheck/check?id=";
		String lookUrl ="/cgpayfor/checkdetail?id=";
		bean=(PurchaseApplyBasic)tProcessCheckMng.checkProcess(checkBean,entity,user,"CGPAY",checkUrl,lookUrl,files);
		super.saveOrUpdate(bean);
	}

	/*
	 * 财务审定分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-18
	 * @updatetime 2018-08-18
	 */
	@Override
	public Pagination auditPageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user) {
		//区分   采购审批和付款审批
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fuserId='"+user.getId()+"' AND fCheckStauts=9");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpMethodStr()) ){//采购方式
			finder.append(" AND fpMethod = :fpMethodStr");
			finder.setParam("fpMethodStr", bean.getFpMethodStr());
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getFpAmount1()))){
			finder.append(" AND fpAmount >= :fpAmount");
			finder.setParam("fpAmount", bean.getFpAmount1());
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getFpAmount2()))){
			finder.append(" AND fpAmount <= :fpAmount");
			finder.setParam("fpAmount", bean.getFpAmount2());
		}
		
		return super.find(finder,pageNo,pageSize);
	}

	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@Override
	public Pagination cashierPageList(PurchaseApplyBasic bean, int pageNo,
			int pageSize, User user,String type) {
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts = '9' and  fIsReceive= '2' ");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按部门名称模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		
		if(type.equals("ledger")){
			String deptIdStr=departMng.getDeptIdStrByUser(user);
	 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
	 			finder.append(" and fpId in (select purchaseId from ReimbAppliBasicInfo where type ='10' and flowStauts = '9' and user ='"+user.getId()+"' )");
	 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
	 			
	 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
	 			finder.append(" and fpId in (select purchaseId from ReimbAppliBasicInfo where type ='10' and flowStauts = '9' and dept in ("+deptIdStr+") )");
	 		}
		}
		return super.find(finder,pageNo,pageSize);
	}
	
}

	
	
	



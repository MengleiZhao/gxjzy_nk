package com.braker.icontrol.cgmanage.cgcheck.manager.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.CgCheckMng;
import com.braker.icontrol.cgmanage.cgcheck.model.PurchaseCheckInfo;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessPrintDetailMng;


/**
 * 采购申请的service实现类
 * @author 冉德茂
 * @createtime 2018-07-10
 * @updatetime 2018-07-10
 */
@Service
@Transactional
public class CgCheckMngImpl extends BaseManagerImpl<PurchaseApplyBasic> implements CgCheckMng {
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng proItfMng; 
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProcessPrintDetailMng tProcessPrintDetailMng;
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	@Override
	public Pagination pageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user, String timea, String timeb, String amounta, String amountb) {		
		//区分   采购审批和付款审批
		//Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE userName2='"+user.getName()+"' AND fDeptName='"+user.getDepartName()+"'AND fCheckStauts="+1+" AND fStauts <>"+99+" ");
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fuserId='"+user.getId()+"' AND fStauts <> '99' AND fpayStauts ='0'  ");
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
		/*if(!StringUtil.isEmpty(bean.getForgtype())){//组织形式
			finder.append(" AND fOrgType.code = :fOrgType");
			finder.setParam("fOrgType", bean.getForgtype());
		}*/
		if(!StringUtil.isEmpty(bean.getfCheckStauts()) ){//审批状态
			if("2".equals(bean.getfCheckStauts())){//审核中
				finder.append(" AND fCheckStauts >0 and fCheckStauts <9");
			}else{
				finder.append(" AND fCheckStauts = :fCheckStauts");
				finder.setParam("fCheckStauts", bean.getfCheckStauts());
			}
		}
		finder.append(" order by fpId desc ");
		return super.find(finder,pageNo,pageSize);
	}

	/*
	 * 历史审批记录
	 * @author 冉德茂
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	@Override
	public List<PurchaseCheckInfo> checkHistory(Integer id, String stauts) {
		Finder finder = Finder.create(" FROM PurchaseCheckInfo WHERE fpId="+id);
		if(stauts != null) {
			finder.append(" AND stauts='"+stauts+"'");
		}
		finder.append(" order by cId desc");
		List<PurchaseCheckInfo> li = super.find(finder);
		return li;
	}

	/*
	 * 保存审核信息
	 * @author 李安达
	 * @createtime 2019-04-129
	 * @updatetime 2019-04-129
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, PurchaseApplyBasic bean, User user,String files)  throws Exception {
		//保存采购类型和采购方式
		String fpPype=null;
		String fpMethod = null;
		fpPype = bean.getFpPype();
		fpMethod = bean.getFpMethod();
		bean = this.findById(bean.getFpId());
		bean.setFpPype(fpPype);
		bean.setFpMethod(fpMethod);
		/*if(!StringUtil.isEmpty(bean.getFpMethod())){	//采购方式已由某级审批人输入
			fpMethod = bean.getFpMethod();
			bean.setFpMethod(fpMethod);
		}*/
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/cgcheck/check?id=";
		String lookUrl ="/cgsqsp/detail?id=";
		//查询工作流
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			bean=(PurchaseApplyBasic)tProcessCheckMng.checkProcess(checkBean,entity,user,"HWCGSQ",checkUrl,lookUrl,files);
		}else{
			bean=(PurchaseApplyBasic)tProcessCheckMng.checkProcess(checkBean,entity,user,"GCCGSQ",checkUrl,lookUrl,files);
		}
		if("-1".equals(bean.getfCheckStauts())){//审批不通过的时候，归还冻结金额
			//审批不通过的时候，归还冻结金额
			budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getFpAmount());
		}
		if("9".equals(bean.getfCheckStauts())){//审批通过的时候,获取审批流程中的审批人信息
//			tProcessPrintDetailMng.arrangeCGCheckDetail(bean, null, user);
		}
		//bean=(PurchaseApplyBasic)tProcessCheckMng.checkProcess(checkBean,entity,user,"CGSQ",checkUrl,lookUrl,files);
		super.saveOrUpdate(bean);
		
	}

	@Override
	public Pagination updatePageList(PurchaseApplyBasic bean, Integer page, Integer rows, User user) {
		Finder finder =Finder.create(" FROM PurchaseUpdateInfo WHERE fpId = '"+bean.getFpId()+"'");
		finder.append(" order by updateTime desc ");
		return super.find(finder,page,rows);
	}
	
	
}

	
	
	



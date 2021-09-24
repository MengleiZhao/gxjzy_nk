package com.braker.icontrol.purchase.apply.manager.Impl;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

@Service
@Transactional
public class PurchaseApplyMngImpl extends BaseManagerImpl<PurchaseApplyBasic> implements PurchaseApplyMng{

	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private UptMng uptMng;
	
	
	@Override
	public Pagination queryList(PurchaseApplyBasic purchaseApplyBasic, Integer pageNo, Integer pageSize, String sign) {
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts=9");
		if(!StringUtil.isEmpty(purchaseApplyBasic.getFpCode())){
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+purchaseApplyBasic.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(purchaseApplyBasic.getFpAmount()))){
			String pmount=purchaseApplyBasic.getFpAmount().stripTrailingZeros().toPlainString();
			finder.append(" AND fpAmount LIKE:fpAmount");
			finder.setParam("fpAmount","%"+pmount+"%");
		}
		if(!StringUtil.isEmpty(purchaseApplyBasic.getFpMethodStr())){
			finder.append(" AND fpMethod.code =:fpMethod");
			finder.setParam("fpMethod", purchaseApplyBasic.getFpMethodStr());
		}
		if(!StringUtil.isEmpty(purchaseApplyBasic.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+purchaseApplyBasic.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(purchaseApplyBasic.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+purchaseApplyBasic.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(sign)){	//采购验收状态 tab标签页		sign： 0- (0暂存，1待验收，-1已退回)		1- 9已验收	2-审批页面
			if("1".equals(sign)){
				finder.append(" AND fIsReceive = :fIsReceive");
			}else {
				finder.append(" AND fIsReceive <> :fIsReceive");
				
			}
			finder.append(" AND fbidStauts = 1");
			purchaseApplyBasic.setfIsReceive("9");
			finder.setParam("fIsReceive", purchaseApplyBasic.getfIsReceive());
		}
		//待审批列表页
		if("awaitCheck".equals(purchaseApplyBasic.getfIsReceive())){	
			finder.append(" AND fIsReceive = 1");
		}
		if(!StringUtil.isEmpty(purchaseApplyBasic.getFevalStauts())){//评价状态
			finder.append(" AND fevalStauts = :fevalStauts");
			finder.setParam("fevalStauts", purchaseApplyBasic.getFevalStauts());
		}
		finder.append(" order by fReqTime desc");
		return super.find(finder,pageNo,pageSize);
	}

	@Override
	public List<PurchaseApplyBasic> find1Condition(String condition1, String val1) {
		Finder finder =Finder.create(" from PurchaseApplyBasic where "+condition1+"='"+val1+"'");
		return super.find(finder);
	}

	@Override
	public Pagination queryReceiveList(AcceptCheck acceptCheck,
			Integer pageNo, Integer pageSize, User user) {
		Finder finder =Finder.create(" FROM AcceptCheck WHERE cgUser ='"+user.getId()+"'");
		
		if(!StringUtil.isEmpty(acceptCheck.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+acceptCheck.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(acceptCheck.getFacpName())){ //按采购名称模糊查询
			finder.append(" AND facpName LIKE :facpName");
			finder.setParam("facpName", "%"+acceptCheck.getFacpName()+"%");
		}
		if(!StringUtil.isEmpty(acceptCheck.getfDepartName())){ //按采购申请部门模糊查询
			finder.append(" AND cgDeptName LIKE :cgDeptName");
			finder.setParam("cgDeptName", "%"+acceptCheck.getCgDeptName()+"%");
		}
		finder.append(" order by cgTime desc ");//fIsReceive,  不需要根据状态排序
		return super.find(finder,pageNo, pageSize);
	}

	private void contractAndUpt(List<PurchaseApplyBasic> list,
			PurchaseApplyBasic purchaseApplyBasic2) {
		if("1".equals(purchaseApplyBasic2.getFbidStauts())){
			ContractBasicInfo contractBasicInfo = formulationMng.findAttacByFPurchNo(String.valueOf(purchaseApplyBasic2.getFpId()));
			if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getFcId()))){
				if("9".equals(String.valueOf(contractBasicInfo.getfFlowStauts()))){
					if("0".equals(contractBasicInfo.getfUpdateStatus()) || StringUtil.isEmpty(contractBasicInfo.getfUpdateStatus())){
						list.add(purchaseApplyBasic2);
					}else{
						List<Upt> upts = uptMng.findByFContId_U(String.valueOf(contractBasicInfo.getFcId()));
						if(upts.size()>0){
							Upt upt = upts.get(0);
							if("9".equals(upt.getfUptFlowStauts())){
								list.add(purchaseApplyBasic2);
							}
						}
					}
				}
			}
		}
	}

	@Override
	public Pagination queryReceiveCheckList(
			PurchaseApplyBasic purchaseApplyBasic, Integer pageNo,
			Integer pageSize, User user) {
		StringBuilder sb = new StringBuilder("select b.F_P_ID as fpId,b.F_P_CODE as fpCode,b.F_P_NAME as fpName,b.F_AMOUNT as fAmount,b.F_REQ_TIME as fReqTime,"
				+ "b.F_USER as fUser,b.F_DEPT_NAME as fDeptName,a.F_ACP_ID as fAcpId,b.F_IS_RECEIVE as fIsReceive,b.F_ITEMS as fItems,b.F_USER_NAME as fUserName ,b.F_IS_CONTRACT as fIsContract"
				+ " from T_ACCEPT_CHECK a left join T_PURCHASE_APPLY_BASIC b on a.F_P_ID = b.F_P_ID where b.F_STAUTS <>99"
				+ " and a.F_STAUTS <>99 and b.F_CHECK_STAUTS ='9'");
			sb.append(" and a.F_USER_CODE ='"+user.getId()+"'");
		if (!StringUtil.isEmpty(purchaseApplyBasic.getFpCode())){
			sb.append(" and b.F_P_CODE='"+purchaseApplyBasic.getFpCode()+"'");//采购申请编号
		}
		if (!StringUtil.isEmpty(purchaseApplyBasic.getFpName())) {
			sb.append(" and b.F_P_NAME='"+purchaseApplyBasic.getFpName()+"'");//采购申请名称
		}
		if (!StringUtil.isEmpty(purchaseApplyBasic.getfDeptName())) {//采购申请部门
			sb.append(" and b.F_DEPT_NAME='"+purchaseApplyBasic.getfDeptName()+"'");
		}
		sb.append(" ORDER BY a.F_CHECK_STAUTS,a.F_ACP_TIME DESC");
		String str=sb.toString();
		Pagination p1 =super.findObjectListBySql(str, pageNo, pageSize);
		List<Object[]> dataList = (List<Object[]>) p1.getList();
		List<PurchaseApplyBasic>list=new ArrayList<>();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (Object[] obj: dataList) {
				PurchaseApplyBasic t=new PurchaseApplyBasic();
				t.setFpId(Integer.valueOf(String.valueOf(obj[0])));
				t.setFpCode(String.valueOf(obj[1]));
				t.setFpName(String.valueOf(obj[2]));
				t.setFpAmount(BigDecimal.valueOf(Double.valueOf(String.valueOf(obj[3]))));
				DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); 
				try {
					t.setfReqTime(sdf.parse(sdf.format(obj[4])));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				t.setfUser(String.valueOf(obj[5]));
				t.setfDeptName(String.valueOf(obj[6]));
				t.setfAcpId(Integer.valueOf(String.valueOf(obj[7])));
				t.setfIsReceive(String.valueOf(obj[8]));
				t.setfItems(String.valueOf(obj[9]));
				t.setfUserName(String.valueOf(obj[10]));
				t.setfIsContract(String.valueOf(obj[11]));
				t.setNumber(pageNo * pageSize + i - (pageSize-1));
				i++;
				list.add(t);
			}
			p1.setList(list);
		}
		return p1;
	}
}

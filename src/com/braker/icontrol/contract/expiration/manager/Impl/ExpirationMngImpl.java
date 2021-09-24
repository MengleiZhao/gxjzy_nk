package com.braker.icontrol.contract.expiration.manager.Impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.expiration.manager.ExpirationMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;

@Service
@Transactional
public class ExpirationMngImpl extends BaseManagerImpl<ContractBasicInfo> implements ExpirationMng{

	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Override
	public List<ContractBasicInfo> find(ContractBasicInfo contractBasicInfo, User user,Integer pageNo, Integer pageSize) throws ParseException {
		try {
			String sql ="SELECT rp.F_CONT_ID,rp.F_PLAN_ID,min( F_RECE_PLAN_TIME ),rp.F_RECE_PROPERTY,rp.F_RECE_CONDITION,rp.F_RECE_PLAN_AMOUNT,wfk.wfk_amount  "
					+ "from t_contract_basic_info cbi,t_receiv_plan rp ,( SELECT F_CONT_ID, sum( F_RECE_PLAN_AMOUNT ) AS wfk_amount FROM t_receiv_plan WHERE F_STAUTS = 0 GROUP BY F_CONT_ID ) wfk "
					+ "where cbi.F_CONT_ID = wfk.F_CONT_ID AND cbi.F_CONT_ID = rp.F_CONT_ID  and rp.F_STAUTS='0' and cbi.F_CONT_STAUTS in(11,9,7) ";
			if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
				sql+=" and cbi.F_CONT_CODE like '%"+contractBasicInfo.getFcCode()+"%'";
			}
			if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
				sql+=" and cbi.F_CONT_TITLE like '%"+contractBasicInfo.getFcTitle()+"%'";
			}
			if(!StringUtil.isEmpty(contractBasicInfo.getfSignUser())){
				sql+=" and cbi.F_SIGN_USER like '%"+contractBasicInfo.getfSignUser()+"%'";
			}
			if(!StringUtil.isEmpty(contractBasicInfo.getfReceProperty())){
				sql+=" and rp.F_RECE_PROPERTY ='"+contractBasicInfo.getfReceProperty()+"'";
			}
			sql+=" GROUP BY rp.F_CONT_ID order by min( F_RECE_PLAN_TIME ) desc";
			sql+=" limit "+(pageNo-1)+","+pageSize;
			
			Query query = getSession().createSQLQuery(sql);
			List<Object[]> li= query.list();
			List<ReceivPlan> rp=new ArrayList<ReceivPlan>();
			for (int i = 0; i < li.size(); i++) {
				ReceivPlan receivPlan=new ReceivPlan();
				receivPlan.setfContId_R((Integer) li.get(i)[0]);
				receivPlan.setfPlanId((Integer) li.get(i)[1]);
				receivPlan.setfRecePlanTime((Date) li.get(i)[2]);
				receivPlan.setfReceProperty((String) li.get(i)[3]);
				receivPlan.setfReceCondition((String) li.get(i)[4]);
				receivPlan.setfRecePlanAmount(BigDecimal.valueOf((Double) li.get(i)[5]));
				receivPlan.setfNotAllAmountL(BigDecimal.valueOf(Double.valueOf(li.get(i)[6].toString())));
			    int datenum=DateUtil.getDaySpanNoAbs(new Date(),receivPlan.getfRecePlanTime());
		    	receivPlan.setDatenum(datenum);
		    	rp.add(receivPlan);
			}
			String countIdS="";
			for (int i = 0; i < rp.size(); i++) {
				if("".equals(countIdS)){
					countIdS=rp.get(i).getfContId_R()+"";
				}else{
					countIdS=countIdS+","+rp.get(i).getfContId_R();
				}
			}
			List<ContractBasicInfo> CBI=new ArrayList<ContractBasicInfo>();
			if(!"".equals(countIdS)){
			//根据ID字符串去查询合同基本信息表集合，以fcId为Key，以ContractBasicInfo 为value
			Map<Integer,ContractBasicInfo> infoMap=getContractBasicInfoMapByIds(countIdS);
			for (int i = 0; i < rp.size(); i++) {
				ContractBasicInfo c=infoMap.get(rp.get(i).getfContId_R());
				if(c!=null){
					c.setfPlanId(rp.get(i).getfPlanId());
					c.setfRecePlanTime(rp.get(i).getfRecePlanTime());
					c.setfReceProperty(rp.get(i).getfReceProperty());
					c.setfReceCondition(rp.get(i).getfReceCondition());
					c.setfRecePlanAmount(rp.get(i).getfRecePlanAmount().doubleValue());
					c.setDatenumber(rp.get(i).getDatenum());
					c.setfNotAllAmountL(rp.get(i).getfNotAllAmountL().toString());
					if(StringUtil.isEmpty(c.getFcAmount())){
						c.setFcAmount("0");
					}
					/*if(!StringUtil.isEmpty(c.getfAllAmount())){
						c.setfNotAllAmountL(String.valueOf(Double.valueOf(c.getFcAmount())-Double.valueOf(c.getfAllAmount())));
					}else{
						c.setfNotAllAmountL(String.valueOf(Double.valueOf(c.getFcAmount())));
					}*/
					CBI.add(c);
				}
				}	
			}
			return CBI;
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据ID字符串去查询合同基本信息表集合，以fcId为Key，以ContractBasicInfo 为value
	 * @param countIdS
	 * @return
	 */
	public Map<Integer,ContractBasicInfo> getContractBasicInfoMapByIds(String countIdS){
		Map<Integer,ContractBasicInfo> infoMap=new HashMap<Integer,ContractBasicInfo>();
		Finder finder = Finder.create(" FROM ContractBasicInfo WHERE fcId in("+countIdS+")");
		List<ContractBasicInfo> infoList=super.find(finder);
		if(infoList!=null && infoList.size()>0){
			for(ContractBasicInfo info:infoList){
				infoMap.put(info.getFcId(), info);
			}
		}
		return infoMap;
	}
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("FROM Lookups WHERE flag='1' ");
		hql.append("  AND category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" AND code<>:code").setParam("code", blanked);
		}
		hql.append(" ORDER BY convert(orderNo,SIGNED)");
		return super.find(hql);
	}

	@Override
	public void remindPayMoney() {
		
		
		// TODO Auto-generated method stub
		String sql ="SELECT rp.F_CONT_ID,rp.F_PLAN_ID,min( F_RECE_PLAN_TIME ),rp.F_RECE_PROPERTY,rp.F_RECE_CONDITION,rp.F_RECE_PLAN_AMOUNT "
				+ "from t_contract_basic_info cbi,t_receiv_plan rp "
				+ "where cbi.F_CONT_ID=rp.F_CONT_ID and rp.F_STAUTS='0' and cbi.F_CONT_STAUTS in(11,9,7) ";
		sql+=" GROUP BY rp.F_CONT_ID order by min( F_RECE_PLAN_TIME ) desc";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> li= query.list();
		List<ReceivPlan> rp=new ArrayList<ReceivPlan>();
		for (int i = 0; i < li.size(); i++) {
			ReceivPlan receivPlan=new ReceivPlan();
			receivPlan.setfContId_R((Integer) li.get(i)[0]);
			receivPlan.setfPlanId((Integer) li.get(i)[1]);
			receivPlan.setfRecePlanTime((Date) li.get(i)[2]);
			receivPlan.setfReceProperty((String) li.get(i)[3]);
			receivPlan.setfReceCondition((String) li.get(i)[4]);
			receivPlan.setfRecePlanAmount(BigDecimal.valueOf((Double) li.get(i)[5]));
		    int datenum=DateUtil.getDaySpanNoAbs(new Date(),receivPlan.getfRecePlanTime());
		    	receivPlan.setDatenum(datenum);
		    	rp.add(receivPlan);
		}
		
		
		//通过消息推送，提示页面main.jsp更新待办事项数字
		for (int i = 0; i < rp.size(); i++) {
			 int days = DateUtil.getDaySpan(rp.get(i).getfRecePlanTime(),DateUtil.today());
			 //判断是不是在60、30、20、10、10 天以内 公式：今天-计划付款时间
			 if(days==60||days==30||days==20||days<=10){
				ContractBasicInfo c=formulationMng.get(rp.get(i).getfContId_R());
				User user = userMng.findById(String.valueOf(rp.get(i).getfContId_R()));
				Lookups receProperty = lookupsMng.findByLookCode(rp.get(i).getfReceProperty());
				String title=c.getFcTitle()+"合同付款提醒";
				String msg="您有一份'"+c.getFcTitle()+"'合同的"+receProperty.getName()+"还差"+days+"天就要付款了，请尽快办理！";
				privateInforMng.setMsg(title, msg, c.getUserId(), "3");
			}
			
		}
		
	}

	@Override
	public void remindContract() {
		Finder finder = Finder.create(" from ContractBasicInfo where fContStauts not in('-1',3,99)");	
		List<ContractBasicInfo> contList = super.find(finder);
		
		
		//通过消息推送，提示页面main.jsp更新待办事项数字
		for (int i = 0; i < contList.size(); i++) {
			//距离到期时间  = 今天 - 合同结束时间
			Integer days = DateUtil.getDaySpan(contList.get(i).getfContEndTime(),DateUtil.today());
			//中期时间  = 结束时间-开始时间除以2
			Integer mediumdays = DateUtil.getDaySpan(contList.get(i).getfContEndTime(),contList.get(i).getfContStartTime())/2;
			//合同开始到今天共多少天
			Integer sumdays = DateUtil.getDaySpan(DateUtil.today(),contList.get(i).getfContStartTime());
			
			//（结束时间-开始时间除以2）和到期前5天进行消息提醒，内容为：您有一份XX合同正在XX状态
			if(days <= 5||mediumdays==sumdays){
				String title=contList.get(i).getFcTitle()+"合同执行提醒";
				String msg="您有一份'"+contList.get(i).getFcTitle()+"'合同"+contList.get(i).getFcCode()+"正在执行，请尽快办理！";
				privateInforMng.setMsg(title, msg, contList.get(i).getfOperatorId(), "3");
			}
			
		}
		
		
		
	}


}

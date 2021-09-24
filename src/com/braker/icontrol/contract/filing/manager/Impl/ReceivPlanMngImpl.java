package com.braker.icontrol.contract.filing.manager.Impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;

@Service
@Transactional
public class ReceivPlanMngImpl extends BaseManagerImpl<ReceivPlan> implements ReceivPlanMng{

	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private UptMng uptMng;
	
	@Override
	public List<ContractBasicInfo> query_Amount(List<ContractBasicInfo> li) {
		
		for (int i = 0; i < li.size(); i++) {
			String sql = "SELECT sum(F_RECE_AMOUNT) fAllAmount FROM t_receiv_plan WHERE F_CONT_ID="+li.get(i).getFcId();
			Query query=getSession().createSQLQuery(sql);
			List fAllAmount = query.list();
			if(StringUtil.isEmpty(String.valueOf(fAllAmount.get(0)))){
				fAllAmount.set(0, "0.00");
			}
			li.get(i).setfAllAmount(String.valueOf(fAllAmount.get(0)));
			Double fcAmount=Double.valueOf(li.get(i).getFcAmount());
			Double fAAmount=Double.valueOf(String.valueOf(fAllAmount.get(0)));
			li.get(i).setfNotAllAmountL(String.valueOf(fcAmount-fAAmount));
		}
		return li;
	}

	@Override
	public Pagination allPlan(Integer id, Integer pageNo, Integer pageSize) {
		ContractBasicInfo cbi = formulationMng.findById(id);
		List<ReceivPlan> planList = finduptandbase(cbi);
		Finder finder=Finder.create(" FROM ReceivPlan WHERE fContId_R="+id+" ORDER BY fReceProperty DESC");
		Pagination p = new Pagination();
		p.setList(planList);
		p.setPageNo(pageNo);
		p.setPageSize(planList.size());
		p.setTotalCount(planList.size());
		return p;
	}

	@Override
	public List<ReceivPlan> findUnPay(Integer fContId_R) {
		Finder finder=Finder.create(" FROM ReceivPlan WHERE fContId_R="+fContId_R+" AND fStauts_R=0");
		return super.find(finder);
	}

	@Override
	public List<ReceivPlan> queryMoney1(Integer id) {
		Finder finder=Finder.create("FROM ReceivPlan WHERE fStauts_R='0' AND fContId_R="+id);
		return super.find(finder);
	}

	@Override
	public List<ReceivPlan> findbyUptId(Integer uptid) {
		Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='1' AND fUptId_R="+uptid);
		return super.find(finder);
	}
	
	@Override
	public List<ReceivPlan> findbyConId(Integer fcId) {
		Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='0' AND fContId_R="+fcId);
		return super.find(finder);
	}

	@Override
	public List<ReceivPlan> finduptandbase(String ctype, Integer cid) {
		List<ReceivPlan> payedPlan = new ArrayList<ReceivPlan>();
		if("0".equals(ctype)||"2".equals(ctype)){//未变更
			Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='0' AND fContId_R="+cid);
			payedPlan = super.find(finder);
		}else if("1".equals(ctype)){//有变更
			
			Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='1' AND fUptId_R="+cid);
			Finder finder1=Finder.create("FROM ReceivPlan WHERE fStauts_R ='1' and dataType='0' AND fContId_R="+cid);
			payedPlan = super.find(finder);
			List<ReceivPlan> unPayPlan = super.find(finder1);
			for (int i = 0; i < unPayPlan.size(); i++) {
				payedPlan.add(unPayPlan.get(i));
			}
		}
		return payedPlan;
	}

	
	@Override
	public List<ReceivPlan> finduptandbaseNew(ContractBasicInfo cbi) {
		String ctype =cbi.getfUpdateStatus();
		List<ReceivPlan> payedPlan = new ArrayList<ReceivPlan>();
		if("0".equals(ctype)||"2".equals(ctype)){//未变更
			Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='0' AND fContId_R="+cbi.getFcId());
			payedPlan = super.find(finder);
		}else if("1".equals(ctype)){//有变更
			Upt upt=uptMng.findByFContId_U(cbi.getFcId().toString()).get(0);
			if("1".equals(upt.getFsealedStatus())){
				Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='1' AND fUptId_R="+upt.getfId_U());
				payedPlan = super.find(finder);
			}else{
				Finder finder=Finder.create("FROM ReceivPlan WHERE dataType='0' AND fContId_R="+cbi.getFcId());
				payedPlan = super.find(finder);
			}
			
			//Finder finder1=Finder.create("FROM ReceivPlan WHERE fStauts_R ='1' and dataType='0' AND fContId_R="+cbi.getFcId());
			
			/*List<ReceivPlan> unPayPlan = super.find(finder1);
			for (int i = 0; i < unPayPlan.size(); i++) {
				payedPlan.add(unPayPlan.get(i));
			}*/
		}
		return payedPlan;
	}
	
	public List<ReceivPlan> finduptandbase(ContractBasicInfo cbi) {
		String ctype =cbi.getfUpdateStatus();
		List<ReceivPlan> payedPlan = new ArrayList<ReceivPlan>();
		Finder finder=Finder.create("FROM ReceivPlan WHERE fContId_R="+cbi.getFcId());
		payedPlan = super.find(finder);
		return payedPlan;
	}
}

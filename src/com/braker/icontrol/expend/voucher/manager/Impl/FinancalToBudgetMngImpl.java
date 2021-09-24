package com.braker.icontrol.expend.voucher.manager.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.voucher.entity.FinancalToBudget;
import com.braker.icontrol.expend.voucher.manager.FinancalToBudgetMng;

@Service
public class FinancalToBudgetMngImpl extends BaseManagerImpl<FinancalToBudget> implements FinancalToBudgetMng{

	@Override
	public String toBudget(String financal) {
		//根据财务会计科目编号查询
		FinancalToBudget financalToBudget = new FinancalToBudget();
		financalToBudget.setfFinancialCode(financal);
		financalToBudget = findbyFinancialCode(financalToBudget);
		//预算会计科目编号
		String fBudgeyCode = financalToBudget.getfBudgeyCode();
		//预算会计名称
		String fBudgeyName = "";
		for (int i = 0; i < fBudgeyCode.length(); i++) {
			//如果长度小于4个就不在继续
			if(fBudgeyCode.length()-(i*2)>=4){
				String str1 = fBudgeyCode.substring(0, fBudgeyCode.length()-(i*2));
				FinancalToBudget ftb = findbyproperties("fBudgeyCode",str1);
				String name = ftb.getfBudgeyName();
				//如果为空值不拼接
				if(StringUtil.isEmpty(fBudgeyName)){
					fBudgeyName = name ;
				}else {
					fBudgeyName = name +"_"+ fBudgeyName;
				}
			}
		}
		String codeAndName = fBudgeyCode +"\n"+ fBudgeyName;
		return codeAndName;
	}

	@Override
	public List<FinancalToBudget> findbyAll(FinancalToBudget financalToBudget) {
		Finder finder = Finder. create("FROM FinancalToBudget WHERE 1=1");
		if(!StringUtil.isEmpty(String.valueOf(financalToBudget.getfId()))){
			finder.append(" and fId = :fId");
			finder.setParam("fId", financalToBudget.getfId());
		}
		if(!StringUtil.isEmpty(financalToBudget.getfFinancialCode())){
			finder.append(" and fFinancialCode = :fFinancialCode");
			finder.setParam("fFinancialCode", financalToBudget.getfFinancialCode());
		}
		if(!StringUtil.isEmpty(financalToBudget.getfFinancialName())){
			finder.append(" and fFinancialName = :fFinancialName");
			finder.setParam("fFinancialName", financalToBudget.getfFinancialName());
		}
		if(!StringUtil.isEmpty(financalToBudget.getfBudgeyCode())){
			finder.append(" and fBudgeyCode = :fBudgeyCode");
			finder.setParam("fBudgeyCode", financalToBudget.getfBudgeyCode());
		}
		if(!StringUtil.isEmpty(financalToBudget.getfBudgeyName())){
			finder.append(" and fBudgeyName = :fBudgeyName");
			finder.setParam("fBudgeyName", financalToBudget.getfBudgeyName());
		}
		return super.find(finder);
	}

	@Override
	public FinancalToBudget findbyFinancialCode(FinancalToBudget financalToBudget) {
		Finder finder = Finder.create("FROM FinancalToBudget WHERE 1=1");
		if(!StringUtil.isEmpty(financalToBudget.getfFinancialCode())){
			finder.append(" and fFinancialCode = :fFinancialCode");
			finder.setParam("fFinancialCode", financalToBudget.getfFinancialCode());
		}
		return (FinancalToBudget) super.find(finder).get(0);
	}
	
	@Override
	public FinancalToBudget findbyproperties(String properties,String val) {
		Finder finder = Finder.create("FROM FinancalToBudget WHERE "+properties+"="+val);
		return (FinancalToBudget) super.find(finder).get(0);
	}

}

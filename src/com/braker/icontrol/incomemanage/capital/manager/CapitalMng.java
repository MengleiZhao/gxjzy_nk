package com.braker.icontrol.incomemanage.capital.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.incomemanage.capital.model.FundPayforInfo;

/**
 * 资金垫支的service抽象类
 * @author 冉德茂
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
public interface CapitalMng extends BaseManager<FundPayforInfo>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	public Pagination pageList(FundPayforInfo bean, int pageNo, int pageSize);

	/*
	 * 保存资金垫支信息
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	public void save(FundPayforInfo bean,LoanBasicInfo loanbean,String files, User user);

	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	public void delete(Integer id);
	/*
	 * 根据借款单ID查询还款信息
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	public List<FundPayforInfo> findByloanId(Integer id);
}

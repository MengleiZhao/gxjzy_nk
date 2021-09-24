package com.braker.icontrol.incomemanage.capital.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.incomemanage.capital.manager.CapitalMng;
import com.braker.icontrol.incomemanage.capital.model.FundPayforInfo;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 *资金垫支的service实现类
 * @author 冉德茂
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
@Service
@Transactional
public class CapitalMngImpl extends BaseManagerImpl<FundPayforInfo> implements CapitalMng {
	
	@Autowired
	private LoanMng loanMng;
	@Autowired
	private AttachmentMng attachmentMng;
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@Override
	public Pagination pageList(FundPayforInfo bean, int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM FundPayforInfo WHERE fstauts <>"+99+" ");
		/*if(!StringUtil.isEmpty(bean.getFproName())){
			finder.append(" AND fproName LIKE :fproName");
			finder.setParam("fproName", bean.getFproName());
		}
		if(!StringUtil.isEmpty(bean.getFproName2())){
			finder.append(" AND fproName2 LIKE :fproName2");
			finder.setParam("fproName2", bean.getFproName2());
		}*/

		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 保存资金垫支信息
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@Override
	public void save(FundPayforInfo bean,LoanBasicInfo loanbean,String files, User user) {//没有修改
		
		//保存还款信息
		bean.setFstauts("0");//数据删除状态
		bean.setCreator(user.getName());//创建人
		bean.setCreateTime(new Date());//创建时间
		bean.setFcoId(loanbean.getlId());//借款单id
		bean.setFcoCode(loanbean.getlCode());//借款单编号
		bean.setFreIndexId(loanbean.getIndexId());//还款指标id
		bean.setFreIndexName(loanbean.getIndexName());//还款指标名称
		bean.setFreIndexType(loanbean.getIndexType());//还款指标类型
		bean = (FundPayforInfo) super.saveOrUpdate(bean);	
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		//更改借款单的还款状态
		LoanBasicInfo oldbean = loanMng.findById(loanbean.getlId());
		oldbean.setFrepayStatus("1");//还款状态由待还款改为待审定
		super.merge(oldbean);
		
		//资金调整信息  未添加！！！！！！！！！！
		
		
}
	/*
	 * 根据id删除
	 * @author 冉德茂
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@Override
	public void delete(Integer id) {
		FundPayforInfo bean = super.findById(id);
		bean.setFstauts("99");
		super.saveOrUpdate(bean);
	}
	/*
	 * 根据借款单ID查询还款信息
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@Override
	public List<FundPayforInfo> findByloanId(Integer id) {
		Finder finder = Finder.create(" FROM FundPayforInfo WHERE fcoId="+id+" ");
		return super.find(finder);
	}
	
	
}



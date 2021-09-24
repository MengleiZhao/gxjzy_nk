package com.braker.icontrol.budget.adjust.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasicItf;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicProItf;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 指标外部调整的service抽象类
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
public interface OutsideAdjustMny extends BaseManager<TIndexExteAd> {
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	public Pagination pageList(TIndexExteAd bean, int pageNo, int pageSize, User user);
	
	/*
	 * 外部指标调整保存
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	public void save(TIndexExteAd bean, List<TIndexExteAdLst> tzli, User user) throws Exception;
	
	/*
	 * 根据项目指标编号查找相应的项目
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	public TProBasicInfo findByIndexCode(String  indexCode);
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	public Pagination checkPageList(TIndexExteAd bean, int pageNo,int pageSize, User user);
	
	/*
	 * 外部指标调整删除
	 * @author 叶崇晖
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	public void delete(Integer id);
	
	/**
	 * 外部指标调整审批
	 * @param checkBean
	 * @param insideBean
	 * @param user
	 */
	public void saveCheckInfo(TProcessCheck checkBean, TIndexExteAd insideBean,User user,String files) throws Exception;
	
	
}

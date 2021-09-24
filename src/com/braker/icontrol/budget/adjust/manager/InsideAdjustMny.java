package com.braker.icontrol.budget.adjust.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasicItf;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicProItf;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 指标内部调整的service抽象类
 * @author 叶崇晖
 * @createtime 2018-07-10
 * @updatetime 2018-07-10
 */
public interface InsideAdjustMny extends BaseManager<TIndexInnerAd>{
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	public Pagination pageList(TIndexInnerAd bean, int pageNo, int pageSize, User user, String type);
	
	/*
	 * 内部指标调整保存
	 * @author 叶崇晖
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	public String save(TIndexInnerAd bean, User user, List<TIndexAdItf> dcli, List<TIndexAdItf> drli ,String files) throws Exception;
	
	/*
	 * 根据项目指标编号查找相应的项目
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	public TProBasicInfo findByIndexCode(String  indexCode);
	
	/*
	 * 内部指标调整删除
	 * @author 安达
	 * @createtime 2019-03-13
	 * @updatetime 2019-03-13
	 */
	public void delete(Integer id);
	
	/**
	 * 内部指标调整审批
	 * @param checkBean
	 * @param insideBean
	 * @param user
	 */
	public void saveCheckInfo(TProcessCheck checkBean, TIndexInnerAd insideBean,User user,String files) throws Exception;

	public List<Object[]> adjustEconomicList();

	public List<Object[]> departList() ;

	public List<Object[]> prolist(String deptCode);

	public List<Object[]> getDataList(List<Object[]> adjustEconomicList,
			List<Object[]> departAndProlist);

	public String  reCall(Integer id)  throws Exception;
}

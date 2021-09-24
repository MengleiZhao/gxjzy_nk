package com.braker.icontrol.cgmanage.cgexpert.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.icontrol.cgmanage.cgprocess.model.BidExpertRef;

/**
 * 评标专家service抽象类
 * @author 李安达
 * @createtime 2019-02-27
 * @updatetime 2019-02-27
 */
public interface CgExpertMng extends BaseManager<ExpertInfo>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	public Pagination pageList(ExpertInfo bean, int pageNo, int pageSize);

	/*
	 *通过中标的主键ID查询评标专家的id
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	public List<BidExpertRef> findByBidid(Integer bidid);

	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void save(ExpertInfo bean,User user) throws Exception ;
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void delete(Integer id);
	/*
	 * 分页查询（白名单页面）（专家库台账）(中标选择专家页面)
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	public Pagination whitepageList(ExpertInfo bean, int pageNo, int pageSize);
	/*
	 * 分页查询（黑名单页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	public Pagination blackpageList(ExpertInfo bean, int pageNo, int pageSize);
	
	/*
	 * 移入/移出黑名单
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	public void moveblack(ExpertBlackInfo expertBlackInfo,User user);
	/*
	 * 移入/移出黑名单历史记录
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	public List<ExpertBlackInfo> movehistory(Integer feid);
	
	/**
	 * 出库 
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	public void outExpert(ExpertOutInfo e,User user);
	
	
	/**
	 * 专家库抽取
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	public List<ExpertInfo> expertExtract(ExpertInfo bean,String num,String label);
}

package com.braker.icontrol.budget.declare.manager;

import java.io.File;
import java.util.List;

import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.declare.entity.ProjectReviewInfo;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 项目评审的service抽象类
 * @author 叶崇晖
 * @createtime 2018-10-11
 * @updatetime 2018-10-11
 */
public interface ProjectReviewMng extends BaseManager<ProjectReviewInfo> {

	/**
	 * 项目评审列表信息查询
	 * @author 叶崇晖
	 * @param bean为项目model
	 * @param user为当前登录人
	 * @param type查询类型0为未评审项目，1为已评审、待评审和已退回项目
	 * @return 返回项目的List
	 */
	public List<TProBasicInfo> pageList(TProBasicInfo bean, User user, String type,String ymlx);
	
	
	
	/**
	 * 
	* @author:安达
	* @Title: saveReview 
	* @Description: 保存需要上报的项目
	* @param fproIdList
	* @param type
	* @return void    返回类型 
	* @date： 2019年5月28日下午4:36:14 
	* @throws
	 */
	public void saveReview(String sbIdList, String lxIdList, String files,User user);
	/**
	 * 
	 * @author:zml
	 * @Title: saveReviewBigProName 
	 * @Description:  提交保存评审中的大项目信息
	 * @param fproId
	 * @param bigProName
	 * @return void    返回类型 
	 * @date： 2019年5月28日下午4:36:14 
	 * @throws
	 */
	public void saveReviewBigProName(String FProId,String bigProName);

	
	
	/**
	 * 项目审批记录查询
	 * @author 叶崇晖
	 * @param bean
	 * @param model
	 * @param page
	 * @param rows
	 * @return
	 */
	public Pagination reviewPage(ProjectReviewInfo bean, int pageNo, int pageSize);
	
	/**
	 * 
	* @author:安达
	* @Title: reviewDetail 
	* @Description: 评审明细
	* @return
	* @return List<TProBasicInfo>    返回类型 
	* @date： 2019年5月29日下午2:35:52 
	* @throws
	 */
	List<TProBasicInfo>  reviewDetail(TProBasicInfo bean);
	
	/**
	 * 
	 * @Description: 查询申报数据
	 * @param @param sbIds
	 * @param @return   
	 * @return List<ProjectReviewInfo>  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月17日
	 */
	public List<ProjectReviewInfo> findBySbIds();
	
	/**
	 * 
	 * @Description: 查询申报失败数据
	 * @param @param sbIds
	 * @param @return   
	 * @return List<ProjectReviewInfo>  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月17日
	 */
	public List<ProjectReviewInfo> findByLxIds(String lxIds);
}

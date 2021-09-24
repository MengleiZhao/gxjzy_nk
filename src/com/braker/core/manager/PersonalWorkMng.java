package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;

/**
 * 首页个人工作台的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-31
 * @updatetime 2018-08-31
 */
/**
 * <p>Description: 请在这里填写类描述</p>
 * @author:安达
 * @date： 2019年9月3日下午2:25:42 
 */
public interface PersonalWorkMng extends BaseManager<PersonalWork> {
	
	/**
	 * 查询代办已办办结信息
	 * @author 叶崇晖
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	public Pagination PageList(PersonalWork bean, int pageNo, int pageSize, User user, String taskStauts);
	
	/**
	 * 通过任务编号和任务处理人查询信息
	 * @author 叶崇晖
	 * @createtime 2018-09-3
	 * @updatetime 2018-09-3
	 */
	public List<PersonalWork> findByCodeAndUser(String taskCode, User user);
	
	/**
	 * 
	* @author:安达
	* @Title: findByCodeAndUser 
	* @Description: 通过任务编号和任务处理人查询信息 ，这里包括已办结的
	* @param taskCode
	* @param user
	* @return
	* @return List<PersonalWork>    返回类型 
	* @date： 2019年8月28日上午11:56:04 
	* @throws
	 */
	public PersonalWork getByCodeAndUser(String taskCode, User user);
	
	/**
	 * 通过任务编号和任务处理用户id查询信息
	 * @author 安达
	 * @createtime 2019-04-25
	 * @updatetime 2019-04-25
	 */
	public List<PersonalWork> findByCodeAndUserId(String taskCode, String userId);
	
	/**
	 * 统计待办的任务数
	 */
	public List<Integer> countTaskNum(String userId);
	/**
	 * 统计已办的任务数
	 */
	public List<Integer> countAlready(String userId);
	/**
	 * 统计办结的任务数
	 */
	public List<Integer> countFinish(String userId);
	
	/**
	 * 修改申请人的待办信息
	 */
	public PersonalWork  updateStautsAndType(String taskCode, String userId,String taskStauts,String type);
	
	/**
	 * 建立下一环节处理人的待办信息
	 */
	public PersonalWork addPersonalWork(PersonalWork newWork,String roleId,String checkUrl,String lookUrl);
	/**
	 * 
	 */
	
	/**
	 * 
	* @author:安达
	* @Title: sendMessageToUser 
	* @Description: 这里用一句话描述这个方法的作用 
	* @param userId   消息接收人
	* @param type    推送类型   0：无， 1：您有新的消息，2：您有新的待办事项
	* @return void    返回类型 
	* @date： 2019年9月3日下午7:07:05 
	* @throws
	 */
	public void sendMessageToUser(String userId,int type);
	
	/**
	 * @ToDo 通过任务编号和任务处理人查询信息(已完结的)
	 */
	List<PersonalWork> findByFinal(String taskCode, User user);
	
	/**
	 * 查询所有taskStauts=0代办事项并且发送消息
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年8月28日
	 * @updateTime 2019年8月28日
	 */
	public void findAlltaskStauts0();
	
	/**
	 * 新增或者保存个人待办信息
	 */
	public PersonalWork merge(PersonalWork personalWork);
	
	/**
	 * 
	* @author:安达
	* @Title: deleteDb 
	* @Description: 删除待办信息
	* @param userId  用户id
	* @param beanCode  编码
	* @param type  类型  0：待办
	* @return void    返回类型 
	* @date： 2019年10月8日下午8:54:03 
	* @throws
	 */
	public void deleteDb(String userId,String beanCode,String type);

	public void delete(String id, User user);
	
	
}

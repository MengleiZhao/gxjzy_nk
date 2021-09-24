package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.TextMessage;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.JpushClientUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.webSocket.MyWebSocketHandler;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.PrivateInformation;
import com.braker.core.model.User;

/**
 * 首页个人工作台的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-31
 * @updatetime 2018-08-31
 */
@Service
@Transactional
public class PersonalWorkMngImpl extends BaseManagerImpl<PersonalWork> implements PersonalWorkMng {
	//websocket消息推送
	@Autowired
	private MyWebSocketHandler handler;
	@Autowired
	private UserMng userMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	/*
	 * 查询代办已办办结信息
	 * @author 叶崇晖
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	@Override
	public Pagination PageList(PersonalWork bean, int pageNo, int pageSize, User user, String taskStauts) {
		Finder finder = Finder.create(" FROM PersonalWork WHERE userId='"+user.getId()+"' AND taskStauts='"+taskStauts+"'");
		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getBeforeUser())) {
				finder.append(" and beforeUser like '%"+ bean.getBeforeUser() +"%'");
			}
			if (!StringUtil.isEmpty(bean.getTaskName())) {
				finder.append(" and taskName like '%"+ bean.getTaskName() +"%'");
			}
			finder.append(" and( fStauts !=0 or fStauts is null)");
			finder.append(" order by fId desc");
		}
		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 通过任务编号和任务处理人查询信息
	 * @author 叶崇晖
	 * @createtime 2018-09-3
	 * @updatetime 2018-09-3
	 */
	@Override
	public List<PersonalWork> findByCodeAndUser(String taskCode, User user) {
		Finder finder = Finder.create(" FROM PersonalWork WHERE taskCode='"+taskCode+"' and taskStauts <>4");
		if(user != null) {
			finder.append(" AND userId='"+user.getId()+"'  ");
		}
		return super.find(finder);
	}
	
	@Override
	public PersonalWork getByCodeAndUser(String taskCode, User user) {
		Finder finder = Finder.create(" FROM PersonalWork WHERE taskCode='"+taskCode+"' ");
		if(user != null) {
			finder.append(" AND userId='"+user.getId()+"'  ");
		}
		 List<PersonalWork> list= super.find(finder);
		 if(list==null || list.size()==0){
			 return null; 
		 }
		 return list.get(0);
	}
	/*
	 * 待办事项消息
	 * 
	 */
	
	@Override
	public List<Integer> countTaskNum(String userId) {
		Finder finder = Finder.create(" select taskStauts,count(*) from PersonalWork where userId=:userId ").setParam("userId", userId);
		finder.append(" and( fStauts !=0 or fStauts is null)");
		finder.append(" and taskStauts=0 group by taskStauts order by taskStauts ");
		List<Object[]> list = super.find(finder);
		List<Integer> res = new ArrayList<Integer>();
		if (list != null && list.size() > 0) {
			for (Object[] array: list) {
				int num = Integer.valueOf(String.valueOf(array[1]));
				if (Integer.valueOf(String.valueOf(array[0])) == 0) {
					res.add(num);
				}
			}
		}
		if(list.size()==0){
			return null;
		}
		return res;
	}
	
	/*
	 * 已办事项消息
	 * 
	 */
	@Override
	public List<Integer> countAlready(String userId) {
		
		Finder finder = Finder.create(" select taskStauts,count(*) from PersonalWork where userId=:userId ").setParam("userId", userId);
		finder.append(" and( fStauts !=0 or fStauts is null)");
		finder.append(" and taskStauts=2 group by taskStauts order by taskStauts ");
		List<Object[]> list = super.find(finder);
		
		List<Integer> res = new ArrayList<Integer>();
		if (list != null && list.size() > 0) {
			for (Object[] array: list) {
				int num = Integer.valueOf(String.valueOf(array[1]));
				if (Integer.valueOf(String.valueOf(array[0])) == 2) {
					res.add(num);
				}
			}
		}
		if(res.size()==0){
			return null;
		}
		return res;
	}
	
	/*
	 * 完结事项消息
	 * 
	 */
	@Override
	public List<Integer> countFinish(String userId) {
		
		Finder finder = Finder.create(" select taskStauts,count(*) from PersonalWork where userId=:userId ").setParam("userId", userId);
		finder.append(" and( fStauts !=0 or fStauts is null)");
		finder.append(" and taskStauts=4 group by taskStauts order by taskStauts ");
		List<Object[]> list = super.find(finder);
		
		List<Integer> res = new ArrayList<Integer>();
		if (list != null && list.size() > 0) {
			for (Object[] array: list) {
				int num = Integer.valueOf(String.valueOf(array[1]));
				if (Integer.valueOf(String.valueOf(array[0])) == 4) {
					res.add(num);
				}
			}
		}
		if(list.size()==0){
			return null;
		}
		return res;
	}
	
	/**
	 * 修改自己的待办信息，将待办改为已办,任务类型 改为查看
	 */
	@Override
	public PersonalWork updateStautsAndType(String taskCode, String userId,String taskStauts,String type) {
		// TODO Auto-generated method stub
		Date date = new Date();
		List<PersonalWork> workList = findByCodeAndUserId(taskCode, userId);//查询全部只需要user为null
		for (int i = 0; i < workList.size(); i++) {
			PersonalWork work = workList.get(i);
			work.setTaskStauts(taskStauts);  //任务状态0-待办：等待当前用户审批2-已办：当前用户审批后4-办结：流程最终用户审批后
			work.setType(type);   //任务类型	（0、删除 	1、审批	2、查看	3、退回修改）
			if("0".equals(taskStauts)){
				work.setBeforeTime(new Date());
			}
			if(userId==null){		//如果userId==null说明已经办结，只需要修改最后一个人的任务完成时间
				if( i == workList.size()-1){
					work.setFinishTime(date);//本环节任务任务完成时间
				}
				work.setOverTime(date);//任务全部完成的时间
			}else{
				work.setFinishTime(date);//任务完成时间
			}
			//推送消息
		   // 刷新自己页面的待办信息
		   // 推送类型   0：无， 1：您有新的消息，2：您有新的待办事项
		   sendMessageToUser(work.getUserId(),0);
		   super.merge(work);
		}
		return workList.get(0);
		
	}

	/**
	 * 
	 * 建立下一环节处理人的待办信息
	 */
	@Override
	public PersonalWork addPersonalWork(PersonalWork work,String userId,String checkUrl,String lookUrl) {
		// TODO Auto-generated method stub
		PersonalWork newWork = new PersonalWork();
		newWork.setUserId(userId);//任务处理人ID既是下节点处理人ID
		newWork.setTaskId(work.getTaskId());//申请单ID
		newWork.setTaskCode(work.getTaskCode());//为申请单的单号
		newWork.setTaskName(work.getTaskName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		newWork.setUrl(checkUrl);//审批url
		newWork.setUrl1(lookUrl);//查看url
		newWork.setTaskStauts("0");//待办
		newWork.setType("1");//任务类型（1审批）
		newWork.setTaskType("1");//任务归属（1审批人）
		newWork.setBeforeUser(work.getBeforeUser());//任务提交人姓名
		newWork.setBeforeDepart(work.getBeforeDepart());//任务提交人所属部门名称
		newWork.setBeforeTime(work.getBeforeTime());//任务提交时间
		super.merge(newWork);
		//推送消息
		// 推送类型   0：无， 1：您有新的消息，2：您有新的待办事项
		sendMessageToUser(userId,2);
		return newWork;
	}

	/*
	 * 通过任务编号和任务处理人id查询信息
	 * @author 叶崇晖
	 * @createtime 2018-09-3
	 * @updatetime 2018-09-3
	 */
	@Override
	public List<PersonalWork> findByCodeAndUserId(String taskCode, String userId) {
		Finder finder = Finder.create(" FROM PersonalWork WHERE taskCode='"+taskCode+"' and taskStauts <>4");
		if(!StringUtils.isEmpty(userId)) {
			finder.append(" AND userId='"+userId+"'  ");
		}
		return super.find(finder);
	}

	@Override
	public void sendMessageToUser(String userId,int type) {
		// TODO Auto-generated method stub
		//审批流程结束后，通过消息推送，提示页面main.jsp更新待办事项数字
		List<Integer> taskNumList = countTaskNum(userId);
		//更新已办事项数字
		List<Integer> countAlreadyList = countAlready(userId);
		//更新完结事项数字
		List<Integer> countFinishList = countFinish(userId);
		//更新消息数字
		List<PrivateInformation> privateInf = privateInforMng.unread(userId);
		int num1=0;
		if(countAlreadyList !=null && countAlreadyList.size()>0){
			num1=countAlreadyList.get(0);
		}
		int num2=0;
		if(countFinishList !=null && countFinishList.size()>0){
			num2=countFinishList.get(0);
		}
		int num=0;
		if(taskNumList !=null && taskNumList.size()>0){
			num=taskNumList.get(0);
		}
		int num3=0;
		if(privateInf !=null && privateInf.size()>0){
			num3=privateInf.size();
		}
		
		handler.sendMessageToUser(userId,new TextMessage(String.valueOf(num)+","+String.valueOf(num1)+","+String.valueOf(num2)+","+String.valueOf(num3)+","+type));
	
	}

	@Override
	public List<PersonalWork> findByFinal(String taskCode, User user) {
		Finder finder = Finder.create(" FROM PersonalWork WHERE taskCode='"+taskCode+"' and taskStauts=4");
		if(user != null) {
			finder.append(" AND userId='"+user.getId()+"'  ");
		}
		return super.find(finder);
	}

	@Override
	public void findAlltaskStauts0() {
		Finder finder = Finder.create(" FROM PersonalWork WHERE taskStauts = 0");
		List<PersonalWork> list = super.find(finder);
		for (int i = 0; i < list.size(); i++) {
			//计算本环节任务到现在多久了
			int days =  DateUtil.getDaySpan(DateUtil.today(), list.get(i).getReferTime());
			if(days>=30){
				String title="待办事项超时提醒";
				String msg="您任务编号："+list.get(i).getTaskCode()+"的代办事项已经超过30天未办理，请及时办理！";
				privateInforMng.setMsg(title, msg, list.get(i).getUserId(), "3");
			}
		}
	}
	@Override
	public PersonalWork merge(PersonalWork personalWork){
		int type=0;
		if("0".equals(personalWork.getTaskStauts())){
			type=2;
		}
		personalWork=(PersonalWork)super.merge(personalWork);
	/*	//推送待办通知到app端
		if(type==2){
			User user =userMng.findById(personalWork.getUserId());
			if(JpushClientUtil.sendToRegistrationId(user.getAccountNo(),null,"您有一条待审批任务",personalWork.getTaskName(),personalWork.getTaskId().toString(), "0","")==1){
	            System.out.println("推送给指定Android用户success");
	        }
		}*/
		//推送消息
		// 推送类型   0：无， 1：您有新的消息，2：您有新的待办事项
		sendMessageToUser(personalWork.getUserId(),type);
		return personalWork;
	}
	/**
	 * 删除某个人的待办信息
	 */
	@Override
	public void deleteDb(String userId,String beanCode,String type){
		String sql="delete from T_PERSONAL_WORKTABLE where F_USER_ID='"+userId+"' and F_TASK_CODE='"+beanCode+"' and F_TASK_STAUTS='"+type+"'";
		Query query=getSession().createSQLQuery(sql);
		query.executeUpdate();
	}
	
	@Override
	public void delete(String id,User user) {
		getSession().createSQLQuery("update  T_PERSONAL_WORKTABLE set f_stauts = '0' where f_id = '"+id+"'").executeUpdate();
		sendMessageToUser(user.getId(),0);
	}
}

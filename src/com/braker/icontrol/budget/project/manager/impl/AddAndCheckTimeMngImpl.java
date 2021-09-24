/**
 * <p>Title: AddAndCheckTimeMngImpl.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年9月27日
 */
package com.braker.icontrol.budget.project.manager.impl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.AddAndCheckTime;
import com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng;

/** 
 * <p>Title: AddAndCheckTimeMngImpl</p>  
 * <p>Description: 申报审批节点时间表实现层</p>  
 * @author 陈睿超
 * @date 2020年9月27日  
 */
@Service
@Transactional
public class AddAndCheckTimeMngImpl extends BaseManagerImpl<AddAndCheckTime> implements AddAndCheckTimeMng{

	/* 
	 * <p>Title: save</p>
	 * <p>Description: </p>
	 * @param bean
	 * @param user
	 * @return
	 * @see com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng#save(com.braker.icontrol.budget.project.entity.AddAndCheckTime, com.braker.core.model.User) 
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	@Override
	public String save(AddAndCheckTime bean, User user) {
		if(StringUtil.isEmpty(String.valueOf(bean.getFid()))){
			bean.setCreateTime(new Date());
			bean.setCreator(user.getName());
			bean.setUpdateTime(new Date());
			bean.setUpdator(user.getName());
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdator(user.getName());
		}
		super.merge(bean);
		return null;
	}

	/* 
	 * <p>Title: findbyDataType</p>
	 * <p>Description: </p>
	 * @param fDataType
	 * @return
	 * @see com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng#findbyDataType(java.lang.Integer) 
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	@Override
	public AddAndCheckTime findbyDataType(Integer fDataType) {
		Finder finder = Finder.create(" FROM AddAndCheckTime WHERE 1=1");
		finder.append(" AND fDataType="+fDataType);
		List<AddAndCheckTime> list = super.find(finder);
		AddAndCheckTime bean = new AddAndCheckTime();
		if(list.size()>0){
			bean =(AddAndCheckTime) list.get(0);
		}
		return bean;
	}

	/* 
	 * <p>Title: verifyToCheckTime</p>
	 * <p>Description: 校验是否超过申报日期范围</p>
	 * @param bean
	 * @param model
	 * @return true通过,false不通过
	 * @see com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng#verifyToCheckTime(com.braker.icontrol.budget.project.entity.AddAndCheckTime, org.springframework.ui.ModelMap) 
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	@Override
	public Boolean verifyToCheckTime(AddAndCheckTime bean) {
		if(1==bean.getfDataType()){//一上
			bean = findbyDataType(1);
		}else if(2==bean.getfDataType()){//二上
			bean = findbyDataType(2);
		}
		int startdays = 0;
		int enddays = 0;
		if(bean == null){//没查到限制
			return true;
		}else{
			/*if(addorupdate==0){//新增
				if(bean.getAddStartTime()!=null&&bean.getAddEndTime()!=null){//都不为空的时候
					startdays = bean.getAddStartTime().compareTo(new Date());
					enddays = new Date().compareTo(bean.getAddEndTime());
				}
			}else if(addorupdate==1){//修改
*/			if(bean.getAddStartTime()!=null&&bean.getAddEndTime()!=null){//都不为空的时候
				startdays = bean.getAddStartTime().compareTo(new Date());
				enddays = new Date().compareTo(bean.getAddEndTime());
			}
			/*}*/
			if((startdays==-1||startdays==0)&&(enddays==-1||enddays==0)){//
				return true;
			}else {
				return false;
			}
		}
	}

	/* 
	 * <p>Title: verifyCheckTime</p>
	 * <p>Description: 校验是否超过审批日期范围</p>
	 * @param bean
	 * @return
	 * @see com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng#verifyCheckTime(com.braker.icontrol.budget.project.entity.AddAndCheckTime) 
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	@Override
	public Boolean verifyCheckTime(AddAndCheckTime bean) {
		if(1==bean.getfDataType()){//一上
			bean = findbyDataType(1);
		}else if(2==bean.getfDataType()){//二上
			bean = findbyDataType(2);
		}
		if(bean == null){//没查到限制
			return true;
		}else{//有限制
			if(bean.getCheckStartTime()!=null&&bean.getCheckEndTime()!=null){//都不为空的时候
				
				int startdays = bean.getCheckStartTime().compareTo(new Date());
				int enddays = new Date().compareTo(bean.getCheckEndTime());
				if((startdays==-1||startdays==0)&&(enddays==-1||enddays==0)){//
					return true;
				}else {
					return false;
				}
			}
		}
		return null;
	}

	/* 
	 * <p>Title: verifyUpdateTime</p>
	 * <p>Description: 校验是否超过修改日期范围</p>
	 * @param bean
	 * @return
	 * @see com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng#verifyUpdateTime(com.braker.icontrol.budget.project.entity.AddAndCheckTime) 
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	@Override
	public Boolean verifyUpdateTime(AddAndCheckTime bean) {
		if(1==bean.getfDataType()){//一上
			bean = findbyDataType(1);
		}else if(2==bean.getfDataType()){//二上
			bean = findbyDataType(2);
		}
		if(bean == null){//没查到限制
			return true;
		}else{//有限制
			if(bean.getUpdateStartTime()!=null&&bean.getUpdateEndTime()!=null){//都不为空的时候
				
				int startdays = bean.getUpdateStartTime().compareTo(new Date());
				int enddays = new Date().compareTo(bean.getUpdateEndTime());
				if((startdays==-1||startdays==0)&&(enddays==-1||enddays==0)){//
					return true;
				}else {
					return false;
				}
			}
		}
		return null;
	}
	
	
	
}

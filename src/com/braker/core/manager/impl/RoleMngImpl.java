package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.common.web.init.InitFacade;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.model.Function;
import com.braker.core.model.Role;
import com.braker.core.model.User;
@SuppressWarnings("unchecked")
@Service
@Transactional
public class RoleMngImpl extends BaseManagerImpl<Role> implements RoleMng{
	
	
	@Autowired
	private FunctionMng functionMng;
	
	/**
     * 验证角色是否已存在
     * @author ren_wei
     * @param user
     * @return
     */
	@Override
    public synchronized boolean isExist(Role role)
    {
    	List<Role> list=null;
    	if(StringUtil.isEmpty(role.getId())){
    		String condition = " from Role where  name = ? and departid=? and flag='1' ";
    		list = this.find(condition, new Object[]{role.getName(),role.getDepartid()});
    	}else{
			String condition = " from Role where  name = ?  and departid=?  and id <> ? and flag='1' ";
			list = this.find(condition, new Object[]{role.getName(),role.getDepartid(),role.getId()});
    	}
    	if(null!=list && list.size()>0){
    		return true;
    	}
		return false;
    }

	@Override
	public Pagination list(Role bean, String sort, String order, int pageIndex,
			int pageSize) {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from Role Where flag='1'");
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getName())){
				f.append(" and name like :name");
				f.setParam("name","%"+bean.getName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getDepartid())){
				f.append(" and departid = :departid");
				f.setParam("departid",bean.getDepartid());
			}
		}
		if(!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order) && (order.equals("asc") || order.equals("desc"))){
			f.append(" order by "+sort+" "+order);
		}else{
			f.append(" order by orderNo,name");
		}
		return super.find(f, pageIndex, pageSize);
	}

	@Override
	public void save(Role bean,String funcIds,User user) {
		// TODO Auto-generated method stub
		if(null!=bean && !StringUtil.isEmpty(bean.getId())){
			Role role=super.findById(bean.getId());
			bean.setUpdator(user);
			bean.setFunctions(role.getFunctions());
			bean.setUsers(role.getUsers());
		}else{
			bean.setCreator(user);
		}
		bean=(Role)super.merge(bean);
		//设置多对多关系
		if(!StringUtil.isEmpty(funcIds)){
			String[] functionArr=funcIds.split(",");
			List<Long> funcs=new ArrayList<Long>();
			for(String id:functionArr){
				funcs.add(Long.valueOf(id));
			}
			List<Function> listRemoveFunction=new ArrayList<Function>();
			if(null==bean.getFunctions()){
				bean.setFunctions(new ArrayList<Function>());
			}
			for(Function function:bean.getFunctions()){
				if(!funcs.contains(function.getId())){
					listRemoveFunction.add(function);
				}
			}
			for(Function function:listRemoveFunction){
				bean.removeFunction(function);
			}
			for(Long fid:funcs){
				Function function=functionMng.findById(fid);
				if(null==function.getRoles()){
					function.setRoles(new ArrayList<Role>());
				}
				if(!bean.getFunctions().contains(function)){
					bean.addFunction(function);
				}
			}
		}else{
			bean.setFunctions(null);
		}
	}

	@Override
	public List<Role> getAll(String departId) {
		if(!departId.isEmpty()){
			Finder f=Finder.create("from Role Where flag='1' and departid='"+departId+"' order by orderNo,name");
			return super.find(f);
		}else{
			Finder f=Finder.create("from Role Where flag='1' and departid is null order by orderNo,name");
			return super.find(f);
		}
		
	}

	@Override
	public String getRolesByUserId(String userId) {
		String roleNames="";
		StringBuilder builder=new StringBuilder();
		builder.append("select rolename FROM  sys_role ro where pflag='1' and  exists (select roleid from sys_user_role sur where sur.roleid=ro.pid and sur.userid='"+userId+"' ) ");
		SQLQuery query=getSession().createSQLQuery(builder.toString());
		List<String> roleNameList= query.list();
		if(roleNameList !=null && roleNameList.size()>0){
			for(String str:roleNameList){
				if("".equals(roleNames)){
					roleNames=str;
				}else{
					roleNames=roleNames+" | "+str;
				}
			}
		}
		
		return roleNames;
	}

	@Override
	public String getUserIdByRoleName(String roleName) {
		String userId = "";
		StringBuilder builder = new StringBuilder();
		builder.append("select sur.userId from sys_role sr, sys_user_role sur where sr.pid = sur.roleId and sr.roleName = '"+ roleName +"'");
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<String> userIdList = query.list();
		if(userIdList != null && userIdList.size()>0){
			userId = userIdList.get(0);
		}
		return userId;
	}

	@Override
	public String getUserIdByDepartIdAndRoleName(String departId,
			String roleName) {
		String userId = "";
		StringBuilder builder = new StringBuilder();
		builder.append("select sur.userId from sys_role sr, sys_user_role sur where sr.pid = sur.roleId and sr.departId='"+ departId +"' and sr.roleName = '"+ roleName +"'");
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<String> userIdList = query.list();
		if(userIdList != null && userIdList.size()>0){
			userId = userIdList.get(0);
		}
		return userId;
	}

	@Override
	public String getManagerIdByUserId(String userId) {
		String managerId = "";
		StringBuilder builder = new StringBuilder();
		builder.append("select sd.MANAGER_ID from sys_depart sd, sys_user su where sd.pid = su.departid and su.pid='"+ userId +"'");
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<String> managerIdList = query.list();
		if(managerIdList != null && managerIdList.size()>0){
			managerId = managerIdList.get(0);
		}
		return managerId;
	}

	@Override
	public String getUserIdByDepartNameAndRoleName(String departName,
			String roleName) {
		String userId = "";
		StringBuilder builder = new StringBuilder();
		builder.append("select sur.userId from sys_role sr, sys_user_role sur where sr.pid = sur.roleId and sr.departName='"+ departName +"' and sr.roleName = '"+ roleName +"'");
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<String> userIdList = query.list();
		if(userIdList != null && userIdList.size()>0){
			userId = userIdList.get(0);
		}
		return userId;
	}

}

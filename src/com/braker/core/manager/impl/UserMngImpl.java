package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.List;

import oracle.net.aso.s;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.security.BadCredentialsException;
import com.braker.common.security.CodeHelper;
import com.braker.common.security.LockedException;
import com.braker.common.security.UserNameNotFoundException;
import com.braker.common.util.StringUtil;
import com.braker.common.util.redis.RedisConstantsKeys;
import com.braker.common.util.redis.RedisUtil;
import com.braker.common.web.init.InitFacade;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.Role;
import com.braker.core.model.RoleDepartUser;
import com.braker.core.model.User;
import com.braker.core.model.UserTransient;

@SuppressWarnings("unchecked")
@Service
@Transactional
public class UserMngImpl extends BaseManagerImpl<User> implements UserMng{
	
	@Autowired
	private RoleMng roleMng;
	@Autowired
	private DepartMng departMng;
	@Override
	public synchronized boolean isExist(User user) {
		List<User> list = null;
		if (StringUtil.isEmpty(user.getId())) {
			list=super.find("from User where flag='1' and accountNo=?",new Object[]{user.getAccountNo()});
		} else {
			String hql ="from User where accountNo=? and id<>? and flag='1'";
			list=super.find(hql,new Object[]{user.getAccountNo(),user.getId()});
		}
		if(null!=list && list.size()>0){
			return true;
		}
		return false;
	}
	
	@Override
	public User SSOLogin(String accountNo) throws UserNameNotFoundException,
			BadCredentialsException, LockedException {
		// TODO Auto-generated method stub
		if(StringUtil.isEmpty(accountNo)){
			throw new UserNameNotFoundException("登录信息填写不完整！");
		}
		User user=getUserByAccountNo(accountNo);
		if(null==user){
			throw new UserNameNotFoundException("该用户不存在！");
		}else{
			if(!StringUtil.isEmpty(user.getIslocked()) && "TRUE".equals(user.getIslocked())){
				throw new LockedException("该用户已被锁定！");
			}
		}
		return user;
	}
	public List<User> getUserInfoByDepart(String departId){
		String hql = null;
		if(departId !=null && !"".equals(departId)){
			hql = "from User where flag='1' and display_type=10 and depart.id ='"+departId+"' order by name";
		}
		return find(hql);
	}
	
	/**
	 * 得到项目角色
	 * 2012-5-15
	 * @author wang_dong
	 * @return
	 */
	@Override
	 public List<Lookups> getXiangMuJueSe(){
		 String hql=null;
		 hql="from Lookups where lookupcode='XMJS' order by orderNo asc";
		 return find(hql);
	 }


	 /**
	 * 根据 name 排序获得所有用户
	 * @return
	 */
	@Override
	public List<User> getUserInfo() {
		// TODO Auto-generated method stub
		String hql = "from User where flag='1' and display_type=10 order by name ";
		return super.find(hql);
	}

	@Override
	public User login(String accountNo, String password)
			throws UserNameNotFoundException, BadCredentialsException,
			LockedException {
		// TODO Auto-generated method stub
		if(StringUtil.isEmpty(accountNo) || StringUtil.isEmpty(password)){
			throw new UserNameNotFoundException("登录信息填写不完整！");
		}
		User user=getUserByAccountNo(accountNo);
		if(null==user){
			throw new UserNameNotFoundException("该用户不存在！");
		}else{
			if(!StringUtil.isEmpty(user.getIslocked()) && "TRUE".equals(user.getIslocked())){
				throw new LockedException("该用户已被锁定！");
			}
			if(!user.getPassword().equals(CodeHelper.encryptPassword(password))){
				throw new BadCredentialsException("密码错误,请重新输入！");
			}
		}
		return user;
	}
	@Override
	public User zzwwlogin(String accountNo, String password)
			throws UserNameNotFoundException, BadCredentialsException,
			LockedException {
		// TODO Auto-generated method stub
		if(StringUtil.isEmpty(accountNo) || StringUtil.isEmpty(password)){
			throw new UserNameNotFoundException("登录信息填写不完整！");
		}
		User user=getUserByAccountNo(accountNo);
		if(null==user){
			throw new UserNameNotFoundException("该用户不存在！");
		}else{
			if(!StringUtil.isEmpty(user.getIslocked()) && "TRUE".equals(user.getIslocked())){
				throw new LockedException("该用户已被锁定！");
			}
			if(!user.getPassword().equals(password)){
				throw new BadCredentialsException("密码错误,请重新输入！");
			}
		}
		return user;
	}
	public User getUserByAccountNo(String accountNo){
		User user=(User)super.findUnique("from User Where flag='1' and (accountNo = ? or mobileNo=?)",accountNo,accountNo);
		/*User user=(User)redisUtil.getObject(RedisConstantsKeys.GET_USER_KEY+accountNo);
		if(user==null){
			String hql = "from User where flag='1' and accountNo = ? ";
			List<User> list=super.find(hql, accountNo);
			user= list.get(0);
			redisUtil.setObject(RedisConstantsKeys.GET_USER_KEY+accountNo, user);
		}*/
		return user;
	}

	@Override
	public Pagination list(User user,String departId,String sort,String order,int pageNo, int pageSize) {
		/*try {
			StringBuilder builder=new StringBuilder();
			builder.append("select * FROM  sys_user su where pflag='1' ");
			if(!StringUtil.isEmpty(user.getUserRoleName())){ //按角色名称模糊查询
				builder.append(" and exists (select userid from sys_user_role sur where su.pid=sur.userid and roleid exists ("
						+ "select pid from sys_role sr where sr.pid=sur.roleid and rolename like '%"+user.getUserRoleName()+"%'  )) ");
			}
			if(!StringUtil.isEmpty(user.getName())){
				builder.append(" and name like '%"+user.getName()+"%' ");
			}
			if(!StringUtil.isEmpty(user.getAccountNo())){
				builder.append(" and accountNo like '%"+user.getAccountNo()+"%'");
			}
			
			return super.findBySql( user,builder.toString(), pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;*/
		Finder finder=Finder.create("from User bean left join fetch bean.depart dp Where bean.flag='1'");
		if(!StringUtil.isEmpty(departId)){
			finder.append(" and dp.id = :departId");
			finder.setParam("departId",departId);
		}
		if(null!=user){
			if(!StringUtil.isEmpty(user.getName())){
				finder.append(" and bean.name like :name");
				finder.setParam("name","%"+user.getName()+"%");
			}
			if(!StringUtil.isEmpty(user.getAccountNo())){
				finder.append(" and bean.accountNo like :accountNo");
				finder.setParam("accountNo","%"+user.getAccountNo()+"%");
			}
			if(!StringUtil.isEmpty(user.getUserRoleName())){ //按角色名称模糊查询
				String userIds=getUserIdsByRoleName(user.getUserRoleName());
				if(!"".equals(userIds)){
					finder.append(" and bean.id in ("+userIds+") ");
				}
			}
		}
		if(!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order) && (order.equals("asc") || order.equals("desc"))){
			finder.append(" order by bean."+sort+" "+order);
		}else{
			finder.append(" order by bean.name");
		}
		Pagination pagintion=super.find(finder, pageNo, pageSize);
		pagintion=setRoleNameInToUser(pagintion);
		return pagintion;
	}
	
	@Override
	public Pagination listTravel(User user,String departId,String sort,String order,int pageNo, int pageSize) {
		
		String hql = "select user0_.PID,user0_.ACCOUNTNO,user0_.NAME,depart1_.DEPARTNAME,user0_.roleslevel,user0_.post from sys_user user0_ left outer join sys_depart depart1_ on user0_.departid=depart1_.pid where user0_.pflag='1'";  
		if(null!=user){
			if(!StringUtil.isEmpty(user.getName())){
				hql += " and (user0_.name like '%"+user.getName()+"%')";
			}
			if(!StringUtil.isEmpty(user.getDepartName())){
				hql += " and (depart1_.departName like '%"+user.getDepartName()+"%')";
			} 
			hql += " order by user0_.name";
		}
		SQLQuery query=getSession().createSQLQuery(hql.toString());
		List<Object[]> userIdList= query.list();
		List<UserTransient> userList=new ArrayList<UserTransient>();
		for (int i = 0; i < userIdList.size(); i++) {
			if("admin".equals(String.valueOf(userIdList.get(i)[1]))){
				userIdList.remove(i);
			}else{
				UserTransient transient1 = new UserTransient(); 
				transient1.setId(String.valueOf(userIdList.get(i)[0]));
				transient1.setAccountNo(String.valueOf(userIdList.get(i)[1]));
				transient1.setName(String.valueOf(userIdList.get(i)[2]));
				transient1.setDepartName(String.valueOf(userIdList.get(i)[3]));
				int level = userIdList.get(i)[4] ==null ? 0:Integer.valueOf(String.valueOf(userIdList.get(i)[4]));
				transient1.setRoleslevel(level);
				transient1.setRoleslevelname(String.valueOf(userIdList.get(i)[5]));
				userList.add(transient1);
			}
		}
		Pagination pagintion= new Pagination();
		pagintion.setList(userList);
		return pagintion;
	}
	/**
	 * 
	* @author:安达
	* @Title: setRoleNameInToUser 
	* @Description: 把角色名称set进User里
	* @param pagintion
	* @return
	* @return Pagination    返回类型 
	* @date： 2019年5月28日下午2:31:10 
	* @throws
	 */
	private Pagination setRoleNameInToUser(Pagination pagintion){
		for(int i=0,k=pagintion.getList().size(); i<k; i++){
			User user = (User) pagintion.getList().get(i);
			List<Role> roleList=user.getRoles();
			String roleNames=getRoleNamesByList(roleList);
			user.setUserRoleName(roleNames);
		}
		
		return pagintion;
	}
	/**
	 * 
	* @author:安达
	* @Title: getRoleNamesByList 
	* @Description: 根据角色list返回角色名称字符串 使用 | 分割
	* @param roleList
	* @return
	* @return String    返回类型 
	* @date： 2019年5月28日下午2:30:45 
	* @throws
	 */
	private String getRoleNamesByList(List<Role> roleList){
		String roleNames="";
		for(Role role:roleList){
			if("".equals(roleNames)){
				roleNames=role.getName();
			}else{
				roleNames=roleNames+" | "+role.getName();
			}
		}
		return roleNames;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getUserIdsByRoleName 
	* @Description: 根据角色名称模糊查询，返回对应的userid 
	* @param roleName
	* @return
	* @return String    返回类型 
	* @date： 2019年5月28日下午2:30:15 
	* @throws
	 */
	private String getUserIdsByRoleName(String roleName){
		StringBuilder builder=new StringBuilder();
		builder.append("select userid from sys_user_role sur where  exists ("
						+ "select pid from sys_role sr where sr.pid=sur.roleid and rolename like '%"+roleName+"%'  )");
		SQLQuery query=getSession().createSQLQuery(builder.toString());
		List<String> userIdList= query.list();
		String userIds="";
		if(userIdList !=null && userIdList.size()>0){
			for(String str:userIdList){
				if("".equals(userIds)){
					userIds="'"+str+"'";
				}else{
					userIds=userIds+","+"'"+str+"'";
				}
			}
		}
		return userIds;
	}
	@Override
	public void reSetPwd(String userId,User user) {
		User bean=super.findById(userId);
		bean.setPassword(CodeHelper.encryptPassword("123456"));
		super.updateDefault(bean);
	}

	@Override
	public void save(User bean, String roleIds,User user) {
		// TODO Auto-generated method stub
		if(StringUtil.isEmpty(bean.getId())){//新增时密码和帐号相同
			bean.setCreator(user);
			bean.setPassword(CodeHelper.encryptPassword("123456"));
			//设置角色
			if(!StringUtil.isEmpty(roleIds)){
				bean.setRoles(new ArrayList<Role>());
				String[] rIds = roleIds.split(",");
				// 添加新选择的角色
				for (String rid:rIds) {
					bean.addRole(roleMng.findById(rid));
				}
			}
			
		}else{
			bean.setUpdator(user);
			User u=super.findById(bean.getId());
			bean.setRoles(u.getRoles());
			//设置角色
			if (!StringUtil.isEmpty(roleIds)) {
				String[] rIds = roleIds.split(",");
				// 先删除角色
				List<Role> deleteRoles = new ArrayList<Role>();
				if(null==bean.getRoles()){
					bean.setRoles(new ArrayList<Role>());
				}
				for (Role r:bean.getRoles()) {
					if (roleIds.indexOf(r.getId())==-1){
						deleteRoles.add(r);
					}
				}
				for (Role r:deleteRoles) {
					bean.removeRole(r);
				}
				// 添加新选择的角色
				for (String rid:rIds) {
					Role r=roleMng.findById(rid);
					if(!bean.getRoles().contains(r)){
						bean.addRole(r);
					}
				}
			}else{
				if(null!=bean.getRoles() && bean.getRoles().size()>0){
					List<Role> deleteRoles = new ArrayList<Role>();
					for (Role r:bean.getRoles()) {
						deleteRoles.add(r);
					}
					for (Role r:deleteRoles) {
						bean.removeRole(r);
					}
				}
			}
		}
		if(null==bean.getDepart() || StringUtil.isEmpty(bean.getDepart().getId())){
			bean.setDepart(null);
		}
		/*if(null!=bean.getStreet() && !StringUtil.isEmpty(bean.getStreet().getStreetCode())){
			bean.setStreet(commStreetMng.findUniqueByProperty("streetCode",bean.getStreet().getStreetCode()));
		}else{
			bean.setStreet(null);
		}*/
		/*if(bean.getDepart()!=null && !StringUtil.isEmpty(bean.getDepart().getCode())){
			bean.setDwdm(bean.getDepart().getCode());
		}
		if(!StringUtil.isEmpty(bean.getIsPersonLiable())){
			if(StringUtil.isEmpty(bean.getStatus())&&"1".equals(bean.getIsPersonLiable())){
				bean.setStatus("10");
			}else if("0".equals(bean.getIsPersonLiable())){
				bean.setStatus(null);
			}
		}*/
		bean=super.save(bean);
	}

	@Override
	public List<User> list(String uId,Depart depart,String roleCode) {
		// TODO Auto-generated method stub
		Finder f=Finder.create("Select u from User u join u.roles r Where u.flag='1'");
		if(!StringUtil.isEmpty(roleCode)){
			f.append(" and r.code= :rcode");
			f.setParam("rcode",roleCode);
		}
		if(null!=depart && !StringUtil.isEmpty(depart.getId())){
			f.append(" and u.depart.id= :departId");
			f.setParam("departId",depart.getId());
		}
//		if(!StringUtil.isEmpty(uId)){
//			f.append(" and u.id <> :id");
//			f.setParam("id",uId);
//		}
		f.append(" order by u.name");
		return super.find(f);
	}
	@Override
	public List<User> getUserByDepartCode(String departCode) {
		// TODO Auto-generated method stub
		String hql="from User Where flag='1' and depart.code=?";
		return super.find(hql,new Object[]{departCode});
	}
	@Override
	public List<User> getALL() {
		// TODO Auto-generated method stub
		String hql="from User Where flag='1'";
		return super.find(hql);
	}
	
	@Override
	public List<RoleDepartUser> getALL(User user) {
		// TODO Auto-generated method stub
		List<RoleDepartUser> list = new ArrayList<RoleDepartUser>();
		String hql="SELECT sysuser.PID,sysuser.`NAME`,depart.DEPARTNAME FROM `sys_user` sysuser,sys_depart depart where sysuser.DEPARTID=depart.PID";
		if(!StringUtil.isEmpty(user.getName())){
			hql+=" and sysuser.name like'%"+user.getName()+"%'";
		}
		if(!StringUtil.isEmpty(user.getDepart().getName())){
			hql+=" and depart.DEPARTNAME like'%"+user.getDepart().getName()+"%'";
		}
		Query query = getSession().createSQLQuery(hql);
		List<Object[]> userList = query.list();
		for (int i = 0; i < userList.size(); i++) {
			RoleDepartUser newuser = new RoleDepartUser();
			newuser.setUserId(String.valueOf(userList.get(i)[0]));
			newuser.setUserName(String.valueOf(userList.get(i)[1]));
			newuser.setDepartName(String.valueOf(userList.get(i)[2]));;
			list.add(newuser);
		}
		return list;
	}
	
	@Override
	public List<User> getByIds(String ids) {
		// TODO Auto-generated method stub
		String hql="from User Where flag='1' and id in ("+ids+")";
		return super.find(hql);
	}
	@Override
	public List<User> getChildByJwhCode(String jwhId) {
		// TODO Auto-generated method stub
		String hql = "from User where flag='1' and jwh.id = ? and isPersonLiable='1' order by name";
		return find(hql, jwhId);
	}
	@Override
	public  boolean findByAccount(String account){
		String hql = "from User where flag='1' and accountNo = ? ";
		List<User> list=super.find(hql, account);
		if(list!=null&&list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public List<User> findChild(String streetId,String jwhId,String liablePerson,boolean hasqu, boolean hasStreet,User user) {		
		StringBuffer hql =new StringBuffer("from User where flag='1' and isPersonLiable='1'");
        if(streetId!=null&&!streetId.equals("")){
        	hql.append(" and street.id='"+streetId+"'");
        }
        if(jwhId!=null&&!jwhId.equals("")){
        	hql.append(" and jwh.id = '"+jwhId+"'");
        }
        if(liablePerson!=null&&!liablePerson.equals("")){
        	hql.append(" and name like '%"+liablePerson+"%'");
        }
        hql.append(" order by name");
		return find(hql.toString());
	}
	
	public User getByAccount(String account){
		String hql = "from User where flag='1' and accountNo = ? ";
		List<User> list=super.find(hql, account);
		User user= list.get(0);
		return user;
	}

	@Override
	public Pagination liablelist(User user, boolean isQuRole,
			boolean isStreetRole, String sort, String order, int pageNo,
			int pageSize, User u) {
		Finder finder=Finder.create("from User Where flag='1' and isPersonLiable='1' ");
		/*if(!isQuRole){
			finder.append(" and street.id = '"+u.getStreet().getId()+"'");
		}*/
		if(null!=user){
			if(!StringUtil.isEmpty(user.getDm())){
				finder.append(" and street.id = :dm");
				finder.setParam("dm",user.getDm());
			}
			if(!StringUtil.isEmpty(user.getJwhname())){
				finder.append(" and jwh.id = :jwhid");
				finder.setParam("jwhid",user.getJwhname());
			}
			if(!StringUtil.isEmpty(user.getName())){
				finder.append(" and name like :Name");
				finder.setParam("Name","%"+user.getName()+"%");
			}
			if(!StringUtil.isEmpty(user.getPersonliablestatus())){
				finder.append(" and status = :status");
				finder.setParam("status",user.getPersonliablestatus());
			}
		}
		if(!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order) && (order.equals("asc") || order.equals("desc"))){
			finder.append(" order by "+sort+" "+order);
		}else{
			finder.append(" order by name");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Pagination refInspectorList(User bean, String sort, String order,
			int pageIndex, int pageSize, boolean isQuRole,
			boolean isStreetRole, User user) {
		// TODO Auto-generated method stub
		Finder finder=Finder.create("from User Where flag='1' and isPersonLiable='1' and status='10'");
		/*if(!isQuRole){
			finder.append(" and street.id = '"+user.getStreet().getId()+"'");
		}*/
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getJdId())){
				finder.append(" and street.id = :jdId");
				finder.setParam("jdId",bean.getJdId());
			}
			if(!StringUtil.isEmpty(bean.getJwhId())){
				finder.append(" and jwh.id = :jwhId");
				finder.setParam("jwhId",bean.getJwhId());
			}
			if(!StringUtil.isEmpty(bean.getName())){
				finder.append(" and name like :name");
				finder.setParam("name","%"+bean.getName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getPersonliablestatus())){
				finder.append(" and status = :status");
				finder.setParam("status",bean.getPersonliablestatus());
			}
		}
		if(!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order) && (order.equals("asc") || order.equals("desc"))){
			finder.append(" order by "+sort+" "+order);
		}else{
			finder.append(" order by name");
		}
		return super.find(finder, pageIndex, pageSize);
	}

	@Override
	public List<User> inspectorList(boolean isQuRole, boolean isStreetRole,
			User user) {
		// TODO Auto-generated method stub
		StringBuffer hql=new StringBuffer("from User Where flag='1' and isPersonLiable='1' and status='10'");
	/*	if(!isQuRole){
			hql.append(" and street.id = '"+user.getStreet().getId()+"'");
		}*/
		hql.append(" order by name");
		return super.find(hql.toString(),new Object[]{});
	}
	
	/**
	 * 获取有某个角色的人员
	 * @param roleCode
	 * @return
	 */
	public List<User> listAuditor(String roleCode){
		List<User> auditors=new ArrayList<User>();
		StringBuffer hql=new StringBuffer("from User Where flag='1'");
		List<User> list=super.find(hql.toString());
		for(User us: list){
			List<Role> listRole=us.getRoles();
			if(null!=listRole && listRole.size()>0){
				for(Role r:listRole){
					if(roleCode.equals(r.getCode())){
						auditors.add(us);
					}
				}
			}
		}
		return auditors;  
	}
	/**
	 * 检查手机号唯一
	 * @return
	 */
	public boolean checkMobileNo(String mobileNo,String id){
		Finder hql=Finder.create("from User where flag='1' ");
		hql.append(" and mobileNo=:mobileNo").setParam("mobileNo", mobileNo);
		if(!StringUtil.isEmpty(id)){
			hql.append(" and id <>:id").setParam("id", id);
		}
		List<User> list=super.find(hql);
		if(list!=null&&list.size()>0){
			return true;
		}
		
		return false;
	}
	
	/**
	 * 返回用户的角色
	 * @author 叶崇晖
	 * @createtime 2018-06-19
	 * @updatetime 2018-06-19
	 */
	@Override
	public List<Role> getUserRole(String userId) {
		User user = super.findById(userId);
		List<Role> list = user.getRoles();
		return list;
	}


	@Override
	public Pagination getNameAndDept(User user, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM User WHERE 1=1 ");
		if(!StringUtil.isEmpty(user.getName())){
			finder.append("AND name like :name ");
			finder.setParam("name",  "%"+user.getName()+"%");
		}else if(!StringUtil.isEmpty(user.getAccountNo())){
			finder.append("AND accountNo like :accountNo ");
			finder.setParam("accountNo", "%"+user.getAccountNo()+"%" );
		}else if(!StringUtil.isEmpty(user.getMobileNo())){
			finder.append("AND depart.name like :departName ");
			finder.setParam("departName","%"+user.getMobileNo()+"%" );
		}
		return super.find(finder, pageNo, pageSize);
	}
	
	/**
	 * 根据角色id和部门id获取用户
	 * @param roleId
	 * @param departId
	 * @return
	 */
	@Override
	public User getUserByRoleIdAndDepartId(String roleId,String departId){
		//先查到主管校长的id
		List<Role> roleList=roleMng.findByProperty("name", "主管校长");
		String zgxzRoleId="";
		if(roleList!=null && roleList.size()>0){
			zgxzRoleId=roleList.get(0).getId(); //主管校长id
		}
		if(zgxzRoleId.equals(roleId)){
			//如果是主管校长，就不能根据角色id和部门id去查询用户了. 要查询部门的主管校长
			Depart depart=departMng.findById(departId);
			User user=depart.getManager();
			return user;
		}
		String userSql = "select * from sys_user su WHERE  exists (SELECT USERID FROM sys_user_role sur WHERE su.PID=sur.USERID and  ROLEID='"+roleId+"') AND departid='"+departId+"'";
		Query userQuery = getSession().createSQLQuery(userSql).addEntity(User.class);
		List<User> userList = userQuery.list();
		if(userList !=null && userList.size()>0){
			User user = userList.get(0);
			return user;
		}else{
			return new User();
		}
		
	}
	/**
	 * 
	* @author:安达
	* @Title: wfNameAndDepart 
	* @Description: 流程配置的时候，选择角色 
	* @return
	* @return List<Object[]>    返回类型 
	* @date： 2019年7月3日下午10:19:07 
	* @throws
	 */
	@Override
	public  List<RoleDepartUser> wfNameAndDepart(String roleName,String departName){
		List<RoleDepartUser> roleDepartUserList=new ArrayList<RoleDepartUser>();
		String sql ="select DISTINCT su.name as userName,su.pid as userId,su.DEPARTID as departId,sd.DEPARTNAME as departName,sr.ROLENAME as roleName,sr.pid as roleId "
				+ " from sys_depart sd right join  sys_user su on sd.pid=su.DEPARTID  RIGHT join sys_user_role sur on sur.USERID=su.pid "
				+ " left join  sys_role sr on  sur.ROLEID=sr.pid  where 1=1 ";
		if(StringUtils.isNotEmpty(roleName)){
			sql=sql+" and sr.ROLENAME like '%"+roleName+"%' ";
		}
		if(StringUtils.isNotEmpty(departName)){
			sql=sql+" and sd.DEPARTNAME like '%"+departName+"%' ";
		}
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		if(list!=null && list.size()>0){
			for(Object[] objs:list){
				RoleDepartUser roleDepartUser=new RoleDepartUser();
				roleDepartUser.setUserName((String)objs[0]);
				roleDepartUser.setUserId((String)objs[1]);
				roleDepartUser.setDepartId((String)objs[2]);
				roleDepartUser.setDepartName((String)objs[3]);
				roleDepartUser.setRoleName((String)objs[4]);
				roleDepartUser.setRoleId((String)objs[5]);
				roleDepartUserList.add(roleDepartUser);
			}
		}
		return roleDepartUserList;
	}

	@Override
	public boolean checkUsersByDepartId(String departId) {
		Finder hql = Finder.create("from User where flag = '1' ");
		hql.append(" and departId=:departId").setParam("departId", departId);
		List<User> list = super.find(hql);
		if(list != null && list.size() > 0){
			return true;
		}
		return false;
	}

	@Override
	public void updateUserFlow(String UserId,String userName,String userById,String departName) throws Exception{
		String sql = "update t_node_data set USER_ID='"+UserId+"',TEXT='"+userName+"|"+departName+"'  where USER_ID = '"+userById+"'";
		Query query=getSession().createSQLQuery(sql);
		query.executeUpdate();
		
	}

	@Override
	public User getUserByRoleNameAndDepartName(String roleName,
			String departName) {
		String userSql = "SELECT * FROM sys_user su WHERE EXISTS (SELECT userId FROM sys_user_role sur, sys_role sr WHERE su.PID = sur.USERID AND sur.ROLEID = sr.PID AND su.DEPARTID = sr.DEPARTID AND sr.ROLENAME = '"+roleName+"' AND sr.DEPARTNAME = '"+departName+"')";
		Query userQuery = getSession().createSQLQuery(userSql).addEntity(User.class);
		List<User> userList = userQuery.list();
		if(userList !=null && userList.size()>0){
			User user = userList.get(0);
			return user;
		}else{
			return new User();
		}
	}

	@Override
	public Pagination getUserByIds(String ids) {
		String sql = "select user0_.PID,user0_.ACCOUNTNO,user0_.NAME,depart1_.DEPARTNAME,user0_.roleslevel from sys_user user0_ left outer join sys_depart depart1_ on user0_.departid=depart1_.pid where user0_.pflag='1'"; 
		if (!StringUtil.isEmpty(ids)) {
			sql = sql+" and user0_.PID IN (" + ids + ")";
		}
		SQLQuery query = getSession().createSQLQuery(sql);
		List<Object[]> userList = query.list();
		
		List<UserTransient> userTransientList = new ArrayList<UserTransient>();
		for (int i = 0; i < userList.size(); i++) {
			
			UserTransient transient1 = new UserTransient(); 
			transient1.setId(String.valueOf(userList.get(i)[0]));
			transient1.setAccountNo(String.valueOf(userList.get(i)[1]));
			transient1.setName(String.valueOf(userList.get(i)[2]));
			transient1.setDepartName(String.valueOf(userList.get(i)[3]));
			int level = userList.get(i)[4] ==null ? 0:Integer.valueOf(String.valueOf(userList.get(i)[4]));
			transient1.setRoleslevel(level);
			switch (level) {
			case 1:
				transient1.setRoleslevelname("市级人员");
				break;
			case 2:
				transient1.setRoleslevelname("厅级人员");
				break;
			case 3:
				transient1.setRoleslevelname("其他人员");
				break;
			}
			userTransientList.add(transient1);
		}
		
		Pagination pagintion= new Pagination();
		pagintion.setList(userTransientList);
		return pagintion;
	}
	
}

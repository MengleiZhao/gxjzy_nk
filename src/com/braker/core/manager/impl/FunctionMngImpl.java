package com.braker.core.manager.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.OrderBy;
import com.braker.common.hibernate.Updater;
import com.braker.common.util.StringUtil;
import com.braker.common.util.redis.RedisConstantsKeys;
import com.braker.common.util.redis.RedisUtil;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.model.Function;
import com.braker.core.model.Role;

@SuppressWarnings("unchecked")
@Service
@Transactional
public class FunctionMngImpl extends BaseManagerImpl<Function> implements
		FunctionMng {
	public static Map<String,List<Function>> parentFunListsMap;
	public static Map<String,Set<Function>> parentFunSetsMap;
	@Autowired
	private RoleMng roleMng;
	
	
	/**
	 * 
	* @author:安达
	* @Title: getparentFuncsMap 
	* @Description: 得到 parent下面的每个子节点集合
	* @return
	* @return Map<Long,List<Function>>    返回类型 
	* @date： 2019年5月27日上午10:15:21 
	* @throws
	 */
	public  void init(){
		//查询所有权限表数据
		List<Function> funcList=super.findAll(OrderBy.asc("priority"));
		//得到一个给每个parentid都占个位置，对应的child集合是空
		Map<String,List<Function>> parentFunListMap=getEmptyFunListMap(funcList);
		Map<String,Set<Function>> parentFunSetMap=getEmptyFunSetMap(funcList);
		for(Function funs:funcList){
			if("1".equals(funs.getFlag())){
				if(funs.getParentId()==null && funs.getParent()!=null){
					funs.setParentId(funs.getParent().getId()+"");
				}
				if(parentFunListMap.get(funs.getParentId()) !=null){
					List<Function> childList=parentFunListMap.get(funs.getParentId());
					childList.add(funs);
					parentFunListMap.put(funs.getParentId(), childList);
				}
				if(parentFunSetMap.get(funs.getParentId()) !=null){
					Set<Function> childSet=parentFunSetMap.get(funs.getParentId());
					childSet.add(funs);
					parentFunSetMap.put(funs.getParentId(), childSet);
				}
			}
			
		}
		parentFunListsMap=parentFunListMap;
		parentFunSetsMap=parentFunSetMap;
	}
	/**
	 * 
	* @author:安达
	* @Title: getEmptyFuncsMap 
	* @Description: 根据集合，得到一个给每个parentid都占个位置，对应的child集合是空
	* @param funcList
	* @return
	* @return Map<String,List<Function>>    返回类型 
	* @date： 2019年5月27日上午10:31:48 
	* @throws
	 */
	private Map<String,List<Function>> getEmptyFunListMap(List<Function> funcList){
		 Map<String,List<Function>> parentFuncsMap=new HashMap<String,List<Function>>();
		 for(Function funs:funcList){
				List<Function> childLst=new ArrayList<Function>();
				if(parentFuncsMap.get(funs.getParentId())==null){
					parentFuncsMap.put(funs.getParentId(), childLst);
				}
			}
		 return parentFuncsMap;
	}
	private Map<String,Set<Function>> getEmptyFunSetMap(List<Function> funcList){
		 Map<String,Set<Function>> parentFuncsMap=new HashMap<String,Set<Function>>();
		 for(Function funs:funcList){
			 Set<Function> childSet=new HashSet<Function>();
				if(parentFuncsMap.get(funs.getParentId())==null){
					parentFuncsMap.put(funs.getParentId(), childSet);
				}
			}
		 return parentFuncsMap;
	}
	/*
	 * 根据用户id查询自己拥有的权限列表集合
	 * @author 李安达
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 */
	public List<Function> getFunctions_old(String userId) {
		String hql = "from Function func where func.id in"
				+ " (select f1.id from User user join user.roles role join role.functions f1 where user.id = ?) "
				+ " order by func.priority asc";
		List<Function> functionList=find(hql,userId);
		return functionList;
	}
	/*
	 * 根据用户id查询自己拥有的权限列表集合
	 * @author 李安达
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 */
	public List<Function> getFunctions(String userId) {
			String sql = "SELECT "
						 +	"	pid ,url,funcs,name"		 
						 +	"	FROM"
						 +	"	SYS_FUNCTION function0_ "
						 +	"	WHERE"
						 +	"		function0_.pid IN ("
						 +	"	SELECT"
						 +	"		function5_.pid "
						 +	"	FROM"
						 +	"		sys_user user1_"
						 +	"		INNER JOIN sys_user_role roles2_ ON user1_.pid = roles2_.userid"
						 +	"		INNER JOIN sys_role role3_ ON roles2_.roleid = role3_.pid "
						 +	"		AND ( role3_.pflag = '1' )"
						 +	"		INNER JOIN SYS_ROLE_FUNCTION functions4_ ON role3_.pid = functions4_.ROLE_ID"
						 +	"		INNER JOIN SYS_FUNCTION function5_ ON functions4_.FUNCTION_ID = function5_.pid "
						 +	"		AND ( function5_.pflag = '1' ) "
						 +	"	WHERE"
						 +	"		user1_.pid = '"+userId+"' "
						 +	"		) "
						 +	"	ORDER BY function0_.priority ASC";
			SQLQuery query=getSession().createSQLQuery(sql.toString());
			List<Object[]> objectList= query.list();
			List<Function> functionList=new ArrayList<Function>();
			if(objectList!=null ){
				for(Object[] objs:objectList){
					Function function=new Function();
					function.setId((long) Double.parseDouble(objs[0]+""));
					function.setUrl(String.valueOf(objs[1]));
					function.setFuncs(String.valueOf(objs[2]));
					function.setName(String.valueOf(objs[3]));
					functionList.add(function);
				}
			}
		return functionList;
	}
	public Set<String> getFunctionItems(String userId) {
		List<Function> funcList = getFunctions(userId);
		Set<String> funcItemSet = new HashSet<String>();
		String f = null;
		String fs = null;
		String[] fa = null;
		for (Function function : funcList) {
			f = function.getUrl();
			if (!StringUtil.isEmpty(f)) {
				funcItemSet.add(f);
			}
			fs = function.getFuncs();
			if (!StringUtil.isEmpty(fs)) {
				fa = fs.split(Function.FUNC_SPLIT);
				for (String fas : fa) {
					funcItemSet.add(fas);
				}
			}
		}
		return funcItemSet;
	}

	public List<Function> getRoots() {
		String hql = "select func from Function func where func.flag='1' and func.parent.id is null order by func.priority asc";
		return find(hql);
	}

	public List<Function> getChild(Long pid) {
		List<Function> childList=parentFunListsMap.get(pid+"");
		//String hql = "select func from Function func where func.flag='1' and func.parent.id = ? order by func.priority asc";
		return childList;
	}
	/*
	 * 查询所有没有子节点的菜单（底层菜单）
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public List<Double> getFunctionIdList() {
		String sql = "select a.pid from sys_function a where not EXISTS (select * from sys_function b where a.pid = b.PARENT) and pflag=1";
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}
	/*
	 * 把集合转换成Map， 以ID为Key，Id为value
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public Map<Long,Long> getFunctionIdMap(List<Double> list) {
		Map<Long,Long> map=new HashMap<Long,Long>();
		for(Double pid:list){
			map.put(pid.longValue(), pid.longValue());
		}
		return map;
	}
	@Override
	public void update(Function bean) {
		Function f = findById(bean.getId());
		Function pf = f.getParent();
		Function pbean = bean.getParent();
		// pbean!=null代表需要更新父节点。父节点不能等于自身。
		if (pbean != null && !f.getId().equals(pbean.getId())) {
			// pf!=null原父节点存在，处理原父节点的child
			if (pf != null && !pf.getId().equals(pbean.getId())) {
				pf.getChild().remove(f);
			}
			// pbean.getId()!=null新父节点存在，处理新父节点child
			if (pbean.getId() != null && !pbean.getId().equals(pf.getId())) {
				//Function np = findById(pbean.getId());
				//np.addTochild(f);
			}
		}
		Updater<Function> updater=new Updater<Function>(bean);
		super.updateByUpdater(updater);
		//修改完毕以后，维护缓存里的权限数据跟数据库一致
		init();
	}

	@Override
	public Function save(Function func) {
		if(null==func.getParent() || null==func.getParent().getId()){
			func.setParent(null);
		}
		Function newFunc=super.save(func);
		return newFunc;
	}

	@Override
	public Function findById(Serializable id) {
		Function func = super.findById(id);
		return func;
	}

	@Override
	public Function deleteById(Serializable id) {
		Function entity = findById(id);
		entity.setFlag("0");
		Function newFunc=(Function)super.updateDefault(entity);
		//修改完毕以后，维护缓存里的权限数据跟数据库一致
		init();
		return newFunc;
	}
	
	/**
	 * 根据角色id得到该角色拥有功能id集合
	 * @param roleId
	 * @return
	 */
	public List<Long> getFuncsIdsByRoleId(String roleId){
		List<Long> listFuncsIds=new ArrayList<Long>();
		if(!StringUtil.isEmpty(roleId)){
			Role role=roleMng.findById(roleId);
			if(null!=role && null!=role.getFunctions() && role.getFunctions().size()>0){
				List<Function> listFuncs=role.getFunctions(); 
				for(Function f:listFuncs){
					listFuncsIds.add(f.getId());
				}
			}
		}
		return listFuncsIds;
	}
	
	/**
	 * 返回一个全部节点的json格式的字符串
	 * @param roleId 角色id
	 * @return
	 */
	@Override
	public String getTree(String roleId) {
		// TODO Auto-generated method stub
		StringBuffer tree=new StringBuffer("[");
		List<Long> listFuncsIds=getFuncsIdsByRoleId(roleId);
		List<Function> list=getRoots();
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				Function f=list.get(i);
				tree.append("{");
				tree.append("\"id\":"+f.getId()+",");
				if(listFuncsIds.contains(f.getId())){
					tree.append("\"checked\":true,");
				}
				tree.append("\"text\":\""+f.getName()+"\"");
				addChild(f,listFuncsIds,tree);
				tree.append("}");
				if(i!=t-1){
					tree.append(",");
				}
			}
		}
		tree.append("]");
		return tree.toString();
	}
	
	/**
	 * 递归添加子节点的json格式的字符串
	 * @param f
	 * @param tree
	 */
	public void addChild(Function f,List<Long> listFuncsIds,StringBuffer tree){
		//List<Function> listChild=super.find("from Function func where func.flag='1' and func.parent.id=? order by priority",f.getId());
		List<Function> listChild=parentFunListsMap.get(f.getId()+"");
		if(null!=listChild && listChild.size()>0){
			tree.append(",\"state\":\"closed\",\"children\":[");
			int t=listChild.size();
			for (int i = 0; i < t; i++) {
				Function child=listChild.get(i);
				tree.append("{");
				tree.append("\"id\":"+child.getId()+",");
				if(listFuncsIds.contains(child.getId())){
					tree.append("\"checked\":true,");
				}
				tree.append("\"text\":\""+child.getName()+"\"");
				addChild(child,listFuncsIds,tree);
				tree.append("}");
				if(i!=t-1){
					tree.append(",");
				}
			}
			tree.append("]");
		}
	}

	@Override
	public Function findById(Long id) {
		// TODO Auto-generated method stub
		Function f=null;
		List<Function> list=super.find("from Function func where func.flag='1' and func.id=?",id);
		if(null!=list && list.size()>0){
			f=list.get(0);
		}
		return f;
	}

	/**
	 * 返回用户的权限
	 * @author 叶崇晖
	 * @createtime 2018-06-19
	 * @updatetime 2018-06-19
	 */
	@Override
	public List<Function> getUserMenu(Role role) {		
		List<Function> list = role.getFunctions();
		return list;
	}
	
	public List<Function> getChildByUser(Long pid, String userId) {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT * from sys_function where pid in (");
		sb.append("select a.FUNCTION_ID from  sys_role_function a,sys_user_role b where ");
		sb.append("b.USERID='"+userId+"' and b.ROLEID  = a.role_id ");
		sb.append(") and PFLAG='1' and PARENT='"+pid+"'");
		String sql = sb.toString();
		
		Query q = getSession().createSQLQuery(sql).addEntity(Function.class);
		List<Function> list = q.list();
		return list;
	}

}

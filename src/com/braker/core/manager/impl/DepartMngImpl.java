package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.hibernate.OrderBy;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.Role;
import com.braker.core.model.User;
@SuppressWarnings("unchecked")
@Service
@Transactional
public class DepartMngImpl extends BaseManagerImpl<Depart> implements DepartMng{
	public static Map<String,List<Depart>> parentDeptListsMap; //上级部门下面得所有子部门集合
	public static Map<String,Set<Depart>> parentDeptSetsMap;
	public static Map<String,Depart> codeDepartMap;  //部门编码对应的部门信息
	
	/**
	 * 
	* @author:安达
	* @Title: getparentFuncsMap 
	* @Description: 得到 parent下面的每个子节点集合
	* @return
	* @return Map<Long,List<Depart>>    返回类型 
	* @date： 2019年5月27日上午10:15:21 
	* @throws
	 */
	public  void init(){
		//查询所有部门表数据
		List<Depart> funcList=super.findAll(OrderBy.asc("orderNo"));
		//得到一个给每个parentid都占个位置，对应的child集合是空
		Map<String,List<Depart>> parentDeptListMap=getEmptyDeptListMap(funcList);
		Map<String,Set<Depart>> parentdepartetMap=getEmptydepartetMap(funcList);
		Map<String,Depart> codeDepartMap=new HashMap<String,Depart>();
		for(Depart depart:funcList){
			if("1".equals(depart.getFlag())){
				if(parentDeptListMap.get(depart.getParentId()) !=null){
					List<Depart> childList=parentDeptListMap.get(depart.getParentId());
					childList.add(depart);
					parentDeptListMap.put(depart.getParentId(), childList);
				}
				if(parentdepartetMap.get(depart.getParentId()) !=null){
					Set<Depart> childSet=parentdepartetMap.get(depart.getParentId());
					childSet.add(depart);
					parentdepartetMap.put(depart.getParentId(), childSet);
				}
				codeDepartMap.put(depart.getCode(), depart);
			}
			
		}
		this.codeDepartMap=codeDepartMap;
		parentDeptListsMap=parentDeptListMap;
		parentDeptSetsMap=parentdepartetMap;
	}
	/**
	 * 
	* @author:安达
	* @Title: getEmptyFuncsMap 
	* @Description: 根据集合，得到一个给每个parentid都占个位置，对应的child集合是空
	* @param funcList
	* @return
	* @return Map<String,List<Depart>>    返回类型 
	* @date： 2019年5月27日上午10:31:48 
	* @throws
	 */
	private Map<String,List<Depart>> getEmptyDeptListMap(List<Depart> funcList){
		 Map<String,List<Depart>> parentFuncsMap=new HashMap<String,List<Depart>>();
		 for(Depart depart:funcList){
				List<Depart> childLst=new ArrayList<Depart>();
				if(parentFuncsMap.get(depart.getParentId())==null){
					parentFuncsMap.put(depart.getParentId(), childLst);
				}
			}
		 return parentFuncsMap;
	}
	private Map<String,Set<Depart>> getEmptydepartetMap(List<Depart> funcList){
		 Map<String,Set<Depart>> parentFuncsMap=new HashMap<String,Set<Depart>>();
		 for(Depart depart:funcList){
			 Set<Depart> childSet=new HashSet<Depart>();
				if(parentFuncsMap.get(depart.getParentId())==null){
					parentFuncsMap.put(depart.getParentId(), childSet);
				}
			}
		 return parentFuncsMap;
	}
	
	@Override
	public List<Depart> getRoots() {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from Depart Where flag='1' and parent.id is null order by orderNo");
		return super.find(f);
	}

	@Override
	public List<Depart> getChild(String pid) {
		// TODO Auto-generated method stub
		String hql = "from Depart where flag='1' and parent.id = ? order by orderNo";
		return find(hql, pid);
	}

	@Override
	public String deptTreeJson() {
		// TODO Auto-generated method stub
		StringBuffer treeJson=new StringBuffer("[");
		//所有父节点
		List<Depart> roots=this.getRoots();
		if(roots!=null&&roots.size()>0){
			for (int i = 0; i < roots.size(); i++) {
				String rootId=roots.get(i).getId();
				treeJson.append("{\"id\":\""+rootId+"\",\"text\":\""+roots.get(i).getName()+"\"");
				childTreeJson(treeJson, rootId);
				treeJson.append("}");
				if(i!=(roots.size()-1)){
					treeJson.append(",");
				}
			}
		}
		treeJson.append("]");
		return treeJson.toString();
	}

	public void childTreeJson(StringBuffer treeJson, String rootId) {
		//当前父节点
		List<Depart> childs=this.getChild(rootId);
		if(childs!=null&&childs.size()>0){
			treeJson.append(",\"children\":[");
			for (int j = 0; j < childs.size(); j++) {
				treeJson.append("{\"id\":\""+childs.get(j).getId()+"\",\"text\":\""+childs.get(j).getName()+"\"}");
				if(j!=(childs.size()-1)){
					treeJson.append(",");
				}
				this.childTreeJson(treeJson, childs.get(j).getId());
			}
			treeJson.append("]");
		}
	}

	@Override
	public Pagination list(Depart bean, String sort, String order,
			int pageIndex, int pageSize) {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from Depart Where flag='1'");
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getName())){
				f.append(" and name like :name");
				f.setParam("name","%"+bean.getName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getCode())){
				f.append(" and code like :code");
				f.setParam("code","%"+bean.getCode()+"%");
			}
			if(!StringUtil.isEmpty(bean.getId())){
				f.append(" and id = :id");
				f.setParam("id",bean.getId());
			}
		}
		if(!StringUtil.isEmpty(sort)){
			f.append(" order by " + sort );
		}else{
			f.append(" order by   CONVERT(orderNo,SIGNED)");
		}
		if(!StringUtil.isEmpty(order)){
			
		}else{
			f.append(" asc");
		}
		return super.find(f, pageIndex, pageSize);
	}

	@Override
	public synchronized boolean isExist(Depart bean) {
		// TODO Auto-generated method stub
		List<Depart> list=null;
    	if(StringUtil.isEmpty(bean.getId())){
    		String condition = " from Depart where (code = ? or name = ?) and flag='1' ";
    		list = this.find(condition, new Object[]{bean.getCode(),bean.getName()});
    	}else{
			String condition = " from Depart where (code = ? or name = ?) and id <> ? and flag='1' ";
			list = this.find(condition, new Object[]{bean.getCode(),bean.getName(),bean.getId()});
    	}
    	if(null!=list && list.size()>0){
    		return true;
    	}
		return false;
	}

	@Override
	public Depart findByCode(String code) {
		// TODO Auto-generated method stub
		Depart d=null;
		List<Depart> list=super.find("from Depart Where flag='1' and code = ?", new Object[]{code});
		if(null!=list && list.size()>0){
			d=list.get(0);
		}
		return d;
	}

	@Override
	public boolean haveChild(Depart depart) {
		List<Depart> list=super.find("from Depart Where flag='1' and parent.id = ?", new Object[]{depart.getId()});
		if(list!=null && list.size()>0){
			return true;
		}
		return false;
	}
	public boolean haveChild(String parentId) {
		List<Depart> list=super.find("from Depart Where flag='1' and parent.id = ?", new Object[]{parentId});
		if(list!=null && list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public List<TreeEntity> getQueryTree(Depart depart) {
		List<Depart> departList = new ArrayList<Depart>();
		//根据姓名、代码模糊查询
		StringBuffer hql = new StringBuffer("select depart from Depart depart where depart.flag='1' ");
		if(depart!=null){
			if(!StringUtil.isEmpty(depart.getName())){
				hql.append(" and depart.name like '%" + depart.getName() + "%'");
			}
			if(!StringUtil.isEmpty(depart.getCode())){
				hql.append(" and depart.code = '" + depart.getCode() + "'");
			}
			hql.append(" order by depart.orderNo asc");
		}
		
		departList = find(hql.toString());
		
		List<TreeEntity> list = new ArrayList<TreeEntity>();
		for(Depart depart1: departList ){
			TreeEntity tree = new TreeEntity();
			tree.setId(depart1.getId());
			tree.setText(depart1.getName());
			tree.setCode(depart1.getCode());
			tree.setGrww_zrld(depart1.getGrww_zrld());
			tree.setGrww_zrlddh(depart1.getGrww_zrlddh());
			tree.setGrww_lxr(depart1.getGrww_lxr());
			tree.setGrww_lxrdh(depart1.getGrww_lxrdh());
			tree.setParentId(depart1.getParent()!=null? depart1.getParent().getId():"");
			if(haveChild(depart1)){
				tree.setHaveChild("1");
				tree.setState("closed");
			}else{
				tree.setHaveChild("0");
			}
			list.add(tree);
		}
		
		//将子节点放入父节点下
		List<TreeEntity> seniorList = new ArrayList<TreeEntity>();
		List<TreeEntity> juniorList = new ArrayList<TreeEntity>();
		for (TreeEntity tree: list) {
			if (haveChild(tree.getId())) {
				seniorList.add(tree);
			} else {
				juniorList.add(tree);
			}
		}
		List<TreeEntity> deleteList = new ArrayList<TreeEntity>();
		for (TreeEntity stree: seniorList) {
			for (TreeEntity jtree: juniorList) {
				if (stree.getId().equals(jtree.getParentId())) {
					deleteList.add(jtree);
					List<TreeEntity> list1 = stree.getChildren();
					if (list1 == null || list1.size() == 0) {
						list1 = new ArrayList<TreeEntity>();
						stree.setChildren(list1);
					}
					list1.add(jtree);
					stree.setState("opened");
				}
			}
		}
		for (TreeEntity tree: deleteList) {
			juniorList.remove(tree);
		}

		List<TreeEntity> finalList = new ArrayList<TreeEntity>();
		finalList.addAll(seniorList);
		finalList.addAll(juniorList);
		return finalList;
	}

	@Override
	public Depart findByName(String name) {
		Depart d=new Depart();
		Finder f = Finder.create("from Depart Where flag='1' and name =:name").setParam("name", name);
		List<Depart> list=super.find(f);
		if(null!=list && list.size()>0){
			d=list.get(0);
		}
		return d;
	}
	@Override
	public String[] findDeptByUserId(String userId) {
		String[] dept=new String[2];
		String sql = "select sd.pid,sd.DEPARTNAME  from sys_depart sd where exists (select departid from sys_user su where sd.pid=departid and su.pid='"+userId+"') ";
		SQLQuery query=getSession().createSQLQuery(sql.toString());
		List<Object[]> objectList= query.list();
		if(objectList!=null && objectList.size()>0){
			dept[0]=(String) objectList.get(0)[0];
			dept[1]=(String) objectList.get(0)[1];
		}
		return dept;
	}

	@Override
	public List<Depart> findAllDepart(Depart bean, String sort, String order) {
		Finder f=Finder.create("from Depart Where flag='1'");
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getName())){
				f.append(" and name like :name");
				f.setParam("name","%"+bean.getName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getCode())){
				f.append(" and code like :code");
				f.setParam("code","%"+bean.getCode()+"%");
			}
			if(!StringUtil.isEmpty(bean.getId())){
				f.append(" and id = :id");
				f.setParam("id",bean.getId());
			}
		}
		if(!StringUtil.isEmpty(sort)){
			f.append(" order by " + sort );
		}else{
			f.append(" order by code");
		}
		if(!StringUtil.isEmpty(order)){
			
		}else{
			f.append(" asc");
		}
		return super.find(f);
	}

	@Override
	public List<String[]> getSonCompany(Depart depart) {
		
		if (depart == null) return null;

		List<String[]> resList = new ArrayList<>();
		StringBuffer sbf = new StringBuffer(" SELECT DEPARTNAME,PID FROM sys_depart WHERE PFLAG=1 AND TYPE= '" + Depart.TYPE_COM + "'");
		sbf.append(" AND PARENTID='" + depart.getId() + "'");
		/*if (depart != null) {
			String departType = depart.getType();
			if (Depart.TYPE_COM.equals(departType)) {
				//公司登录，获得所有子部门的
				sbf.append(" AND PID IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			} else if (Depart.TYPE_COM.equals(departType)) {
				//部门登录，获取所属公司下所有子部门的
				sbf.append(" AND PID IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getParent().getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			}
		}*/
		List<Object[]> objList = getSession().createSQLQuery(sbf.toString()).list();
		if (objList != null && objList.size() > 0) {
			for (Object[] array: objList) {
				resList.add(new String[]{String.valueOf(array[0]),String.valueOf(array[1])});
			}
		} else {
			resList.add(new String[]{depart.getName(),depart.getId()});
		}
		return resList;
	}
	@Override
	public String getDeptIdStrByUser(User user) {
		List<Role> roleList=user.getRoles();
		String deptIdStr="";
		for(Role role:roleList){
			//部门负责人
			if("部门负责人".equals(role.getName())){
				String dpID = user.getDpID();
				if (dpID.equals("14") || dpID.equals("35")) {
					return dpID;
				}
				deptIdStr=user.getDpID();
			}else if("主管校长".equals(role.getName())){
				List<Depart> departList=super.findByProperty("manager", user);
				//主管校长可以查看自己主管的所有部门
				for(Depart depart:departList){
					if("".equals(deptIdStr)){
						deptIdStr=depart.getId();
					}else{
						deptIdStr=deptIdStr+","+depart.getId();
					}
				}
				
			}else if("校长".equals(role.getName()) || "系统管理员".equals(role.getName())){
				//校长可以查看所有
				return "all";
			}
		}
		return deptIdStr;
	}
	
	@Override
	public List<Depart> getAllDepts(String selected) {
		Finder f=Finder.create("from Depart ");
		if(!StringUtil.isEmpty(selected)){
			f.append("where id ='"+selected+"'");
		}
		f.append("order by (orderNo+0) asc");
		return super.find(f);
	}
	
	@Override
	public List<Lookups> getAllDeptsLookups(String selected) {
		List<Depart> list = getAllDepts(selected);
		List<Lookups> LookupsList = new ArrayList<Lookups>();
		for (int i = 0; i < list.size(); i++) {
			Lookups lookups = new Lookups();
			lookups.setCode(list.get(i).getId());
			lookups.setName(list.get(i).getName());
			lookups.setOrderNo(String.valueOf(i));
			LookupsList.add(lookups);
		}
		return LookupsList;
		
	}
	@Override
	public List<Depart> getAllDeptsParts(String selected) {
		Finder f=Finder.create("from Depart where id not in('557743AE-4987-4B5A-ADBC-32E1D981044B',23,24,37,38,40,42,43)");
		if(!StringUtil.isEmpty(selected)){
			f.append(" and id ='"+selected+"'");
		}
		f.append(" order by (orderNo+0) asc");
		return super.find(f);
	}
	@Override
	public List<Lookups> getAllDeptsPartsLookups(String selected) {
		List<Depart> list = getAllDeptsParts(selected);
		List<Lookups> LookupsList = new ArrayList<Lookups>();
		for (int i = 0; i < list.size(); i++) {
			Lookups lookups = new Lookups();
			lookups.setCode(list.get(i).getId());
			lookups.setName(list.get(i).getName());
			lookups.setOrderNo(String.valueOf(i));
			LookupsList.add(lookups);
		}
		return LookupsList;
	}
	@Override
	public String getDeptIdStrByUsers(User user) {
		List<Role> roleList=user.getRoles();
		String deptIdStr="";
		for(Role role:roleList){
			//部门负责人
			if("部门负责人".equals(role.getName())){
				deptIdStr=user.getDpID();
			}else if("主管校长".equals(role.getName())){
				List<Depart> departList=super.findByProperty("manager", user);
				//主管校长可以查看自己主管的所有部门
				for(Depart depart:departList){
					if("".equals(deptIdStr)){
						deptIdStr=depart.getId();
					}else{
						deptIdStr=deptIdStr+","+depart.getId();
					}
				}
				
			}else if("校长".equals(role.getName()) || "系统管理员".equals(role.getName())){
				//校长可以查看所有
				return "all";
			}
		}
		return deptIdStr;
	}
	
}

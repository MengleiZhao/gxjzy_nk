package com.braker.base.accountant.manager.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.base.accountant.entity.AccoTree;
import com.braker.base.accountant.entity.AccoYear;
import com.braker.base.accountant.manager.AccoTreeMng;
import com.braker.base.accountant.manager.AccoYearMng;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.MyBeanUtils;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.YearsBasicMng;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;

@Service
@Transactional
public class AccoTreeMngImpl extends BaseManagerImpl<AccoTree> implements AccoTreeMng{
	@Autowired
	private AccoYearMng yearsBasicMng;

	/**
	 * 主页面的查询
	 * @author crc
	 * @createtime 2018-06-05
	 * @createname crc
	 */
	@Override
	public Pagination list(AccoTree economic, String departId, String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("FROM AccoTree WHERE 1=1");
		if(!StringUtil.isEmpty(economic.getCode())){
			finder.append(" AND F_EC_CODE LIKE :code");
			finder.setParam("code","%"+economic.getCode()+"%");
		}
		if(!StringUtil.isEmpty(economic.getName())){
			finder.append(" AND F_EC_NAME LIKE :name");
			finder.setParam("name","%"+economic.getName()+"%");
		}
		if(!StringUtil.isEmpty(economic.getType())){
			finder.append(" AND F_EC_TYPE LIKE :type");
			finder.setParam("type","%"+economic.getType()+"%");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public List<AccoTree> EconomicList() {
		String hql = "from AccoTree";
		return find(hql);
	}

	@Override
	public void economic_save(AccoTree economic,User user) {
		if(StringUtil.isEmpty(String.valueOf(economic.getFid()))){
			economic.setCreator(user.getAccountNo());
			economic.setCreateTime(new Date());
		}else{
			AccoTree e = findById(economic.getFid());
			if(!e.getCode().equals(economic.getCode())){
				Finder finder=Finder.create(" from Economic where pid="+Integer.valueOf(e.getCode()));
				List<AccoTree> li=find(finder);
				for (int i = 0; i < li.size(); i++) {
					li.get(i).setPid(Integer.valueOf(economic.getCode()));
					saveOrUpdate(li.get(i));
				}
			}
			economic.setUpdator(user.getAccountNo());
			economic.setUpdateTime(new Date());
		}
		super.merge(economic);
	}

	@Override
	public void economic_delete(String fid) {
		AccoTree e = findById(Integer.valueOf(fid));
		delete1(e);
		//super.deleteById(Integer.valueOf(fid));
	}

	@Override
	public List<AccoTree> getRoots() {
		Finder f=Finder.create("from AccoTree Where 1=1 and parent.id is null order by orderNo");
		return super.find(f);
	}

	@Override
	public int queryFECCode(AccoTree economic) {
		Finder f=Finder.create("from AccoTree Where code=:code");
		f.setParam("code", economic.getCode());
		List<AccoTree> code=super.find(f);
		return code.size();
	}

	@Override
	public List<AccoTree> indexTree(String id,String parentId) {
		Finder finder=Finder.create(" from AccoTree where fYBId="+Integer.valueOf(id));
		if(StringUtil.isEmpty(parentId)||parentId.length()==9){
			finder.append(" and pid =0");
		}else{
			finder.append(" and pid="+parentId);
		}
		
		return super.find(finder);
	}

	@Override
	public Pagination List(String parentId, AccoTree economic, String departId, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" from AccoTree where 1=1");
		boolean aa1=StringUtil.isEmpty(parentId);
		boolean aa2=!StringUtil.isEmpty(economic.getName());
		boolean aa3=!StringUtil.isEmpty(economic.getCode());
		boolean aa4=!StringUtil.isEmpty(economic.getType());
		boolean aa5=!StringUtil.isEmpty(parentId);
		boolean aa6=!StringUtil.isEmpty(String.valueOf(economic.getfYBId()));
		if(aa1){
			finder.append(" and pid=0");			
		}if(aa2){
			finder.append(" and name='"+economic.getName()+"'");
		}if(aa3){
			finder.append(" and code='"+economic.getCode()+"'");
		}if(aa6){
			finder.append(" and fYBId="+economic.getfYBId());
		}if(aa4){
			finder.append(" and type='"+economic.getType()+"'");
		}if(aa5){
			finder.append(" and pid="+parentId);
		}
		return super.find(finder, pageNo, pageSize);
	}

	
	public void delete1(AccoTree bean){
		delete(bean);
		Finder finder=Finder.create(" from AccoTree where pid="+Integer.valueOf(bean.getCode()));
		List<AccoTree> li=find(finder);
		//先把自己删掉
		if (li != null && li.size() > 0) {
			for (AccoTree ee: li) {
				delete1(ee);
			}
		}
		
	}
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" and code<>:code").setParam("code", blanked);
		}
		hql.append(" order by convert(orderNo,SIGNED)");
		return super.find(hql);
	}

	@Override
	public void copy(Integer id) {
		Finder finder=Finder.create("FROM Economic");
	 	List<Economic> e=super.find(finder);
	 	for (int i = 0; i < e.size(); i++) {
	 		AccoTree ec=new AccoTree();
	 		/*MyBeanUtils.mergeObject(e.get(i), ec);*/
	 		ec.setfYBId(id);//年度科目外键
	 		ec.setCode(e.get(i).getCode());//科目编号
	 		ec.setName(e.get(i).getName());//科目名称
	 		ec.setLeve(e.get(i).getLeve());//科目级别
	 		ec.setPid(e.get(i).getPid());//上级科目编号
	 		ec.setOn(e.get(i).getOn());//是否启用
	 		ec.setType(e.get(i).getType());//科目类型
			super.merge(ec);
		}
	 	
	}

	@Override
	public List<AccoTree> findbypid(Integer pid) {
		Finder finder =Finder.create(" FROM Economic WHERE pid = :pid and pid<>0");
		finder.setParam("pid", pid);
		return super.find(finder);
	}
	/*
	 * 查询收入科目信息  类型KMLX-09	是否含有子节点
	 * @author 冉德茂
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@Override
	public List<AccoTree> indexTree(String parCode) {
		Finder finder=Finder.create(" from Economic where type='KMLX-09' ");
		if(!StringUtil.isEmpty(parCode)){//点击查询tree的节点信息
			finder.append(" and pid = '"+parCode+"' ");
		}
		if(StringUtil.isEmpty(parCode)){//展示一级数据列表
			finder.append(" and leve ='KMJB-01' ");
		}
		return super.find(finder);
	}

	/**
	 * 项目申报页面项目支出明细,返回name和code集合
	 * @author 安达
	 * @param name
	 * @return
	 */
	@Override
	public Map<Object,Object> getCodeMap() {
		Map<Object,Object> map=new HashMap<Object,Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String year = sdf.format(new Date());
		List<AccoYear> basicList = yearsBasicMng.findByYear(year);
		//Finder finder=Finder.create(" from Economic where pid in('301','302','303') and name='"+name+"'");
		String sql="select  F_EC_NAME,F_EC_CODE from t_acco_tree  where F_P_EC_ID in ('301' , '302' , '303')  ";
		if (basicList.size() != 0) {
			sql=sql+" and F_Y_B_ID='"+basicList.get(0).getFbId()+"'";
		}
		sql=sql+"  group by F_EC_NAME";
		return super.getObjectMap(sql);
	}

	@Override
	public Lookups findLookupsByCode(String lookupscode, String categoryCode) {
		// TODO Auto-generated method stub
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(lookupscode)){
			hql.append(" and code=:code").setParam("code", lookupscode);
		}
		List<Lookups> list=super.find(hql);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return new Lookups();
	}
	
	
}

package com.braker.core.manager.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.formula.eval.StringValueEval;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.MyBeanUtils;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.SysDepartEconomicMng;
import com.braker.core.manager.YearsBasicMng;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.core.model.YearsBasic;

@Service
@Transactional
public class EconomicMngImpl extends BaseManagerImpl<Economic> implements EconomicMng{
	public static Map<String,Economic> codeEconomicMap;  //部门编码对应的部门信息
	
	@Autowired
	private YearsBasicMng yearsBasicMng;
	@Autowired
	private SysDepartEconomicMng departEconomicMng;
	
	
	public  void init(){
		//查询所有经济科目表数据
		List<Economic> economicList= EconomicList();
		Map<String,Economic> codeEconomicMap1=new HashMap<String,Economic>();
		for(Economic economic:economicList){
			if("1".equals(economic.getOn())){
				codeEconomicMap1.put(economic.getCode(), economic);
			}
		}
		codeEconomicMap=codeEconomicMap1;
	}
	/**
	 * 主页面的查询
	 * @author crc
	 * @createtime 2018-06-05
	 * @createname crc
	 */
	@Override
	public Pagination list(Economic economic, String departId, String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("FROM Economic WHERE 1=1");
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
	public List<Economic> EconomicList() {
		String hql = "from Economic";
		return find(hql);
	}

	@Override
	public void economic_save(Economic economic,User user) {
		if(StringUtil.isEmpty(String.valueOf(economic.getFid()))){
			economic.setCreator(user.getAccountNo());
			economic.setCreateTime(new Date());
		}else{
			Economic e = findById(economic.getFid());
			if(!e.getCode().equals(economic.getCode())){
				Finder finder=Finder.create(" from Economic where pid="+Integer.valueOf(e.getCode()));
				List<Economic> li=find(finder);
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
		Economic e = findById(Integer.valueOf(fid));
		delete1(e);
		//super.deleteById(Integer.valueOf(fid));
	}

	@Override
	public List<Economic> getRoots() {
		Finder f=Finder.create("from Economic Where 1=1 and parent.id is null order by orderNo");
		return super.find(f);
	}

	@Override
	public int queryFECCode(Economic economic) {
		Finder f=Finder.create("from Economic Where code=:code");
		f.setParam("code", economic.getCode());
		List<Economic> code=super.find(f);
		return code.size();
	}


	@Override
	public Economic findbyCode(String code) {
		Finder f=Finder.create("from Economic Where 1=1 and fYBId=:year");
		if(!StringUtil.isEmpty(code)){
			f.append(" and code=:code");
			f.setParam("code", code);
		}
		YearsBasic yb = (YearsBasic) yearsBasicMng.findByYear(DateUtil.getCurrentYear()).get(0);
		f.setParam("year", yb.getFbId());
		return (Economic) super.find(f).get(0);
	}
	
	@Override
	public List<Economic> indexTree(String id,String parentId) {
		Finder finder=Finder.create(" from Economic where fYBId="+Integer.valueOf(id));
		if(StringUtil.isEmpty(parentId)||parentId.length()==8){
			finder.append(" and pCode =0");
		}else{
			finder.append(" and pid="+Integer.valueOf(parentId));
		}
		
		return super.find(finder);
	}

	@Override
	public Pagination List(String parentId, Economic economic, String departId, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" from Economic where 1=1");
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

	
	public void delete1(Economic bean){
		delete(bean);
		Finder finder=Finder.create(" from Economic where pid="+Integer.valueOf(bean.getCode()));
		List<Economic> li=find(finder);
		//先把自己删掉
		if (li != null && li.size() > 0) {
			for (Economic ee: li) {
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
	 		Economic ec=new Economic();
	 		MyBeanUtils.mergeObject(e.get(i), ec);
	 		ec.setFid(null);
	 		ec.setfYBId(id);
			super.merge(ec);
		}
	 	
	}

	@Override
	public List<Economic> findbypid(Integer pid) {
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
	public List<Economic> indexTree(String parCode) {
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
	 * 查询二级指标名称
	 */
	@Override
	public List<Economic> findEconomicLeve2() {
		Finder finder=Finder.create(" from Economic where  leve ='KMJB-02' ");
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
		List<YearsBasic> basicList = yearsBasicMng.findByYear(year);
		//Finder finder=Finder.create(" from Economic where pid in('301','302','303') and name='"+name+"'");
		String sql="select  F_EC_NAME,F_EC_CODE from T_ECONOMIC_SUBJECT_LIB  where F_P_EC_ID in ('301' , '302' , '303')  ";
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
	@Override
	public List<Economic> findByEjLeve(String leve, String year) {
		Finder f=Finder.create("from Economic Where 1=1");
		if(!StringUtil.isEmpty(leve)){
			f.append(" and leve = '"+leve+"' ");
		}
		List<YearsBasic> list = yearsBasicMng.findByYear(year);
		if(list!=null && list.size()>0){
			YearsBasic yb = (YearsBasic) yearsBasicMng.findByYear(year).get(0);
			f.append(" and fYBId='"+yb.getFbId()+"'");
		}else{
			f.append(" and fYBId=''");
		}
		return super.find(f);
	}
	
	@Override
	@Transactional
	public void copyEconomic(Integer oldYearId, YearsBasic newYb) throws Exception{
		Integer newYearId = newYb.getFbId();	//新的年度主键
		String year = newYb.getFtName();	//年度
		//年度 2019 截取后两位
		year = year.substring(2, 4);
		
		//旧年度所有所有数据
		List<Economic> oldList = findByYearIdAllData(oldYearId);
		//父级list KMJB-01的数据
		List<Economic> parentList = new ArrayList<>();
		
		//把每一个父id都放在Map中
		Map<String, List<Economic>> mapList = getParentChild(oldList);
		Map<String, Integer> mapPidList = getParentId(oldList);
		
		for (Economic ec : oldList) {
			if("KMJB-01".equals(ec.getLeve())){
				parentList.add(ec);
			}
			//把子数据放到Map中
			if(mapList.get(String.valueOf(ec.getPid()))!=null){
				Integer pid = mapPidList.get(String.valueOf(ec.getCode()));
				Integer p = ec.getPid();
				List<Economic> childList = mapList.get(String.valueOf(ec.getPid()));
				childList.add(ec);
//				ec.setPid(pid);
//				super.saveOrUpdate(ec);
				mapList.put(String.valueOf(ec.getPid()), childList);
			}
		}
//		return;
		//根据KMJB-01  的父级 集合 递归复制
		for(Economic economic : parentList){
			Economic ec=new Economic();
			//拷贝新对象出来，设置Id为空，保存到数据库，并且返回对象
	 		MyBeanUtils.mergeObject(economic, ec);
	 		ec.setFid(null);
	 		ec.setfYBId(newYearId);
	 		ec.setCreateTime(new Date());
	 		ec.setUpdateTime(new Date());
	 		ec.setCreator("拷贝");
	 		//保存到数据库，并且返回对象
	 		ec=(Economic) super.saveOrUpdate(ec);
//	 		//保存当前科目下一年的id
//	 		super.updateDefault(economic);
	 		//递归复制子集合
 			copyRecursion(mapList, economic.getFid(),ec.getFid(),newYearId,year);
		}
		departEconomicMng.copyDE(oldYearId, newYb);//保存sysdepartEconomic新一年部门和经济分类科目对应关系表数据
		
	}
	
	@Override
	public List<Economic> findByYearIdAllData(Integer fYBId) {
		Finder finder =Finder.create(" FROM Economic WHERE 1=1");
		if(fYBId!=null){
			finder.append(" and fYBId='"+fYBId+"'");
		}
		finder.append(" order by fid asc");
		
		return super.find(finder);
	}
	
	
	/**
	 * 给每一个父id放在map里占个位置
	 * @author  焦广兴
	 * @param mapList
	 * @param list
	 * @return
	 * @Date  2019年12月20日
	 */
	private Map<String,List<Economic>> getParentChild(List<Economic> list){
		Map<String,List<Economic>> parentSubMap=new HashMap<String,List<Economic>>();
		 for(Economic ec:list){
			List<Economic> childLst =  new ArrayList<>();
			if(parentSubMap.get(String.valueOf(ec.getPid()))==null){
				parentSubMap.put(String.valueOf(ec.getPid()), childLst);
			}
		}
		 return parentSubMap;
	}
	private Map<String,Integer> getParentId(List<Economic> list){
		Map<String,Integer> parentSubMap=new HashMap<String,Integer>();
		for(Economic ec:list){
			if(parentSubMap.get(String.valueOf(ec.getCode()))==null){
				parentSubMap.put(String.valueOf(ec.getCode()), ec.getFid());
			}
		}
		return parentSubMap;
	}
	
	/**
	 * 递归复制子集合
	 * @author  焦广兴
	 * @param mapList
	 * @param oldPId
	 * @param newId
	 * @param newYearId
	 * @Date  2019年12月20日
	 */
	private void copyRecursion(Map<String,List<Economic>> mapList, Integer oldPId,Integer newPId,Integer newYearId,String year){
		//根据旧的父id取出子集合
		List<Economic> list = mapList.get(String.valueOf(oldPId));
		if(list!=null && list.size()>0){
			for(Economic economic:list){
				Economic ec=new Economic();
		 		MyBeanUtils.mergeObject(economic, ec);
		 		ec.setFid(null);
		 		ec.setfYBId(newYearId);	//设置新的年度id
		 		ec.setPid(newPId); //设置新的父Id
		 		ec.setCreateTime(new Date());
		 		ec.setUpdateTime(new Date());
		 		ec.setCreator("拷贝");
		 		ec=(Economic) super.saveOrUpdate(ec);
		 		//保存当前科目下一年的id
		 		//super.updateDefault(economic);
	 			copyRecursion(mapList, economic.getFid(),ec.getFid(),newYearId,year);
			}
		}
	}
	
	
}

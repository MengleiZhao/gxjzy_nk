
package com.braker.icontrol.budget.performancemanage.selfrule.manager.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.Validate;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.performancemanage.selfeval.model.SelfEvaluation;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalConfMng;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalTempMng;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalConf;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalTemp;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfProRef;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.cgmanage.cginquiries.model.Sel;


/**
 *自评模版的service实现类
 * @author 冉德茂
 * @createtime 2018-08-07
 * @updatetime 2018-08-07
 */
@Service
@Transactional
public class SelfEvalTempMngImpl extends BaseManagerImpl<SelfEvalTemp> implements SelfEvalTempMng {
	
	@Autowired
	private SelfEvalConfMng selfEvalConfMng;
	@Autowired
	private SelfEvalTempMng selfEvalTempMng;
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public Pagination pageList(SelfEvalTemp bean, int pageNo, int pageSize) {
		try {
			Finder finder =Finder.create("  FROM SelfEvalTemp WHERE fstauts <>"+99+" ");
			if(!StringUtil.isEmpty(bean.getFtempCode())){
				finder.append(" AND ftempCode LIKE :ftempCode");
				finder.setParam("ftempCode", "%"+bean.getFtempCode()+"%");
			}
			if(!StringUtil.isEmpty(bean.getFtempName())){
				finder.append(" AND ftempName LIKE :ftempName");
				finder.setParam("ftempName", "%"+bean.getFtempName()+"%");
			}
			return super.find(finder,pageNo,pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;
	}
	/*
	 * 保存模版   自评配置    规避清单映射表   以及自评项目表的信息
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@Override
	public void save(SelfEvalTemp bean,SelfEvalConf fevalbean, User user, String rate,String proid,String finalproid,String qiyong) {
		/*System.out.println("规避"+"------------"+fevalbean.getFisAvoid());//规避选否的时候没有项目的id合集
		System.out.println("最小值"+"-----------"+fevalbean.getFamountMin());
		System.out.println("最大值"+"-----------"+fevalbean.getFamountMax());
		System.out.println("比例"+"-------------"+rate);
		System.out.println("随机个数"+"----------"+fevalbean.getFrandomMount());
		System.out.println("固定个数"+"----------"+fevalbean.getFfixedMount());//全部  1  一半2  其他3   选全部和一半 没有下面的其他数量
		System.out.println("其他数量"+"----------"+fevalbean.getFotherMount());//其他数量  
		System.out.println("规避清单"+"----------"+proid);
		System.out.println("最终清单"+"----------"+finalproid);
		System.out.println("启用状态"+"----------"+qiyong);*/
		
		bean.setFstauts("0");//新增和修改   数据的删除状态都是0  删除是99
	
		if (bean.getFtId()==null&&fevalbean.getFcId()==null) {//新增
			//保存模版表创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(new Date());
			//设置配置状态  已配置  
			bean.setFisCo("1");
			//设置启用状态   前台页面传递   马上启用是1  稍后启用是0
			bean.setFisOn(qiyong);
			//保存模版
			bean = (SelfEvalTemp) super.saveOrUpdate(bean);	
			//获取刚保存的模版id   为配置表 外键id赋值
			Integer beanId=bean.getFtId();
			//保存  配置表
			fevalbean.setFtId(beanId);//外鍵
			fevalbean.setFevalType(fevalbean.getFevalType());//自评规则类型   字典表数据
			
			if(Integer.valueOf(rate)==0){//筛选比例为0  默认没有根据比例进行筛选
				fevalbean.setFrate(" ");
			}else{
				Double d = Double.valueOf(rate)/100; 
				d.toString();
				fevalbean.setFrate(String.valueOf(d));
			}
			if(fevalbean.getFisAvoid().equals("1")){//规避选是   有映射表
				//保存配置表
				fevalbean = (SelfEvalConf) super.saveOrUpdate(fevalbean);	
				//获取配置表id  为映射表的fcid  自评表的fcid
				Integer cid=fevalbean.getFcId();
			   //保存规避清单     获取规避表的所有id
				String[] datas = new String[]{};
				datas = proid.split(",");
				for (int i = 0; i < datas.length; i++) {
					Integer proids=Integer.valueOf(datas[i]);
					SelfProRef refbean=new SelfProRef();
					refbean.setFcId(cid);
					refbean.setFproId(proids);
					refbean = (SelfProRef) super.saveOrUpdate(refbean);	
				}		
				//保存自评项目的清单信息   
				String[] evals = new String[]{};
				evals = finalproid.split(",");
				for (int i = 0; i < evals.length; i++) {
					Integer proids=Integer.valueOf(evals[i]);
					SelfEvaluation selfevalbean=new SelfEvaluation();
					selfevalbean.setFcId(cid);
					selfevalbean.setFproId(proids);
					selfevalbean.setFisShow(qiyong);//展示状态
					selfevalbean.setFisEval("0");//自评状态
					selfevalbean = (SelfEvaluation) super.saveOrUpdate(selfevalbean);	
				}				
			}
			if(fevalbean.getFisAvoid().equals("0")){//规避选否  没有映射表
				//保存配置表
				fevalbean = (SelfEvalConf) super.saveOrUpdate(fevalbean);
				//获取配置表id  为映射表的fcid
				Integer cid=fevalbean.getFcId();
				//保存自评项目的清单信息   
				String[] evals = new String[]{};
				evals = finalproid.split(",");
				for (int i = 0; i < evals.length; i++) {
					Integer proids=Integer.valueOf(evals[i]);
					SelfEvaluation selfevalbean=new SelfEvaluation();
					selfevalbean.setFcId(cid);
					selfevalbean.setFproId(proids);
					selfevalbean.setFisShow(qiyong);//展示状态
					selfevalbean.setFisEval("0");//自评状态
					selfevalbean = (SelfEvaluation) super.saveOrUpdate(selfevalbean);	
				}				
			}
		} 
		
	else if((bean.getFtId()!=null&&fevalbean.getFcId()!=null) ) {//修改
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(new Date());
			//设置配置状态  已配置  
			bean.setFisCo("1");
			//设置启用状态   未启用
			bean.setFisOn(qiyong);
			//保存模版表
			bean = (SelfEvalTemp) super.saveOrUpdate(bean);	
			//保存  配置表
			fevalbean.setFtId(bean.getFtId());//外鍵
			fevalbean.setFevalType(fevalbean.getFevalType());//自评规则类型   字典表数据
			
			if(Integer.valueOf(rate)==0){//筛选比例为0  默认没有根据比例进行筛选
				fevalbean.setFrate(" ");
			}else{
				Double d = Double.valueOf(rate)/100; 
				d.toString();
				fevalbean.setFrate(String.valueOf(d));
			}
			//根据fcid清空原有映射表的信息
			List<Object> old_pro= getMingxi("SelfProRef", "fcId", fevalbean.getFcId());
			//删除原有的映射表信息
			for (int i = old_pro.size()-1; i >= 0; i--) {
				SelfProRef old_proref = (SelfProRef) old_pro.get(i);
				super.delete(old_proref);
			}
			//根据fcid清空原有自评表的信息
			List<Object> old_eval= getMingxi("SelfEvaluation", "fcId", fevalbean.getFcId());
			//删除原有的映射表信息
			for (int i = old_eval.size()-1; i >= 0; i--) {
				SelfEvaluation old_proeval = (SelfEvaluation) old_eval.get(i);
				super.delete(old_proeval);
			}
			
			if(fevalbean.getFisAvoid().equals("1")){//规避选是   有映射表
				//保存配置表
				fevalbean = (SelfEvalConf) super.saveOrUpdate(fevalbean);
			   //获取新的映射表的所有id
				String[] datas = new String[]{};
				datas = proid.split(",");
				for (int i = 0; i < datas.length; i++) {//保存新的映射信息
					Integer proids=Integer.valueOf(datas[i]);
					SelfProRef refbean=new SelfProRef();
					refbean.setFcId(fevalbean.getFcId());
					refbean.setFproId(proids);
					refbean = (SelfProRef) super.saveOrUpdate(refbean);	
				}
				//保存自评项目的清单信息   
				String[] evals = new String[]{};
				evals = finalproid.split(",");
				for (int i = 0; i < evals.length; i++) {
					Integer proids=Integer.valueOf(evals[i]);
					SelfEvaluation selfevalbean=new SelfEvaluation();
					selfevalbean.setFcId(fevalbean.getFcId());
					selfevalbean.setFproId(proids);
					selfevalbean.setFisShow(qiyong);
					selfevalbean.setFisEval("0");//自评状态
					selfevalbean = (SelfEvaluation) super.saveOrUpdate(selfevalbean);	
				}
				
			}
			if(fevalbean.getFisAvoid().equals("0")){//规避选否  没有映射表
				//保存配置表
				fevalbean = (SelfEvalConf) super.saveOrUpdate(fevalbean);	
				//获取配置表id  为映射表的fcid
				Integer cid=fevalbean.getFcId();
				//保存自评项目的清单信息   
				String[] evals = new String[]{};
				evals = finalproid.split(",");
				for (int i = 0; i < evals.length; i++) {
					Integer proids=Integer.valueOf(evals[i]);
					SelfEvaluation selfevalbean=new SelfEvaluation();
					selfevalbean.setFcId(cid);
					selfevalbean.setFproId(proids);
					selfevalbean.setFisShow(qiyong);
					selfevalbean.setFisEval("0");//自评状态
					selfevalbean = (SelfEvaluation) super.saveOrUpdate(selfevalbean);	
				}
				
			} 

		}
	  }
	/*
	 * 根据ID删除模版信息  同时删除配置表和规避项目映射表的信息
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	@Override
	public void delete(Integer id) {
		//id是模版表的F_T_ID	
		//查询配置表的信息
		List<Object> confbeanlist= getMingxi("SelfEvalConf", "ftId", id);
		SelfEvalConf confbean = (SelfEvalConf) confbeanlist.get(0);
		//判断配置表是否有规避的项目  若有进行删除  
		if(confbean.getFisAvoid().equals("1")){
			//查询映射表的信息
			List<Object> oldpro= getMingxi("SelfProRef", "fcId", confbean.getFcId());
			//删除映射表
			for (int i = oldpro.size()-1; i >= 0; i--) {
				SelfProRef oldproref = (SelfProRef) oldpro.get(i);
				super.delete(oldproref);
			}
		}		
		//删除自评项目表
		List<Object> evalpro= getMingxi("SelfEvaluation", "fcId", confbean.getFcId());
		for (int j = evalpro.size()-1; j >= 0; j--) {
			SelfEvaluation oldproeval= (SelfEvaluation) evalpro.get(j);
			super.delete(oldproeval);
		}
		
		
		//删除配置表的信息
		super.delete(confbean);
		
		//删除模版表的信息
		SelfEvalTemp tempbean = super.findById(id);
		super.delete(tempbean);						
	}
	/*
	 *查询
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}
	
	/*
	 * 根据页面的配置信息生成预览自评项目的信息
	 * @author 冉德茂
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	@Override
	public List<TProBasicInfo> getprolist(String rate,String proids, String min, String max, String randM, String fixed,String othM,String isavoid) {

		//获取比例信息  如果为0  默认没有按照比例来筛选
		if(Integer.valueOf(rate)==0){//筛选比例为0  默认没有根据比例进行筛选
			rate=" ";
		}else{
			Double d = Double.valueOf(rate)/100; 
			d.toString();
			rate=String.valueOf(d);
		}
		//存在规避项目的   去掉id合集的最后一个，符号
		if(isavoid.equals("1")){
			proids = proids.substring(0,proids.length()-1);
		}
		/*System.out.println("规避"+"------------"+isavoid);//规避选否的时候没有项目的id合集
		System.out.println("最小值"+"-----------"+min);
		System.out.println("最大值"+"-----------"+max);
		System.out.println("比例"+"-------------"+rate);
		System.out.println("随机个数"+"----------"+randM);
		System.out.println("固定个数"+"----------"+fixed);//全部  1  一半2  其他3   选全部和一半 没有下面的其他数量
		System.out.println("其他数量"+"----------"+othM);//其他数量  
		System.out.println("规避清单"+"----------"+proids);*/
								
		//执行筛选操作
		List<TProBasicInfo> prolist = new ArrayList<TProBasicInfo>();
		List<Object[]> idlist =new ArrayList<Object[]>();

		//判断是否按金额筛选
		if(!min.equals("") && !max.equals("")){
			//判断是否有规避项目
			if(isavoid.equals("0")){//按金额范围筛选无规避项目
				//System.out.println("金额无规避");
				//查出按条件筛选后的项目id
				String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT "
							+ "from t_pro_basic_info where  F_PRO_STAUTS ='1' "
							+ "and F_PRO_BUDGET_AMOUNT >= "+min+" "
							+ "and F_PRO_BUDGET_AMOUNT <= "+max+"  ";
				Query qs = getSession().createSQLQuery(s);
				idlist = qs.list();
			}
			if(isavoid.equals("1")){//按金额范围筛选有规避项目
				//System.out.println("金额有规避");
				//查出按条件筛选后的项目id（除去规避项目的id）
				String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT "
							+ "from t_pro_basic_info where  F_PRO_STAUTS ='1' "
							+ "and F_PRO_BUDGET_AMOUNT >= "+min+" "
							+ "and F_PRO_BUDGET_AMOUNT <= "+max+" "
							+ "and F_PRO_ID not in("+proids+") ";
				Query qs = getSession().createSQLQuery(s);
				idlist = qs.list();
			}
		}
		//判断是否按比例筛选
		else if(!rate.equals(" ")){
			//判断是否有规避项目
			if(isavoid.equals("0")){//按比例筛选无规避项目
				//System.out.println("比例无规避");
				//先查询按照比例所筛选  会获得多少条数据 向上取整  去小数
				String s1 = "select CEIL((select count(*)*"+rate+" from t_pro_basic_info where  F_PRO_STAUTS ='1') ) ";
				Query qs1 = getSession().createSQLQuery(s1);
				List<Object[]> countid = qs1.list();
				Integer total= Integer.valueOf(String.valueOf(countid.get(0)));
				//查询满足筛选数的 项目的id
				String  s2= "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							+ "from t_pro_basic_info  where  F_PRO_STAUTS ='1'"
							+ " order by F_PRO_ID asc limit "+total+" ";
				Query qs2 = getSession().createSQLQuery(s2);
				idlist = qs2.list();
			}
			if(isavoid.equals("1")){//按比例筛选有规避项目
				//System.out.println("比例有规避");
				//先查询按照比例所筛选  会获得多少条数据  向上取整 去小数
				String s1 = "select CEIL((select count(*) * "+rate+" from t_pro_basic_info where  F_PRO_STAUTS ='1') ) ";
				Query qs1 = getSession().createSQLQuery(s1);
				List<Object[]> countid = qs1.list();
				Integer total= Integer.valueOf(String.valueOf(countid.get(0)));
				
				//查询满足筛选数的 项目的id （除去规避项目的id）
				String  s2= "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT "
						+ "from t_pro_basic_info  where  F_PRO_STAUTS ='1' "
						+ "and F_PRO_ID not in("+proids+") "
						+ " order by F_PRO_ID asc limit "+total+" ";
				Query qs2 = getSession().createSQLQuery(s2);
				idlist = qs2.list();
			}
		}
		//判断是否  是随机筛选
		else if(!randM.equals("")){
			if(isavoid.equals("0")){//随机筛选无规避项目
				//System.out.println("随机无规避");
				String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
						+ "FROM t_pro_basic_info WHERE F_PRO_ID >="
						+ " ((SELECT MAX(F_PRO_ID) FROM t_pro_basic_info where  F_PRO_STAUTS ='1')-"
						+ "(SELECT MIN(F_PRO_ID) FROM t_pro_basic_info where  F_PRO_STAUTS ='1')) "
						+ "* RAND() + (SELECT MIN(F_PRO_ID) FROM t_pro_basic_info where  F_PRO_STAUTS ='1') "
						+ "and  F_PRO_STAUTS ='1' LIMIT "+randM+" ";
				Query qs = getSession().createSQLQuery(s);
				idlist = qs.list();
			}
			if(isavoid.equals("1")){//随机筛选有规避项目
				//System.out.println("随机有规避");
				String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT "
						+ " FROM t_pro_basic_info WHERE F_PRO_ID >= "
						+ "((SELECT MAX(F_PRO_ID) FROM t_pro_basic_info where  F_PRO_STAUTS ='1' and F_PRO_ID not in("+proids+") )-"
						+ "(SELECT MIN(F_PRO_ID) FROM t_pro_basic_info where  F_PRO_STAUTS ='1' and F_PRO_ID not in("+proids+") )) "
						+ "* RAND() + (SELECT MIN(F_PRO_ID) FROM t_pro_basic_info where  F_PRO_STAUTS ='1' and F_PRO_ID not in("+proids+") ) "
						+ "and F_PRO_ID not in("+proids+")  "
						+ "and F_PRO_STAUTS ='1' LIMIT "+randM+" ";
				Query qs = getSession().createSQLQuery(s);
				idlist = qs.list();
			}
		}
		//判断是否根据固定数进行筛选
		else if(!fixed.equals("")){
			if(isavoid.equals("0")){//固定数筛选 没有规避项目
				//System.out.println("固定数筛选 没有规避项目");
				if(fixed.equals("1")){//1是全部筛选 
					//System.out.println("全部筛选");
					String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							 + "from t_pro_basic_info where  F_PRO_STAUTS ='1' ";
					Query qs = getSession().createSQLQuery(s);
					idlist = qs.list();
				}
				if(fixed.equals("2")){//2是筛选一半 
					//System.out.println("筛选一半");
					//查询一半有多少  向上取整 去小数
					String s1 = "select CEIL((select count(*)*"+0.5+" from t_pro_basic_info where  F_PRO_STAUTS ='1') ) ";
					Query qs1 = getSession().createSQLQuery(s1);
					List<Object[]> countid = qs1.list();
					Integer total= Integer.valueOf(String.valueOf(countid.get(0)));
					String s2 = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							  + "from t_pro_basic_info  where  F_PRO_STAUTS ='1' order by F_PRO_ID asc limit "+total+"";
					Query qs2 = getSession().createSQLQuery(s2);
					idlist = qs2.list();
				}
				if(fixed.equals("3")){//3是  其他筛选
					//System.out.println("筛选其他数量");
					Integer othermount= Integer.valueOf(othM);
					String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							 + "from t_pro_basic_info  where  F_PRO_STAUTS ='1' order by F_PRO_ID asc limit "+othermount+"";
					Query qs = getSession().createSQLQuery(s);
					idlist = qs.list();
				}
			}
			if(isavoid.equals("1")){//固定数筛选  有规避项目
				//System.out.println("固定数筛选  有规避项目");
				if(fixed.equals("1")){//1是全部筛选 
					//System.out.println("全部筛选");
					String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							 + "from t_pro_basic_info where  F_PRO_STAUTS ='1' "
							 + "and F_PRO_ID not in("+proids+")  ";
					Query qs = getSession().createSQLQuery(s);
					idlist = qs.list();
				}
				if(fixed.equals("2")){//2是筛选 一半
					//System.out.println("筛选一半");
					//查询一半有多少  向上取整 去小数
					String s1 = "select CEIL((select count(*)*"+0.5+" from t_pro_basic_info where  F_PRO_STAUTS ='1') ) ";
					Query qs1 = getSession().createSQLQuery(s1);
					List<Object[]> countid = qs1.list();
					Integer total= Integer.valueOf(String.valueOf(countid.get(0)));
					String s2 = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							  + "from t_pro_basic_info  where  F_PRO_STAUTS ='1' "
							  + "and F_PRO_ID not in("+proids+") "
							  + "order by F_PRO_ID asc limit "+total+"";
					Query qs2 = getSession().createSQLQuery(s2);
					idlist = qs2.list();
				}
				if(fixed.equals("3")){//3是筛选 其他数量
					//System.out.println("筛选其他数量");
					Integer othermount= Integer.valueOf(othM);
					String s = "select F_PRO_ID, F_PRO_CODE, F_PRO_NAME, F_PRO_TYPE, F_PRO_CLASS, F_PRO_HEAD, F_PRO_APPLI_PEOPLE, F_PRO_APPLI_DEPART, F_PRO_APPLI_TIME, F_PRO_BUDGET_AMOUNT  "
							 + "from t_pro_basic_info  where  F_PRO_STAUTS ='1' "
							 + "and F_PRO_ID not in("+proids+")"
							 + " order by F_PRO_ID asc limit "+othermount+"";
					Query qs = getSession().createSQLQuery(s);
					idlist = qs.list();
				}
			}							
	  }
		//遍历结果集  获取筛选的项目清单
		for(int i=0;i<idlist.size();i++){
			TProBasicInfo bean=new TProBasicInfo();
			bean.setPageOrder(i+1);//序号   下标是从0开始
			bean.setFProId(Integer.valueOf(String.valueOf(idlist.get(i)[0])));//项目id
			bean.setFProCode(String.valueOf(idlist.get(i)[1]));//项目编号
			bean.setFProName(String.valueOf(idlist.get(i)[2]));//项目名称
			bean.setFirstLevelName(String.valueOf(idlist.get(i)[3]));//项目类型
			bean.setFProClass(String.valueOf(idlist.get(i)[4]));//项目类别
			bean.setFProHead(String.valueOf(idlist.get(i)[5]));//负责人
			bean.setFProAppliPeople(String.valueOf(idlist.get(i)[6]));//申请人
			bean.setFProAppliDepart(String.valueOf(idlist.get(i)[7]));//申请部门
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
			try {
				bean.setFProAppliTime(format.parse(String.valueOf(idlist.get(i)[8])));//申请时间
			} catch (ParseException e) {
				e.printStackTrace();
			}
			bean.setFProBudgetAmount(BigDecimal.valueOf(Double.valueOf(String.valueOf(idlist.get(i)[9]))));//项目预算
			
			prolist.add(bean);
		}

		
		
		return prolist;
	}
	
	/*
	 * 页面加载已结项的项目信息  用于规避操作
	 * @author 冉德茂
	 * @createtime 2018-08-28
	 * @updatetime 2018-08-28
	 */
	@Override
	public List<TProBasicInfo> getjiexianglist(TProBasicInfo bean) {
		
		Finder finder = Finder.create(" from TProBasicInfo where  FProLibType in('3','4') ");
		if (!StringUtil.isEmpty(bean.getFProName())) {//项目名称
			finder.append(" and FProName like :name").setParam("name", "%" + bean.getFProName() + "%");
		}
		if (bean.getFProAppliTime()!=null) {//执行年份
			finder.append(" and FProAppliTime = :fproApplition").setParam("fproApplition", bean.getFProAppliTime());
		}
		
		return super.find(finder);
	}
	
	/*
	 * 停用模版信息   设置模版表的启用状态和自评项目表的展示状态
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@Override
	public void turnoff(Integer id) {
		//设置模版表启用状态
		SelfEvalTemp tempbean = selfEvalTempMng.findById(id);
		tempbean.setFisOn("0");
		
		//查询配置表的信息
		List<Object> confbeanlist= getMingxi("SelfEvalConf", "ftId", id);
		SelfEvalConf confbean = (SelfEvalConf) confbeanlist.get(0);
		//设置自评表数据的展示状态
		List<Object> evalpro= getMingxi("SelfEvaluation", "fcId", confbean.getFcId());
		for (int j = evalpro.size()-1; j >= 0; j--) {
			SelfEvaluation oldproeval= (SelfEvaluation) evalpro.get(j);
			oldproeval.setFisShow("0");
			super.saveOrUpdate(oldproeval);
		}
		
	}
	/*
	 * 启用模版信息   设置模版表的启用状态和自评项目表的展示状态
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@Override
	public void turnon(Integer id) {
		//设置模版表启用状态
		SelfEvalTemp tempbean = selfEvalTempMng.findById(id);
		tempbean.setFisOn("1");
		
		//查询配置表的信息
		List<Object> confbeanlist= getMingxi("SelfEvalConf", "ftId", id);
		SelfEvalConf confbean = (SelfEvalConf) confbeanlist.get(0);
		//设置自评表数据的展示状态
		List<Object> evalpro= getMingxi("SelfEvaluation", "fcId", confbean.getFcId());
		for (int j = evalpro.size()-1; j >= 0; j--) {
			SelfEvaluation oldproeval= (SelfEvaluation) evalpro.get(j);
			oldproeval.setFisShow("1");
			super.saveOrUpdate(oldproeval);
		}
		
	}
	







}


















	


























	

	




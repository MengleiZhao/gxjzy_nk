package com.braker.icontrol.budget.performancemanage.selfrule.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalConf;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalTemp;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;


/**
 * 自评模版的service抽象类
 * @author 冉德茂
 * @createtime 2018-08-14
 * @updatetime 2018-08-14
 */
public interface SelfEvalTempMng extends BaseManager<SelfEvalTemp>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	public Pagination pageList(SelfEvalTemp bean, int pageNo, int pageSize);
	/*
	 * 保存模版  自评配置   规避清单的映射信息
	 * @author 冉德茂
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	public void save(SelfEvalTemp bean,SelfEvalConf fevalbean, User user, String rate,String proid,String finalproid,String qiyong);
	/*
	 * 根据ID删除模版信息  同时删除配置表和规避项目映射表的信息
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	public void delete(Integer id);
	
	/*
	 * 启用模版信息  改变模版表和自评项目表的状态信息
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	public void turnon(Integer id);
	/*
	 * 停用模版信息   设置模版表的启用状态和自评项目表的展示状态
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	public void turnoff(Integer id);
	/*
	 * 预览自评项目的信息
	 * @author 冉德茂
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	public List<TProBasicInfo> getprolist(String rate,String proids, String min, String max, String randM, String fixed,String othM,String isavoid);
	/*
	 * 页面加载已结项的项目信息  用于规避操作
	 * @author 冉德茂
	 * @createtime 2018-08-28
	 * @updatetime 2018-08-28
	 */
	public List<TProBasicInfo> getjiexianglist(TProBasicInfo bean);
	
	

}

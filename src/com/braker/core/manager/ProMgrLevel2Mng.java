package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.SysDepartEconomic;
import com.braker.core.model.User;

public interface ProMgrLevel2Mng extends BaseManager<ProMgrLevel2>{

	
	/**
	 * 加载二级分类List页面数据
	 * @param proMgrLevel1 搜索条件
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(ProMgrLevel2 ProMgrLevel2,String sort, String order, Integer pageNo, Integer pageSize);

	/**
	 * 
	 * <p>Title: findbyCode2</p>  
	 * <p>Description: 根据code2查询</p>  
	 * @param fLevCode2
	 * @return
	 * @author 陈睿超
	 * @createtime 2021年1月8日
	 * @updator 陈睿超
	 * @updatetime 2021年1月8日
	 */
	ProMgrLevel2 findbyCode2(String fLevCode2);
	
	/**
	 * 查询是否有相同二级代码
	 * @param fLevCode2  传入要检查
	 * @return
	 */
	Integer findbyFLevCode2(String fLevCode2);
	
	/**
	 * 查询是否有相同二级代码（除了自己）
	 * @param fLevCode2  传入要检查
	 * @return
	 */
	Integer findbyFLevCode2NotMine(String fLevCode2,Integer fLvId2);
	
	/**
	 * 根据上级分类删除所有的二级分类
	 * @param id 上级分类主键
	 */
	void deleteAll(Integer id);

	/**
	 * 根据上级分类查询所有二级分类
	 * @param parentCode
	 * @return
	 */
	List<ProMgrLevel2> findByParendCode(String parentCode,User user); 
	
	/**
	 * 根据上级分类查询所有二级分类
	 * @param parentCode
	 * @return
	 */
	List<ProMgrLevel2> getSubject2ByPml(String pml); 
	
	/**
	 * 获得二级分类最大编码再加一
	 * @return
	 */
	String maxfLevCode2(String str);
	
	/**
	 * 获得上级基本支出的二级分类（报表二使用）
	 * @return
	 */
	List<ProMgrLevel2> basicTypeList(); 
	
	/**
	 * 
	 * <p>Title: save</p>  
	 * <p>Description: 保存二级项目分类，同时添加字典表数据，因为在预算申请的地方有逻辑关系</p>  
	 * @param proMgrLevel2
	 * @param proMgrLevel1
	 * @author 陈睿超
	 * @createtime 2021年1月11日
	 * @updator 陈睿超
	 * @updatetime 2021年1月11日
	 */
	void save(ProMgrLevel2 proMgrLevel2,ProMgrLevel1 proMgrLevel1);
}

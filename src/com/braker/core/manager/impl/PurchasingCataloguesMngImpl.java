package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.FunctionClassMgrMng;
import com.braker.core.manager.PurchasingCataloguesMng;
import com.braker.core.model.Economic;
import com.braker.core.model.FunctionClassMgr;
import com.braker.core.model.PurchasingCatalogues;
import com.braker.core.model.User;

/**
 * 功能分类科目管理的service实现类
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */
@Service
@Transactional
public class PurchasingCataloguesMngImpl extends BaseManagerImpl<PurchasingCatalogues> implements PurchasingCataloguesMng {
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@Override
	public Pagination pageList(PurchasingCatalogues bean, int pageNo, int pageSize, String pcode) {
		//区分输入框查询 （查询全局）   左侧tree点击查询不会限制当前输入框的查询条件
		Finder finder =Finder.create("  FROM PurchasingCatalogues where 1=1 ");
		if(!StringUtil.isEmpty(bean.getFpurCode())){//科目编码查询  点击查询
			finder.append(" AND fpurCode LIKE :fpurCode");
			finder.setParam("fpurCode", bean.getFpurCode());
		}
		if(!StringUtil.isEmpty(bean.getFpurName())){//科目名称查询  点击查询
			finder.append(" AND fpurName LIKE :fpurName");
			finder.setParam("fpurName", bean.getFpurName());
		}else if(pcode==null){//一级 默认查询
			finder.append(" and flevel ='"+1+"' ");
		}else if(pcode!=null){//不是一级 默认查询
			finder.append(" and fpPurCode = '"+pcode+"' ");
		}
		

		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@Override
	public void save(PurchasingCatalogues bean, User user) {
		if(bean.getfId()==null){
			//System.out.println("当前code---"+bean.getFpurCode());
			//System.out.println("上级code---"+bean.getFpPurCode());
			bean = (PurchasingCatalogues) super.save(bean);
		}else{
			bean = (PurchasingCatalogues) super.saveOrUpdate(bean);
		}
	}
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@Override
	public void delete(Integer id) {
		PurchasingCatalogues bean = super.findById(id);
		String flevel = bean.getFlevel();
		if(flevel.equals("1")){//1級删除掉二三级
			List<PurchasingCatalogues> exitbean2 = findNextbyParcode(bean.getFpurCode());
			for(int i=0;i<exitbean2.size();i++){
				String p2code = exitbean2.get(i).getFpurCode();
				List<PurchasingCatalogues> exitbean3 = findNextbyParcode(p2code);
					for(int j=0;j<exitbean3.size();j++){
						super.delete(exitbean3.get(j));//删除三级科目
					}
				super.delete(exitbean2.get(i));	//删除二级科目
			}
			super.delete(bean);//删除当前科目
		}else if(flevel.equals("2")){//2级删掉三级
			List<PurchasingCatalogues> exitbean3 = findNextbyParcode(bean.getFpurCode());
			for(int i=0;i<exitbean3.size();i++){
				super.delete(exitbean3.get(i));	//删除3级科目
			}
			super.delete(bean);//删除当前科目
		}else if(flevel.equals("3")){
			super.delete(bean);//删除当前科目
		}
		
	}
	/*
	 * 查询所有的信息   或者是否含有下一节点
	 * @author 冉德茂
	 * @createtime 2018-09-10
	 * @updatetime 2018-09-10
	 */

	@Override
	public List<PurchasingCatalogues> indexTree(String parCode) {
		Finder finder=Finder.create(" from PurchasingCatalogues where 1=1 ");
		if(!StringUtil.isEmpty(parCode)){//点击查询tree的节点信息
			finder.append(" and fpPurCode = '"+parCode+"' ");
		}
		if(StringUtil.isEmpty(parCode)){//展示一级数据列表
			finder.append(" and flevel ='"+1+"' ");
		}
		return super.find(finder);
	}
	/*
	 * 删除查询有没有下一级的节点数据
	 * @author 冉德茂
	 * @createtime 2018-09-10
	 * @updatetime 2018-09-10
	 */
	@Override
	public List<PurchasingCatalogues> findNextbyParcode(String parCode){
		Finder finder=Finder.create(" from PurchasingCatalogues where fpPurCode='"+parCode+"' ");
		return super.find(finder);
	}
	/**
	 * 根据编号和名字查询采购品目明细信息
	 */
	@Override
	public List<PurchasingCatalogues> getItemsCodeName(String name) {
		
		return null;
	}

}
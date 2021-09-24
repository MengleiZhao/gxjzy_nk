package com.braker.icontrol.budget.release.manager.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartBasicOut;
import com.braker.icontrol.budget.arrange.manager.DepartArrangeMng;
import com.braker.icontrol.budget.arrange.manager.DepartBasicOutMng;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasic;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasicItf;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TBasicMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * 基本支出预算指标下达（二下）service的实现类
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Service
@Transactional
public class TBasicMngImpl extends BaseManagerImpl<TBudgetaryIndicBasic> implements TBasicMng{
	
	@Autowired
	private TBasicItfMng tBasicItfMng;
	@Autowired
	private TProItfMng tProItfMng;
	@Autowired
	private DepartBasicOutMng departBasicOutMng;
	@Autowired
	private DepartArrangeMng departArrangeMng;
	
	
	/*
	 * 通过明细ID查找
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 * @param bId 明细主键
	 */
	@Override
	public TBudgetaryIndicBasic findByBId(Integer bId) {
		Finder finder = Finder.create(" FROM TBudgetaryIndicBasic WHERE bbId=(SELECT bbId FROM TBudgetaryIndicBasicItf where biId ='"+bId+"')");
		List<TBudgetaryIndicBasic> li = super.find(finder);
		return li.get(0);
	}

	@Override
	public TBudgetaryIndicBasic save(TBudgetaryIndicBasic bean, User user) {
		
		bean.setUserId(user);
		bean.setOpTime(new Date());
		if (bean.getBbId() == null) {
			
		} else {
			
		}
		return (TBudgetaryIndicBasic)super.saveOrUpdate(bean);
	}

	@Override
	public float save(String saveType, TBudgetaryIndicBasic bean, User user, 
			String personData, String commData) throws Exception {

		//区别新增和修改
		if ("add".equals(saveType)) {
			Depart depart = user.getDepart();
			bean.setDepartName(depart.getName());
			bean.setDepartCode(depart.getCode());
		} else if ("edit".equals(saveType)) {

		}
		//初始化
		List<TBudgetaryIndicBasicItf> personContainer = new ArrayList<>();
		List<TBudgetaryIndicBasicItf> commContainer = new ArrayList<>();
		ObjectMapper mapper = new ObjectMapper();
		//保存指标下达
		TBudgetaryIndicBasic jbzc = save(bean, user);
		//保存人员支出
		List<TreeEntity> personTree = mapper.readValue(personData, new TypeReference<List<TreeEntity>>(){});
		analysisAndAdd(saveType,personContainer,personTree,null,jbzc,user);//解析获得需要保存的支出
		tBasicItfMng.save(personContainer, user);
		changeStatusOfArange(personContainer,user);
		//保存公用支出
		List<TreeEntity> commTree = mapper.readValue(commData, new TypeReference<List<TreeEntity>>(){});
		analysisAndAdd(saveType,commContainer,commTree,null,jbzc,user);
		changeStatusOfArange(commContainer,user);
		tBasicItfMng.save(commContainer, user);
		
		return 0;
	}
	

	/**
	 * 设置部门总指标状态为已下达
	 */	private void changeStatusOfArange(
			List<TBudgetaryIndicBasicItf> container, User user) {

		if (container != null && container.size() > 0) {
			for (TBudgetaryIndicBasicItf bean: container) {
				String id = bean.getArrangeIndexId();
				if (!StringUtil.isEmpty(id)) {
					DepartBasicOut out = departBasicOutMng.findById(Integer.valueOf(id));
					departBasicOutMng.save(out, user);
				}
			}
		}
	}


	/**
	 * 将编制指标转换为下达指标 解析tree
	 * @param container 容器
	 * @param treeList 节点集合
	 * @param parent 节点集合的父节点
	 * @param jbzc 关联控部门编制
	 */
	private void analysisAndAdd(String saveType, List<TBudgetaryIndicBasicItf> container, List<TreeEntity> treeList,
			TBudgetaryIndicBasicItf parent, TBudgetaryIndicBasic jbzc, User user) {
		
		if (treeList != null && treeList.size() > 0) {
			for (TreeEntity tree: treeList) {
				
				TBudgetaryIndicBasicItf bean = new TBudgetaryIndicBasicItf();
				//指标下达对象
				bean.setBbId(jbzc);
				//父节点id
				bean.setParentId(parent);
				//科目编码
				bean.setIndexCode(tree.getCode());
				//科目名称
				bean.setIndexName(tree.getText());
				//基本支出类型
				bean.setType(tree.getCol3());
				//下达金额
				bean.setAmount(!StringUtil.isEmpty(tree.getCol2())?Double.valueOf(tree.getCol2()):null);
				//关联预算编制指标id
				bean.setArrangeIndexId(tree.getId());
				//放入容器
				container.add(bean);
				List<TreeEntity> children = tree.getChildren();
				if (children != null && children.size() > 0) {
					//如果含有下级子节点，嵌套循环
					analysisAndAdd(saveType,container,children,bean,jbzc,user);
				} else if ("add".equals(saveType) && bean.getParentId() == null) {
					//如果: 新增时 and 该节点没有下级节点 and 该节点是一级节点，在数据库中查询后放入
					List<TreeEntity> zeroList = new ArrayList<>();
					if ("1".equals(tree.getCol3())) {
						zeroList = departArrangeMng.getPersonOutFromArrange(tree.getId(),null,"0");
					} else if ("2".equals(tree.getCol3())) {
						zeroList = departArrangeMng.getCommOutFromArrange(tree.getId(),null, "0");
					}
					if (zeroList != null && zeroList.size() > 0) {
						for (TreeEntity tr: zeroList) {
							tr.setCol2("0");//金额设置0
						}
					}
					analysisAndAdd(saveType,container,zeroList,bean,jbzc,user);
				}
				
			}
		}
	}

}

package com.braker.icontrol.budget.arrange.manager.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartArrange;
import com.braker.icontrol.budget.arrange.entity.DepartBasicOut;
import com.braker.icontrol.budget.arrange.entity.DepartIndexInfo;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;
import com.braker.icontrol.budget.arrange.manager.DepartArrangeMng;
import com.braker.icontrol.budget.arrange.manager.DepartBasicOutMng;
import com.braker.icontrol.budget.arrange.manager.DepartIndexInfoMng;
import com.braker.icontrol.budget.arrange.manager.DepartProjectOutMng;
import com.braker.icontrol.budget.control.entity.TBasicExpend;
import com.braker.icontrol.budget.control.entity.TProExpend;
import com.braker.icontrol.budget.control.manager.TBasicExpendMng;
import com.braker.icontrol.budget.control.manager.TProExpendMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class DepartArrangeMngImpl extends BaseManagerImpl<DepartArrange> implements DepartArrangeMng {
	
	@Autowired
	private DepartBasicOutMng departBasicOutMng;
	@Autowired
	private DepartProjectOutMng departProjectOutMng;
	@Autowired
	private TBasicExpendMng basicOutMng;
	@Autowired 
	private TProExpendMng proOutMng;
	@Autowired
	private DepartIndexInfoMng departIndexInfoMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private UserMng userMng;
	
	
	@Override
	public DepartArrange save(String saveType, DepartArrange bean, User user, String personData, String commData, String yearData, String leastData) throws Exception {
		
		//设置数据
		bean.setFUser(user.getName());
		bean.setFTime(new Date());
		//区别新增和修改保存
		if ("edit".equals(saveType)) {
			//如果是修改，编制基础数据不改变
			bean = findById(bean.getFDCId());
		}
		//初始化
		double num1 = 0, num2 = 0, num3 = 0, num4 = 0;//批复总额
		List<DepartBasicOut> personOutList = new ArrayList<>();
		List<DepartBasicOut> commOutList = new ArrayList<>();
		ObjectMapper mapper = new ObjectMapper();
		//部门预算编制
		DepartArrange arrange = save(bean,user);
		/*//人员支出
		List<TreeEntity> personTree = mapper.readValue(personData, new TypeReference<List<TreeEntity>>(){});
		analysisAndAdd(saveType,personOutList,personTree,null,arrange,user);//解析获得需要保存的支出
		num1 = calBasicTotal(personOutList);//计算总金额
		departBasicOutMng.save(personOutList, user);
		//公用支出
		List<TreeEntity> commTree = mapper.readValue(commData, new TypeReference<List<TreeEntity>>(){});
		analysisAndAdd(saveType,commOutList,commTree,null,arrange,user);
		num2 = calBasicTotal(commOutList);
		departBasicOutMng.save(commOutList, user);*/
		if ("add".equals(saveType)) {
			//当年项目支出
			List<TProExpend> yearList = mapper.readValue(yearData, new TypeReference<List<TProExpend>>(){});
			List<DepartProjectOut> yearList1 = proOutToDepartOut(yearList,arrange);
			num3 = calProTotal(yearList1);
			departProjectOutMng.save(yearList1, user);
			//历年项目支出
			List<TProExpend> leastList = mapper.readValue(leastData, new TypeReference<List<TProExpend>>(){});
			List<DepartProjectOut> leastList1 = proOutToDepartOut(leastList,arrange);
			num4 = calProTotal(leastList1);
			departProjectOutMng.save(leastList1, user);
		} else if ("edit".equals(saveType)) {
			//当年项目支出
			List<DepartProjectOut> yearList = mapper.readValue(yearData, new TypeReference<List<DepartProjectOut>>(){});
			num3 = calProTotal(yearList);
			departProjectOutMng.save(yearList, user);
			//历年项目支出
			List<DepartProjectOut> leastList = mapper.readValue(leastData, new TypeReference<List<DepartProjectOut>>(){});
			num4 = calProTotal(leastList);
			departProjectOutMng.save(leastList, user);
		}
		//设置批复总金额
		arrange.setFBudgetControlSum(num1 + num2 + num3 + num4);
		return arrange;
	}
	
	/**
	 * 计算基本支出批复总额
	 * @param list
	 * @return
	 */
	private double calBasicTotal(List<DepartBasicOut> list){
		double total = 0;
		if (list != null && list.size() > 0) {
			for (DepartBasicOut li: list) {
				if (li.getFControl() != null) {
					total = total + li.getFControl();
				}
			}
		}
		return total;
	}
	/**
	 * 计算项目支出批复总额
	 * @param list
	 * @return
	 */
	private double calProTotal(List<DepartProjectOut> list){
		double total = 0;
		if (list != null && list.size() > 0) {
			for (DepartProjectOut li: list) {
				if (li.getFBudgetControl() != null) {
					total = total + li.getFBudgetControl();
				}
			}
		}
		return total;
	}
	
	/**
	 * 将基本指标转换为部门基本指标 解析tree
	 * @param container 容器
	 * @param treeList 节点集合
	 * @param parent 节点集合的父节点
	 * @param arrange 关联控部门编制
	 */
	private void analysisAndAdd(String saveType, List<DepartBasicOut> container, List<TreeEntity> treeList,
			DepartBasicOut parent, DepartArrange arrange, User user) {
		
		
		if (treeList != null && treeList.size() > 0) {
			for (TreeEntity tree: treeList) {
				
				DepartBasicOut bean = new DepartBasicOut();
				//主键
				if ("edit".equals(saveType)) {
					bean.setFPId(Integer.valueOf(tree.getId()));
				}
				//关联预算控制数
				bean.setArrange(arrange);
				//归口部门名称
				bean.setFDepartment(tree.getCol1());
				//控制数
				bean.setFControl(!StringUtil.isEmpty(tree.getCol2())?Double.valueOf(tree.getCol2()):null);
				//基本支出类型
				bean.setFType(tree.getCol3());
				//名称
				bean.setName(tree.getText());
				//编码
				bean.setCode(tree.getCode());
				//年度
				bean.setFExt1(tree.getCol6());
				//上级节点
				bean.setParentNode(parent);
				//放入容器
				container.add(bean);
				//如果含有下级子节点，嵌套循环
				List<TreeEntity> children = tree.getChildren();
				if (children != null && children.size() > 0) {
					analysisAndAdd(saveType,container,children,bean,arrange,user);
				} else if ("add".equals(saveType) && bean.getParentNode() == null) {
					//如果: 新增时 and 该节点没有下级节点 and 该节点是一级节点，在数据库中查询后放入
					List<TreeEntity> zeroList = new ArrayList<>();
					if ("1".equals(bean.getFType())) {
						zeroList = getPersonOutFromControl(tree.getCol9(),user.getDepartName());
					} else if ("2".equals(bean.getFType())) {
						zeroList = getCommOutFromControl(tree.getCol9(),user.getDepartName());
					}
					if (zeroList != null && zeroList.size() > 0) {
						for (TreeEntity tr: zeroList) {
							tr.setCol2("0");//金额设置0
						}
					}
					analysisAndAdd(saveType,container,zeroList,bean,arrange,user);
				}
			}
		}
	}
	
	@Override
	public List<TreeEntity> getPersonOutFromControl(String parentId, String departName) {
		
		List<TreeEntity> treeList = new ArrayList<>();
		List<TBasicExpend> outList = null;
		//查询数据
		if (parentId == null) {
			//一级支出菜单
			outList = basicOutMng.getPersonOutListEdit("0",departName);
		} else {
			//非第一级支出菜单
			outList = basicOutMng.getPersonOutListEdit(parentId,departName);
		}
		//放入tree值
		if (outList != null && outList.size() > 0) {
			for (TBasicExpend bean: outList) {
				TreeEntity node = new TreeEntity();
				node.setText(bean.getName());//名称
				node.setCode(bean.getCode());//节点代码
				node.setId(String.valueOf(bean.getFPId()));//节点id
				node.setParentCode(bean.getParentNode()!=null? bean.getParentNode().getCode():"");//父节点代码
				node.setCol1(bean.getFDepartment());//归口部门
				node.setCol2(bean.getFControl()!=null?String.valueOf(bean.getFControl()):"");//控制数
				node.setCol3(bean.getFType());//类型
				node.setCol9(String.valueOf(bean.getFPId()));//在预算控制中的科目id
				if(basicOutMng.getPersonOutListEdit(node.getId(),departName) != null && 
						basicOutMng.getPersonOutListEdit(node.getId(),departName).size() > 0){
					node.setState("closed");
				}else{
//					node.setLeaf(true);
				}
				treeList.add(node);
			}
		}
		return treeList;
	
	}
	
//	/**
//	 * 将基本指标转换为部门基本指标
//	 * @param list
//	 * @param arrange
//	 * @return
//	 */
//	public List<DepartBasicOut> basicOutToDepartOut(List<TBasicExpend> list, DepartArrange arrange){
//		
//		List<DepartBasicOut> resList = new ArrayList<>();
//		if (list != null && list.size() > 0) {
//			for (TBasicExpend bean: list) {
//				DepartBasicOut out = new DepartBasicOut();
//				//关联部门预算编制
//				out.setArrange(arrange);
//				//归口部门名称
//				out.setFDepartment(bean.getFDepartment());
//				//金额
//				out.setFControl(bean.getFControl());
//				//类型
//				out.setFType(bean.getFType());
//				//名称
//				out.setName(bean.getName());
//				//编码
//				out.setCode(bean.getName());
//				//年度
//				out.setFExt1(bean.getFExt1());
//				resList.add(out);
//			}
//		}
//		return resList;
//	}
	
	/**
	 * 将项目支出转换为部门项目支出
	 * @param list
	 * @param arrange
	 * @return
	 */
	public List<DepartProjectOut> proOutToDepartOut(List<TProExpend> list, DepartArrange arrange){
		
		List<DepartProjectOut> resList = new ArrayList<>();
		if (list != null && list.size() > 0) {
			for (TProExpend bean: list) {
				DepartProjectOut out = new DepartProjectOut();
				//关联项目
				/*out.setFProId(bean.getFProId());
				//关联部门编制
				out.setArrange(arrange);
				//金额
				out.setFBudgetControl(bean.getFBudgetControl());
				//类型
				out.setFType(bean.getFType());
				//年度
				out.setFExt1(bean.getFExt1());*/
				//是否发布
				out.setFExt2("0");
				resList.add(out);
			}
		}
		return resList;
	}
	
	@Override
	public DepartArrange save(DepartArrange bean, User user) {

		Date date = new Date();
		if (bean.getFDCId() == null) {
			bean.setFCreateUser(user);
			bean.setFCreateTime(date);
		} else {
			
		}
		bean.setFUpdateUser(user);
		bean.setFUpdateTime(date);
		return (DepartArrange) super.merge(bean);
	}

	@Override
	public Pagination pageList(DepartArrange bean, User user, Integer pageNo,
			Integer pageSize, String menuType) {
		
		Finder finder = Finder.create(" from DepartArrange where 1=1 ");
		//编号
		if (!StringUtil.isEmpty(bean.getFBudgetControlNum())) {
			finder.append(" and FBudgetControlNum like:FBudgetControlNum").setParam("FBudgetControlNum", "%" + bean.getFBudgetControlNum() + "%");
		}
		//部门
		if (!StringUtil.isEmpty(bean.getDepartName())) {
			finder.append(" and depart.name like:departName").setParam("departName", "%" + bean.getDepartName() + "%");
		}
		//年度
		if (bean.getFBudgetYear() != null) {
			finder.append(" and YEAR(FBudgetYear)=:FBudgetYear ")
				.setParam("FBudgetYear", Integer.valueOf(new SimpleDateFormat("yyyy").format(bean.getFBudgetYear())));
		}
		//审批状态
		if (!StringUtil.isEmpty(bean.getFlowStatus())) {
			finder.append(" and departName=:departName").setParam("departName", bean.getDepartName());
		}
		//菜单类型
		if (!StringUtil.isEmpty(menuType)) {
			if (menuType.equals("1")) {
				//申报页面
				//当前用户是申报人
				finder.append(" and FUser=:userName ").setParam("userName", user.getName());
			} else if (menuType.equals("2")) {
				//审核页面
				//当前用户是审核人
				finder.append(" and nextAssigner.id=:nUserId ").setParam("nUserId", user.getId());
			} else if (menuType.equals("3")) {
				//台账页面
				//非暂存 and 非不通过
				finder.append(" and flowStatus!='0' and flowStatus!='-1' ");
			}
		}
		
		finder.append(" order by FUpdateTime desc");
		
		//加入排序号
		Pagination p = super.find(finder, pageNo, pageSize);
		List<DepartArrange> list = (List<DepartArrange>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				DepartArrange arr = list.get(i);
				arr.setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		return p;
	}

	
	@Override
	public List<TreeEntity> getCommOutFromControl(String parentId, String departName) {

		List<TreeEntity> treeList = new ArrayList<>();
		List<TBasicExpend> outList = null;
		//查询数据
		if (parentId == null) {
			//一级支出菜单
			outList = basicOutMng.getCommOutListEdit("0",departName);
		} else {
			//非第一级支出菜单
			outList = basicOutMng.getCommOutListEdit(parentId,departName);
		}
		//放入tree值
		if (outList != null && outList.size() > 0) {
			for (TBasicExpend bean: outList) {
				TreeEntity node = new TreeEntity();
				node.setText(bean.getName());//名称
				node.setCode(bean.getCode());//节点代码
				node.setId(String.valueOf(bean.getFPId()));//节点id
				node.setParentCode(bean.getParentNode()!=null? bean.getParentNode().getCode():"");//父节点代码
				node.setCol1(bean.getFDepartment());//归口部门
				node.setCol2(bean.getFControl()!=null?String.valueOf(bean.getFControl()):"");//控制数
				node.setCol3(bean.getFType());//类型
				node.setCol9(String.valueOf(bean.getFPId()));//在预算控制中的科目id
				if(basicOutMng.getCommOutListEdit(node.getId(),departName) != null && 
						basicOutMng.getCommOutListEdit(node.getId(),departName).size() > 0){
					node.setState("closed");
				}else{
					node.setLeaf(true);
				}
				treeList.add(node);
			}
		}
		return treeList;
	}

	@Override
	public List<TreeEntity> getPersonOutFromArrange(String parentId,String arrangeId, String isRelease) {
		
		List<TreeEntity> treeList = new ArrayList<>();
		List<DepartBasicOut> outList = null;
		//查询数据
		outList = getCommOut(parentId,arrangeId,"1",isRelease);
		//放入tree值
		if (outList != null && outList.size() > 0) {
			for (DepartBasicOut bean: outList) {
				TreeEntity node = new TreeEntity();
				node.setText(bean.getName());//名称
				node.setCode(bean.getCode());//节点代码
				node.setId(String.valueOf(bean.getFPId()));//节点id
				node.setParentCode(bean.getParentNode()!=null? bean.getParentNode().getCode():"");//父节点代码
				node.setCol1(bean.getFDepartment());//归口部门
				node.setCol2(bean.getFControl()!=null?String.valueOf(bean.getFControl()):"");//控制数
				node.setCol3(bean.getFType());//支出类型
				String nodeId = bean.getParentNode()!=null? bean.getParentNode().getCode():"";
				if(getCommOut(nodeId,arrangeId,"1",isRelease) != null && getCommOut(nodeId,arrangeId,"1",isRelease).size() > 0){
					node.setState("closed");
				}else{
					node.setLeaf(true);
				}
				treeList.add(node);
			}
		}
		return treeList;
	}

	@Override
	public List<TreeEntity> getCommOutFromArrange(String parentId, String arrangeId, String isRelease) {

		List<TreeEntity> treeList = new ArrayList<>();
		List<DepartBasicOut> outList = null;
		//查询数据
		outList = getCommOut(parentId,arrangeId,"2",isRelease);
		//放入tree值
		if (outList != null && outList.size() > 0) {
			for (DepartBasicOut bean: outList) {
				TreeEntity node = new TreeEntity();
				node.setText(bean.getName());//名称
				node.setCode(bean.getCode());//节点代码
				node.setId(String.valueOf(bean.getFPId()));//节点id
				node.setParentCode(bean.getParentNode()!=null? bean.getParentNode().getCode():"");//父节点代码
				node.setCol1(bean.getFDepartment());//归口部门
				node.setCol2(bean.getFControl()!=null?String.valueOf(bean.getFControl()):"");//控制数
				node.setCol3(bean.getFType());//支出类型
				String nodeId = bean.getParentNode()!=null? bean.getParentNode().getCode():"";
				if(getCommOut(nodeId,arrangeId,"2",isRelease) != null && getCommOut(nodeId,arrangeId,"2",isRelease).size() > 0){
					node.setState("closed");
				}else{
					node.setLeaf(true);
				}
				treeList.add(node);
			}
		}
		return treeList;
	}

	//查询基本支出
	private List<DepartBasicOut> getCommOut(String parentId, String arrangeId, String type, String isRelease){
		
		Finder f = Finder.create(" from DepartBasicOut where 1=1 ");
		if (!StringUtil.isEmpty(arrangeId)) {//关联部门编制id
			f.append(" and arrange.FDCId=:arrangeId").setParam("arrangeId", Integer.valueOf(arrangeId));
		}
		if (!StringUtil.isEmpty(type)) {
			f.append(" and FType=:FType").setParam("FType", type);//类型
		}
		if (StringUtil.isEmpty(parentId)) {//父节点
			f.append(" and parentNode.FPId is null");
		} else {
			f.append(" and parentNode.FPId =:parentId ").setParam("parentId", Integer.valueOf(parentId));
		}
		if ("0".equals(isRelease)) {
			//筛选出 未发布的 or 一级菜单 
			f.append(" and (FExt2 IS NULL OR FExt2='0' OR parentNode.FPId IS NULL)");
		}
		f.append(" order by code asc ");

		return super.find(f);
	}
	

	@Override
	public void passArrange(DepartArrange arrange, User user, double total)  throws Exception{

		//只改变流转状态
		arrange = findById(arrange.getFDCId());
		//设置流转状态
		if (StringUtil.isEmpty(arrange.getFlowStatus()) || "-1".equals(arrange.getFlowStatus())) {
			//如果是新增或已退回的数据提交审核
			arrange.setFlowStatus("1");
		} else {
			int flowStatus = Integer.valueOf(arrange.getFlowStatus()) + 1;
			arrange.setFlowStatus(String.valueOf(flowStatus));
		}
		//得到第一个审批节点key
		Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),"T_DEPT_BUDGET_CONTROL_NUM","F_BUDGET_CONTROL_NUM",arrange.getFBudgetControlNum(), "NBZBDZ", user);
		//根据资源名称和当前登陆者所属部门查询对应工作流
		TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("NBZBDZ", user.getDpID());
		Integer flowId= processDefin.getFPId();
		TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
		User nextUser=userMng.findById(node.getUserId());
		//设置下节点节点编码
		arrange.setFlowStatus(String.valueOf(firstKey));
		//设置下一环节审批人
		arrange.setNextAssigner(nextUser);
		save(arrange, user);
		//当审核通过时，保存单位预算指标信息
		if ("2".equals(arrange.getFlowStatus())) {
			DepartIndexInfo info = new DepartIndexInfo();
			if (arrange.getFBudgetYear() != null) {//年度
				info.setYear(new SimpleDateFormat("yyyy").format(arrange.getFBudgetYear()));
			}
			info.setAmount(total);//批复总额 
			info.setStatus("0");//下达状态 未下达
			info.setProcess(0);//下达进度 百分之0
			info.setAmount(Double.valueOf(getTotalAmount(arrange.getFDCId())));//批复总额
			departIndexInfoMng.save(info);
		}
	}

	@Override
	public void noPassArrange(DepartArrange arrange, User user) {

		arrange = findById(arrange.getFDCId());
		arrange.setFlowStatus(String.valueOf("-1"));
		arrange.setNextAssigner(null);
		save(arrange, user);
	}

	@Override
	public double getTotalAmount(int arrangeId) {
		
		double total = 0;
		List<DepartBasicOut> list1 = departBasicOutMng.findByProperty("arrange.FDCId", arrangeId);
		List<DepartProjectOut> list2 = departProjectOutMng.findByProperty("arrange.FDCId", arrangeId);
		if (list1 != null && list1.size() > 0) {
			for (DepartBasicOut out: list1) {
				if (out.getFControl() != null) {
					double num = out.getFControl();
					total = total + num;
				}
			}
		}
		if (list2 != null && list2.size() > 0) {
			for (DepartProjectOut out: list2) {
				if (out.getFBudgetControl() != null) {
					double num = out.getFBudgetControl();
					total = total + num;
				}
			}
		}
		return total;
	}

	

	

}

package com.braker.icontrol.contract.filing.manager;

import java.text.ParseException;
import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.model.Attac;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.mchange.v2.sql.filter.RecreatePackage;

public interface FilingMng extends BaseManager<ContractBasicInfo>{

	/**
	 * 显示主页面
	 * @param contractBasicInfo
	 * @param user
	 * @return
	 */
	Pagination list(ContractBasicInfo contractBasicInfo ,User user, int pageNo, int pageSize);
	
	//转换类型为ReceivPlan的list
	List<ReceivPlan> getReceivPlan(List<DataEntity> dataList,User user,ContractBasicInfo contractBasicInfo) throws ParseException;
	
	/**
	 * 保存ReceivPlan
	 * @param receivPlan
	 */
	void save_ReceivPlan(List<ReceivPlan> receivPlan);
	
	/**
	 * 保存SignInfo信息
	 * @param signInfo
	 * @param user
	 * @param contractBasicInfo
	 */
	void save_SignInfo(SignInfo signInfo,User user,ContractBasicInfo contractBasicInfo,List<String> files);
	
	/**
	 * 保存附件信息
	 * @param attac
	 * @param user
	 */
	void save_Attac(List<Attac> HTAttac,List<Attac> otherAttac,User user,ContractBasicInfo contractBasicInfo);
	
	/**
	 * 根绝id返回一个签约信息的集合
	 * @param contractBasicInfo
	 * @return
	 */
	List<SignInfo> find_Sign(ContractBasicInfo contractBasicInfo);

	/**
	 * 返回数字，是否有已存在的签约信息
	 * @param contractBasicInfo
	 * @return
	 */
	int find_Sign_number(ContractBasicInfo contractBasicInfo);
	
	/**
	 * 根据id返回一个相应的集合
	 * @param FcId
	 * @return
	 */
	Pagination find_ReceivPlan(String FcId, Integer pageNo, Integer pageSize);
	
	/**
	 * 查询数据库中FcId下的付款计划的信息条数
	 * @param FcId
	 * @return
	 */
	List<ReceivPlan> find_ReceivPlan_List(String FcId);
	
	/**
	 * 查询合同正本的附件
	 * @param id
	 * @return
	 */
	List<Attac> findHTAttac(Integer id);
	
	/**
	 * 查询其他附件
	 * @param id
	 * @return
	 */
	List<Attac> findOtherAttac(Integer id);
	
	
	void otherSave(ContractBasicInfo contractBasicInfo,User user,String planJson,String htwbfiles,SignInfo signInfo) throws ParseException;
	
}

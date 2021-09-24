package com.braker.icontrol.contract.Formulation.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.model.Attac;
import com.braker.icontrol.contract.filing.model.SignInfo;

public interface FormulationMng extends BaseManager<ContractBasicInfo>{

	/**
	 * 显示主页面信息(合同拟定)
	 * @param contractBasicInfo
	 * @return
	 */
	Pagination queryList(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);
	Pagination queryListbg(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);
	/**
	 * 保存
	 * @param contractBasicInfo
	 * @param user
	 */
	void save_CBI(ContractBasicInfo contractBasicInfo, User user, String files, SignInfo signInfo, String htwbfiles, String planJson,String mingxi,String proceedsJson) throws Exception;
	
	void save_CBIBG(ContractBasicInfo contractBasicInfo, User user, String files, SignInfo signInfo, String htwbfiles, String planJson,String mingxi,String proceedsJson,String openType) throws Exception;
	/**
	 * 根据id删除
	 * @param fcId
	 */
	void delete_CBI(String fcId,User user);
	
	/**
	 * 上传附件和保存
	 * @param attac
	 * @param user
	 */
	void save_attac(ContractBasicInfo contractBasicInfo,List<Attac> at,User user);
	
	/**
	 * 根据合同id去查询附件记录
	 * @param id
	 * @return
	 */
	List<Attac> findAttac(Integer id);
	
	/**
	 * 根据文件名称查询
	 * @param name
	 * @return
	 */
	List<Attac> findAttacByName(String name);
	
	/**
	 * 根据文件名删除
	 * @param attac
	 */
	void deleteAttac(List<Attac> attac);
	
	/**
	 * 查询字典里审批状态
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked,String selected);
	/**
	 * 根据采购编号查询
	 * @param fPurchNo
	 * @return
	 */
	ContractBasicInfo findAttacByFPurchNo(String fPurchNo);
	
	/**
	 * 根据不同状态条件查询
	 * @param condition1
	 * @param val1
	 * @param endStauts
	 * @return
	 */
	Pagination find(ContractBasicInfo cbi,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 显示主页面信息(合同变更用)
	 * @param contractBasicInfo
	 * @return
	 */
	Pagination queryForChange(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);

	/**
	 * 显示主页面信息(合同终止用)
	 * @param contractBasicInfo
	 * @return
	 */
	Pagination queryForEnding(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 撤回表单，修改数据
	 * @param id
	 */
	String reCall(String id);
	
	/**
	 * 
	* @author:安达
	* @Title: getFcCode 
	* @Description: 获得合同编号
	* @return
	* @return int    返回类型 
	* @date： 2020年1月6日下午8:29:36 
	* @throws
	 */
	public String getFcCode();
	
	/**
	 * 用于查询来款登记里面的合同查询
	 * @author:赵孟雷
	 * @param contractBasicInfo
	 * @return
	 */
	Pagination queryContraList(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);

	
	/**
	 * 查询合同（纠纷：审批状态和合同状态）
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination queryForChangejf(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);

	
	/**
	 * 根据id查询
	 * @param name 条件名称
	 * @param val 条件的值
	 * @return
	 */
	List<Object> registerOrApplymingxi(String id);
	/**
	 * 根据id查询登记信息上的供应商信息
	 * @return
	 */
	WinningBidder registerWinning(String id);
	
	public List<Lookups> getLookupName(String categoryCode);

	public ContractBasicInfo findByYhtId(int id);
	List<ContractBasicInfo> findbyPurchId(String id);
	WinningBidder getGys(String id);
	public List<WinningBidder> findBysingName(String singName);
}

package com.braker.icontrol.incomemanage.register.manager;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 收入登記的service抽象类
 * @author 冉德茂
 * @createtime 2018-08-07
 * @updatetime 2018-08-07
 */
public interface RegisterMng extends BaseManager<IncomeInfo>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	public Pagination pageList(IncomeInfo bean, int pageNo, int pageSize, User user,String fCode,String fProName,String fDeptName,String fType);
	
	/*
	 * 保存收入信息
	 * @author 冉德茂
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	public void save(IncomeInfo bean, User user, String mingxiJson, String files) throws Exception;
	
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	public void delete(Integer id);
	
	/**
	 * 获得收入会计科目列表
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param qName 查询字段：科目名称
	 * @return 节点id 节点名称 节点代码 父节点代码
	 */
	public List<Object[]> getInComeSubject(String basicType, String parentCode, String year, String qName);
	/**
	 * 获得收入会计科目列表,根据parentCode作为KEY存入map集合
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param qName 查询字段：科目名称
	 * @return 节点id 节点名称 节点代码 父节点代码
	 */
	public Map<String,Integer> getPidMap(String basicType, String parentCodes, String year, String qName);

	public List<ReceiveMoneyDetail> getMingxiList(String fincomeId,String fpId);

	public void reCall(Integer id) throws Exception;

	public void saveCheck(TProcessCheck checkBean, IncomeInfo bean,
			String spjlFile, User user) throws Exception;

	public Pagination confirmPageList(IncomeInfo bean, int pageNo, int pageSize,
			User user);

	public void saveConfirm(IncomeInfo bean, String mingxiJson, String files) throws Exception;
	
	/*
	 * 台账分页查询
	 * @author 赵孟雷
	 * @createtime 2020-12-02
	 * @updatetime 2020-12-02
	 */
	public List<IncomeInfo> pageLedgerList(IncomeInfo bean,User user);

	/**
	 * 生成培训类登记明细导出
	 */
	public HSSFWorkbook exportExcel(String filePath);

	public Pagination choosePageList(IncomeInfo bean, Integer page, Integer rows, User user, String fCode,
			String fProName, String fDeptName, String fType);

	public List<ReceiveMoneyDetail> getMingxiRegisterList(String fincomeId);
}

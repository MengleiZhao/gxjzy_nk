package com.braker.icontrol.expend.loan.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.TotalAmountOfBorrowing;
import com.braker.core.model.User;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;

/**
 * 借款申请的service抽象类
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
public interface LoanMng extends BaseManager<LoanBasicInfo>{
	/*
	 * 资金归垫模块查询已审批  未删除的借款单信息
	 * @author 冉德茂
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	public Pagination repayforpageList(LoanBasicInfo bean, int pageNo, int pageSize, String type,User user);
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 */
	public Pagination pageList(LoanBasicInfo bean, int pageNo, int pageSize, User user,String sign);
	
	/*
	 * 借款申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	public void save(LoanBasicInfo bean, LoanPayeeInfo payeeBean, User user) throws Exception;
	
	/*
	 * 借款申请删除
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	public void delete(Integer id,String fid,User user);
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	public Pagination checkPageList(LoanBasicInfo bean, int pageNo,int pageSize, User user);
	
	/**
	 * 台账分页查询
	 * isCashier是否部门出纳岗
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updator 张迅
	 * @updatetime 2019-08-13
	 */
	public Pagination ledgerPageList(String loanString, LoanBasicInfo bean, int pageNo,int pageSize, User user, boolean isCashier);
	
	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	public Pagination cashierPageList(LoanBasicInfo bean, int pageNo,int pageSize, User user);
	
	/**
	 * 查询需要导出的所有台账信息
	 * @author 叶崇晖
	 * @return 所有审批通过在台账页面的借款单List
	 */
	public List<LoanBasicInfo> ledgerList(LoanBasicInfo bean,String loanString,String userId);
	
	
	/**
	 * 生成需要导出的台账HSSFWorkbook
	 * @param ledgerData借款申请基本信息集合List
	 * @param filePath模板位置
	 * @return 台账HSSFWorkbook
	 */
	public HSSFWorkbook exportLedger(List<LoanBasicInfo> ledgerData, String filePath);
	
	
	/*
	 * 首页借款查询
	 */
	
	public List<LoanBasicInfo> homePageList(String flowStauts,String userId);
	
	/*
	 * 首页借款总额和条数
	 */
	
	public List<TotalAmountOfBorrowing> homeTotalAmount(String a,String userId);
	
	/**
	 * 还款提前15天到期提醒
	 * @author 陈睿超
	 * @createTime 2019年8月27日
	 * @updateTime 2019年8月27日
	 */
	void daysRemind();
	
	/**
	 * 
	 * @Description: 借款申请回退
	 * @param @param id
	 * @param @return
	 * @param @throws Exception   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	public String  loanReCall(Integer id)  throws Exception ;
}

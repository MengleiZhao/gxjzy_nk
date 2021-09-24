package com.braker.icontrol.expend.voucher.manager.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.voucher.entity.DeptToSubject;
import com.braker.icontrol.expend.voucher.entity.Voucher;
import com.braker.icontrol.expend.voucher.entity.VoucherList;
import com.braker.icontrol.expend.voucher.manager.DeptToSubjectMng;
import com.braker.icontrol.expend.voucher.manager.FinancalToBudgetMng;
import com.braker.icontrol.expend.voucher.manager.VoucherListMng;

@Service
public class VoucherListMngImpl extends BaseManagerImpl<VoucherList> implements VoucherListMng{
	@Autowired
	private DeptToSubjectMng deptToSubjectMng;
	@Autowired
	private FinancalToBudgetMng financalToBudgetMng;
	
	@Override
	public List<VoucherList> findbyListVoucher(VoucherList voucherList) {
		Finder finder = Finder.create(" FROM VoucherList WHERE 1=1");
		if(!StringUtil.isEmpty(voucherList.getfListVoucher())){
			finder.append(" and fListVoucher = :fListVoucher");
			finder.setParam("fListVoucher",voucherList.getfListVoucher());
		}
		/*if(!StringUtil.isEmpty(String.valueOf(voucherList.getfVid()))){
			finder.append(" and voucher.fid = :fVid");
			finder.setParam("fVid",voucherList.getfVid());
		}*/
		return super.find(finder);
	}

	/**
	 * 
	* @author:安达
	* @Title: addVoucher 
	* @Description: 添加凭证库
	* @param beanCode   各种申请单编码
	* @param fSummary  摘要
	* @param fDeptName  部门Id
	* @param fDeptName  部门名称
	* @param fProjectName 项目名称
	* @param fEconomicName  预算指标体系的最末级指标
	* @param amount   发生金额
	* @param sourcesfunds  根据预算指标选取到的资金来源
	* @param bankText  出纳受理后选取的对应银行进行付款
	* @param lineNum   第几行    总共有 4行 
	* @return
	* @return String    返回类型 
	* @date： 2019年7月1日下午9:34:25 
	* @throws
	 */
	@Override
	public VoucherList addVoucherList(String fSummary, String fDeptId,
			String fDeptName, String fProjectName, String fEconomicName,
			Double amount,String sourcesfunds,String bankText,int lineNum,Voucher voucher) {
			//记账凭证清单表
			VoucherList voucherList=new VoucherList();  
			voucherList.setVoucher(voucher);
			voucherList.setfListVoucher(autoGenericCode(voucher.getFid()+"",8)); //根据凭证表id得到凭证号 保留8位长度
			voucherList.setfSummary(fSummary);//摘要
			String subjectCodeAndName=getSubjectCodeAndName(fSummary,fDeptId,sourcesfunds,bankText,lineNum);
			voucherList.setfSubjectCodeAndName(subjectCodeAndName);////科目编号及名称
			if(lineNum==1 || lineNum==3){ //如果是第一行或者第三行
				voucherList.setfDebitAmount(amount);//借方金额
				//根据部门id获得部门对应费用科目 对象
				List<DeptToSubject> deptToSubjectList=deptToSubjectMng.findByProperty("fDeptId", fDeptId);
				String fCode="";//对应部门编号
				if(deptToSubjectList!=null && deptToSubjectList.size()>0){
					fCode=deptToSubjectList.get(0).getfCode();
				}
				voucherList.setfDeptName("["+fCode+"]"+fDeptName);//部门名称
				voucherList.setfProjectName(fProjectName);//项目名称
				voucherList.setfEconomicName(fEconomicName);//经济分类科目名称
			}else{
				voucherList.setfCreditAmount(amount);//贷方金额
			}
			voucherList=(VoucherList) super.saveOrUpdate(voucherList);
		return voucherList;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: autoGenericCode 
	* @Description:  不够位数的在前面补0，保留num的长度位数字
	* @param str  需要补0的字符串
	* @param num  字符串长度
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午4:59:33 
	* @throws
	 */
	private  String  autoGenericCode(String str,int num){
		String result = String.format("%0" + num + "d", Integer.parseInt(str));
	    return result;
	}
	/**
	 * 
	* @author:安达
	* @Title: getSubjectCodeAndName 
	* @Description: 获得科目编号及名称
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @param fDeptName  部门名称
	* @param sourcesfunds  根据预算指标选取到的资金来源
	* @param bankText  出纳受理后选取的对应银行进行付款
	* @param lineNum   第几行    总共有 4行 
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午4:11:06 
	* @throws
	 */
	private String getSubjectCodeAndName(String fSummary, String fDeptId,String sourcesfunds,String bankText,int lineNum){
		String subjectCodeAndName="";
		String subjectName="";//应费用科目名称
		
		if(lineNum==1){
			//返回第一行的对应费用科目名称
			//①根据申请部门判断费用科目前半段（详见表2），特殊费用归口如下：银行手续费-财务；硒鼓、公车、水电-总务处；招待费-校办；出国差旅-国际交流处；日常设`备-设备安技处（不包括项目中的设备）
			subjectName=deptToSubjectMng.getFirstRowSubjectName(fSummary, fDeptId,sourcesfunds);
			//②判断资金来源（详见表3 5001末级科目），资金来源可根据预算指标选取到
			subjectCodeAndName=subjectName;
		}else if(lineNum==2){
			//返回第二行的对应费用科目名称
			//二、财务会计分录贷方（一次结清）：出纳受理后选取对应银行进行付款
			subjectCodeAndName=bankText;
		}else if(lineNum==3){
			//返回第三行的对应费用科目名称
			//二、预算会计分录借方：根据前面4-财务会计科目对应预算会计科目表的勾稽关系中选取对应科目
			String subjectCode=deptToSubjectMng.getFirstRowSubjectCode(fSummary, fDeptId,sourcesfunds);
			subjectCodeAndName=financalToBudgetMng.toBudget(subjectCode);
		}else if(lineNum==4){
			//返回第四行的对应费用科目名称
			//二、预算会计分录贷方：因为目前学校只有这个选项所以写死数据
			subjectCodeAndName="80012"+"\n"+"资金结存_货币资金";
		}
		
		return subjectCodeAndName;
	}
}

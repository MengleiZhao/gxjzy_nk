package com.braker.icontrol.expend.reimburse.model;


/**
 * 返回给app校验信息的model
 * @author 沈帆
 * @createtime 2020-07-03
 * @updatetime 2020-07-03
 */
public class InvoiceCheckInfo   {
	
	// 发票代码
    public String code;
    // 备注
    public String checkResult;
    
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCheckResult() {
		return checkResult;
	}
	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}
    
    

	

	
	
}

package com.braker.icontrol.expend.reimburse.model;

/**
 * 发票信息（接口查询）
 * @author 张迅
 */
public class InvoiceQuery {

	//发票代码 --必须
	private String fpdm;
	//发票号码 --必须
	private String fphm;
	//开票日期 --必须
	private String kprq;
	//校验码后六位 --必须
	private String checkCode;
	
	//是否覆盖查询，只有true时表示覆盖
	private String isCover = "false";
	//true：查询到发票信息， false：没有查询到发票信息
	private boolean success;
	public String getFpdm() {
		return fpdm;
	}
	public void setFpdm(String fpdm) {
		this.fpdm = fpdm;
	}
	public String getFphm() {
		return fphm;
	}
	public void setFphm(String fphm) {
		this.fphm = fphm;
	}
	public String getKprq() {
		return kprq;
	}
	public void setKprq(String kprq) {
		this.kprq = kprq;
	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public String getIsCover() {
		return isCover;
	}
	public void setIsCover(String isCover) {
		this.isCover = isCover;
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	
	
}

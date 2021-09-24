package com.braker.common.entity;

/**
 * 收款人的工具类用来获取信息
 * @author 叶崇晖
 *
 */
public interface PayeeDao {
	
	public String getPayeeId();


	public String getPayeeName();


	public String getBank();

	public String getBankName();
	
	public String getBankAccount();


	public String getZfbAccount();


	public String getWxAccount();


	public String getZfbQR();


	public String getWxQR();
	
	public String getIdCard();

}

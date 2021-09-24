package com.braker.core.manager;

import java.util.List;

public interface OperationsMng {

	/**
	 * 电子走访数量
	 * @param dates 起始时间
	 * @param datee 结束时间
	 * @return 居委id 数量
	 */
	public List<Object[]> countDzzf(String dates, String datee);
	/**
	 * 电子巡查数量
	 * @return 居委code 数量
	 */
	public List<Object[]> countDzxc(String dates, String datee);
	/**
	 * 实有人口更新量
	 * @return 居委id 数量
	 */
	public List<Object[]> countSyrk(String dates, String datee);
	/**
	 * 社情民意数量
	 * @return 居委id 数量
	 */
	public List<Object[]> countSqmy(String dates, String datee);
	/**
	 * 用户登录数量
	 * @return 居委id 数量
	 */
	public List<Object[]> countYhdl(String dates, String datee);
	
}

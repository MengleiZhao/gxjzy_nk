package com.braker.icontrol.cgmanage.cginquiries.manager;


import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningRef;

/**
 * 询比价登记的service
 * @author 冉德茂
 * @createtime 2018-07-31
 * @updatetime 2018-07-31
 */
public interface CgInquiriesMng extends BaseManager<InqWinningRef>{


	/*
	 * 保存报价清单   映射表的信息
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-11-20
	 */
	public String save(InqWinningRef bean, String mingxi, String files,User user, String fpid, String fwid,String fmainid);

	/*
	 *查询报价清单信息
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-0788-01
	 */
	public Pagination pageList(InqWinningRef bean, Integer page, Integer rows, User user, String pid);


	/*
	 * 通过pid查询所有的供应商
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	public List<InqWinningRef> findByPid(Integer pid);
	
	
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	public void delete(Integer id);
	/*
	 * 根据wid和pid判断同一采购批次下的供应商是否登记
	 * @author 冉德茂
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	public List<InqWinningRef> findByPidWid(Integer fpid, Integer fwid );
	
}

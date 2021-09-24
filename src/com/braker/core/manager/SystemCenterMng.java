package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.SystemCenterAttac;
import com.braker.core.model.User;


/**
 * 制度中心管理的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
public interface SystemCenterMng extends BaseManager<CheterInfo>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	public Pagination pageList(CheterInfo bean, int pageNo, int pageSize);
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	//public void save(CheterInfo bean,User user);
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2018-09-04
	 */
	public void delete(Integer id);
	
	/*
	 * 制度的保存
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2018-09-04
	 */
	public void save(CheterInfo bean,String files,User user);
	
	/*
	 * 点击增加点击次数
	 * @author 叶崇晖
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	public void addClickNum(Integer id);
	
	/*
	 * 查询制度中心List
	 * @author 叶崇晖
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	public List<CheterInfo> getList();
	
	/*
	 * 记录制度文件的查看历史
	 */
	public void recordViewLog(CheterInfo bean);
	
	/*
	 *	根据文件名称查询 
	 */
	public CheterInfo findByFileName(String fileName);
	
	/*
	 *	制度中心 根据文件名称查询 list 
	 */
	public List<CheterInfo> getFileNamList(String fileName,String belong,String more);
	
	/*
	 *	获得文档编号最大值 
	 */
	public String getMaxCode();
}

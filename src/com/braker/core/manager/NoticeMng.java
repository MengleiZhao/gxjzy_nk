package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;
import com.braker.core.model.User;

/**
 * 公告中心的service抽象类
 * @author 叶崇晖
 * @createtime 2018-06-6
 * @updatetime 2018-06-6
 */
public interface NoticeMng extends BaseManager<Notice>{
	
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	public Pagination pageList(Notice bean, int pageNo, int pageSize, String order);
	
	/*
	 * 公告新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	public void save(Notice bean,String files,User user);
	
	/*
	 * 公告删除
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	public void delete(Integer id);
	
	/*
	 * 查询数据条数
	 * @author 叶崇晖
	 * @createtime 2018-06-8
	 * @updatetime 2018-06-8
	 */
	public Integer NoticeNumber();
	
	/*
	 * 查询前四条数据首页用
	 * @author 叶崇晖
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public List<Notice> getNotices();
}

package com.braker.core.manager.impl;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.ftp.FileUpload;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.jdbc.ApplicationDB;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.NoticeMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;
import com.braker.core.model.User;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 公告中心的service实现类
 * @author 叶崇晖
 * @createtime 2018-06-6
 * @updatetime 2018-06-6
 */
@Service
@Transactional
public class NoticeMngImpl extends BaseManagerImpl<Notice> implements NoticeMng {
	
	
	@Autowired
	private AttachmentMng attachmentMng;
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@Override
	public Pagination pageList(Notice bean, int pageNo, int pageSize, String order) {
		//查询条件
		Finder finder = Finder.create(" FROM Notice WHERE 1=1");
		if (!StringUtil.isEmpty(bean.getNoticeTitle())) {
			finder.append(" and noticeTitle like :noticeTitle").setParam("noticeTitle", "%" + bean.getNoticeTitle() + "%");
		}
		
		if(!StringUtil.isEmpty(bean.getNoticeSubtitle())){
			finder.append(" and noticeSubtitle like :noticeSubtitle").setParam("noticeSubtitle", bean.getNoticeSubtitle());
		}
		if (bean.getReleaseDates() != null) {
			finder.append(" and DATE_FORMAT(releaseTime,'%Y-%m-%d') >='"+bean.getReleaseDates()+"'");
		}
		if (bean.getReleaseDatee() != null) {
			finder.append(" and DATE_FORMAT(releaseTime,'%Y-%m-%d') <='"+bean.getReleaseDatee()+"'");
		}
		
		if (!StringUtil.isEmpty(bean.getReleaseUser())) {
			finder.append(" and releaseUser like :releaseUser").setParam("releaseUser", "%" + bean.getReleaseUser() + "%");
		}
		if("0".equals(order)){
			finder.append(" and fNoticeStatus ='2'");
		}else{
			finder.append(" and fNoticeStatus in('2','1')");
		}
		finder.append(" ORDER BY noticeNum");
		return super.find(finder, pageNo, pageSize);
	}
	
	/*
	 * 公告新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void save(Notice bean,String files,User user) {
		if (bean.getNoticeId()==null) {
			//创建人、创建时间、发布时间
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(new Date());
			bean.setReleaseTime(new Date());
			
			//排序
			Boolean flag = true;
				Integer num =  NoticeNumber();
				if(flag == true){
					if(bean.getNoticeId()==null){					//是否新增
						bean.setNoticeNum(Double.valueOf(num+1));	//设置排序号
					}
					if(bean.getStick() != null && bean.getStick()==1){							//判断是否置顶
						Finder finder = Finder.create("SELECT COUNT(*) FROM Notice WHERE noticeNum<=1");
						List<Object> list = super.find(finder);	
						num = Integer.valueOf(String.valueOf( list.get(0)));
						bean.setNoticeNum((1-num*0.0001-0.0001));
						
					}
				}
			
			bean = (Notice) super.merge(bean);
			
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(new Date());
			bean.setReleaseTime(new Date());
			
			//排序
			Boolean flag = true;
				Integer num =  NoticeNumber();
				if(flag == true){
					if(bean.getNoticeId()==null){					//是否新增
						bean.setNoticeNum(Double.valueOf(num+1));	//设置排序号
					}
					if(bean.getStick()==1){							//判断是否置顶
						Finder finder = Finder.create("SELECT COUNT(*) FROM Notice WHERE noticeNum<=1");
						List<Object> list = super.find(finder);	
						num = Integer.valueOf(String.valueOf( list.get(0)));
						bean.setNoticeNum((1-num*0.0001-0.0001));
						
					}
				}
				bean = (Notice) super.update(bean);
		}
		
		//附件信息保存
		attachmentMng.joinEntity(bean,files);
	}
	

	/*
	 * 公告删除
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@Override
	public void delete(Integer id) {
		
		getSession().createSQLQuery("UPDATE T_NOTICE_INFO SET F_NOTICE_STATUS=3 WHERE F_NOTICE_ID="+id).executeUpdate();
		
		/*Notice bean = findById(id);
		//删除附件信息
		Finder finder = Finder.create(" FROM NoticeAttac WHERE noticeId="+bean.getNoticeId());
		List<Object> list = super.find(finder);
		for(int x=0; x<list.size(); x++) {
			NoticeAttac na = (NoticeAttac) list.get(x);
			super.delete(na);
		}
		//删除公告
		super.delete(bean);*/
	}
	
	/*
	 * 查询数据条数
	 * @author 叶崇晖
	 * @createtime 2018-06-8
	 * @updatetime 2018-06-8
	 */
	@Override
	public Integer NoticeNumber() {
		Finder finder = Finder.create("SELECT COUNT(*) FROM Notice");
		List<Object> list = super.find(finder);	
		Integer noticeNum = Integer.valueOf(String.valueOf( list.get(0)));		
		return noticeNum;
	}

	/*
	 * 查询前四条数据首页用
	 * @author 叶崇晖
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public List<Notice> getNotices() {
		//查询条件
		Finder finder = Finder.create(" FROM Notice where fNoticeStatus=2 ORDER BY releaseTime DESC");
		Pagination e = super.find(finder,0,10);
		return (List<Notice>) e.getList();
	}


}

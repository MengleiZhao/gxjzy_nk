package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.core.manager.NoticeAttacMng;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;

/**
 * 公告中心附件的service实现类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Service
@Transactional
public class NoticeAttacMngImpl extends BaseManagerImpl<NoticeAttac> implements NoticeAttacMng {
	
	/*
	 * 查询附件信息
	 * @author 叶崇晖
	 * @createtime 2018-06-11
	 * @updatetime 2018-06-11
	 */	@Override
	public NoticeAttac getAttac(Notice bean) {
		Finder finder = Finder.create(" FROM NoticeAttac WHERE noticeId="+bean.getNoticeId());
		List<Object> li = super.find(finder);
		if(li.size()==0){
			return null;
		} else {
			Object obj = li.get(0);
			return (NoticeAttac)obj;
		}
	}

}

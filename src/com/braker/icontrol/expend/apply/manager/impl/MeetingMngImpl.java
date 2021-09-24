package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Condition;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.manager.MeetingMng;
import com.braker.icontrol.expend.apply.manager.TrainingMng;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;

/**
 * 培训统计的service实现类
 * @author 焦广兴
 * @createtime 2019-03-27
 * @updatetime 2019-03-27
 */
@Service
@Transactional
public class MeetingMngImpl extends BaseManagerImpl<MeetingAppliInfo> implements MeetingMng{




}

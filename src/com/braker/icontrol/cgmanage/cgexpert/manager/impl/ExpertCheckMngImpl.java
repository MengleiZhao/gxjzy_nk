package com.braker.icontrol.cgmanage.cgexpert.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertCheckMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TProcessCheckMng;


/**
 * 专家库审核的service实现类
 * @author 冉德茂
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
@Service
@Transactional
public class ExpertCheckMngImpl extends BaseManagerImpl<ExpertInfo> implements ExpertCheckMng {
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng proItfMng; 
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public Pagination pageList(ExpertInfo bean, int pageNo, int pageSize, User user) {		
		
		//查看审批信息根据当前登录人
		StringBuffer s =new StringBuffer("select * from T_EXPERT_INFO zjk where zjk.F_STAUTS <>99 and zjk.F_E_ID in"
				//黑名单审核数据
				+ "(select hmd.f_E_ID from t_expert_black_info hmd where hmd.F_USER_ID='"+user.getId()+"' and zjk.F_EXT_2=1)"
				//出库审批数据
				+ " or zjk.F_E_ID in (select ck.F_E_ID from t_expert_out ck where ck.F_USER_ID='"+user.getId()+"' and zjk.F_EXT_3=1)"
				//入库审核数据
				+ " or (zjk.F_USER_CODE='"+user.getId()+"' and zjk.F_CHECK_STAUTS=1)");
		if(!StringUtil.isEmpty(bean.getFexpertCode())){ //按专家编号模糊查询
			s.append(" AND zjk.F_E_CODE LIKE '%"+bean.getFexpertCode()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getFexpertName())){ //按专家名称名称模糊查询
			s.append(" AND zjk.F_E_NAME LIKE '%"+bean.getFexpertName()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getFfield())){ //按擅长领域模糊查询
			s.append(" AND zjk.F_FIELD '%"+bean.getFfield()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getFexpertSex()) ){//性别
			s.append(" AND zjk.F_E_SEX ="+bean.getFexpertSex()+"");
		}
		s.append(" order by zjk.F_REQ_TIME desc");
		Pagination p = super.findBySql(new ExpertInfo(),s.toString(),pageNo,pageSize);
    	List<ExpertInfo> li = (List<ExpertInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(pageNo-1)*pageSize);	
		}
		return p;
		
	}


	/*
	 * 保存审核信息
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, ExpertInfo bean, User user ,Role role,String files) throws Exception  {
		bean=this.findById(bean.getFeId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/expertcheck/check?checkType=in&id=";
		String lookUrl ="/expertgl/detail?checkType=in&id=";
		bean=(ExpertInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"CGEXSQ",checkUrl,lookUrl,files);
		super.saveOrUpdate(bean);
	}


	@Override
	public String inRecall(Integer id) throws Exception {
		//根据id查询对象
		ExpertInfo bean=(ExpertInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="专家库入库申请被撤回消息";
		String msg="您待审批的  "+bean.getFexpertName() +" 专家,任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(ExpertInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}

}

	
	
	



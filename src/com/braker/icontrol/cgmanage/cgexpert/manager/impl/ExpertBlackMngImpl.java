package com.braker.icontrol.cgmanage.cgexpert.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.manager.CgExpertMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertBlackMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertCheckMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

@Service
@Transactional
public class ExpertBlackMngImpl extends BaseManagerImpl<ExpertBlackInfo> implements ExpertBlackMng {
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private ExpertCheckMng expertcheckMng;
	
	@Autowired
	private CgExpertMng cgexpertMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	/* 保存黑名单审核信息
	 * @author 焦广兴
	 * @createtime 2019-06-18
	 * @updatetime 2019-06-18
	 */
	@Override
	public void saveCheckBlack(TProcessCheck checkBean, ExpertBlackInfo bean, User user, String files) throws Exception {
		bean=this.findById(bean.getFeBId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/expertcheck/check?checkType=black&id=";
		String lookUrl ="/expertgl/detail?checkType=black&id=";
		bean=(ExpertBlackInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"ZJKHMD",checkUrl,lookUrl,files);
		bean=(ExpertBlackInfo)super.saveOrUpdate(bean);
		ExpertInfo w=expertcheckMng.findById(bean.getFeId());
		if(w.getFisOutStatus().equals("-1")){
			w.setFisOutStatus("0");
		}
		if(bean.getfCheckStatus().equals("9")){
			w.setFisBlack("1");
			Integer n=w.getFaccFreq();
			w.setFaccFreq(n+1);
			w.setFisBlackStatus("9");
			w.setFisOutStatus("0");
			expertcheckMng.saveOrUpdate(w);
		}
		if(checkBean.getFcheckResult().equals("0")){
			w.setFisBlack("0");
			w.setFcheckType("in");
			w.setFisBlackStatus("-1");	//不通过 被退回
			expertcheckMng.saveOrUpdate(w);
		}
	}


	@Override
	public List<ExpertBlackInfo> findCheckBlack(String feId, User user) {
		Finder finder =Finder.create(" FROM ExpertBlackInfo WHERE fCheckStatus <>"+99+"");	//未审核通过的
		finder.append(" AND fUserId="+user.getId()+"");
		finder.append(" AND feId="+feId+"");
		finder.append(" order by fblackTime desc");
		return super.find(finder);
	}


	@Override
	public List<ExpertBlackInfo> findByExpertBlack(String feId, String status) {
		Finder finder =Finder.create(" FROM ExpertBlackInfo WHERE fCheckStatus ="+status+"");
		finder.append(" AND feId="+feId+"");
		finder.append(" order by fblackTime desc");
		return super.find(finder);
	}


	@Override
	public void deleteBlackExpert(String feId, String feBId) {
		ExpertBlackInfo exBlack=new ExpertBlackInfo();
		ExpertInfo bean=new ExpertInfo();
		if(!StringUtil.isEmpty(feId)){
			exBlack=findByExpertBlack(feId, "-1").get(0);
			deleteById(exBlack.getFeBId());
			bean=cgexpertMng.findById(Integer.valueOf(feId));
		}
		if(!StringUtil.isEmpty(feBId)){
			exBlack=findById(feBId);
			deleteById(feBId);
			bean=cgexpertMng.findById(Integer.valueOf(exBlack.getFeId()));
		}
		bean.setFisBlackStatus("0");
		super.saveOrUpdate(bean);
	}


	@Override
	public String blackRecall(Integer id) throws Exception {
		//根据id查询对象
		ExpertBlackInfo bean=(ExpertBlackInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		
		ExpertInfo w=expertcheckMng.findById(bean.getFeId());
		if(bean.getfCheckStatus().equals("1")){
			w.setFisBlack("0");
			w.setFcheckType("in");
			w.setFisBlackStatus("-4");	//被撤回
			expertcheckMng.saveOrUpdate(w);
		}
		
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="专家库黑名单申请被撤回消息";
		String msg="您待审批的  "+bean.getFeName() +" 专家,任务编号：("+bean.getFeBCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(ExpertBlackInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
	
}

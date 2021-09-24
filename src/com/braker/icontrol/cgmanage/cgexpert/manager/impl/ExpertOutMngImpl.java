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
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertCheckMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertOutMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;


@Service
@Transactional
public class ExpertOutMngImpl extends BaseManagerImpl<ExpertOutInfo> implements ExpertOutMng{

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
	@Override
	public void saveCheckOut(TProcessCheck checkBean, ExpertOutInfo bean,
			User user, String files) throws Exception {
		bean=this.findById(bean.getFoId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/expertcheck/check?checkType=out&id=";
		String lookUrl ="/expertgl/detail?checkType=out&id=";
		bean=(ExpertOutInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"ZJKCK",checkUrl,lookUrl,files);
		bean=(ExpertOutInfo)super.saveOrUpdate(bean);
		ExpertInfo w=expertcheckMng.findById(Integer.valueOf(bean.getFeId()));
		if(w.getFisBlackStatus().equals("-1")){
			w.setFisBlackStatus("0");
		}
		if(bean.getfCheckStatus().equals("9")){
			if(bean.getFflag().equals("1")){
				w.setFstauts("2");	//2出库状态,1默认 ，99 删除
			}else{
				//w.setFisBlackStatus("0");
				w.setFstauts("1");	//  数据状态默认
			}
			w.setFisOutStatus("9");
			w.setFisBlackStatus("0");
			expertcheckMng.saveOrUpdate(w);
		}
		if(checkBean.getFcheckResult().equals("0")){
			if(bean.getFflag().equals("1")){
				w.setFstauts("1");
				w.setFisOutStatus("-1");	//出库 不通过 被退回
				w.setFcheckType("in");
			}else{
				w.setFstauts("2");
				w.setFisOutStatus("-2");	//入库 不通过 被退回
				w.setFcheckType("out");
			}
			expertcheckMng.saveOrUpdate(w);
		}
	}

	@Override
	public List<ExpertOutInfo> findCheckOut(String feId, User user) {
		Finder finder =Finder.create(" FROM ExpertOutInfo WHERE fCheckStatus <>"+99+"");	//未审核通过的
		finder.append(" AND fUserId="+user.getId()+"");
		finder.append(" AND feId="+feId+"");
		finder.append(" order by fRecTime desc");
		return super.find(finder);
	}

	@Override
	public List<ExpertOutInfo> findByExpertOut(String feId, String recId, String status, String checkType) {
		Finder finder =Finder.create(" FROM ExpertOutInfo WHERE");
		if(!StringUtil.isEmpty(status) && status.equals("-2")){
			status="-1";
		}
		finder.append(" fCheckStatus="+status+"");
		//finder.append(" AND fRecUserId="+recId+"");
		finder.append(" AND feId="+feId+"");
		finder.append(" order by fRecTime desc");
		return super.find(finder);
	}

	@Override
	public void deleteOutExpert(Integer feId, Integer foId) {
		ExpertOutInfo exOut=new ExpertOutInfo();
		ExpertInfo bean=new ExpertInfo();
		if(!StringUtil.isEmpty(String.valueOf(feId))){
			exOut=findByExpertOut(String.valueOf(feId),null, "-1",null).get(0);
			deleteById(exOut.getFoId());
			bean=cgexpertMng.findById(feId);
		}
		if(!StringUtil.isEmpty(String.valueOf(foId))){
			exOut=findById(foId);
			deleteById(foId);
			bean=cgexpertMng.findById(Integer.valueOf(exOut.getFeId()));
		}
		if(exOut.getFflag().equals("1")){//出库 不通过 被退回
			bean.setFisOutStatus("0");
		}
		if(exOut.getFflag().equals("2")){//入库 不通过 被退回
			bean.setFisOutStatus("9");
		}
		super.saveOrUpdate(bean);
	}

	@Override
	public String outRecall(Integer id) throws Exception {
		//根据id查询对象
		ExpertOutInfo bean=(ExpertOutInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		ExpertInfo w=expertcheckMng.findById(bean.getFeId());
		if(bean.getFflag().equals("1")){
			w.setFstauts("1");
			w.setFisOutStatus("-4");	//出库 被撤回
			w.setFcheckType("in");
		}else{
			w.setFstauts("2");
			w.setFisOutStatus("-4");	//入库被撤回
			w.setFcheckType("out");
		}
		expertcheckMng.saveOrUpdate(w);
		String title="专家库入库申请被撤回消息";
		String msg="您待审批的  "+w.getFexpertName() +" 专家,任务编号：("+bean.getFoCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(ExpertOutInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}

}

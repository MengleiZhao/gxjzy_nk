package com.braker.icontrol.cgmanage.cgsupplier.manager.impl;

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
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierOutMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

@Service
@Transactional
public class SupplierOutMngImpl extends BaseManagerImpl<SupplierOut> implements SupplierOutMng{

	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private PrivateInforMng privateInforMng;
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
	private SupplierMng supplierMng;
	
	@Override
	public List<SupplierOut> findCheckOut(String fwId, User user) {
		Finder finder =Finder.create(" FROM SupplierOut WHERE fCheckStatus <>"+99+"");	//未审核通过的
		finder.append(" AND fUserId="+user.getId()+"");
		finder.append(" AND fwId="+fwId+"");
		finder.append(" order by fRecTime desc");
		return super.find(finder);
	}

	@Override
	public void saveCheckOut(TProcessCheck checkBean, SupplierOut bean,
			User user, String files) throws Exception {
		bean=this.findById(bean.getFoId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/suppliercheck/check?checkType=out&id=";
		String lookUrl ="/suppliergl/detail?type=out&id=";
		bean=(SupplierOut)tProcessCheckMng.checkProcess(checkBean,entity,user,"GYSCK",checkUrl,lookUrl,files);
		bean=(SupplierOut)super.saveOrUpdate(bean);
		WinningBidder w=supplierMng.findById(Integer.valueOf(bean.getFwId()));
		if(w.getFisBlackStatus().equals("-1")){
			w.setFisBlackStatus("0");
		}
		if(bean.getfCheckStatus().equals("9")){
			if(bean.getFflag().equals("1")){
				w.setFstauts("2");	//2出库状态,1默认 ，99 删除
			}else{
				w.setFstauts("1");	//  数据状态默认
			}
			w.setFisOutStatus("9");
			w.setFisBlackStatus("0");
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
		}
		supplierMng.saveOrUpdate(w);
	}

	@Override
	public List<SupplierOut> findBySupplierOut(String fwId, String status) {
		Finder finder =Finder.create(" FROM SupplierOut WHERE fCheckStatus ="+status+"");
		finder.append(" AND fwId="+fwId+"");
		finder.append(" order by fRecTime desc");
		return super.find(finder);
	}

	@Override
	public void deleteSupplierOut(Integer fwId, Integer foId) {
		SupplierOut suOut=new SupplierOut();
		WinningBidder bean=new WinningBidder();
		if(!StringUtil.isEmpty(String.valueOf(fwId))){
			suOut=findBySupplierOut(String.valueOf(fwId),"-1").get(0);
			deleteById(suOut.getFoId());
			bean=supplierMng.findById(fwId);
		}
		if(!StringUtil.isEmpty(String.valueOf(foId))){
			suOut=findById(foId);
			deleteById(foId);
			bean=supplierMng.findById(suOut.getFwId());
		}
		if(suOut.getFflag().equals("1")){//出库 不通过 被退回
			bean.setFisOutStatus("0");
		}
		if(suOut.getFflag().equals("2")){//入库 不通过 被退回
			bean.setFisOutStatus("9");
		}
		super.saveOrUpdate(bean);
	}

	@Override
	public String outRecall(Integer id) throws Exception {
		//根据id查询对象
		SupplierOut bean=(SupplierOut)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		WinningBidder w=supplierMng.findById(Integer.valueOf(bean.getFwId()));
		if(bean.getFflag().equals("1")){
			w.setFstauts("1");
			w.setFisOutStatus("-4");	//出库 被撤回
			w.setFcheckType("in");
		}else{
			w.setFstauts("2");
			w.setFisOutStatus("-4");	//入库被撤回
			w.setFcheckType("out");
		}
		supplierMng.saveOrUpdate(w);
		String title="供应商出库申请被撤回消息";
		String msg="您待审批的  "+w.getFwName() +",任务编号：("+bean.getFoCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(SupplierOut) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
	
}

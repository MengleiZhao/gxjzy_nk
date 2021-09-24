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
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierBlackInfoMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
@Service
@Transactional
public class SupplierBlackInfoMngImpl  extends BaseManagerImpl<SupplierBlackInfo> implements  SupplierBlackInfoMng{
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
	/**
	 * 保存黑名单审核信息
	 * @author 焦广兴
	 * @createtime 2019-06-04
	 * @updatetime 2019-06-04
	 */
	@Override
	public void saveCheckBlack(TProcessCheck checkBean, SupplierBlackInfo bean, User user, String files)  throws Exception {
		bean=this.findById(bean.getFwBId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/suppliercheck/check?checkType=black&id=";
		String lookUrl ="/suppliergl/detail?checkType=black&id=";
		bean=(SupplierBlackInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"GYSHMD",checkUrl,lookUrl,files);
		bean=(SupplierBlackInfo)super.saveOrUpdate(bean);
		WinningBidder w=supplierMng.findById(bean.getFwId());
		if(w.getFisOutStatus().equals("-1")){
			w.setFisOutStatus("0");
		}
		if(bean.getfCheckStatus().equals("9")){
			w.setFisBlack("1");
			Integer n=w.getFaccFreq();
			w.setFaccFreq(n+1);
			w.setFisBlackStatus("9");
			w.setFisOutStatus("0");
			supplierMng.saveOrUpdate(w);
		}
		if(checkBean.getFcheckResult().equals("0")){
			w.setFisBlack("0");
			w.setFcheckType("in");
			w.setFisBlackStatus("-1");	//不通过 被退回
			supplierMng.saveOrUpdate(w);
		}
	}
	@Override
	public Pagination blackCheckPageList(SupplierBlackInfo sb,  int pageNo, int pageSize,User user) {
		//查看审批信息根据当前登录人
		Finder finder =Finder.create(" FROM SupplierBlackInfo WHERE fUserName='"+user.getName()+"'");
		//黑名单审核数据
		if(!StringUtil.isEmpty(sb.getfCheckStatus())){
			finder.append(" And fCheckStatus="+sb.getfCheckStatus()+"");	//1待审核
		}
		if(!StringUtil.isEmpty(sb.getFwCode())){ //按供应商编码模糊查询
			finder.append(" AND fwCode LIKE :fwCode");
			finder.setParam("fwCode", "%"+sb.getFwCode()+"%");
		}
		if(!StringUtil.isEmpty(sb.getFwName())){ //按供应商名称模糊查询
			finder.append(" AND fwName LIKE :fwName");
			finder.setParam("fwName", "%"+sb.getFwName()+"%");
		}
		finder.append(" order by fblackTime desc");
		
		return super.find(finder,pageNo,pageSize);
	}
	@Override
	public List<SupplierBlackInfo> findCheckBlack(String fwId, User user) {
		Finder finder =Finder.create(" FROM SupplierBlackInfo WHERE fCheckStatus <>"+99+"");	//未审核通过的
		finder.append(" AND fUserId="+user.getId()+"");
		finder.append(" AND fwId="+fwId+"");
		finder.append(" order by fblackTime desc");
		return super.find(finder);
	}
	@Override
	public List<SupplierBlackInfo> findBySupplierBlack(String fwId, String status) {
		Finder finder =Finder.create(" FROM SupplierBlackInfo WHERE fCheckStatus ="+status+"");	
		finder.append(" AND fwId="+fwId+"");
		finder.append(" order by fblackTime desc");
		return super.find(finder);
	}
	
	@Override
	public void deleteSupplierBlack(String fwId, String fwBId) {
		SupplierBlackInfo suBlack=new SupplierBlackInfo();
		WinningBidder bean=new WinningBidder();
		if(!StringUtil.isEmpty(fwId)){
			suBlack=findBySupplierBlack(fwId, "-1").get(0);
			deleteById(suBlack.getFwBId());
			bean=supplierMng.findById(Integer.valueOf(fwId));
		}
		if(!StringUtil.isEmpty(fwBId)){
			suBlack=findById(fwBId);
			deleteById(fwBId);
			bean=supplierMng.findById(Integer.valueOf(suBlack.getFwId()));
		}
		bean.setFisBlackStatus("0");
		super.saveOrUpdate(bean);
	}
	@Override
	public String blackRecall(Integer id) throws Exception {
		//根据id查询对象
		SupplierBlackInfo bean=(SupplierBlackInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		
		WinningBidder w=supplierMng.findById(bean.getFwId());
		if(bean.getfCheckStatus().equals("1")){
			w.setFisBlack("0");
			w.setFcheckType("in");
			w.setFisBlackStatus("-4");	//被撤回
			supplierMng.saveOrUpdate(w);
		}
		
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="供应商黑名单申请被撤回消息";
		String msg="您待审批的  "+bean.getFwName() +",任务编号：("+bean.getFwBCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(SupplierBlackInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
}

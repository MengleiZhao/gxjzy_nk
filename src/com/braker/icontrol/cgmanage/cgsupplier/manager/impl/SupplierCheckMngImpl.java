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
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierCheckMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TProcessCheckMng;


/**
 * 供应商审核的service实现类
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Service
@Transactional
public class SupplierCheckMngImpl extends BaseManagerImpl<WinningBidder> implements SupplierCheckMng {
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng proItfMng; 
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@Override
	public Pagination pageList(WinningBidder bean, int pageNo, int pageSize, User user) {		
		//查看审批信息根据当前登录人
		StringBuffer s =new StringBuffer("select * from T_WINNING_BIDDER gys where gys.F_STAUTS <>99 AND gys.F_W_ID in"
				//黑名单审核数据
				+ " (select hmd.F_W_ID from T_WINNING_BLACK_info hmd where  hmd.F_USER_ID='"+user.getId()+"' and gys.F_EXT_2=1)"
				//出库审批数据
				+ " or gys.F_W_ID in (select ck.F_W_ID from t_supplier_out ck where ck.F_USER_ID='"+user.getId()+"' and gys.F_EXT_3=1)"
				//入库审核数据
				+ " or (gys.F_USER_CODE='"+user.getId()+"' and gys.F_CHECK_STAUTS=1)");
		if(!StringUtil.isEmpty(bean.getFwCode())){ //按供应商编码模糊查询
		s.append(" AND gys.F_W_CODE LIKE '%"+bean.getFwCode()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getFwName())){ //按供应商名称模糊查询
		s.append(" AND gys.F_W_NAME LIKE '%"+bean.getFwName()+"%'");
		}
		s.append(" order by gys.F_REQ_TIME desc");
		Pagination p = super.findBySql(new WinningBidder(),s.toString(),pageNo,pageSize);
    	List<WinningBidder> li = (List<WinningBidder>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(pageNo-1)*pageSize);	
		}
		return p;
	}


	/*
	 * 保存入库审核信息
	 * @author 李安达
	 * @createtime 2018-09-12
	 * @updatetime 2018-04-30
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, WinningBidder bean, User user,String files ) throws Exception {
		bean=this.findById(bean.getFwId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/suppliercheck/check?checkType=in&id=";
		String lookUrl ="/suppliergl/detail?type=in&id=";
		bean=(WinningBidder)tProcessCheckMng.checkProcess(checkBean,entity,user,"CGFWSQ",checkUrl,lookUrl,files);
		super.saveOrUpdate(bean);
	}


	@Override
	public String inRecall(Integer id) throws Exception {
		//根据id查询对象
		WinningBidder bean=(WinningBidder)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="供应商入库申请被撤回消息";
		String msg="您待审批的  "+bean.getFwName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(WinningBidder) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
	
	
}

	
	
	



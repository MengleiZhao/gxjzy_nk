package com.braker.icontrol.budget.manager.manager.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.model.PrivateInformation;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.data.manager.AnalysisProBasicInfoMng;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.manager.manager.ResolveMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;

/**
 * 控制数分解的service实现类
 * @author 叶崇晖
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
@Service
@Transactional
public class ResolveMngImpl extends BaseManagerImpl<TProBasicInfo> implements ResolveMng {
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private AnalysisProBasicInfoMng analysisProMng;
	/*
	 * 控制数分解数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public List<TProBasicInfo> pageList(TProBasicInfo bean, int pageNo, int pageSize, User user, String type) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0')");
		if("0".equals(type)) {
			//待分解项目
			finder.append(" and  FFlowStauts ='29' and FExt4 ='11' and FExt5 is null");
		} else if("1".equals(type)) {
			//已分解项目
			finder.append(" and  FExt5 in('0','1')");
		}
		if(bean.getPlanStartYear() != null) {
			String y = bean.getPlanStartYear();
			if(!"".equals(y)){
				finder.append(" and planStartYear like '%"+y+"%'");
			}
			
		} else {
			String y = new Date().toString();
			y = y.substring(y.length()-4);
			finder.append(" and planStartYear like'%"+(Integer.valueOf(y)+1)+"%'");
		}
		
		//查询条件
		if (!StringUtil.isEmpty(bean.getFProCode())) {//项目编码
			finder.append(" and FProCode like :fProCode").setParam("fProCode", "%" + bean.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {//名称
			finder.append(" and FProName like :name").setParam("name", "%" + bean.getFProName() + "%");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getFProOrBasic()))) {//支出类型
			finder.append(" and FProOrBasic = :FProOrBasic").setParam("FProOrBasic",  bean.getFProOrBasic() );
		}
		
		finder.append(" order by updateTime desc");
		List<TProBasicInfo> list=super.find(finder);
		return list;
	}

	/*
	 * 控制数分解数据保存
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public void save(String fproId, String provideAmount1, String fext12) {
		String[] id = fproId.split(",");
		String[] amount = provideAmount1.split(",");
		String[] remake = fext12.split(",");
		
		for (int i = 0; i < id.length; i++) {
			//新建一个消息推送信息
			TProBasicInfo bean = super.findById(Integer.valueOf(id[i]));
			String remark = "";
			if (remake != null && remake.length > i) {
				remark = remake[i];
			}
			if(bean.getFProBudgetAmount().compareTo(BigDecimal.valueOf(Double.valueOf(amount[i])))==0){
				List<TProBasicInfo> indexli = new ArrayList<TProBasicInfo>();
				bean.setFProLibType("2");//所属库 1：备选库 2：上报库   3：执行中 4：已完结
				bean.setFExt4("21");//上报状态 20、二上未申报   21、二上已申报
				bean.setFExt5("0");
				bean.setFFlowStauts("39");
				bean.setFIsExecute("0");
				bean.setProvideAmount1(BigDecimal.valueOf(Double.valueOf(amount[i])));//一下控制数金额
				bean.setFExt12(remark);//一下控制数简要说明
				bean.setFExt5("0");//一下控制数状态
				super.saveOrUpdate(bean);
				indexli.add(bean);
				budgetIndexMgrMng.createIndex(indexli);
			} else {
				//送审二上申报
				getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_KZCB_1='"+Double.valueOf(amount[i])+"',F_EXT_12='"+remark+"',F_FLOW_STAUTS='0',F_EXT_4='20',F_EXT_5='0' WHERE F_PRO_ID='"+id[i]+"'").executeUpdate();
				String title=bean.getFProName()+"预算分解消息";
				String msg="您申请的  "+bean.getFProName()+"项目,项目编号：("+bean.getBeanCode()+")已分解完毕。请前往预算管理->项目库管理->上报库->二上申报菜单中查看分解结果。";
				privateInforMng.setMsg(title, msg, bean.getUserId(),"2");
				analysisProMng.copyProBasicInfo(bean, 3);
			}
		}
	}
}

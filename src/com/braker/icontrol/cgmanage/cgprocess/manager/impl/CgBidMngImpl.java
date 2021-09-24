package com.braker.icontrol.cgmanage.cgprocess.manager.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidExpRefMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidWinRefMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidExpertRef;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgprocess.model.BidWinningRef;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierTransactionHisMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierTransactionHis;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.zzww.comm.manager.AttachmentMng;



/**
 * 中标登记的service实现类
 * @author 冉德茂
 * @createtime 2018-07-24
 * @updatetime 2018-07-24
 */
@Service
@Transactional
public class CgBidMngImpl extends BaseManagerImpl<BidRegist> implements CgBidMng {
	
	@Autowired
	private CgBidWinRefMng bwrefMng;
	
	@Autowired
	private CgBidExpRefMng bereftMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private CgProcessMng cgProcessMng;
	
	@Autowired
	private SupplierTransactionHisMng supplierTransMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public Pagination pageList(BidRegist bean, int pageNo, int pageSize) {

		//Finder finder =Finder.create(" FROM BidRegist WHERE fstatus <>"+99+" ");
		Finder finder =Finder.create("  FROM BidRegist WHERE fstatus <>"+99+" ");
		if(!StringUtil.isEmpty(bean.getFbiddingCode())){ //按采购编号模糊查询
			finder.append(" AND fbiddingCode LIKE :fbiddingCode");
			finder.setParam("fbiddingCode", "%"+bean.getFbiddingCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFbiddingName())){ //按采购名称模糊查询
			finder.append(" AND fbiddingName LIKE :fbiddingName");
			finder.setParam("fbiddingName", "%"+bean.getFbiddingName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getForgName())){ //按采购名称模糊查询
			finder.append(" AND forgName LIKE :forgName");
			finder.setParam("forgName", "%"+bean.getForgName()+"%");
		}
		finder.append(" order by fbIdId desc ");//倒序
		return super.find(finder,pageNo,pageSize);
	}

	


	
	/*
	 * 保存招标登记信息
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	@Override
	public void save(BidRegist bean, String files, User user,String org, String pid,String wid,String eids,String wCode) {
		//org是中标组织（供应商）名称 wid是供应商id  wcode是供应商的编码  bean.fbidAmount是总中标金额（成交金额） bean.fbidTime是中标日期（成交日期） bean.fbiddingName是招标名称（成交的项目名称）
		/*String time=bean.getFbidTime().toString();
		String year = time.substring(0, 4);
		String month = time.substring(5, 7);*/
		
		bean.setFstatus("0");//新增和修改  数据的删除状态都是0  删除是99

		if (bean.getFbIdId()==null) {//新增
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(new Date());
			bean.setFpId(Integer.valueOf(pid));//采购表id
			bean.setForgName(org);	//供应商名字
			bean.setFwId(Integer.valueOf(wid));//供应商id
			//通过pid查询采购信息  给登记状态赋值1
			PurchaseApplyBasic cgsqbean = cgsqMng.findById(Integer.valueOf(pid));
			cgsqbean.setFbidStauts("1");
			super.merge(cgsqbean);
		/*	//通过bid查询招标表   给中标状态赋值1  避免多次进行中标登记
			BiddingRegist processbean = cgProcessMng.findById(bean.getFbId());
			processbean.setFbidStatus("1");
			super.merge(processbean);*/
			
			//保存基本信息
			bean = (BidRegist) super.saveOrUpdate(bean);	
			Integer bid=bean.getFbIdId();//获取主键赋值给成交记录的外键
			
			//保存成交记录信息
			SupplierTransactionHis suptrbean=new SupplierTransactionHis();
			suptrbean.setFwId(Integer.valueOf(wid));//供应商id
			suptrbean.setFbIdId(bid);//唯一标识   过程登记主键id
			suptrbean.setFtrTime(bean.getFbidTime());//成交时间
			suptrbean.setFsupCode(wCode);//供应商编码
			suptrbean.setFsupName(org);//中标组织名称（供应商名称）
			suptrbean = (SupplierTransactionHis) super.saveOrUpdate(suptrbean);	
			
			Integer mainid=bean.getFbIdId();
			//获取主键  保存外键
			BidWinningRef bwbean=new BidWinningRef();
			//保存过程登记和供应商映射信息
			bwrefMng.save(bwbean,mainid,Integer.valueOf(wid));
			/*//保存中标和评标专家映射信息
			String[] datas = new String[]{};
			datas = eids.split(",");
			for (int i = 0; i < datas.length; i++) {
				Integer eid=Integer.valueOf(datas[i]);
				bereftMng.save(mainid,eid);
			}*/
		} else {//修改
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(new Date());
			bean.setFpId(Integer.valueOf(pid));
			bean.setForgName(org);	
			
			bean = (BidRegist) super.saveOrUpdate(bean);	
			
			//修改成交记录信息
			SupplierTransactionHis trbean= supplierTransMng.getTrbyBidid(bean.getFbIdId());//根据中标登记的主键id
			trbean.setFwId(Integer.valueOf(wid));//供应商id
			trbean.setFtrTime(bean.getFbidTime());//成交时间
			trbean.setFsupCode(wCode);//供应商编码
			trbean.setFsupName(org);//中标组织名称（供应商名称）
			trbean.setFproName(bean.getFbiddingName());//招标名称（项目名称）(唯一标识)
			trbean.setFtrAmount(bean.getFbidAmount());//成交金额（总中标金额）
			/*trbean.setFtrYear(year);//成交年份
			trbean.setFtrMonth(month);//成交月份
*/			trbean = (SupplierTransactionHis) super.saveOrUpdate(trbean);	

			//清除原有的映射信息
			
			//清除供应商的信息
			//获得已经存在的供应商信息明细
			List<Object> oldwinner = getMingxi("BidWinningRef", "fbIdId", bean.getFbIdId());
			//删除已存在中标和供应商的映射信息
			for (int i = oldwinner.size()-1; i >= 0; i--) {
				BidWinningRef oldgad = (BidWinningRef) oldwinner.get(i);
				super.delete(oldgad);
			}
			//保存新的中标和供应商映射信息
			BidWinningRef bwbean=new BidWinningRef();
			bwrefMng.save(bwbean,bean.getFbIdId(),Integer.valueOf(wid));
			
			
		}
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
	}



	
	/*
	 *获取原有的中标和供应商信息
	 * @author 冉德茂
	 * @createtime 2018-07-30
	 * @updatetime 2018-07-30
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}

	/*
	 * 根据id删除
	 * @author 冉德茂
	 * @createtime 2018-07-30
	 * @updatetime 2018-07-30
	 */
	@Override
	public void delete(Integer id) {
		//清除供应商的信息
		//获得已经存在的供应商信息明细
		List<Object> oldwinner = getMingxi("BidWinningRef", "fbIdId", id);
		//删除已存在中标和供应商的映射信息
		for (int i = oldwinner.size()-1; i >= 0; i--) {
			BidWinningRef oldgad = (BidWinningRef) oldwinner.get(i);
			super.delete(oldgad);
		}
		
		//清除中标和评标专家映射信息
		List<Object> oldexpert = getMingxi("BidExpertRef", "fbIdId", id);
		//删除已存在的中标和评标专家的映射信息
		for (int i = oldexpert.size()-1; i >= 0; i--) {
			BidExpertRef oldexp = (BidExpertRef) oldexpert.get(i);
			super.delete(oldexp);
		}
		//删除供应商成交记录信息
		SupplierTransactionHis suphisbean = supplierTransMng.getTrbyBidid(id);
		super.delete(suphisbean);
		
		BidRegist bean = super.findById(id);
		//更改对应招标登记的中标状态信息
		BiddingRegist processbean = cgProcessMng.findById(bean.getFbId());
		processbean.setFbidStatus("0");
		super.merge(processbean);
		//删除中标登记信息
		super.delete(bean);	

	}



	/*
	 * 根据pid查询
	 * @author 冉德茂
	 * @createtime 2018-07-19
	 * @updatetime 2018-07-19
	 */	

	@Override
	public BidRegist getBidRegistByPId(Integer pid) {
		Finder finder = Finder.create(" FROM BidRegist WHERE fpId='"+pid+"'");
		List<BidRegist> li =  super.find(finder);
		return li.get(0);
	}


}

	
	
	



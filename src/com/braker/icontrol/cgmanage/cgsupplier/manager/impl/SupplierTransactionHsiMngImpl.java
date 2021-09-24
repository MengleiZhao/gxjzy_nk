package com.braker.icontrol.cgmanage.cgsupplier.manager.impl;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierTransactionHisMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierTransactionHis;

/**
 * 供应商成交记录service实现类
 * @author 冉德茂
 * @createtime 2018-09-13
 * @updatetime 2018-09-13
 */
@Service
@Transactional
public class SupplierTransactionHsiMngImpl extends BaseManagerImpl<SupplierTransactionHis> implements SupplierTransactionHisMng {
	
	/*
	 * 分页查询(查询供应商成交记录信息  用于供应商评价)
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@Override
	public Pagination pageList(SupplierTransactionHis bean, int pageNo,int pageSize) {

		Finder finder =Finder.create("  FROM SupplierTransactionHis WHERE 1=1 ");
		if(!StringUtil.isEmpty(bean.getFsupCode())){
			finder.append(" AND fsupCode LIKE :fsupCode");
			finder.setParam("fsupCode", bean.getFsupCode());
		}
		if(!StringUtil.isEmpty(bean.getFsupName())){
			finder.append(" AND fsupName LIKE :fsupName");
			finder.setParam("fsupName", bean.getFsupName());
		}
		finder.append(" order by fhId desc");
		return super.find(finder,pageNo,pageSize);
	}
	
	/*
	 * 根据中标登记的主键id查询供应商的成交记录
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */	
	@Override
	public SupplierTransactionHis getTrbyBidid(Integer bid) {
		Finder finder = Finder.create(" FROM SupplierTransactionHis WHERE fbIdId="+bid+"");
		List<SupplierTransactionHis> li =  super.find(finder);
		return li.get(0);
	}
	/*
	 * 根据供应商id查询每个月的交易总额
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */	
	@Override
	public List<SupplierTransactionHis> getTrbyfwid(Integer fwid) {
		
		List<SupplierTransactionHis> trsuplist = new ArrayList<SupplierTransactionHis>();
		List<Object[]> trlist =new ArrayList<Object[]>();
		//查询每个月的总成交额
		String s = "select F_TR_MONTH,sum(F_TR_AMOUNT) FROM T_SUPPLIER_TRANSACTION_HIS "
					+ "WHERE F_TR_YEAR='2018' and F_W_ID="+fwid+" GROUP BY  F_TR_MONTH ";
		Query qs = getSession().createSQLQuery(s);
		trlist = qs.list();	
		for(int i=0;i<trlist.size();i++){
			SupplierTransactionHis bean=new SupplierTransactionHis();
			bean.setFtrMonth(String.valueOf(trlist.get(i)[0]));//月份
			bean.setFtrAmount(String.valueOf(trlist.get(i)[1]));//每月的成交额
			trsuplist.add(bean);
		}
		return trsuplist;
	}
	/*
	 * 根据供应商id查询每个月的交易次数
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */	
	@Override
	public List<SupplierTransactionHis> getsupamountbyfwid(Integer fwid) {
		
		List<SupplierTransactionHis> trsuplist = new ArrayList<SupplierTransactionHis>();
		List<Object[]> trlist =new ArrayList<Object[]>();
		//查询每个月的成交次数
		String s = "select F_TR_MONTH,count(F_H_ID) FROM T_SUPPLIER_TRANSACTION_HIS "
				+ "WHERE F_TR_YEAR='2018' and F_W_ID="+fwid+" GROUP BY  F_TR_MONTH ";
		Query qs = getSession().createSQLQuery(s);
		trlist = qs.list();	
		for(int i=0;i<trlist.size();i++){
			SupplierTransactionHis bean=new SupplierTransactionHis();
			bean.setFtrMonth(String.valueOf(trlist.get(i)[0]));//月份
			bean.setFtrAmount(String.valueOf(trlist.get(i)[1]));//每月的成交次数
			trsuplist.add(bean);
		}
		return trsuplist;
	}
	/*
	 * 根据供应商id和月份查询当月的成交信息
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */	
	@Override
	public List<SupplierTransactionHis> getTrSup(Integer fwid, String month) {
		List<SupplierTransactionHis> trsuplist = new ArrayList<SupplierTransactionHis>();
		List<Object[]> trlist =new ArrayList<Object[]>();
		//查询
		String s = "SELECT F_H_ID,F_W_ID,F_TR_TIME,F_SUP_CODE,F_SUP_NAME,F_PRO_NAME,F_TR_AMOUNT,F_TR_MONTH "
				+ "FROM T_SUPPLIER_TRANSACTION_HIS "
				+ "WHERE F_TR_YEAR='2018' and F_W_ID="+fwid+" and F_TR_MONTH='"+month+"' ";
		Query qs = getSession().createSQLQuery(s);
		trlist = qs.list();	
		for(int i=0;i<trlist.size();i++){
			SupplierTransactionHis bean=new SupplierTransactionHis();
			bean.setNum(i+1);//序号
			bean.setFhId(Integer.valueOf(String.valueOf(trlist.get(i)[0])));//主键id
			bean.setFwId(Integer.valueOf(String.valueOf(trlist.get(i)[1])));//供应商id
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
			try {
				bean.setFtrTime(format.parse(String.valueOf(trlist.get(i)[2])));//成交时间
			} catch (ParseException e) {
				e.printStackTrace();
			}
			bean.setFsupCode(String.valueOf(trlist.get(i)[3]));//供应商编码
			bean.setFsupName(String.valueOf(trlist.get(i)[4]));//供应商名称
			bean.setFproName(String.valueOf(trlist.get(i)[5]));//成交项目名称
			bean.setFtrAmount(String.valueOf(trlist.get(i)[6]));//成交金额
			bean.setFtrMonth(String.valueOf(trlist.get(i)[7]));//成交月份
			trsuplist.add(bean);
		}
		return trsuplist;
	}
	/*
	 * 导出供应商id和月份查询当月的成交信息
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */	
	@Override
	public List<SupplierTransactionHis> getoutputTrSup(int pageSize, int page,String sort, String order, Integer fwid, String month) {
		List<SupplierTransactionHis> trsuplist = new ArrayList<SupplierTransactionHis>();
		List<Object[]> trlist =new ArrayList<Object[]>();
		//查询
		String s = "SELECT F_H_ID,F_W_ID,F_TR_TIME,F_SUP_CODE,F_SUP_NAME,F_PRO_NAME,F_TR_AMOUNT,F_TR_MONTH "
				+ "FROM T_SUPPLIER_TRANSACTION_HIS "
				+ "WHERE F_TR_YEAR='2018' and F_W_ID="+fwid+" and F_TR_MONTH='"+month+"' ";
		Query qs = getSession().createSQLQuery(s);
		trlist = qs.list();	
		for(int i=0;i<trlist.size();i++){
			SupplierTransactionHis bean=new SupplierTransactionHis();
			bean.setNum(i+1);//序号
			bean.setFhId(Integer.valueOf(String.valueOf(trlist.get(i)[0])));//主键id
			bean.setFwId(Integer.valueOf(String.valueOf(trlist.get(i)[1])));//供应商id
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
			try {
				bean.setFtrTime(format.parse(String.valueOf(trlist.get(i)[2])));//成交时间
			} catch (ParseException e) {
				e.printStackTrace();
			}
			bean.setFsupCode(String.valueOf(trlist.get(i)[3]));//供应商编码
			bean.setFsupName(String.valueOf(trlist.get(i)[4]));//供应商名称
			bean.setFproName(String.valueOf(trlist.get(i)[5]));//成交项目名称
			bean.setFtrAmount(String.valueOf(trlist.get(i)[6]));//成交金额
			bean.setFtrMonth(String.valueOf(trlist.get(i)[7]));//成交月份
			trsuplist.add(bean);
		}
		return trsuplist;
	}


	

}

	
	
	



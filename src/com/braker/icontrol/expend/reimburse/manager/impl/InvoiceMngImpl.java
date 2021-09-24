package com.braker.icontrol.expend.reimburse.manager.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DataCloudMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.model.AppInvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceQuery;

@Service
@Transactional
public class InvoiceMngImpl extends BaseManagerImpl<AppInvoiceInfo> implements InvoiceMng{

	@Autowired
	private DataCloudMng dataColoudMng;
	
	@Override
	public String verify(InvoiceQuery bean) {
		
		//连接参数
		String host = "https://fapiao.market.alicloudapi.com";
	    String path = "/invoice/query";
	    String method = "GET";
	    String appcode = "67c8325230a2407a928d814d6fc335fb";
	    Map<String, String> headers = new HashMap<String, String>();
	    headers.put("Authorization", "APPCODE " + appcode);
	    //数据参数
	    Map<String, String> querys = new HashMap<String, String>();
	    querys.put("fpdm", bean.getFpdm());System.out.println(bean.getFpdm());
	    querys.put("fphm", bean.getFphm());
	    querys.put("kprq", bean.getKprq());
	    querys.put("checkCode", bean.getCheckCode());
	    //调用接口
	    String res = dataColoudMng.doGet(host, path, method, headers, querys);
		return res;
	}

	@Override
	public List<AppInvoiceInfo> findByRID(String type, Integer id) {
		Finder finder = Finder.create(" FROM AppInvoiceInfo WHERE fRId='"+id+"'");
		if(id != null) {
			finder.append(" AND reimbType='"+type+"'");
		}
		return super.find(finder);
	}

	
	@Override
	public List<AppInvoiceInfo> findByCostType(String type, Integer id,String costType) {
		Finder finder = Finder.create(" FROM AppInvoiceInfo WHERE fRId='"+id+"'");
		if(id != null) {
			finder.append(" AND reimbType='"+type+"'");
		}
		if(!StringUtil.isEmpty(costType)) {
			finder.append(" AND costType='"+costType+"'");
		}
		return super.find(finder);
	}
	/*
	 * 根据发票代码获取发票
	 * @author 沈帆
	 * @createtime 2020-07-03
	 * @updatetime 2020-07-03
	 */
	@Override
	public List<AppInvoiceInfo> findByCode(String code, String userId) {
		Finder finder = Finder.create(" FROM AppInvoiceInfo WHERE pFlag='0' and fInvoiceCode='"+code+"'");
		if(!StringUtil.isEmpty(userId)) {
			finder.append(" AND fUploadUserid='"+userId+"'");
		}
		return super.find(finder);
	}
	
	@Override
	public void deleteInvoice(String id) {
		getSession().createSQLQuery("update T_APP_INVOICE_INFO set P_FLAG ='99' where F_I_ID ="+id+" ").executeUpdate();
	}
}

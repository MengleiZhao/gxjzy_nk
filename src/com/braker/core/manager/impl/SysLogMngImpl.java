package com.braker.core.manager.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.SysLogMng;
import com.braker.core.model.SysLog;
@SuppressWarnings("unchecked")
@Transactional
@Service
public class SysLogMngImpl extends BaseManagerImpl<SysLog> implements SysLogMng{

	@Override
	public Pagination list(SysLog log, String sort, String order,
			int pageIndex, int pageSize) {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from SysLog Where flag='1'");
		if(null!=log){
			if(!StringUtil.isEmpty(log.getLogName())){
				f.append(" and creator.name like :name");
				f.setParam("name","%"+log.getLogName()+"%");
			}
			if(!StringUtil.isEmpty(log.getOperateContent())){
				f.append(" and operateContent like :operateContent");
				f.setParam("operateContent", "%"+log.getOperateContent()+"%");
			}
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			try {
				//操作居委
				if (!StringUtil.isEmpty(log.getJwhId())) {
					f.append(" and creator.jwh.id =:jwhId").setParam("jwhId", log.getJwhId());
				}
				//操作时间
				if(!StringUtil.isEmpty(log.getStartTime())){
					f.append(" and createTime >=:startTime").setParam("startTime",sdf.parse(log.getStartTime()));
				}
				if(!StringUtil.isEmpty(log.getEndTime())){
					f.append(" and createTime <=:endTime").setParam("endTime",sdf.parse(log.getEndTime()));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		f.append(" order by createTime desc");
		return super.find(f, pageIndex, pageSize);
	}

	@Override
	public void archive(String archiveDate) {
		// TODO Auto-generated method stub
		StringBuffer sql=new StringBuffer("insert into SYS_OPERATE_LOG_HIS");
		sql.append("(pflag,creator,createtime,pupdater,pupdatetime,operate_url,operate_content,archive_time)");
		sql.append(" select pflag,creator,createtime,pupdater,pupdatetime,operate_url,operate_content,'"+archiveDate+"' from SYS_OPERATE_LOG");
		sql.append(" Where convert(nvarchar(10),createtime,20)<'"+archiveDate+"';");
		sql.append(" delete from SYS_OPERATE_LOG Where convert(nvarchar(10),createtime,20)<'"+archiveDate+"';");
		super.getSession().createSQLQuery(sql.toString()).executeUpdate();
	}

	@Override
    public String getLocalMac() throws UnknownHostException, SocketException {
        InetAddress ia = InetAddress.getLocalHost();
        // 获取网卡，获取地址
        byte[] mac = NetworkInterface.getByInetAddress(ia).getHardwareAddress();
        StringBuffer sb = new StringBuffer("");
        for (int i = 0; i < mac.length; i++) {
            if (i != 0) {
                sb.append("-");
            }
            // 字节转换为整数
            int temp = mac[i] & 0xff;
            String str = Integer.toHexString(temp);
            if (str.length() == 1) {
                sb.append("0" + str);
            } else {
                sb.append(str);
            }
        }
        String localMAC = sb.toString().toUpperCase();
        return localMAC;
    }
	
	/**
	 * 通过HttpServletRequest返回IP地址
	 * @param request HttpServletRequest
	 * @return ip String
	 * @throws Exception
	 */
	@Override
	public String getIpAddr(HttpServletRequest request) throws Exception {
	    String ip = request.getHeader("x-forwarded-for");
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	    }
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	    }
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }
	    if ("0:0:0:0:0:0:0:1".equals(ip)) {
	    	ip = "本地";
	    }
	    return ip;
	}
	 
	 
	 
	 /**
	 * 通过IP地址获取MAC地址
	 * @param ip String,127.0.0.1格式
	 * @return mac String
	 * @throws Exception
	 */
	@Override
	public String getMACAddress(String ip) throws Exception {
	    String line = "";
	    String macAddress = "";
	    final String MAC_ADDRESS_PREFIX = "MAC Address = ";
	    final String MAC_CHINESE_ADDRESS_PREFIX = "MAC 地址 = ";
	    final String LOOPBACK_ADDRESS = "本地";
	    //如果为本地,则获取本地MAC地址。
	    if (LOOPBACK_ADDRESS.equals(ip)) {
	        InetAddress inetAddress = InetAddress.getLocalHost();
	        //貌似此方法需要JDK1.6。
	        byte[] mac = NetworkInterface.getByInetAddress(inetAddress).getHardwareAddress();
	        //下面代码是把mac地址拼装成String
	        StringBuilder sb = new StringBuilder();
	        for (int i = 0; i < mac.length; i++) {
	            if (i != 0) {
	                sb.append("-");
	            }
	            //mac[i] & 0xFF 是为了把byte转化为正整数
	            String s = Integer.toHexString(mac[i] & 0xFF);
	            sb.append(s.length() == 1 ? 0 + s : s);
	        }
	        //把字符串所有小写字母改为大写成为正规的mac地址并返回
	        macAddress = sb.toString().trim().toUpperCase();
	        return macAddress;
	    }
	    //获取非本地IP的MAC地址
	    try {
	        Process p = Runtime.getRuntime().exec("nbtstat -A " + ip);
	        InputStreamReader isr = new InputStreamReader(p.getInputStream());
	        BufferedReader br = new BufferedReader(isr);
	        while ((line = br.readLine()) != null) {
	            if (line != null) {
	                int index = line.indexOf(MAC_CHINESE_ADDRESS_PREFIX);
	                if (index != -1) {
	                    macAddress = line.substring(index + MAC_CHINESE_ADDRESS_PREFIX.length()).trim().toUpperCase();
	                }
	            }
	        }
	        br.close();
	    } catch (IOException e) {
	        e.printStackTrace(System.out);
	    }
	    return macAddress;
	}
	
}

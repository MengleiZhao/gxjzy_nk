package com.braker.core.manager.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.SystemCenterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.User;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 制度中心管理的service实现类
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
@Service
@Transactional
public class SystemCenterMngImpl extends BaseManagerImpl<CheterInfo> implements SystemCenterMng {
	@Autowired
	private AttachmentMng attachmentMng;
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public Pagination pageList(CheterInfo bean, int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM CheterInfo WHERE fstauts <>"+99+" ");
		if(!StringUtil.isEmpty(bean.getFileName())){
			finder.append(" AND fileName LIKE :fileName");
			finder.setParam("fileName", "%" + bean.getFileName() + "%");
		}
		if(!StringUtil.isEmpty(bean.getBelong())){
			finder.append(" AND belong LIKE :belong");
			finder.setParam("belong", bean.getBelong());
		}
		finder.append(" order by DATE_FORMAT(releseTime,'%Y-%m-%d') desc,clickNum desc");
		return super.find(finder,pageNo,pageSize);
	}

	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public void delete(Integer id) {
		CheterInfo bean = super.findById(id);
		bean.setFstauts("99");;
		super.saveOrUpdate(bean);
	}
	

	
	
	
	
	/*
	 * 制度的保存
	 * @author 冉德茂
	 * @createtime 2018-09-04
	 * @updatetime 2018-09-04
	 */

	@Override
	public void save(CheterInfo bean, String files, User user) {
		
		bean.setFstauts("1");//数据的删除状态   默认1  删除是99
		
		if (bean.getSystemId()==null) {
			//上传人 上传时间
			bean.setReleseUser(user.getName());
			bean.setReleseTime(new Date());
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(new Date());						
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(new Date());
		}
		
		//保存基本信息
		bean = (CheterInfo) super.merge(bean);
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		
	}

	
	/*
	 * 点击增加点击次数
	 * @author 叶崇晖
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@Override
	public void addClickNum(Integer id) {
		CheterInfo cheter = super.findById(id);
		Integer num = cheter.getClickNum();
		if(num == null) {
			num = 0;
		}
		cheter.setClickNum(num+1);
		super.saveOrUpdate(cheter);
	}

	/*
	 * 查询制度中心List
	 * @author 叶崇晖
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@Override
	public List<CheterInfo> getList() {
		Finder finder =Finder.create("  FROM CheterInfo WHERE fstauts <>"+99+" order by releseTime desc");
		Pagination e = super.find(finder,0,10000);
		return (List<CheterInfo>) e.getList();
	}

	@Override
	public void recordViewLog(CheterInfo bean) {
		// 更新浏览次数
		if (bean.getClickNum() == null) {
			bean.setClickNum(1);
		} else {
			bean.setClickNum(bean.getClickNum() + 1);
		}
		super.saveOrUpdate(bean);
	}

	@Override
	public CheterInfo findByFileName(String fileName) {
		
		Finder finder = Finder.create(" from CheterInfo where fstauts=1 and fileName=:fileName ").setParam("fileName", fileName);
		List<CheterInfo> list = super.find(finder);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public String getMaxCode() {

		StringBuilder sb= new StringBuilder(" SELECT MAX(CAST(F_HELP_NUM as SIGNED)) FROM T_SYSTEM_CENTER_INFO ");
		List<Integer> codeList = getSession().createSQLQuery(sb.toString()).list();
		
		if (codeList != null && codeList.get(0)!=null) {
			//序号加一
			Integer codeInt = Integer.valueOf(String.valueOf(codeList.get(0)));
			codeInt++;
			String codeStr = String.valueOf(codeInt);
			//补齐4位前缀
			while (codeStr.length() < 4) {
				codeStr = "0" + codeStr;
			}
			return codeStr;
		} else {
			return "0001";
		}
	}
	
	
	@Override
	public List<CheterInfo> getFileNamList(String fileName,String belong,String more) {
		Finder finder = Finder.create(" from CheterInfo where fstauts=1");
		if(!StringUtil.isEmpty(fileName)){
			finder.append(" and fileName like:fileName").setParam("fileName", "%" + fileName + "%");
		}
		if(!StringUtil.isEmpty(more)){
			finder.append(" and fileName not like:fileName").setParam("fileName", "%" + more + "%");
		}
		if(!(StringUtil.isEmpty(belong)) && !(belong.equals("All"))){
			finder.append(" and belong !=:belong").setParam("belong", belong);
		}
		finder.append(" order by releseTime desc");
		List<CheterInfo> list = super.find(finder);
		if (list != null && list.size() > 0) {
			return list;
		}
		return null;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

	
	
	



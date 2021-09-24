package com.braker.icontrol.contract.Formulation.manager.Impl;

import java.util.Date;
import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.contract.Formulation.manager.SealInfoMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.Formulation.model.SealInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class SealInfoMngImpl extends BaseManagerImpl<SealInfo> implements SealInfoMng {

	@Autowired
	private AttachmentMng attachmentMng;
	
	@Override
	public void save(SealInfo bean, Integer id, User user,String type,ContractBasicInfo cbiBean,Upt uptbean,String files,String ygzhtwbfiles,String bgygzhtwbfiles) {
		if(bean.getFsId() == null) {
			//创建人、创建时间 
			bean.setCreator(user.getName());
			bean.setCreateTime(bean.getFappTime());
			
			//盖章人id
			bean.setFappUserId(user.getId());
			//自动生成编号
			String str = "HTGZ";
			bean.setFsCode(StringUtil.Random(str));
			//设置盖章信息与合同外键关联
			bean.setFcId(id);
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(bean.getFappTime());
		}
		
		if("1".equals(type)){
			if(uptbean.getfSignTime()==null || StringUtil.isEmpty(bgygzhtwbfiles)){
				throw new ServiceException("请完善签订日期和已盖章合同文本！");
			}
			uptbean.setFsealedStatus("1");
			//保存附件信息
			attachmentMng.joinEntity(uptbean,bgygzhtwbfiles);
			super.merge(uptbean);
			cbiBean.setfUpdateStatus("1");
			super.merge(cbiBean);
		}else{
			if(cbiBean.getfSignTime()==null || StringUtil.isEmpty(ygzhtwbfiles)){
				throw new ServiceException("请完善签订日期和已盖章合同文本！");
			}
			cbiBean.setFsealedStatus(1);
			//保存附件信息
			attachmentMng.joinEntity(cbiBean,ygzhtwbfiles);
			super.merge(cbiBean);
		}
		//保存基本信息
		bean = (SealInfo) super.saveOrUpdate(bean);
	}

	@Override
	public Integer findFsIdByFcId(Integer id) {
		Integer fsId = null;
		StringBuilder builder = new StringBuilder();
		builder.append("SELECT F_SEAL_ID FROM T_CONTRACT_SEAL_INFO WHERE F_CONT_ID = "+id);
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<Integer> fsIdList = query.list();
		if(fsIdList != null && fsIdList.size() > 0){
			fsId = fsIdList.get(0);
		}
		return fsId;
	}

}

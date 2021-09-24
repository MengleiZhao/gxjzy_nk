package com.braker.icontrol.budget.declare.manager.impl;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.data.manager.AnalysisProBasicInfoMng;
import com.braker.icontrol.budget.declare.entity.ProjectReviewInfo;
import com.braker.icontrol.budget.declare.manager.ProjectReviewMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 
 * <p>Description: 项目评审的service实现类</p>
 * @author:安达
 * @date： 2019年5月29日下午2:36:54
 */
@Service
@Transactional
public class ProjectReviewMngImpl extends BaseManagerImpl<ProjectReviewInfo> implements ProjectReviewMng {
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;

	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private AnalysisProBasicInfoMng analysisProMng;
	
	/**
	 * 项目评审列表信息查询
	 * @author 叶崇晖
	 * @param bean为项目model
	 * @param user为当前登录人
	 * @param type查询类型0为未评审项目，1为已评审、待评审和已退回项目
	 * @return 返回项目的List
	 */
	@Override
	public List<TProBasicInfo> pageList(TProBasicInfo bean, User user, String type,String ymlx) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0') ");
		//19为项目申报审批通过，2为项目库类为上报库
		finder.append(" and FFlowStauts='19' and FProLibType='2'");
		if("0".equals(type)) {
			finder.append(" and FExt6 in('0')");
		} else if ("1".equals(type)) {
			finder.append(" and FExt6 in('1')");
		}
		//预算支出类型     区分基本支出或项目支出：0-基本支出，1-项目支出
		if(!StringUtil.isEmpty(String.valueOf(bean.getFProOrBasic()))) {
			finder.append(" and FProOrBasic = :FProOrBasic").setParam("FProOrBasic", bean.getFProOrBasic());
		}
 		if(!StringUtil.isEmpty(bean.getPlanStartYear())) {//预算年度
 			finder.append(" and planStartYear like :planStartYear").setParam("planStartYear", "%" + bean.getPlanStartYear() + "%");
 		}
		if (!StringUtil.isEmpty(bean.getFProCode())) {
			finder.append(" and FProCode like :FProCode").setParam("FProCode", "%" + bean.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {
			finder.append(" and FProName like :FProName").setParam("FProName", "%" + bean.getFProName() + "%");
		}
		if(!StringUtil.isEmpty(bean.getFProAppliPeople())){//人
			finder.append(" and FProAppliPeople=:FProAppliPeople").setParam("FProAppliPeople", bean.getFProAppliPeople());
		}
		if(!StringUtil.isEmpty(bean.getFProAppliDepart())){//部门
			finder.append(" and FProAppliDepart like :FProAppliDepart").setParam("FProAppliDepart","%" + bean.getFProAppliDepart()+"%");
		}
		/*if (!StringUtil.isEmpty(bean.getPlanStartYear1())) {
			finder.append(" and planStartYear >= :planStartYear1").setParam("planStartYear1", bean.getPlanStartYear1());
		}
		if (!StringUtil.isEmpty(bean.getPlanStartYear2())) {
			finder.append(" and planStartYear <= :planStartYear2").setParam("planStartYear2", bean.getPlanStartYear2());
		}*/
		if("0".equals(type)&&"yssb".equals(ymlx)){
			finder.append(" and FProAppliDepartId = '"+user.getDepart().getId()+"'");
		}
		finder.append(" order by FProId desc");
		return super.find(finder);
	}


	
	/**
	 * 字节流复制方法
	 * 复制模板，并将写好的HSSFWorkbook通过输出流写入新的文件
	 * @author 叶崇晖
	 * @param src输入文件地址
	 * @param dest输出文件地址
	 * @param wb写好的POIexcel文件
	 * @throws IOException
	 */
	public void copy(String src,String dest, HSSFWorkbook wb) throws IOException{
		FileInputStream reader=null;
		FileOutputStream writer=null;
		try {
			 reader = new FileInputStream(src);
			 writer = new FileOutputStream(dest,false);
			 wb.write(writer);
			 writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
			//关闭流
			if(writer!=null){
				writer.close();
			}
			if(reader!=null){
				reader.close();
			}
		}
		
		
		
	}


	
	@Override
	public Pagination reviewPage(ProjectReviewInfo bean, int pageNo, int pageSize) {
		StringBuilder builder=new StringBuilder();
		builder.append("select * FROM  T_PRO_REVIEW_INFO tpri  order by F_R_ID desc");
		return super.findBySql( bean,builder.toString(), pageNo, pageSize);
	}

	/**
	 * 保存需要上报的项目
	 * @author 安达
	 * @param fproIdList是需要评审的id集合
	 */
	@Override
	public void saveReview(String sbIdList, String lxIdList, String files,User user) {
		BigDecimal sbMount=BigDecimal.ZERO; //申报总金额
		Integer sbCount=0;  //申报项目数
		//上报
		String[] sbStrarray = sbIdList.split(",");
		if(sbStrarray.length>0&& StringUtils.isNotEmpty(sbStrarray[0])){
			for (int i = 0; i < sbStrarray.length; i++) {
				TProBasicInfo proBean= tProBasicInfoMng.findById(Integer.valueOf(sbStrarray[i]));
				proBean.setFExt6("2");//项目评审状态   0、未评审 1、待评 2、已通过 -1、已退回
				proBean.setFExt8(DateUtil.formatDate(new Date()));//评审时间   年-月-日
				proBean.setFExt4("11");//上报状态   10、一上未申报   11、一上已申报    20、二上未申报   21、二上已申报
				proBean.setFProLibType("2");////所属库 1：备选库 2：上报库   3：执行中 4：已完结
				proBean.setFFlowStauts("29");//所有通过评审的项目进入一下控制数分解页面
				
				sbMount =sbMount.add(proBean.getFProBudgetAmount()); //上报金额
				sbCount++;
				//给项目申报人发送消息
				String title="项目评审通过消息";
				String msg="您申报的项目:"+proBean.getFProName()+"(项目编号："+proBean.getFProCode()+")已评审通过,评审时间:"+DateUtil.formatDate(new Date(),"yyyy-MM-dd HH:mm:ss")+"。";
				String userId=proBean.getUserId();
				privateInforMng.setMsg(title, msg, userId,"2");
				proBean = (TProBasicInfo) super.saveOrUpdate(proBean);
				//保存一条数据到数据分析的表里
				analysisProMng.copyProBasicInfo(proBean, 2);
			}
		}
		
		//落选
		String[] lxStrarray = lxIdList.split(",");
		if(lxStrarray.length>0 && StringUtils.isNotEmpty(lxStrarray[0])){
			for (int i = 0; i < lxStrarray.length; i++) {
				TProBasicInfo proBean= tProBasicInfoMng.findById(Integer.valueOf(lxStrarray[i]));
				proBean.setFExt6("-1");//项目评审状态   0、未评审 1、待评 2、已通过 -1、已退回
				proBean.setFExt8(DateUtil.formatDate(new Date()));//评审时间   年-月-日
				proBean.setFExt4("0");//上报状态   10、一上未申报   11、一上已申报    20、二上未申报   21、二上已申报
				proBean.setFProLibType("1");////所属库 1：备选库 2：上报库   3：执行中 4：已完结
				proBean.setFFlowStauts("0");//所有通过评审的项目进入一下控制数分解页面
				
				sbMount =sbMount.add(proBean.getFProBudgetAmount()); //上报金额
				sbCount++;
				//给项目申报人发送消息
				String title="项目评审落选消息";
				String msg="您申报的项目:"+proBean.getFProName()+"(项目编号："+proBean.getFProCode()+")评审未通过,该项目已回退至备选库中。评审时间:"+DateUtil.formatDate(new Date(),"yyyy-MM-dd HH:mm:ss")+"。";
				String userId=proBean.getUserId();
				privateInforMng.setMsg(title, msg, userId,"3");
				proBean = (TProBasicInfo) super.saveOrUpdate(proBean);
				//保存一条数据到数据分析的表里
				analysisProMng.copyProBasicInfo(proBean, 2);
			}
		}
		//添加评审记录
		insertPsHistory( sbIdList,  lxIdList, sbMount.doubleValue(), sbCount,  files, user );
	}
	
	/**
	 * 
	* @author:安达
	* @Title: insertPsHistory 
	* @Description: 添加评审记录
	* @param sbIdList
	* @param lxIdList
	* @return void    返回类型 
	* @date： 2019年5月29日上午9:51:21 
	* @throws
	 */
	private void insertPsHistory(String sbIdList, String lxIdList,Double sbMount,Integer sbCount, String files,User user ){
		ProjectReviewInfo  info=new ProjectReviewInfo();
		info.setCreateTime(new Date());  //创建时间
		info.setReviewTime(new Date());  //申报时间
		info.setOperator(user.getName());  //申报操作人
		info.setOperatorId(user.getId());  //申报操作人id
		info.setSbIds(sbIdList);   //申报通过的ids
		info.setLxIds(lxIdList);  //申报落选的ids
		info.setSbMount(sbMount); //申报总金额
		info.setSbCount(sbCount);  //申报项目总数
		info.setSbYear(String.valueOf(Integer
				.valueOf(new SimpleDateFormat("yyyy").format(new Date())) + 1));
		info=(ProjectReviewInfo) super.saveOrUpdate(info);
		//保存附件信息
		attachmentMng.joinEntity(info,files);
	}



	@Override
	public List<TProBasicInfo> reviewDetail(TProBasicInfo bean) {
		List<ProjectReviewInfo> reviewInfoList = findBySbIds();
		//上报通过的集合
		List<TProBasicInfo> sbList =null;
		//上报落选的集合
		List<TProBasicInfo> lxList =null;
		List<TProBasicInfo> list = new ArrayList<TProBasicInfo>();
		for(ProjectReviewInfo reviewInfo:reviewInfoList){
			String sbId = reviewInfo.getSbIds(); //上报通过的id
			String lxId = reviewInfo.getLxIds(); //上报落选的id
			if(StringUtils.isNotEmpty(sbId)){
					//上报通过的集合
					sbList = tProBasicInfoMng.getbasiProByIds(sbId);
					for(TProBasicInfo basicInfo:sbList){
						basicInfo.setAccessoryId(String.valueOf(reviewInfo.getrId()));
					}
					list.addAll(sbList);
			}
			if(StringUtils.isNotEmpty(lxId)){
				//上报落选的集合
				lxList = tProBasicInfoMng.getbasiProByIds(lxId);
				for(TProBasicInfo basicInfo:lxList){
					basicInfo.setAccessoryId(String.valueOf(reviewInfo.getrId()));
				}
				list.addAll(lxList);
			}
			
		}
		return list;
	}



	@Override
	public List<ProjectReviewInfo> findBySbIds() {
		Finder finder = Finder.create(" from ProjectReviewInfo order by sbYear desc");
		
		
		return (List<ProjectReviewInfo>) super.find(finder);
	}



	@Override
	public List<ProjectReviewInfo> findByLxIds(String lxIds) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public void saveReviewBigProName(String FProId, String bigProName) {
		TProBasicInfo proBean= tProBasicInfoMng.findById(Integer.valueOf(FProId));
		proBean.setBigProName(bigProName);
		tProBasicInfoMng.saveOrUpdate(proBean);
	}
	
	
}
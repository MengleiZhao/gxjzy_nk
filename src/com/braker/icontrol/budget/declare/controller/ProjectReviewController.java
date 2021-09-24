package com.braker.icontrol.budget.declare.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.SortList;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.declare.entity.ProjectReviewInfo;
import com.braker.icontrol.budget.declare.manager.ProjectReviewMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 预算管理申报库项目评审的控制层
 * @author 叶崇晖
 * @createtime 2018-10-09
 * @updatetime 2018-10-09
 */
@Controller
@RequestMapping(value = "/projectReview")
public class ProjectReviewController extends BaseController {
	@Autowired
	private ProjectReviewMng projectReviewMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		model.addAttribute("currentYear", Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date()))+1);
		return "/WEB-INF/view/budget/project/project-review-list";
	}
	
	/*
	 * 项目评审报列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@RequestMapping(value = "/projectPage")
	@ResponseBody
	public List<TProBasicInfo> yssbProjectPage(TProBasicInfo bean, String type,String ymlx,ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	List<TProBasicInfo> list = projectReviewMng.pageList(bean, getUser() ,type,ymlx);
    	if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page*rows+i-9);
				//pro.setFExt6("2");
				pro.setFExt8(DateUtil.formatDate(new Date()));//评审时间   年-月-日
			}
		}
    	return list;
	}
	
	
	/**
	 * 
	* @author:安达
	* @Title: saveReview 
	* @Description: 项目评审提交保存
	* @param model
	* @param sbIdList
	* @param lxIdList
	* @param attIds
	* @return
	* @return Result    返回类型 
	* @date： 2019年5月29日上午10:32:16 
	* @throws
	 */
	@RequestMapping(value = "/saveReview")
	@ResponseBody
	public Result saveReview( ModelMap model,String sbIdList, String lxIdList, String files) {
		try {
			projectReviewMng.saveReview(sbIdList, lxIdList, files,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	
	/**
	 * 项目审批记录查询
	 * @author 叶崇晖
	 * @param bean
	 * @param model
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value = "/reviewPage")
	@ResponseBody
	public JsonPagination reviewPage(ProjectReviewInfo bean, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = projectReviewMng.reviewPage(bean, page, rows);
    	List<ProjectReviewInfo> list=(List<ProjectReviewInfo>) p.getList();
    	for (int i = 0; i < list.size(); i++) {
    		ProjectReviewInfo pro = list.get(i);
			pro.setNum(i+1);
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 
	* @author:安达
	* @Title: reviewDetail 
	* @Description: 项目评审页面
	* @param model
	* @param id  
	* @return
	* @return String    返回类型 
	* @date： 2019年5月29日下午3:01:01 
	* @throws
	 */
	@RequestMapping(value = "/reviewDetail")
	public String  reviewDetail(ModelMap model, Integer id) {
		ProjectReviewInfo pro = projectReviewMng.findById(Integer.valueOf(id));
		List<Attachment> attaList = attachmentMng.list(pro);
		model.addAttribute("attaList", attaList);
		model.addAttribute("id", id);
		return "/WEB-INF/view/budget/project/project-review-detail";
	}
	
	/**
	 * 
	* @author:安达
	* @Title: reviewDetailList 
	* @Description: 明细列表
	* @param id
	* @return
	* @return List<TProBasicInfo>    返回类型 
	* @date： 2019年5月29日下午3:33:00 
	* @throws
	 */
	@RequestMapping(value = "/reviewDetailList")
	@ResponseBody
	public List<TProBasicInfo> reviewDetailList(TProBasicInfo bean) {
		List<TProBasicInfo> list = projectReviewMng.reviewDetail(bean);
		SortList<TProBasicInfo> sort=new SortList<TProBasicInfo>();
		sort.Sort(list, "getFProId", "desc","number");
		for (int i = 0; i < list.size(); i++) {
			TProBasicInfo pro = list.get(i);
			pro.setPageOrder(i+1);
		}
    	return list;
	}
	
	/*
	 * 跳转修改
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id, String logType,String foCode,
			ModelMap model, String remark) {
		try {
			User user = getUser();
			// 查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
			model.addAttribute("cheterInfo", cheterInfo);

			model.addAttribute("operation", "detail");// 操作类型
			TProBasicInfo pro =new TProBasicInfo();
			if( !StringUtils.isEmpty(id) && !"undefined".equals(id)){
				pro= tProBasicInfoMng.findById(Integer.valueOf(id));
			}else if(!StringUtils.isEmpty(foCode) ){
				pro= tProBasicInfoMng.findbyCode(foCode);
			}
			model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
			model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
			if (pro.getFProAppliTime() != null)
				model.addAttribute("sbsj",
						new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
			// 备用字段
			model.addAttribute("remark", remark);

			model.addAttribute("bean", pro);// 项目实体
			// 查询附件信息
			List<Attachment> attaList = attachmentMng.list(pro);
			model.addAttribute("attaList", attaList);
			//一上申报审批流
			if("21".equals(pro.getFFlowStauts()) || "29".equals(pro.getFFlowStauts()) || "-21".equals(pro.getFFlowStauts())){
				if(pro.getFProOrBasic()==0){
					//基本支出
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"JBZCSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(), pro.getJoinTable(), pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==1){
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"XMSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(), pro.getJoinTable(), pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("XMSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
					
				}
			}else if("31".equals(pro.getFFlowStauts()) || "39".equals(pro.getFFlowStauts()) || "-31".equals(pro.getFFlowStauts())){//二上申报审批流
				if(pro.getFProOrBasic()==0){
					//基本支出
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"JBZCESSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCESSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==1){
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"ESSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ESSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}
				
			}else{
				//查询工作流
				if(pro.getFProOrBasic()==0){
					//基本支出
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"JBZCSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==1){
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"XMSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("XMSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==2){
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"ZXMSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZXMSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}
			}
			
			//对象编码
			model.addAttribute("foCode",pro.getBeanCode());	
			// 建立工作流发起人的信息
			Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
			model.addAttribute("proposer", proposer);

			model.addAttribute("logType", logType);
			return "/WEB-INF/view/budget/project/project-add-review";
		} catch (Exception e) {
			
		}
		return null;
	}
	
	/**
	 * 
	* @author:zml
	* @Title: saveReviewBigProName 
	* @Description: 提交保存评审中的大项目信息
	* @param model
	* @return Result    返回类型 
	* @date： 2019年5月29日上午10:32:16 
	* @throws
	 */
	@RequestMapping(value = "/saveReviewBigProName")
	@ResponseBody
	public Result saveReviewBigProName( ModelMap model,String FProId,String bigProName) {
		try {
			projectReviewMng.saveReviewBigProName(FProId,bigProName);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
}

package com.braker.icontrol.budget.adjust.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;
import com.braker.icontrol.budget.adjust.manager.OutsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexExteAdLstMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 预算外部修改审批的控制层
 * @author 叶崇晖
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */
@Controller
@RequestMapping(value = "/outsideCheck")
public class OutsideCheckController extends BaseController {
	@Autowired
	private OutsideAdjustMny adjustMny;
	
	@Autowired
	private UserMng userMng;
	
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TIndexExteAdLstMng adLstMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/budget/adjust/outside-check-list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value = "/adjustPage")
	@ResponseBody
	public JsonPagination adjustPage(TIndexExteAd bean, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	
    	Pagination p = adjustMny.checkPageList(bean, page, rows, getUser());
    	//序号设置	
    	List<TIndexExteAd> li = (List<TIndexExteAd>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
    		li.get(i).setNum((i+1)+(page-1)*rows);
    		String indexName="";
    		BigDecimal changeAmount=BigDecimal.ZERO;
    		List<TIndexExteAdLst> adLstlist = adLstMng.findByAid(li.get(i).getaId()+"");
    		if(adLstlist!=null && adLstlist.size()>0){
    			for(int j=0;j<adLstlist.size();j++){
	    			if("".equals(indexName)){
	    				indexName=adLstlist.get(j).getIndexName();
	    			}else{
	    				indexName=indexName+" | "+adLstlist.get(j).getIndexName();
	    			}
	    			if(adLstlist.get(j).getChangeAmount() !=null){
	    				changeAmount=changeAmount.add(adLstlist.get(j).getChangeAmount());
	    			}
	    			
    			}	
    		}
    		li.get(i).setIndexName(indexName);
			li.get(i).setChangeAmount(changeAmount);
		}
    	
    	
    	return getJsonPagination(p, page); 
	}
	
	/*
	 * 跳转审批页面
	 * @author 叶崇晖
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/check")
	public String check(Integer id ,ModelMap model) {
		//传回来的id是主键
		TIndexExteAd bean = adjustMny.findById(id);
		model.addAttribute("bean", bean);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WBZBDZ", bean.getDeptCode(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getOutCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		String departName=departMng.findDeptByUserId(bean.getOpUser())[1];
		Proposer proposer = new Proposer(bean.getOpUser(), departName, bean.getOpTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("NBZBDZ", bean.getDeptCode());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		model.addAttribute("detail", "1");
		
		//查询制度中心文件
    	List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("外部指标调整审批");
    	model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/budget/adjust/outside-check";
	}
	
	/*
	 * 审批结果
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,TIndexExteAd bean,String spjlFile) {
		try {
			adjustMny.saveCheckInfo(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
}

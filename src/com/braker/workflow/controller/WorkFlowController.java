package com.braker.workflow.controller;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.RoleDepartUser;
import com.braker.core.model.User;
import com.braker.workflow.entity.TLinkData;
import com.braker.workflow.entity.TLinkRule;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TLinkRuleMng;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

@Controller
@RequestMapping("/wflow")
public class WorkFlowController extends BaseController {
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private TLinkRuleMng tLinkRuleMng;
	
	
	/**
	 * 跳转到流程定义list页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-29
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/gwideal_core/workflow/workflow_list";
	}
	
	/**
	 * 加载流程定义list页面的数据
	 * @param tProcessDefin 搜索条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-29
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(TProcessDefin tProcessDefin,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = tProcessDefinMng.list(tProcessDefin, page, rows);
		List<TProcessDefin> li= (List<TProcessDefin>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
			
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * 跳转到新增流程的页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-29
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		model.addAttribute("openType", "add");
		TProcessDefin tpd=new TProcessDefin();
		tpd.setFPCode(String.valueOf(StringUtil.random8()));
		model.addAttribute("bean", tpd);
		return "/WEB-INF/gwideal_core/workflow/workflow_add";
	}
	/**
	 * /wflow/designFlow
	 * 跳转到设计流程的页面
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-04-9
	 */
	@RequestMapping("/designFlow")
	public String designFlow(ModelMap model,Integer flowId){
		try {
			String flowJson=tNodeLinkMng.getGraphLinksModelByFlowId(flowId);
			model.addAttribute("flowId", flowId);
			model.addAttribute("flowJson", flowJson);
			return "/WEB-INF/gwideal_core/workflow/designFlow";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/gwideal_core/workflow/designFlow";
			// TODO: handle exception
		}
		
	}
	/**
	 * /wflow/bindingRole
	 * 弹出选择部门，角色，人的页面
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-04-19
	 */
	@RequestMapping("/bindingRole")
	public String bindingRole(ModelMap model,String nodeJson){
		try {
			//转码，处理中文乱码问题
			nodeJson = new String(nodeJson.getBytes("ISO8859-1"), "utf-8");
			JSONObject jsonObject = JSONObject.fromObject(nodeJson);  //转换成json对象
			TNodeData node= (TNodeData) JSONObject.toBean(jsonObject, TNodeData.class);
			model.addAttribute("node", node);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/WEB-INF/gwideal_core/workflow/bindingRole";
	}
	/**
	 * /wflow/bindingRole
	 * 弹出选择部门，角色，人的页面
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-04-19
	 */
	@RequestMapping("/bindingUser")
	public String bindingUser(ModelMap model){
		return "/WEB-INF/gwideal_core/workflow/bindingUser";
	}
	
	/**
	 * /wflow/editLink
	 * 弹出连线配置的页面
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-04-19
	 */
	@RequestMapping("/editLink")
	public String editLink(ModelMap model,Integer flowId,Integer fromKey,Integer toKey){
		try {
			model.addAttribute("flowId", flowId);
			
			model.addAttribute("fromKey", fromKey);
			model.addAttribute("toKey", toKey);
			model.addAttribute("bean", tProcessDefinMng.findById(Integer.valueOf(flowId)));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/WEB-INF/gwideal_core/workflow/editLink";
	}
	
	@RequestMapping(value = "/findByFlowIdAndKey")
	@ResponseBody
	public JsonPagination findByFlowIdAndKey(Integer flowId,Integer fromKey,Integer toKey) {
		try {
			Pagination p = new Pagination();
			List<TLinkRule> list=tLinkRuleMng.findByFlowIdAndKey(flowId,fromKey,toKey);
			p.setList(list);
			return getJsonPagination(p, 0);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	/**
	 * /wflow/saveNode
	 * 保存流程节点信息
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-04-23
	 */
	@ResponseBody
	@RequestMapping("/saveNode")
	public String saveNode(ModelMap model,Integer flowId,String flowJson){
		try {
			tNodeLinkMng.saveNodeAndLink(flowId,flowJson);
		} catch (Exception e) {
			e.printStackTrace();
			return "保存完毕";
			// TODO: handle exception
		}
		return "";
	}
	
	/**
	 * /wflow/saveNode
	 * 保存流程节点信息
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-04-23
	 */
	@ResponseBody
	@RequestMapping("/saveRule")
	public String saveRule(ModelMap model,Integer flowId,Integer fromKey,Integer toKey,String ruleJson){
		try {
			tLinkRuleMng.saveLinkRule(flowId,fromKey,toKey,ruleJson);
		} catch (Exception e) {
			e.printStackTrace();
			return "保存完毕";
			// TODO: handle exception
		}
		return "";
	}
	
	/**
	 * /wflow/history
	 * 历史审批记录
	 * @author 安达
	 * @createtime 2019-04-26
	 * @updatetime 2019-04-26
	 */
	@RequestMapping(value = "/history")
	@ResponseBody
	public JsonPagination checkHistory(Integer fpId, String foCode) {
		try {
			Pagination p = new Pagination();
			p.setList(tProcessCheckMng.checkHistory(fpId,foCode));
			return getJsonPagination(p, 0);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		}
		
	}
	
	/**
	 * 弹出选择部门页面
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/departCodeList")
	public String receCodeList(ModelMap model){
		return "/WEB-INF/gwideal_core/workflow/workflow_nameAndDept";
	}
	
	/**
	 * 加载项目部门信息
	 * @param user
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/NameAndDepart")
	@ResponseBody
	public List<Depart> allocaNameAndDeptList(Depart bean,String sort,String order,ModelMap model){
		List<Depart> list = departMng.findAllDepart(bean, sort, order);
		return list;
	}
	
	/**
	 * 查询字典里相应数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = tProcessDefinMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
	/**
	 * 保存工作流
	 * @param tProcessDefin 工作流详情
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/TProcessDefinSave")
	@ResponseBody
	public Result tProcessDefinSave(TProcessDefin tProcessDefin,ModelMap model){
		try {
			if(StringUtil.isEmpty(tProcessDefin.getFPName())){
				return getJsonResult(false, "请填写流程显示名称！");
			}else if(StringUtil.isEmpty(tProcessDefin.getFPCode())){
				return getJsonResult(false, "请填写流程定义代码！");
			}else if(StringUtil.isEmpty(tProcessDefin.getDepartName())){
				return getJsonResult(false, "请选择部门！");
			}else if(StringUtil.isEmpty(tProcessDefin.getFBusiArea())){
				return getJsonResult(false, "请选择业务范围！");
			}else if(tProcessDefin.getFStauts().equals("1")&&StringUtil.isEmpty(String.valueOf(tProcessDefin.getFPId()))){
				return getJsonResult(false, "请先定义流程具体内容！");
			}else if(tProcessDefin.getFStauts().equals("1")&&!StringUtil.isEmpty(String.valueOf(tProcessDefin.getFPId()))){
				List<TNodeData> nodeList=tNodeDataMng.findByFlowId(tProcessDefin.getFPId());
				if(nodeList.size()<=0){
					return getJsonResult(false, "请先定义流程具体内容！");
				}else {
					tProcessDefinMng.save(tProcessDefin, getUser());
					return getJsonResult(true, "操作成功！");
				}
			}else{
				tProcessDefinMng.save(tProcessDefin, getUser());
				return getJsonResult(true, "操作成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
	}
	
	/**
	 * 跳转到修改页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "edit");
		model.addAttribute("bean",tProcessDefinMng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/workflow/workflow_add";
	}
	
	/**
	 * 跳转到详情页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "detail");
		model.addAttribute("bean",tProcessDefinMng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/workflow/workflow_add";
	}
	
	/**
	 * 根据id删除
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			tProcessDefinMng.deleteById(id);
			return getJsonResult(true, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
	}
	
	
	/**
	 * 弹出选择部门，角色，人的页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-03
	 */
	@RequestMapping("/nameDepartRole")
	public String nameDepartRole(String id,ModelMap model){
		model.addAttribute("id", id);
		return "/WEB-INF/gwideal_core/ProcessMonitoring/monitoring_nameDeptRole";
	}
	

	/**
	 * 节点配置是选择处理人(根据角色+部门查询)
	 * @param bean
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/wfNameAndDepart")
	@ResponseBody
	public JsonPagination wfNameAndDeptList(String roleName,String departName,ModelMap model){
		Pagination p = new Pagination();
		try {
			List<RoleDepartUser> roleDepartUserList=userMng.wfNameAndDepart(roleName,departName);
	    	p.setList(roleDepartUserList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getJsonPagination(p, 1);
	}
	
	/**
	 * 查询所有人user
	 * @param roleName
	 * @param departName
	 * @param model
	 * @return
	 */
	@RequestMapping("/allUser")
	@ResponseBody
	public JsonPagination nameAndDeptList(String roleName,String departName,ModelMap model){
		Pagination p = new Pagination();
		try {
			User user = new User();
			user.setName(roleName);
			Depart depart = new Depart();
			depart.setName(departName);
			user.setDepart(depart );
			List<RoleDepartUser> roleDepartUserList=userMng.getALL(user);
			p.setList(roleDepartUserList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getJsonPagination(p, 1);
	}
	
	
	/**
	 * /wflow/showFlowDesinger
	 * 弹出流程进度页面
	 * @param model
	 * @return
	 * @author 安达
	 * @createtime 2019-09-11
	 */
	@RequestMapping("/showFlowDesinger")
	public String showFlowDesinger(Integer flowId,Integer nextKey,ModelMap model){
		try {
			String	flowJson = tNodeLinkMng.getGraphLinksModelByFlowId(flowId);
			model.addAttribute("flowId", flowId);
			model.addAttribute("nextKey", nextKey);
			model.addAttribute("flowJson", flowJson);
			return "/WEB-INF/gwideal_core/workflow/flowdesinger";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/WEB-INF/gwideal_core/workflow/flowdesinger";
	}
}

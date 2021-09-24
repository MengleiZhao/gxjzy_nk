package com.braker.core.controller;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

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
import com.braker.common.security.CodeHelper;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.common.web.init.InitFacade;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Role;
import com.braker.core.model.User;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private RoleMng roleMng;
	
	@Autowired
	private DepartMng departMng;
	
	@RequestMapping(value="/refInspectorList")
	public String refInspectorList(ModelMap model){
		return "/WEB-INF/gwideal_core/user/ref_inspector_list";
	}
	
	@RequestMapping(value="/refInspectorJsonPagination")
	@ResponseBody
	public JsonPagination refInspectorJsonPagination(User bean,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=userMng.refInspectorList(bean,sort,order,page,rows,hasRole("QU_ROLE"),isStreetRole(),getUser());
		return getJsonPagination(p,page);
	}
	
	@RequestMapping("/list")
	public String list(ModelMap model) {
		try {
			//model.addAttribute("listStreet", listStreet());
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return "/WEB-INF/gwideal_core/user/user_list";
	}
	
	@RequestMapping(value="/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(User bean,String departId,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	try {
    		Pagination p=userMng.list(bean,departId,sort,order,page,rows);
    		model.addAttribute("departId",departId);
    		return getJsonPagination(p,page);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	//用于差旅出行人员选择
	@RequestMapping(value="/jsonPaginationTravel")
	@ResponseBody
	public JsonPagination jsonPaginationTravel(User bean,String departId,String sort,String order,Integer page,Integer rows,ModelMap model){
		try {
			if(page==null){page=1;}
	    	if(rows==null){rows=1000;}
			Pagination p=userMng.listTravel(bean,departId,sort,order,page,rows);
			model.addAttribute("departId",departId);
			return getJsonPagination(p,page);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	/**
	 * 短信接收人选择列表
	 */
	@RequestMapping(value="/jsonPaginationMsgReceiver")
	@ResponseBody
	public JsonPagination jsonPaginationMsgReceiver(User bean,String departId,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=userMng.list(bean,departId,sort,order,page,rows);
		//剔除没有手机号的用户数据
		for(int i=0,k=p.getList().size(); i<k; i++){
			User user = (User) p.getList().get(i);
			if(StringUtil.isEmpty(user.getMobileNo())){
				 p.getList().remove(i);
				 i--;
				 k--;
			}
		}
		model.addAttribute("departId",departId);
		return getJsonPagination(p,page);
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model) {
		User user = userMng.findById(id);
		String a = "";
		for(int i=0;i<user.getRoles().size();i++){
			if("".equals(a)){
				a=user.getRoles().get(i).getId();
			}else{
				a =a+","+ user.getRoles().get(i).getId();
			}
			
		}
		model.addAttribute("type", "edit");
		model.addAttribute("beans",a);
		model.addAttribute("bean",user);
		List<Depart> listDepart=departMng.getRoots();
		model.addAttribute("listRole",roleMng.getAll(listDepart.get(0).getId()));
		return "/WEB-INF/gwideal_core/user/user_edit";
	}
	
	@RequestMapping("/add")
	public String add(String departId,ModelMap model) {
		try {
			model.addAttribute("departId",departId);
			List<Depart> listDepart=departMng.getRoots();
			model.addAttribute("listRole",roleMng.getAll(listDepart.get(0).getId()));
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return "/WEB-INF/gwideal_core/user/user_edit";
	}
	
	@RequestMapping("/editPwd")
	public String editPwd() {
		return "/WEB-INF/gwideal_core/user/user_editPwd";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Result save(User bean,String roleIds,ModelMap model) {
		try {
			if(userMng.isExist(bean)){
				return getJsonResult(false,"该帐号已存在，请重新填写！");
			}
			userMng.save(bean,roleIds,getUser());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id) {
		try {
			User bean=userMng.findById(id);
			bean.setFlag("0");
			bean.setUpdateTime(new Date());
			bean.setUpdator(getUser());
			userMng.updateDefault(bean);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 修改密码
	 * @param userId
	 * @param originalPwd
	 * @param nowPwd
	 * @param confirmPwd
	 * @return
	 */
	@RequestMapping("/saveEditPwd")
	@ResponseBody
	public Result saveEditPwd(String userId,String originalPwd,String newPwd,String confirmNewPwd) {
		try {
			User bean=userMng.findById(userId);
			if(!CodeHelper.encryptPassword(originalPwd).equals(bean.getPassword())){
				return getJsonResult(false,"原始密码填写不正确，请重新填写！");
			}
			if(StringUtil.isEmpty(newPwd) || StringUtil.isEmpty(confirmNewPwd)){
				return getJsonResult(false,"新密码或确认密码为空，请填写！");
			}
			if(!newPwd.equals(confirmNewPwd)){
				return getJsonResult(false,"两次密码填写不一致，请重新填写！");
			}
			String regEx = "[ _`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\t";
	        Pattern p = Pattern.compile(regEx);
	        Matcher m = p.matcher(newPwd);
			if(newPwd.length() < 6 || newPwd.length() > 12){
				return getJsonResult(false,"新密码长度不正确，请重新填写！");
			} else if (m.find()) {
				return getJsonResult(false,"新密码包含特殊字符，请重新填写！");
			}
			bean.setPassword(CodeHelper.encryptPassword(newPwd));
			bean.setUpdateTime(new Date());
			bean.setUpdator(getUser());
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", bean);
			userMng.updateDefault(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 锁定/解锁 用户
	 * @param userId
	 * @param originalPwd
	 * @param nowPwd
	 * @param confirmPwd
	 * @return
	 */
	@RequestMapping("/lock/{userId}")
	@ResponseBody
	public Result lock(@PathVariable String userId) {
		User bean=userMng.findById(userId);
		try {
			if(!StringUtil.isEmpty(bean.getIslocked()) && "TRUE".equals(bean.getIslocked())){
				bean.setIslocked("FALSE");
			}else{
				bean.setIslocked("TRUE");
			}
			bean.setUpdateTime(new Date());
			bean.setUpdator(getUser());
			userMng.updateDefault(bean);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 在岗状态
	 * @param userId
	 * @return
	 *//*
	@RequestMapping("/changeStatus/{userId}")
	@ResponseBody
	public Result changeStatus(@PathVariable String userId) {
		User bean=userMng.findById(userId);
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	*/
	
	/**
	 * 重置密码
	 * @param userId
	 * @param model
	 * @return
	 */
	@RequestMapping("/reSetPwd/{userId}")
	@ResponseBody
	public Result reSetPwd(@PathVariable String userId,ModelMap model) {
		try {
			userMng.reSetPwd(userId,getUser());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping("/view/{id}")
	public String view(@PathVariable String id,ModelMap model){
		model.addAttribute("user", userMng.findById(id));
		return "/WEB-INF/gwideal_core/user/user_view";
	}
	

	/**
	 * 在用户姓名后面拼接该用户的角色
	 * @param user
	 * @return
	 */
	private String nameWithRole(User user) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer(user.getName()+"(");
		List<Role> roleList = user.getRoles();
		for(Role r: roleList){
			if(r.getCode().equals("JZWWSJ")){
				sb.append(r.getName()+"，");
			}
			if(r.getCode().equals("PABZR")){
				sb.append(r.getName()+"，");
			}
			if(r.getCode().equals("JWSJZR")){
				sb.append(r.getName()+"，");
			}
		}
		String str = sb.substring(0,sb.length()-1);
		str = str + (")");
		return str;
	}


	
	/*
	 * 跳转到用户选择页面
	 */
	@RequestMapping("/refList/{selectType}")
	public String refList(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/user/user_refMsgReceiver";
	}
	/**
	 * 获取有某个角色的人员
	 * @param roleCode
	 * @return
	 */
	@RequestMapping("/usersJson")
	@ResponseBody
	public List<ComboboxJson> usersJson(String roleCode,String selected){
		List<User> list=userMng.listAuditor(roleCode);
		return getComboboxJson(list,selected);
	}
	
	@RequestMapping("/personLiableForCheckbox")
	@ResponseBody
	public List<User> personLiableForCheckbox(String jwhId,String selected){
		List<User> list=userMng.getChildByJwhCode(jwhId);
		return list;
	}
	
	/**
	 * 检查手机号是否唯一
	 * @param bean
	 * @return
	 */
	@RequestMapping(value="/mobileCheck")
	@ResponseBody
	public Result mobileCheck(String mobileNo,String id){
		try {
			boolean flag=userMng.checkMobileNo(mobileNo,id);
			if(flag){
				return getJsonResult(true, "手机号在系统中已存在，请更换手机号！");
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getJsonResult(false, null);
	}
	
	/**
	 * 跳转到选择下一级审批人页面
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年8月13日
	 * @updateTime 2019年8月13日
	 */
	@RequestMapping("/chooseNextRole")
	public String chooseDepart(String parentCode,String selected,String blanked){
		return "/WEB-INF/view/choose_nextrole";
	}
	/**
	 * 跳转到一键替换用户审核流程页面
	 * @return
	 * @author 赵孟雷
	 * @createTime 2019年9月25日
	 * @updateTime 2019年9月25日
	 */
	@RequestMapping("/aKeyToReplace/{id}")
	public String aKeyToReplace(@PathVariable String id, ModelMap model){
		model.addAttribute("id", id);
		return "/WEB-INF/gwideal_core/user/user_akeytoreplace";
	}
	/**
	 * 一键替换用户审核流程页面修改
	 * @return
	 * @author 赵孟雷
	 * @createTime 2019年9月25日
	 * @updateTime 2019年9月25日
	 */
	@RequestMapping("/aKeyToReplaceEdit")
	@ResponseBody
	public Result aKeyToReplaceEdit(ModelMap model,String userId,String userName,String userById,String departName){
		try {
			 userMng.updateUserFlow(userId, userName, userById,departName);
			 return getJsonResult(true, "替换成功!");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "替换失败,请联系管理员！");
		}
	}
	
	
	@RequestMapping("/getDepartmentRole")
	@ResponseBody
	public List<Role> getDepartmentRole(String departId) {
		try {
			
			List<Role> list = roleMng.getAll(departId);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 跳转到选择住宿人员页面
	 * @param index
	 * @return
	 * @author 沈帆
	 * @createTime 2020年3月3日
	 * @updateTime 2020年3月3日
	 */
	@RequestMapping("/chooseUser")
	public String chooseUser(String index,ModelMap model){
		model.addAttribute("index", index);
		return "/WEB-INF/view/expend/reimburse/reimburse/choose_user";
	}

	/**
	 * 根据ids查询用户
	 * @param ids
	 * @return
	 */
	@RequestMapping("/getUserByIds")
	@ResponseBody
	public JsonPagination getUserByIds(String ids){
		Pagination p = userMng.getUserByIds(ids);
		return getJsonPagination(p,1);
	}
}

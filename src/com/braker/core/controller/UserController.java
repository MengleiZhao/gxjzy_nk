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
	//??????????????????????????????
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
	 * ???????????????????????????
	 */
	@RequestMapping(value="/jsonPaginationMsgReceiver")
	@ResponseBody
	public JsonPagination jsonPaginationMsgReceiver(User bean,String departId,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=userMng.list(bean,departId,sort,order,page,rows);
		//????????????????????????????????????
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
				return getJsonResult(false,"???????????????????????????????????????");
			}
			userMng.save(bean,roleIds,getUser());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/**
	 * ????????????
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
				return getJsonResult(false,"????????????????????????????????????????????????");
			}
			if(StringUtil.isEmpty(newPwd) || StringUtil.isEmpty(confirmNewPwd)){
				return getJsonResult(false,"?????????????????????????????????????????????");
			}
			if(!newPwd.equals(confirmNewPwd)){
				return getJsonResult(false,"????????????????????????????????????????????????");
			}
			String regEx = "[ _`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~???@#???%??????&*????????????+|{}????????????????????????????????????]|\n|\r|\t";
	        Pattern p = Pattern.compile(regEx);
	        Matcher m = p.matcher(newPwd);
			if(newPwd.length() < 6 || newPwd.length() > 12){
				return getJsonResult(false,"?????????????????????????????????????????????");
			} else if (m.find()) {
				return getJsonResult(false,"????????????????????????????????????????????????");
			}
			bean.setPassword(CodeHelper.encryptPassword(newPwd));
			bean.setUpdateTime(new Date());
			bean.setUpdator(getUser());
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", bean);
			userMng.updateDefault(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/**
	 * ??????/?????? ??????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/**
	 * ????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	*/
	
	/**
	 * ????????????
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
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	@RequestMapping("/view/{id}")
	public String view(@PathVariable String id,ModelMap model){
		model.addAttribute("user", userMng.findById(id));
		return "/WEB-INF/gwideal_core/user/user_view";
	}
	

	/**
	 * ?????????????????????????????????????????????
	 * @param user
	 * @return
	 */
	private String nameWithRole(User user) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer(user.getName()+"(");
		List<Role> roleList = user.getRoles();
		for(Role r: roleList){
			if(r.getCode().equals("JZWWSJ")){
				sb.append(r.getName()+"???");
			}
			if(r.getCode().equals("PABZR")){
				sb.append(r.getName()+"???");
			}
			if(r.getCode().equals("JWSJZR")){
				sb.append(r.getName()+"???");
			}
		}
		String str = sb.substring(0,sb.length()-1);
		str = str + (")");
		return str;
	}


	
	/*
	 * ???????????????????????????
	 */
	@RequestMapping("/refList/{selectType}")
	public String refList(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/user/user_refMsgReceiver";
	}
	/**
	 * ??????????????????????????????
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
	 * ???????????????????????????
	 * @param bean
	 * @return
	 */
	@RequestMapping(value="/mobileCheck")
	@ResponseBody
	public Result mobileCheck(String mobileNo,String id){
		try {
			boolean flag=userMng.checkMobileNo(mobileNo,id);
			if(flag){
				return getJsonResult(true, "??????????????????????????????????????????????????????");
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getJsonResult(false, null);
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author ?????????
	 * @createTime 2019???8???13???
	 * @updateTime 2019???8???13???
	 */
	@RequestMapping("/chooseNextRole")
	public String chooseDepart(String parentCode,String selected,String blanked){
		return "/WEB-INF/view/choose_nextrole";
	}
	/**
	 * ?????????????????????????????????????????????
	 * @return
	 * @author ?????????
	 * @createTime 2019???9???25???
	 * @updateTime 2019???9???25???
	 */
	@RequestMapping("/aKeyToReplace/{id}")
	public String aKeyToReplace(@PathVariable String id, ModelMap model){
		model.addAttribute("id", id);
		return "/WEB-INF/gwideal_core/user/user_akeytoreplace";
	}
	/**
	 * ??????????????????????????????????????????
	 * @return
	 * @author ?????????
	 * @createTime 2019???9???25???
	 * @updateTime 2019???9???25???
	 */
	@RequestMapping("/aKeyToReplaceEdit")
	@ResponseBody
	public Result aKeyToReplaceEdit(ModelMap model,String userId,String userName,String userById,String departName){
		try {
			 userMng.updateUserFlow(userId, userName, userById,departName);
			 return getJsonResult(true, "????????????!");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "????????????,?????????????????????");
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
	 * ?????????????????????????????????
	 * @param index
	 * @return
	 * @author ??????
	 * @createTime 2020???3???3???
	 * @updateTime 2020???3???3???
	 */
	@RequestMapping("/chooseUser")
	public String chooseUser(String index,ModelMap model){
		model.addAttribute("index", index);
		return "/WEB-INF/view/expend/reimburse/reimburse/choose_user";
	}

	/**
	 * ??????ids????????????
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

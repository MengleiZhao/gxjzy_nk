package com.braker.core.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.common.webSocket.MyWebSocketHandler;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.model.PrivateInformation;
import com.braker.core.model.User;
import com.braker.icontrol.assets.rece.model.ReceList;
/**
 * 消息中心控制层
 * @author 陈睿超
 *
 */
@Controller
@RequestMapping("/PrivateInfor")
public class PrivateInforController extends BaseController{
	
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	//websocket消息推送
	@Autowired
	private MyWebSocketHandler handler;
	
	/**
	 * 跳转到消息列表页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-06
	 */
	@RequestMapping("/List")
	public String list(ModelMap model){
		//更新消息推送数字
		Integer countInfor = privateInforMng.unread(getUser().getId()).size();
		model.addAttribute("countInfor", countInfor);
		return "/WEB-INF/view/task/task-inf-list";
	}
	
	/**
	 * 首页的消息跳转页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-06
	 */
	@RequestMapping("/unRead")
	public String unRead(ModelMap model){
		//更新消息推送数字
		Integer countInfor = privateInforMng.unread(getUser().getId()).size();
		model.addAttribute("countInfor", countInfor);
		return "/WEB-INF/view/task/task-inf-fast-list";
	}
	
	/**
	 * 加载列表信息数据
	 * @param bean 查询条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-06
	 */
	@ResponseBody
	@RequestMapping("/JsonPagination")
	public JsonPagination jsonPagination(PrivateInformation bean,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = privateInforMng.queryList(bean, getUser(), page, rows);
		List<PrivateInformation> beanList = (List<PrivateInformation>) p.getList();
		for (int i = 0; i < beanList.size(); i++) {
			beanList.get(i).setNumber(i+1);
		}
		p.setList(beanList);
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * 首页的未读信息数据
	 * @param bean
	 * @param sort
	 * @param page
	 * @param rows
	 * @param order
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-07
	 */
	@ResponseBody
	@RequestMapping("/unreadJsonPagination")
	public JsonPagination unreadJsonPagination(PrivateInformation bean,String sort,Integer page,Integer rows,String order,ModelMap model){
		Pagination p=new Pagination();
		p.setPageNo(1);
		p.setPageSize(100);
		List<PrivateInformation> beanList = privateInforMng.allunRead(bean, getUser());
		p.setTotalCount(beanList.size());
		p.setList(beanList);
		return getJsonPagination(p, 1);
	}
	
	
	
	/**
	 * 查看消息页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-07
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id, String furl ,ModelMap model,HttpServletRequest request){
		//根据id查询该条消息
		PrivateInformation bean = privateInforMng.findById(Integer.valueOf(id));
		//打开一次即为一次查看
		bean.setfReadStauts("1");
		bean.setfReadingTime(new Date());
		privateInforMng.merge(bean);
		bean.setRecipient(getUser().getName());
		model.addAttribute("bean", bean);
		model.addAttribute("detailType", "detail");
		//model.addAttribute("openType", "chuli");
		User user=getUser();
		//查看完消息以后，刷新消息条数重新发送给前端
		// 推送类型   0：无， 1：您有新的消息，2：您有新的待办事项
		personalWorkMng.sendMessageToUser(user.getId(),0);
		return "/WEB-INF/view/task/task-info-detail";
	}
	
	/**
	 * 跳转到处理的页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-07
	 */
	@RequestMapping("/process/{id}")
	public String process(@PathVariable String id,String furl,ModelMap model,HttpServletRequest http){
		//
		return "redirect:"+furl;
	}
	
	/**
	 * 批量标记为已读
	 * @param selections
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-08
	 */
	@RequestMapping("/read")
	@ResponseBody
	public Result read(String selections ,ModelMap model){
		try {
			String[] str= selections.split(",");
			privateInforMng.updateReadStauts(str, "1");
			//更新消息推送数字
			Integer countInfor = privateInforMng.unread(getUser().getId()).size();
			model.addAttribute("countInfor", countInfor);
			User user=getUser();
			
			int num3 = countInfor!=null?3:0;
			personalWorkMng.sendMessageToUser(user.getId(), num3);
			return getJsonResult(true, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "操作失败！");
		}
	}
	
	/**
	 * 批量标记为未读
	 * @param selections
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-08
	 */
	@RequestMapping("/unread")
	@ResponseBody
	public Result unread(String selections ,ModelMap model){
		try {
			String[] str= selections.split(",");
			privateInforMng.updateReadStauts(str,"0");
			//更新消息推送数字
			Integer countInfor = privateInforMng.unread(getUser().getId()).size();
			model.addAttribute("countInfor", countInfor);
			User user=getUser();
			int num3 = countInfor!=null?3:0;
			personalWorkMng.sendMessageToUser(user.getId(), num3);
			return getJsonResult(true, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "操作失败！");
		}
	}
	
	/**
	 * 批量删除
	 * @param selections
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-08
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(String selections ,ModelMap model){
		try {
			String[] str= selections.split(",");
			privateInforMng.deletePart(str);
			//更新消息推送数字
			Integer countInfor = privateInforMng.unread(getUser().getId()).size();
			model.addAttribute("countInfor", countInfor);
			/*User user=getUser();
			int num3 = countInfor!=null?countInfor:0;
			handler.sendMessageToUser(user.getId(),new TextMessage(String.valueOf(num3)));*/
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
	}
	
	/**
	 * 修改消息收藏状态
	 * @param id
	 * @param fMessageStauts
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-09
	 */
	@ResponseBody
	@RequestMapping("/updateMessageStauts/{id}")
	public Result updateMessageStauts(@PathVariable String id,String fMessageStauts ,ModelMap model){
		try {
			privateInforMng.updateMessageStauts(id, fMessageStauts);
			return getJsonResult(true, "");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "");
		}
	}
	
	
}

package com.braker.core.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.helper.DataUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.security.BadCredentialsException;
import com.braker.common.security.LockedException;
import com.braker.common.security.UserNameNotFoundException;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.IndexShortcutMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.SystemThemesMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CaptchaUtil;
import com.braker.core.model.Function;
import com.braker.core.model.IndexShortcut;
import com.braker.core.model.SystemThemes;
import com.braker.core.model.User;

@SuppressWarnings("serial")
@Controller
public class LoginController extends BaseController {

	@Autowired
	private UserMng userMng;
	@Autowired
	private FunctionMng functionMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private SystemThemesMng systemThemesMng;
	@Autowired
	private IndexShortcutMng indexShortcutMng;
	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String input(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		
		List<SystemThemes> li = systemThemesMng.findByStauts("1");
		String url = "img";
		if (li.size()>0) {
			url = li.get(0).getUrl1();
		}
		request.getSession().setAttribute("themenurl", url);//????????????
		
		return "welcome";
	}

/*	@RequestMapping(value = "/streetIndex.do", method = RequestMethod.GET)
	public String streetIndex(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		return "/WEB-INF/view/index_street_01022";
	}*/

	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String index(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
//		return "/WEB-INF/view/index_jwh_"+getUser().getStreet().getStreetCode();
//		List<Function> userMenus = functionMng.getFunctions(getUser().getId());
		/*List<Role> role = userMng.getUserRole(getUser().getId());
		List<Function> userMenus = functionMng.getUserMenu(role.get(0));
		List<Function> menus = new ArrayList<Function>();
		for (int i = 0; i < userMenus.size(); i++) {
			if(userMenus.get(i).getPriority()>200 && userMenus.get(i).getParent().getId()==31){
				menus.add(userMenus.get(i));
			}
		}
		menus = changeOrder(menus);
		model.addAttribute("menus", menus);*/
		model.addAttribute("userName", getUser().getName());
		model.addAttribute("taskNums", personalWorkMng.countTaskNum(getUser().getId()));
		if(request.getSession().getAttribute("themenurl")==null){
			List<SystemThemes> li = systemThemesMng.findByStauts("1");
			String url = "img";
			if (li.size()>0) {
				url = li.get(0).getUrl1();
			}
			request.getSession().setAttribute("themenurl", url);//????????????
		}
		/*return "main/main";*/
		
		
		//???????????????????????????
		List<IndexShortcut> ksrk = indexShortcutMng.findByUserId(getUser());
		model.addAttribute("ksrk", ksrk);
		model.addAttribute("loginType", request.getSession().getAttribute("loginType"));
		request.getSession().removeAttribute("loginType");
		return "newMain/main-new";
	}
	
/*	//??????
	public List<Function> changeOrder(List<Function> list) {
		for(int i =0;i < list.size();i++)  
        {   
			for (int j = i; j < list.size(); j++) {
				if(list.get(i).getPriority()>list.get(j).getPriority())	{
					Function f = list.get(i);
					list.set(i, list.get(j));
					list.set(j, f);
				}
			}
        } 
		return list;
	}*/
	
	//??????????????????
	@RequestMapping(value = "/leftmenu.do")
	@ResponseBody
	public List<Function> leftmenu(Long leftmenu, ModelMap model) {
		List<Function> leftlist = functionMng.getChildByUser(leftmenu, getUser().getId());
		return leftlist;
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String submit(String accountNo, String password, String captcha,String verificationCode,
			String message,String street, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		try {
			HttpSession session = request.getSession();
			//??????????????????????????????
			 String codeSession = (String) session.getAttribute("code"); 
			    if (StringUtils.isEmpty(codeSession)) { 
			      log.error("???????????????????????????"); 
			      throw new BadCredentialsException("???????????????????????????"); 
			    } 
			    if (StringUtils.isEmpty(verificationCode)) { 
			      throw new BadCredentialsException("????????????????????????"); 
			    } 
			    if (codeSession.equalsIgnoreCase(verificationCode)) { 
			      // ??????????????? 
			    } else { 
			      throw new BadCredentialsException("?????????????????????????????????????????????"); 
			    }
			
			User user = userMng.login(accountNo, password);
			session.setAttribute("currentUser", user);
			session.setAttribute("year", DateUtil.getCurrentYear());
			session.setAttribute(Function.RIGHTS_KEY, functionMng
					.getFunctionItems(user.getId()));
			session.setAttribute("loginType", 0);
			user.setLastLoginTime(new Date());
			userMng.saveOrUpdate(user);
			// ????????????????????????????????????????????????????????????
			user.hasRole("STREET_ROLE");
			user.hasRole("QU_ROLE");
			//if (user.hasRole("QU_ROLE")) {
			return "redirect:/index.do";
			/*} else if (user.hasRole("STREET_ROLE")) {
				return "redirect:/streetIndex.do";
			}
			return "redirect:/jwhIndex.do";*/
		} catch (UserNameNotFoundException e) {
			model.addAttribute("loginMsg", e.getMessage());
		} catch (LockedException e) {
			model.addAttribute("loginMsg", e.getMessage());
		} catch (BadCredentialsException e) {
			model.addAttribute("loginMsg", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("loginMsg", "??????????????????,??????????????????!");
		}
		return "login";
	}

	@RequestMapping(value = "/logout.do")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (null != session) {
			session.invalidate();
		}
		return "redirect:login.do";
	}
	
	//??????session????????????
	@RequestMapping(value = "/timeout.do")
	@ResponseBody
	public String timeout(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (null != session) {
			return "false";
		}
		return "true";
	}
	
	@RequestMapping(value = "/createCode") 
	public void createCode(HttpServletRequest request, HttpServletResponse response) throws IOException { 
	    // ??????????????????????????? 
	    response.setHeader("Expires", "-1"); 
	    response.setHeader("Cache-Control", "no-cache"); 
	    response.setHeader("Pragma", "-1"); 
	    CaptchaUtil util = CaptchaUtil.Instance(); 
	    // ?????????????????????session?????????????????? 
	    String code = util.getString(); 
	    request.getSession().setAttribute("code", code); 
	    // ?????????web?????? 
	    ImageIO.write(util.getImage(), "jpg", response.getOutputStream()); 
  }
}

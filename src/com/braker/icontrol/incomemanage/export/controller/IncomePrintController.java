package com.braker.icontrol.incomemanage.export.controller;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Proposer;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsRegisterMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.ReceiveMoneyDetailMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.businessService.manager.BusinessServiceMng;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.icontrol.incomemanage.register.manager.RegisterMng;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 收入导出控制层
 * @author 赵孟雷
 *
 */
@Controller
@RequestMapping(value = "/incomePrint")
public class IncomePrintController extends BaseController{

	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private BusinessServiceMng businessServiceMng;
	
	@Autowired
	private AccountsRegisterMng accountsRegisterMng;
	
	@Autowired
	private RegisterMng registerMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private ReceiveMoneyDetailMng receiveMoneyDetailMng;
	
	@Autowired
	private UserMng userMng;
	
	/*
	 * 跳转培训立项打印页面
	 * @author 赵孟雷
	 * @createtime 2020-12-03
	 * @updatetime 2020-12-03        
	 */
	@RequestMapping("/business")
	public String business(ModelMap model, HttpServletResponse response, HttpServletRequest request) {
		OutputStream out = null;
		try {
			//初始化
			response.setHeader("Content-Disposition","attachment; filename="+new String("培训类收入明细模板".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\培训类收入明细模板.xls";
			//生成excel并导出
			HSSFWorkbook workbook = registerMng.exportExcel(filePath);
			
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}  
			}
		}
		return null;
	}
}
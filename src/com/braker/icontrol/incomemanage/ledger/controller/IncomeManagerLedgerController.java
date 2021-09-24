package com.braker.icontrol.incomemanage.ledger.controller;
import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsRegisterMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsRegister;
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
 * 收入管理台账控制层
 * @author 赵孟雷
 *
 */
@Controller
@RequestMapping(value = "/incomeManagerledger")
public class IncomeManagerLedgerController extends BaseController{

	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private BusinessServiceMng businessServiceMng;
	
	@Autowired
	private AccountsRegisterMng accountsRegisterMng;
	
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private RegisterMng registerMng;
	
	@Autowired
	private UserMng userMng;
	
	/**
	 * 跳转到往来款list台账页面
	 * @author 赵孟雷
	 * @createTime 2020年12月2日
	 * @updateTime 2020年12月2日
	 */
	@RequestMapping("/listAccounts")
	public String listAccounts(ModelMap model){
		return "/WEB-INF/view/income_manage/ledger/accountsLedger";
	}
	
	/*
	 * 往来款台账分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-12-2
	 * @updatetime 2020-12-2
	 */
	@RequestMapping(value = "/accountsPage")
	@ResponseBody
	public JsonPagination accountsPage(Integer applyType ,AccountsCurrent bean, ModelMap model, Integer page, Integer rows){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			Pagination p = accountsCurrentMng.pageLedgerList(bean, page, rows, getUser());
			List<AccountsCurrent> accountsCurrents = (List<AccountsCurrent>) p.getList();
			for (int i = 0; i < accountsCurrents.size(); i++) {
				AccountsRegister accountsRegister = new AccountsRegister();
				accountsRegister.setfAcaId(accountsCurrents.get(i).getfAcaId());
				BigDecimal incomeMoney = BigDecimal.ZERO;//收款金额
				List<AccountsRegister> registers = accountsRegisterMng.registerList(accountsRegister, getUser());
				if(registers.size()>0){
					for (int j = 0; j < registers.size(); j++){
						BigDecimal registerMoney =BigDecimal.ZERO;
						if(registers.get(j).getRegisterMoney() ==null || "".equals(registers.get(j).getRegisterMoney())){
							registerMoney =BigDecimal.ZERO;
						}else{
							registerMoney =registers.get(j).getRegisterMoney();
						}
						incomeMoney =incomeMoney.add(registerMoney);
					}
					accountsCurrents.get(i).setIncomeMoney(incomeMoney);
				}else{
					accountsCurrents.get(i).setIncomeMoney(BigDecimal.ZERO);
				}
				BigDecimal paymentMoney = BigDecimal.ZERO;//付款金额
				List<ReimbAppliBasicInfo> reimbAppliBasicInfos = reimbAppliMng.findByProperty("proName", accountsCurrents.get(i).getBeanCode());
				if(reimbAppliBasicInfos.size()>0){
					for (ReimbAppliBasicInfo reimbAppliBasicInfo : reimbAppliBasicInfos) {
						if(reimbAppliBasicInfo.getCashierType() !=null && "1".equals(reimbAppliBasicInfo.getCashierType())){
							BigDecimal registerMoney =BigDecimal.ZERO;
							if(reimbAppliBasicInfo.getAmount() ==null || "".equals(reimbAppliBasicInfo.getAmount())){
								registerMoney =BigDecimal.ZERO;
							}else{
								registerMoney =reimbAppliBasicInfo.getAmount();
							}
							paymentMoney=paymentMoney.add(registerMoney);
						}
					}
					accountsCurrents.get(i).setPaymentMoney(paymentMoney);
				}else{
					accountsCurrents.get(i).setPaymentMoney(BigDecimal.ZERO);
				}
			}
			return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 跳转到培训list台账页面
	 * @author 赵孟雷
	 * @createTime 2020年12月2日
	 * @updateTime 2020年12月2日
	 */
	@RequestMapping("/listBusiness")
	public String listBusiness(ModelMap model){
		return "/WEB-INF/view/income_manage/ledger/businessLedger";
	}
	
	/*
	 * 培训台账分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-12-2
	 * @updatetime 2020-12-2
	 */
	@RequestMapping(value = "/businessPage")
	@ResponseBody
	public JsonPagination businessPage(Integer applyType ,BusinessServiceInfo bean, ModelMap model, Integer page, Integer rows){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			Pagination p = businessServiceMng.pageLedgerList(bean, page, rows, getUser());
			List<BusinessServiceInfo> serviceInfo = (List<BusinessServiceInfo>) p.getList();
			for (int i = 0; i < serviceInfo.size(); i++){
				IncomeInfo incomeInfo = new IncomeInfo();
				incomeInfo.setfBusiId(serviceInfo.get(i).getfBusiId());
				List<IncomeInfo> list = registerMng.pageLedgerList(incomeInfo, getUser());
				BigDecimal incomeMoney = BigDecimal.ZERO;//登记金额
				BigDecimal paymentMoney = BigDecimal.ZERO;//确认金额
				if(list.size()>0){
					for (int j = 0; j < list.size(); j++) {
						if(list.get(j).getFregisterAmount() ==null || "".equals(list.get(j).getFregisterAmount())){
							incomeMoney = BigDecimal.ZERO;
						}else{
							incomeMoney=incomeMoney.add(list.get(j).getFregisterAmount());
						}
						if(list.get(j).getFconfirmAmount() ==null || "".equals(list.get(j).getFconfirmAmount())){
							paymentMoney = BigDecimal.ZERO;
						}else{
							paymentMoney=paymentMoney.add(list.get(j).getFconfirmAmount());
						}
					}
				}
				serviceInfo.get(i).setIncomeMoney(incomeMoney);
				serviceInfo.get(i).setPaymentMoney(paymentMoney);
			}
			return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 跳转修改页面
	 * @author 赵孟雷
	 * @createtime 2020-11-11
	 * @updatetime 2020-11-11        
	 */
	@RequestMapping("/detail")
	public String detail(String id ,ModelMap model) {
		try {
			AccountsCurrent bean = accountsCurrentMng.findById(Integer.valueOf(id));
			//获取默认值
			model.addAttribute("bean", bean);
			//操作类型
			model.addAttribute("operation", "detail");
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKLXSQ", bean.getDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getProCode(),"1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKLXSQ", bean.getDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//根据归口部门修改流程显示数据
			model.addAttribute("nodeConf", nodeConfList);
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getUserName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);	
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_current_detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/income_manage/accountsCurrent/detail/accounts_current_detail";
		}
	}
	
}
package com.braker.icontrol.expend.reimburse.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.braker.common.page.Result;
import com.braker.common.util.Base64DecodeMultipartFile;
import com.braker.common.util.Base64Util;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.expend.apply.model.ReceptionHotel;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.model.AppInvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCheckInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceQuery;
import com.braker.icontrol.expend.reimburse.model.InvoiceResponse;
import com.braker.icontrol.expend.reimburse.model.NoteInfo;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;
/**
 * 发票管理控制器
 * @author 张迅
 * @createtime 2019-03-22
 */
@Controller
@RequestMapping(value = "/invoice")
public class InvoiceController extends BaseController {

	@Autowired
	private InvoiceMng invoiceMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	/**
	 * 发票校验页面
	 */
	@RequestMapping(value="/toVerify")
	public String toVerify () {
		return "/WEB-INF/view/expend/invoice/verify";
	}
	
	/**
	 * 发票校验
	 */
	@RequestMapping(value="/verify")
	@ResponseBody
	public InvoiceResponse verify(InvoiceQuery invoiceQuery){
		
		InvoiceResponse invoice = new InvoiceResponse();
		//连接接口校验
		String invoiceJson = invoiceMng.verify(invoiceQuery);
		//String invoiceJson = "{\"success\":true,\"fplx\":\"10\",\"fpdm\":\"035021800111\",\"fphm\":\"20057257\",\"kprq\":\"20181210\",\"xfMc\":\"中国电信股份有限公司厦门分公司\",\"fplxName\":\"增值税电子普通发票\",\"sfMc\":\"厦门\",\"sfCode\":\"3502\",\"xfNsrsbh\":\"9135020075162018XD\",\"xfContact\":\"厦门市白鹤路25号 10000\",\"xfBank\":\"工行厦门鹭江支行 4100020009022111843\",\"gfMc\":\"张迅\",\"gfNsrsbh\":\"\",\"gfContact\":\"15396243130\",\"gfBank\":\"\",\"code\":\"10197679778100079990\",\"num\":\"499099903028\",\"del\":\"N\",\"taxamount\":\"0.00\",\"goodsamount\":\"73.05\",\"sumamount\":\"73.05\",\"quantityAmount\":1,\"remark\":\"所属账期：201809~201809    客户号码：15396243130\",\"goodsData\":[{\"taxSum\":\"0.00\",\"priceUnit\":\"73.05\",\"taxRate\":\"0\",\"amount\":\"1\",\"unit\":\"*\",\"name\":\"*电信服务*电信服务\",\"priceSum\":\"73.05\",\"spec\":\"*\"}],\"updateTime\":\"1553225009757\"}";
		if (!StringUtil.isEmpty(invoiceJson) && !"400".equals(invoiceJson)) {
			if (!StringUtil.isEmpty(invoiceJson)) {
				invoice = JSON.parseObject(invoiceJson, InvoiceResponse.class);
			}
		}
		
		return invoice;
	}
	
	/**
	 * 叶崇晖
	 * 发票验真检验重
	 * @param json
	 * @return
	 */
	@RequestMapping(value = "/invoiceExamine")
	@ResponseBody
	public Result invoiceSave(String json) {
		
		System.out.println(json);
		
		JSONObject jsonObject=JSONObject.fromObject(json);
		InvoiceInfo stu=(InvoiceInfo)JSONObject.toBean(jsonObject, InvoiceInfo.class);
		
		
		
		return null;
	}
	
	/**
	 * 叶崇晖
	 * 新增发票时的种类选择
	 * @param json
	 * @return
	 */
	@RequestMapping(value = "/invoiceKind")
	public String invoiceKind() {
		return "/WEB-INF/view/expend/reimburse/invoice_kind";
	}
	
	/**
	 * 打开发票新增修改页面
	 * @param id
	 * @param type
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value = "/invoiceAdd")
	public String invoiceAdd(Integer id, String type, String kind, ModelMap model) {
		if("edit".equals(type)&&id!=null){
			InvoiceInfo invoice = invoiceMng.findById(id);
			
			if(invoice != null){
				//查询附件信息
				List<Attachment> attaList = attachmentMng.list(invoice);
				model.addAttribute("attaList", attaList);
			}
		}
		if("add".equals(type)){
			model.addAttribute("kind", kind);
		}
		model.addAttribute("pageType", type);//type为打开页面类型，值为add是新增、值为edit是修改或查看
		
		if("1".equals(kind) || "2".equals(kind)){
			return "/WEB-INF/view/expend/reimburse/invoice_add";
		} else {
			return "/WEB-INF/view/expend/reimburse/invoice_other_add";
		}
	}*/
	
	/**
	 * 打开发票查看页面
	 * @param id
	 * @param type
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value = "/invoiceCheck")
	public String invoiceCheck(Integer id, String type, String kind, ModelMap model) {
		InvoiceInfo invoice = invoiceMng.findById(id);
		
		if(invoice != null){
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(invoice);
			model.addAttribute("attaList", attaList);
		}
		
		model.addAttribute("pageType", type);//type为打开页面类型，值为add是新增、值为edit是修改或查看
		
		if("1".equals(kind) || "2".equals(kind)){
			return "/WEB-INF/view/expend/reimburse/invoice_check";
		} else {
			return "/WEB-INF/view/expend/reimburse/invoice_other_check";
		}
	}*/
	
	
	/*
	 * app发票验证、上传、保存
	 * @author 沈帆
	 * @createtime 2020-07-03
	 * @updatetime 2020-07-03
	 */
	@RequestMapping(value = "/uploadInvoice")
	@ResponseBody
	public List<InvoiceCheckInfo> uploadInvoice(String invoiceJson,String acco, String pwd,String fIId){
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			List<InvoiceCheckInfo> resultList = new ArrayList();
			User user=userMng.login(acco,pwd);
			JSONArray array = JSONArray.fromObject(invoiceJson.toString());
			List<NoteInfo> fpList = (List)JSONArray.toList(array, NoteInfo.class);
			//判断是否是重拍(如果是重拍删除原来数据)
			if(!StringUtil.isEmpty(fIId)){
				invoiceMng.deleteInvoice(fIId);
			}
			if(fpList!=null&&fpList.size()>0){
				for(NoteInfo fp:fpList){
					int flag=0;
					//验证发票是否被他人报销
					List<AppInvoiceInfo> list1 =invoiceMng.findByCode(fp.getNumber(), null);
					if(list1!=null&&list1.size()>0){
						for(AppInvoiceInfo invoice:list1){
							if(invoice.getfInvoiceStatus()!=null){
								if(invoice.getfInvoiceStatus().equals("1")){
									flag=1;
									InvoiceCheckInfo checkInfo=new InvoiceCheckInfo();
									checkInfo.setCode(fp.getNumber());
									String str=""+invoice.getfUploadUsername()+"在 "+simpleDateFormat.format(invoice.getfUploadTime())+"";
									checkInfo.setCheckResult(""+str+"已使用过该发票，请勿重复报销");
									resultList.add(checkInfo);
								}
							}
						}
					}
					//验证自己通一张发票是否重复上传
					if(flag!=1){
						List<AppInvoiceInfo> list2 =invoiceMng.findByCode(fp.getNumber(), user.getId());
						if(list2!=null&&list2.size()>0){
							flag=1;
							InvoiceCheckInfo checkInfo=new InvoiceCheckInfo();
							checkInfo.setCode(fp.getNumber());
							checkInfo.setCheckResult("您已上传过该发票，请勿重复上传");
							resultList.add(checkInfo);
						}
					}
					//验真
					
					
					if(flag!=1){
						//将base64转为file并上传
						String savePath="D:/tomcat-cp-nkgl/webapps/picture";
						//String savePath="D:/kaifagz/apache-tomcat-7.0.79/webapps/picture";
						String base64="data:image/png;base64,"+fp.getImg_base64();
						String id=attachmentMng.uploadInvoiceImage(Base64Util.base64ToMultipart(base64), "appFp", savePath, user);
						//保存发票信息
						AppInvoiceInfo invo =new AppInvoiceInfo();
						invo.setfFileId(id);
						invo.setfInvoiceCode(fp.getNumber());
						invo.setfInvoiceAmount(fp.getTotal_money());
						invo.setfUploadUserid(user.getId());
						invo.setfUploadUsername(user.getName());
						invo.setfUploadTime(new Date());
						invo.setpFlag("0");
						invo.setfInvoiceStatus("0");
						invo.setMark(fp.getMark());
						invo.setfTrueOrFalse("1");
						invoiceMng.saveOrUpdate(invo);
					}
				}
			}
			return resultList;
		}
		catch (Exception e) {
			e.printStackTrace();
			return (List<InvoiceCheckInfo>) getJsonResult(false, e.getMessage());
		}
	}

}

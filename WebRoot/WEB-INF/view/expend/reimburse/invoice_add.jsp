<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="win-div">
<form id="invoice_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width: 942px">
			<div class="win-left-top-div">
			
				<div class="easyui-accordion" id="invoice-add-easyAcc" style="width:902px;margin-left: 20px;border: 0">
					<div title="票头" id="invoice-add-pt" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>发票代码</td>
								<td class="td2">
									<input class="easyui-numberbox" name="invoiceCode" style="width: 300px" 
									data-options="required:true,validType:'fpdm'"/>
								</td>
								
								<td style="width: 90px">
									<!-- <input type="hidden" name="iId" id="invoice_iId"/>
									<input type="hidden" name="type" id="invoice_type"/> -->
								</td>
								
								<td class="td1"><span class="style1">*</span>发票号码</td>
								<td class="td2">
									<input class="easyui-numberbox" name="invoiceNum" style="width: 300px"
									data-options="required:true,validType:'fphm'"/>
								</td>
							</tr>
							
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>校验码</td>
								<td class="td2">
									<input class="easyui-textbox" name="checkCode" style="width: 300px"
									data-options="required:true,validType:'length[20,20]'"/>
								</td>
								
								<td style="width: 90px"></td>
								
								<td class="td1"><span class="style1">*</span>开票日期</td>
								<td class="td2">
									<input class="easyui-datebox" name="invoiceTime" style="width: 300px"
									required="required" editable="false"/>
								</td>
							</tr>
						
						</table>
					</div>
				
					<div title="购买方" id="invoice-add-gmf" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>名称</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerName" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>纳税人识别号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerCode" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>地址、电话</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerAddressTel" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>开户行及账号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerBankAccount" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="销售方" id="invoice-add-xsf" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>名称</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerName" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>纳税人识别号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerCode" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>地址、电话</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerAddressTel" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>开户行及账号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerBankAccount" style="width: 795px"
									data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">备注</p></td>
								<td colspan="4">
									<input class="easyui-textbox" data-options="multiline:true,required:false,validType:'length[0,250]'" name="invoiceRemark"  style="width:795px;height:70px;">
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;&nbsp;收款人</td>
								<td class="td2">
									<input class="easyui-textbox" name="invoicePayee" style="width: 300px" data-options="validType:'length[0,50]'"/>
								</td>
								
								<td></td>
								
								<td class="td1">&nbsp;&nbsp;复核人</td>
								<td class="td2">
									<input class="easyui-textbox" name="invoiceChecker" style="width: 300px" data-options="validType:'length[0,50]'"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;&nbsp;开票人</td>
								<td colspan="4">
									<input class="easyui-textbox" name="invoiceDrawer" style="width: 300px" data-options="validType:'length[0,50]'"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="票面" id="invoice-add-pm" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="invoice_coupon_list.jsp"/>
					</div>
					
					<%-- <div title="发票附件" id="invoice-add-fpfj" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="invoice_file" onchange="upladFileParams(this,null,'zcgl03','invoiceProgressNumber','invoicePercent','invoice_tdf','invoice_files','invoice_progid')" hidden="hidden">
									<input type="text" id="invoice_files" name="fileId" hidden="hidden">
								</td>
								<td colspan="4" id="invoice_tdf">
									<a onclick="$('#invoice_file').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<div id="invoice_progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="invoiceProgressNumber" style="background:#3AF960;width:0px;height:10px" >
										</div>文件上传中...&nbsp;&nbsp;<font id="invoicePercent">0%</font> 
									</div>
									<c:forEach items="${attaList}" var="att">
										<div style="margin-top: 10px;">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
										&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>
					</div> --%>
				</div>
				
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveCoupon()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="alert('请连接扫描枪')">
					<img src="${base}/resource-modality/${themenurl}/button/znsm1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>

<script type="text/javascript">
//加载tab页
flashtab('invoice-add-tab');

$(document).ready(function(){
	if(${pageType=="edit"}){//pageType为打开页面类型，值为add是新增、值为edit是修改
		//向页面写入json信息
		$("#invoice_add_form").form('load', invoicejson);//invoicejson是directly_reimburse_invoice.jsp中的全局变量，用来储存需要修改发票的行对象

		var couponJson="{\"total\":0,\"rows\":"+JSON.stringify(invoicejson.couponList)+"}";
		var coupon=JSON.parse(couponJson);//转化为json对象
		
		$("#invoice-coupon-dg").datagrid().datagrid('loadData',coupon);//添加票面信息 
		
		//计算票面的合计信息
		var rows = $("#invoice-coupon-dg").datagrid('getRows');
		var amountSum = 0;//金额合计
		var taxSum = 0;//税额合计
		for(var i=0;i<rows.length;i++){
			if(rows[i].amount!=""&&rows[i].amount!=null){
				amountSum += parseFloat(rows[i].amount);
			}
		}
		for(var i=0;i<rows.length;i++){
			if(rows[i].tax!=""&&rows[i].tax!=null){
				taxSum += parseFloat(rows[i].tax);
			}
		}
		$("#coupon-amount").text(amountSum.toFixed(2));//金额合计设值
		$("#coupon-tax").text(taxSum.toFixed(2));//税额合计设值
		
		invoicejson=null;
	}
});

//保存票面信息
function saveCoupon() {
	if(!$("#invoice_add_form").form('enableValidation').form('validate')){//触发校验
		alert("红线边框输入内容有误，请检验后重新提交");
		//获取当前有多少个手风琴
		var panels=$("#invoice-add-easyAcc").accordion('panels'); 
		//循环每个手风琴
		for(var i=0;i<panels.length;i++){
			var forflag=true;
			//得到每个手风琴的id
			var id=panels[i].get(0).id;
			$("#"+id+" input").each(function() {
				//判断当前手风琴下是否有校验不通过的，因为校验不通过，会给当前input增加class名validatebox-invalid
				if($(this).hasClass("validatebox-invalid")){
					//获取手风琴title
					var title = $("#"+id).prev().get(0).textContent;
					//根据title打开手风琴
					$(".easyui-accordion").accordion('select',title); 
					forflag=false;
					return false;
				}
			});
			$("#"+id+" select").each(function() {
				//判断当前手风琴下是否有校验不通过的，因为校验不通过，会给当前input增加class名validatebox-invalid
				if($(this).hasClass("validatebox-invalid")){
					//获取手风琴title
					var title = $("#"+id).prev().get(0).textContent;
					//根据title打开手风琴
					$(".easyui-accordion").accordion('select',title); 
					forflag=false;
					return false;
				}
			});
			
			$("#"+id+" textarea").each(function() {
				//判断当前手风琴下是否有校验不通过的，因为校验不通过，会给当前input增加class名validatebox-invalid
				if($(this).hasClass("validatebox-invalid")){
					//获取手风琴title
					var title = $("#"+id).prev().get(0).textContent;
					//根据title打开手风琴
					$(".easyui-accordion").accordion('select',title); 
					forflag=false;
					return false;
				}
			});
			
			//只要第一次出现红色框得css样式，就跳出循环
			if(forflag==false){
				return forflag;
			}
		}
		
		
		return;
	};
	
	var data = $("#invoice_add_form").serializeObject();//调用下面的自动转化方法
	var json = JSON.stringify(data);//获取form表单提交的json字符串
	
	
	couponAccept();//保存票面信息
	var rows = $("#invoice-coupon-dg").datagrid("getRows");//获得所有的票面行
	var coupon = "";
	
	for (var i = 0; i < rows.length; i++) {
		if(i==rows.length-1){
			coupon = coupon + JSON.stringify(rows[i]);
		} else {
			coupon = coupon + JSON.stringify(rows[i]) + ",";
		}
	}
	
	json = json.substring(0,json.length-1)+ ",\"couponList\":["+coupon+"]}";//json拼接（将发票票头票面等信息拼接成完整的json）
	
	
	var invoicerows = $("#drfpdg").datagrid("getRows");//获得发票表格的所有行
	
	var invoicejson="{\"total\":0,\"rows\":[";//easyui专用的json格式需要添加total和rows否则无法动态传入easyui datagrid
	
	for (var i = 0; i < invoicerows.length; i++) {
		if(invoicerows[i].iId != $("#invoice_iId").val()){	//如果iId相同说明是修改，老的发票信息就不需要加进来了
			invoicejson = invoicejson +JSON.stringify(invoicerows[i]) + ',';//获得原来就存在的发票信息
		};
	}
	
	var easyuiJson = invoicejson+json+"]}";//加上新添加的发票信息
	
	var invoice=JSON.parse(easyuiJson);//转化为json对象
	
	//发票验证和验重
	$.ajax({
		url:base+"/invoice/invoiceExamine",
		data:{json:json},
		dataType:"JSON",
		type:"POST",
		success:function (date) {
			
		}
	});
	
	$("#drfpdg").datagrid('loadData',invoice);//添加到表格中
	closeFirstWindow();//关闭页面
	
}
	
//将表单的信息自动转化为json
$.fn.serializeObject = function()  {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');         
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

</script>
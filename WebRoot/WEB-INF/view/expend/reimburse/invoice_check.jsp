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
									<input class="easyui-numberbox" name="invoiceCode" style="width: 300px" readonly="readonly"/>
								</td>
								
								<td style="width: 90px">
									<!-- <input type="hidden" name="iId" id="invoice_iId"/>
									<input type="hidden" name="type" id="invoice_type"/> -->
								</td>
								
								<td class="td1"><span class="style1">*</span>发票号码</td>
								<td class="td2">
									<input class="easyui-numberbox" name="invoiceNum" style="width: 300px" readonly="readonly"/>
								</td>
							</tr>
							
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>校验码</td>
								<td class="td2">
									<input class="easyui-textbox" name="checkCode" style="width: 300px" readonly="readonly"/>
								</td>
								
								<td style="width: 90px"></td>
								
								<td class="td1"><span class="style1">*</span>开票日期</td>
								<td class="td2">
									<input class="easyui-datebox" name="invoiceTime" style="width: 300px" readonly="readonly"/>
								</td>
							</tr>
						
						</table>
					</div>
				
					<div title="购买方" id="invoice-add-gmf" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>名称</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerName" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>纳税人识别号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerCode" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>地址、电话</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerAddressTel" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>开户行及账号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="buyerBankAccount" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="销售方" id="invoice-add-xsf" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>名称</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerName" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>纳税人识别号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerCode" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>地址、电话</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerAddressTel" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>开户行及账号</td>
								<td colspan="4">
									<input class="easyui-textbox" name="sellerBankAccount" style="width: 795px" readonly="readonly"/>
								</td>
							</tr>
							
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">备注</p></td>
								<td colspan="4">
									<input class="easyui-textbox" readonly="readonly" name="invoiceRemark"  style="width:795px;height:70px;">
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;&nbsp;收款人</td>
								<td class="td2">
									<input class="easyui-textbox" name="invoicePayee" style="width: 300px" readonly="readonly"/>
								</td>
								
								<td></td>
								
								<td class="td1">&nbsp;&nbsp;复核人</td>
								<td class="td2">
									<input class="easyui-textbox" name="invoiceChecker" style="width: 300px" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;&nbsp;开票人</td>
								<td colspan="4">
									<input class="easyui-textbox" name="invoiceDrawer" style="width: 300px" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="票面" id="invoice-add-pm" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table id="invoice-coupon-dg" class="easyui-datagrid" style="width:900px;height:auto"
							data-options="
							toolbar: '#invoice-coupon-tb',
							method: 'post',
							striped : true,
							nowrap : false,
							rownumbers:true,
							scrollbarSize:0,
							singleSelect: true,
							">
							<thead>
								<tr>
									<th data-options="field:'icId',hidden:true"></th>
									<th data-options="field:'iId',hidden:true"></th>
									<th data-options="field:'goodsService',align:'center',width:135">货物或应税劳务、服务名称</th>
									<th data-options="field:'norms',align:'center',width:140">规格型号</th>
									<th data-options="field:'unit',align:'center',width:100">单位</th>
									<th data-options="field:'number',align:'center',width:100">数量</th>
									<th data-options="field:'univalent',align:'center',width:100">单价[元]</th>
									<th data-options="field:'amount',align:'center',width:100">金额[元]</th>
									<th data-options="field:'taxRate',align:'center',width:100">税率%</th>
									<th data-options="field:'tax',align:'center',width:100">税额[元]</th>
								</tr>
							</thead>
						</table>
							
						<div id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
							<table cellpadding="0" cellspacing="0" style="width: 100%">
							<tr style="height: 30px">
								<td>
									<a style="color: #ff6800">&nbsp;&nbsp;合计</a>
								</td>
								<td align="center" style="width: 100px">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style="color: #ff6800" id="coupon-amount">0.00</a>
								</td>	
								<td align="center" style="width: 100px"></td>	
								<td align="center" style="padding-right: 10px;width: 100px">
									&nbsp;&nbsp;&nbsp;&nbsp;<a style="color: #ff6800" id="coupon-tax">0.00</a>
								</td>		
							</tr>
							</table>
						</div>
						
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody" style="height: 50px">
								<td class="td1">价税合计（大写）</td>
								<td class="td2">
									<input class="easyui-textbox" name="priceCapitals" id="priceCapitals" style="width: 300px" data-options="" readonly="readonly"/>
								</td>
								
								<td style="width: 90px">
									<input type="hidden" name="iId" id="invoice_iId"/>
									<input type="hidden" name="type" id="invoice_type"/>
								</td>
								
								<td class="td1">价税合计（小写）</td>
								<td class="td2">
									<input class="easyui-textbox" name="priceLowerCase" id="priceLowerCase" style="width: 300px" data-options="" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<%-- <div title="发票附件" id="invoice-add-fpfj" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1">附件</td>
								<td colspan="4">
									<c:forEach items="${attaList}" var="att">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;margin-left: 8px">${att.originalName}</a><br>
									</c:forEach>
								</td>
							</tr>
						</table>
					</div> --%>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>

<script type="text/javascript">
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
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div>
<form id="invoice_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width: 942px">
			<div class="win-left-top-div">
				<div class="easyui-accordion" id="invoice-add-easyAcc" style="width:902px;margin-left: 20px;border: 0">
					<div title="发票信息" id="invoice-add-pt" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>发票代码</td>
								<td class="td2">
									<input class="easyui-numberbox" name="invoiceCode" style="width: 300px" 
									data-options="required:true,validType:'fpdm'" readonly="readonly"/>
								</td> 
								
								<td style="width: 90px">
									<!-- <input type="hidden" name="iId" id="invoice_iId"/> -->
									<input type="hidden" name="invoiceType" value="${kind}"/>
								</td>
								
								<td class="td1"><span class="style1">*</span>发票号码</td>
								<td class="td2">
									<input class="easyui-numberbox" name="invoiceNum" style="width: 300px"
									data-options="required:true,validType:'fphm'" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>开票日期</td>
								<td class="td2">
									<input class="easyui-datebox" name="invoiceTime" style="width: 300px"
									required="required" editable="false" readonly="readonly"/>
								</td>
								
								<td style="width: 90px"></td>
								
								<td class="td1"><span class="style1">*</span>税额合计</td>
								<td class="td2">
									<input class="easyui-numberbox" name="priceLowerCase" style="width: 300px"
									data-options="required:true,precision:2" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
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
		$("#invoice_add_form").form('load', invoicejson);//invoicejson是报销单页面中的全局变量，用来储存需要修改发票的行对象
		
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
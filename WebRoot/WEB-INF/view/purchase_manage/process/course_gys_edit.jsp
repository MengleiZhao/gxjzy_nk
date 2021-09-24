<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<form id="supplierForm">
	<table id="supplierTab" class="window-table" style="margin-top: 10px;width: 700px;overflow: hidden;" cellspacing="0" cellpadding="0" >
		<c:forEach items="${fwbean}" varStatus="i" var="invoice">
		<tbody id="supplier_${i.index}" style="overflow:hidden;">
			<tr>
				<td class="td1"></td>
				<td class="td1"></td>
				<td>供应商<c:if test="${i.index != '0'}">${i.index}</c:if></td>
				<td class="td1">
					<c:if test="${i.index != '0'}">
						<div>
							<a onclick="deleteSupplier(this)" style="float: right;" href="#" >
								<img style="vertical-align:bottom;margin-left:0px;margin-right: 5px;margin-top: 5px;" src="${base}/resource-modality/${themenurl}/button/gb1.jpg">
							</a>
						</div>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="td1"><span class="style1">*</span>&nbsp;供应商名称</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fwName_${i.index}" name="fwName" required="required"  data-options="" style="width: 587px;height: 30px;" value="${invoice.fwName}"/>
				</td>
			</tr>	
				
			<tr>
				<td class="td1" style="width: 70px">联系人</td>
				<td class="td2">
					<input class="easyui-textbox" id="F_fwuserName_${i.index}"  name="fwuserName" data-options=""  style="width: 230px; height: 30px;" value="${invoice.fwuserName}"/>
				</td>
				<td class="td1" style="width: 120px"><span class="style1">*</span>&nbsp;成交日期</td>
				<td class="td2">
					<input class="easyui-datebox" id="F_flastDealTime_${i.index}" name="flastDealTime" required="required"  data-options="editable:false" style="width: 230px; height: 30px;" value="${invoice.flastDealTime}"/>
				</td>
				
			</tr>
			<tr>
				<td class="td1" style="width: 120px">手机号码</td>
				<td class="td2">
					<input class="easyui-textbox" id="F_fwTel_${i.index}" name="fwTel"  data-options="validType:'length[11,11]'" style="width: 230px; height: 30px;" value="${invoice.fwTel}"/>
				</td>
				<td class="td1" style="width: 120px">座机号码</td>
				<td class="td2">
					<input class="easyui-textbox" id="F_fwStorageTel_${i.index}" name="fwStorageTel"  data-options="validType:'length[10,12]'" style="width: 230px; height: 30px;" value="${invoice.fwStorageTel}"/>
				</td>
			</tr>
			<tr>
				<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;成交金额[元]</td>
				<td class="td2">
					<input class="easyui-numberbox" id="F_dealAmount_${i.index}" name="dealAmount" required="required"  data-options="precision:2,onChange:dealAmountCheck" style="width: 230px; height: 30px;" value="${invoice.dealAmount}"/>
				</td>
				<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;允许浮增金额[元]</td>
				<td class="td2">
					<input class="easyui-numberbox" id="F_floatAmount_${i.index}" name="floatAmount" required="required"  data-options="precision:2,onChange:floatAmountCheck" style="width: 230px; height: 30px;" value="${invoice.floatAmount}"/>
				</td>
				
			</tr>
			
			<tr>
				<td class="td1" valign="top">&nbsp;&nbsp;备注</td>
				<td colspan="4" style="margin-top: 10px;">
					<input class="easyui-textbox" id="F_fwRemark_${i.index}" name="fwRemark"  data-options="validType:'length[1,200]',multiline:true" style="width:587px;height:70px;" value="${invoice.fwRemark}"/>
				</td>
			</tr>
			
		</tbody>
	</c:forEach>
	</table>
</form>
	<table class="window-table" style="margin-top: 10px;width: 700px;overflow: hidden;" cellspacing="0" cellpadding="0">
		<!-- 附件信息 -->
			<tr>
				<td class="td1" style="width:60px;">
					<span class="style1">*</span>&nbsp;附件
					<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'supplier','cggl01')" hidden="hidden">
				</td>
				<td colspan="3" id="tdf">
					<a onclick="$('#f').click()" style="font-weight: bold;  " href="#">
						<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
						<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
						 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
					</div>
					<c:forEach items="${brAttac}" var="att">
					<c:if test="${att.serviceType=='supplier'}">
						<div style="margin-top: 5px;">
						<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						</div>
					</c:if>	
					</c:forEach>
				</td>
			</tr>
	</table>
	<a onclick="appendSupplier(this)" style="font-weight: bold;vertical-align: middle;margin-left: 348px" href="#">
		<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
	</a>
<script type="text/javascript">
var a = ${fwbeanNum};
function appendSupplier(obj) {
	var fromNum = parseInt(obj.parentNode.parentNode.children[1].children[3].children[0].children.length);
	$('#supplierTab').append(
		'<tbody id="supplier_'+a+'">'+
			'<tr>'+
				'<td class="td1"></td>'+
				'<td class="td1"></td>'+
				'<th>供应商'+(fromNum)+'</th>'+
				'<td class="td1">'+
					'<div>'+
						'<a onclick="deleteSupplier(this)" style="float: right;" href="#" > '+
							'<img style="vertical-align:bottom;margin-left:0px;margin-right: 5px;margin-top: 5px;" src="${base}/resource-modality/${themenurl}/button/gb1.jpg">'+
						'</a>'+
					'</div>'+
				'</td>'+
			'</tr>'+
			'<tr>'+
				'<td class="td1"><span class="style1">*</span>&nbsp;供应商名称</td>'+
				'<td colspan="4">'+
					'<input class="easyui-textbox" id="F_fwName_'+a+'" name="fwName" required="required" data-options="" style="width: 587px;height: 30px;" value=""/>'+
				'</td>'+
			'</tr>'+
			'<tr>'+
				'<td class="td1" style="width: 70px">联系人</td>'+
				'<td class="td2">'+
					'<input class="easyui-textbox" id="F_fwuserName_'+a+'"  name="fwuserName" data-options="" style="width: 230px; height: 30px;" value=""/>'+
				'</td>'+
				'<td class="td1" style="width: 120px"><span class="style1">*</span>&nbsp;成交日期</td>'+
				'<td class="td2">'+
					'<input class="easyui-datebox" id="F_flastDealTime_'+a+'" name="flastDealTime" required="required" data-options="editable:false" style="width: 230px; height: 30px;" value=""/>'+
				'</td>'+
			'</tr>'+
			'<tr>'+
				'<td class="td1" style="width: 120px">手机号码</td>'+
				'<td class="td2">'+
					'<input class="easyui-textbox" id="F_fwTel_'+a+'" name="fwTel" data-options="validType:\'length[11,11]\'" style="width: 230px; height: 30px;" value=""/>'+
				'</td>'+
				'<td class="td1" style="width: 120px">座机号码</td>'+
				'<td class="td2">'+
					'<input class="easyui-textbox" id="F_fwStorageTel_'+a+'" name="fwStorageTel" data-options="validType:\'length[10,12]\'" style="width: 230px; height: 30px;" value=""/>'+
				'</td>'+
			'</tr>'+
			'<tr>'+
				'<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;成交金额[元]</td>'+
				'<td class="td2">'+
					'<input class="easyui-numberbox" id="F_dealAmount_'+a+'" name="dealAmount" required="required" data-options="precision:2,onChange:dealAmountCheck,iconWidth: 22" style="width: 230px; height: 30px;" value="0"/>'+
				'</td>'+
				'<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;允许浮增金额[元]</td>'+
				'<td class="td2">'+
					'<input class="easyui-numberbox" id="F_floatAmount_'+a+'" name="floatAmount" required="required" data-options="precision:2,onChange:floatAmountCheck,iconWidth: 22" style="width: 230px; height: 30px;" value="0"/>'+
				'</td>'+
			'</tr>'+
			'<tr>'+
				'<td class="td1" valign="top">&nbsp;&nbsp;备注</td>'+
				'<td colspan="4" style="margin-top: 10px;">'+
					'<input class="easyui-textbox" id="F_fwRemark_'+a+'" name="fwRemark" data-options="multiline:true" style="width:587px;height:70px;" value=""/>'+
				'</td>'+
			'</tr>'+
		'</tbody>'
	);
	$.parser.parse("#supplier_"+a);
	a = a + 1;
}

function  deleteSupplier(item){
	var fromNum = item.parentNode.parentNode.parentNode.parentNode.parentNode.children.length;
	var id = item.parentNode.parentNode.parentNode.parentNode.id;
	$("#"+id).remove();
	return ;
}

//将表单序列化成json格式的数据(但不适用于含有控件的表单，例如复选框、多选的select)
(function($) {
	$.fn.serializeJson = function() {
		var jsonData1 = {};
		var serializeArray = this.serializeArray();
		// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
		$(serializeArray).each(
				function() {
					if (jsonData1[this.name]) {
						if ($.isArray(jsonData1[this.name])) {
							jsonData1[this.name].push(this.value);
						} else {
							jsonData1[this.name] = [ jsonData1[this.name],
									this.value ];
						}
					} else {
						jsonData1[this.name] = this.value;
					}
				});
		// 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
		var vCount = 0;
		// 计算json内部的数组最大长度
		for ( var item in jsonData1) {
			var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length
					: 1;
			vCount = (tmp > vCount) ? tmp : vCount;
		}

		if (vCount > 1) {
			var jsonData2 = new Array();
			for (var i = 0; i < vCount; i++) {
				var jsonObj = {};
				for ( var item in jsonData1) {
					jsonObj[item] = jsonData1[item][i];
				}
				jsonData2.push(jsonObj);
			}
			return JSON.stringify(jsonData2);
		} else {
			return "[" + JSON.stringify(jsonData1) + "]";
		}
	};
})(jQuery);

function dealAmountCheck(newValue,oldValue){
	var sum = 0;
	for(var i = 0 ; i < $("#supplierTab")[0].children.length ; i++){
		var id = $("#supplierTab")[0].children[i].id;
		var a = id.lastIndexOf("\_");
		var b = id.substring(a + 1, id.length);
		var floatAmount = $("#F_floatAmount_"+b).numberbox('getValue');
		var dealAmount = $("#F_dealAmount_"+b).numberbox('getValue');
		sum += parseInt(floatAmount)+parseInt(dealAmount);
	}
	var d = parseInt("${bean.fpAmount}");
	
	var h = this.id.lastIndexOf("\_");
	var j = this.id.substring(h + 1, this.id.length);
	if(sum>d){
		alert("成交金额与允许浮增金额之和大于申请金额！");
		$("#F_dealAmount_"+j).numberbox('setValue','0');
		return;
	}
}
function floatAmountCheck(newValue,oldValue){
	var sum = 0;
	for(var i = 0 ; i < $("#supplierTab")[0].children.length ; i++){
		var id = $("#supplierTab")[0].children[i].id;
		var a = id.lastIndexOf("\_");
		var b = id.substring(a + 1, id.length);
		var floatAmount = $("#F_floatAmount_"+b).numberbox('getValue');
		var dealAmount = $("#F_dealAmount_"+b).numberbox('getValue');
		sum += parseInt(floatAmount)+parseInt(dealAmount);
	}
	var d = parseInt("${bean.fpAmount}");
	
	var h = this.id.lastIndexOf("\_");
	var j = this.id.substring(h + 1, this.id.length);
	if(sum>d){
		alert("成交金额与允许浮增金额之和大于申请金额！");
		$("#F_floatAmount_"+j).numberbox('setValue','0');
		return;
	}
}
</script>
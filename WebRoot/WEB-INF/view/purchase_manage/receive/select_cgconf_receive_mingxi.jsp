<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="plan_receive_dg" class="easyui-datagrid" style="width:700px;height:auto"
data-options="
singleSelect: true,
rownumbers : true,
striped:true,
 <c:if test="${empty acptbean.facpId}">
url: '${base}/cgreceive/mingxi?id=${bean.fpId}',
onLoadSuccess:onLoadSuccessAmount,
</c:if>
<c:if test="${!empty acptbean.facpId}">
url: '${base}/cgreceive/mingxi?id=${bean.fpId}&type=3',
</c:if>
<c:if test="${empty fIsContract}">
onClickRow: onClickRowReceive
</c:if>
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fIsImp',hidden:true"></th>
		<th data-options="field:'fSiteAndPeriod',hidden:true"></th>
		<th data-options="field:'fManager',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154">商品名称</th>
		<th data-options="field:'fpurBrand',align:'center',width:154,editor:'textbox'">品牌</th>
		<th data-options="field:'fModel',align:'center',width:154,editor:'textbox'">型号</th>
		<th data-options="field:'fspec',align:'center',width:154,editor:'textbox'">规格</th>
		<th data-options="field:'fnum',align:'center',width:70">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center',width:70">单位</th>
		<th data-options="field:'funitPrice',align:'center',width:110">单价(元)</th>
		<th data-options="field:'fsumMoney',align:'center',width:110">金额(元)</th>
	</tr>
</thead>
</table>
<input type="hidden" id="mingxiJson" name="mingxi"/>
<script type="text/javascript">

//明细表格添加删除，保存方法
var editIndexReceive = undefined;
function endEditingReceive() {
	if (editIndexReceive == undefined) {
		return true;
	}
	if ($('#plan_receive_dg').datagrid('validateRow', editIndexReceive)) {
		var ed = $('#plan_receive_dg').datagrid('getEditor', {
			index : editIndexReceive,
			field : 'costDetail'
		});
		$('#plan_receive_dg').datagrid('endEdit', editIndexReceive);
		editIndexReceive = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowReceive(index) {
	if (editIndexReceive != index) {
		if (endEditingReceive()) {
			$('#plan_receive_dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndexReceive = index;
		} else {
			$('#plan_receive_dg').datagrid('selectRow', editIndexReceive);
		}
	}
}
function acceptReceive() {
	if (endEditingReceive()) {
		$('#plan_receive_dg').datagrid('acceptChanges');
	}
}

function receiveJson(){
	acceptReceive();
	var rows2 = $('#plan_receive_dg').datagrid('getRows');
	var receiveJson = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			receiveJson = receiveJson + JSON.stringify(rows2[i]) + ",";
		}
		
		for (var j = 0; j < rows2.length; j++) {
			if(rows2[j].fpurBrand=='' || rows2[j].fModel=='' || rows2[j].fspec==''){
				return false;
			}
		}
		
		$('#mingxiJson').val(receiveJson);
		return true;
	}
}

function onLoadSuccessAmount(){
	var rows2 = $('#plan_receive_dg').datagrid('getRows');
	var amount = 0;
	for (var j = 0; j < rows2.length; j++) {
		var fsumMoney = parseFloat(rows2[j].fsumMoney);
		if(isNaN(fsumMoney)){
			fsumMoney = 0;
		}
		amount = amount +fsumMoney;
	}
	$('#F_facpAmount').val(amount.toFixed(2));
}
</script>
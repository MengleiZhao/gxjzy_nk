<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" id="directly-edit-div" style="margin-left: 0px;padding-top: 10px">
	<div id="directly-edit-tb" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;font-weight:bold;">报销金额：<span id="directlyeditAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a href="javascript:void(0)" onclick="directlyremoveit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="directlyappend()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<table id="directly-edit-tab" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	toolbar: '#directly-edit-tb',
	url: '${base}/directlyReimburse/mingxi?id=${bean.drId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	onClickRow: directlyonClickRow,
	scrollbarSize:0,
	singleSelect: true,
	<c:if test="${detail =='add'}">
	onLoadSuccess:directlyappend
	</c:if>
	">
		<thead>
			<tr>
				<th data-options="field:'cId',hidden:true"></th>
				<th data-options="field:'costDetail',required:'required',align:'center',editor:{type:'textbox',options:{}}" width='20%'>费用名称</th>
				<th data-options="field:'applySum',required:'required',align:'center',editor:{type:'numberbox',options:{onChange:directlyaddNum,precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='50%'>报销金额</th>
				<th data-options="field:'remark',required:'required',align:'center',editor:{type:'textbox',options:{}}" width='30%'>描述</th>
			</tr>
		</thead>
	</table>
	
</div>
<script type="text/javascript">
var rcommomey = 0.00;
//明细表格添加删除，保存方法
var editIndex = undefined;
function directlyendEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#directly-edit-tab').datagrid('validateRow', editIndex)) {
		var ed = $('#directly-edit-tab').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#directly-edit-tab').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function directlyonClickRow(index) {
	if (editIndex != index) {
		if (directlyendEditing()) {
			$('#directly-edit-tab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#directly-edit-tab').datagrid('selectRow', editIndex);
		}
	}
}
function directlyappend() {
	if (directlyendEditing()) {
		$('#directly-edit-tab').datagrid('appendRow', {});
		editIndex = $('#directly-edit-tab').datagrid('getRows').length - 1;
		$('#directly-edit-tab').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	//页面随滚动条置底
	var div = document.getElementById('directly-edit-div');
	div.scrollTop = div.scrollHeight;
}
function directlyremoveit() {
	if (editIndex == undefined) {
		return
	}
	$('#directly-edit-tab').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#directly-edit-tab').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
	}
	$('#num1').textbox('setValue',num);
	//$('#applyAmount').textbox('setValue',num);
	$('#directlyeditAmount').html(num.toFixed(2)+'[元]');
	$('#reimburseAmount').val(num.toFixed(2));//报销总额
	$('#p_amount').html(parseFloat(num).toFixed(2)+'[元]');//报销总额
	//$('#directlyeditAmount').val(num.toFixed(2));//报销总额
	//$('#p_amount').val(num.toFixed(2));//报销总额
}
function directlyaccept() {
	if (directlyendEditing()) {
		$('#directly-edit-tab').datagrid('acceptChanges');
	}
}
function directlyaddNum (oldValue,newValue){
	var directlyeditAmount = 0.00;
	var rows = $('#directly-edit-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		if(i==editIndex){
			var row = $('#directly-edit-tab').datagrid('getSelected');//获得选择行
			var index=$('#directly-edit-tab').datagrid('getRowIndex',row);//获得选中行的行号
			var tr = $('#directly-edit-tab').datagrid('getEditors', index);
			var applySum = isNaN(tr[1].target.numberbox('getValue'))?0.00:tr[1].target.numberbox('getValue');
			directlyeditAmount = parseFloat(directlyeditAmount) +  parseFloat(applySum);
		}else {
			var applySum = isNaN(parseFloat(rows[i].applySum))?parseFloat(0.00):parseFloat(rows[i].applySum);
			directlyeditAmount = parseFloat(directlyeditAmount) +  parseFloat(applySum);
		}
	}
	$('#directlyeditAmount').html(directlyeditAmount.toFixed(2)+'[元]');
	$('#reimburseAmount').val(directlyeditAmount.toFixed(2));//报销总额
	$('#p_amount').html(parseFloat(directlyeditAmount).toFixed(2)+'[元]');//报销总额
	
}
function directlyjson(){
	directlyaccept();
	var mingxi = "";
	var rows = $('#directly-edit-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
		rcommomey = parseFloat(rcommomey) + parseFloat(rows[i].applySum);
	}
	$('#mingxiJson').val(mingxi);
}

</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" id="rcomm-edit-div" style="margin-left: 0px;padding-top: 10px">
	<div id="rcomm-detail-tb" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rcommeditAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<table id="rcomm-detail-tab" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	toolbar: '#rcomm-detail-tb',
	url: '${base}/reimburse/mingxiTY?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
		<thead>
			<tr>
				<th data-options="field:'cId',hidden:true"></th>
				<th data-options="field:'costDetail',align:'center',editor:{type:'textbox',options:{required:'true'}}" width='30%'>费用名称</th>
				<th data-options="field:'applySum',hidden:true,align:'center',editor:{type:'numberbox',options:{readonly:'true',precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='20%'>申请金额</th>
				<th data-options="field:'remibAmount',align:'center',editor:{type:'numberbox',options:{onChange:rcommaddNum,required:'true',precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='30%'>报销金额</th>
				<th data-options="field:'remark',required:'required',align:'center',editor:'textbox'" width='40%'>描述</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
//明细表格添加删除，保存方法
var editIndex = undefined;
function commendEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#rcomm-detail-tab').datagrid('validateRow', editIndex)) {
		var ed = $('#rcomm-detail-tab').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#rcomm-detail-tab').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function commonClickRow(index) {
	if (editIndex != index) {
		if (commendEditing()) {
			$('#rcomm-detail-tab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#rcomm-detail-tab').datagrid('selectRow', editIndex);
		}
	}
}
function commappend() {
	if (commendEditing()) {
		$('#rcomm-detail-tab').datagrid('appendRow', {});
		editIndex = $('#rcomm-detail-tab').datagrid('getRows').length - 1;
		$('#rcomm-detail-tab').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	//页面随滚动条置底
	var div = document.getElementById('rcomm-edit-div');
	div.scrollTop = div.scrollHeight;
}
function commremoveit() {
	if (editIndex == undefined) {
		return
	}
	$('#rcomm-detail-tab').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#rcomm-detail-tab').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
	}
	$('#num1').textbox('setValue',num);
	$('#applyAmount').textbox('setValue',num);
}
function commaccept() {
	if (commendEditing()) {
		$('#rcomm-detail-tab').datagrid('acceptChanges');
	}
}
function rcommaddNum (oldValue,newValue){
	var rcommeditAmount = 0.00;
	var rows = $('#rcomm-detail-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if(i==editIndex){
			var row = $('#rcomm-detail-tab').datagrid('getSelected');//获得选择行
			var index=$('#rcomm-detail-tab').datagrid('getRowIndex',row);//获得选中行的行号
			var tr = $('#rcomm-detail-tab').datagrid('getEditors', index);
			var reimbSum = isNaN(tr[2].target.numberbox('getValue'))?0.00:tr[2].target.numberbox('getValue');
			rcommeditAmount = parseFloat(rcommeditAmount) +  parseFloat(reimbSum);
		}else {
			var reimbSum = isNaN(parseFloat(rows[i].reimbSum))?parseFloat(0.00):parseFloat(rows[i].reimbSum);
			rcommeditAmount = parseFloat(rcommeditAmount) +  parseFloat(reimbSum);
		}
	}
	$('#rcommeditAmount').html(rcommeditAmount+'[元]');
	$('#reimburseAmount').val(rcommeditAmount);//报销总额
	
}
function commjson(){
	var mingxi = "";
	var rows = $('#rcomm-detail-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	console.log(mingxi);
	$('#mingxiJson').val(mingxi);
}

</script>
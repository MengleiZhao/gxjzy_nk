<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="business_add_details_dg" class="easyui-datagrid" style="width:660px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
striped:true,
url: '${base}/business/addDetails?id=${bean.fBusiId }',
method: 'post',
onClickRow: onClickRow
">
<thead>
	<tr>
		<th data-options="field:'fdId',hidden:true"></th>
		<th data-options="field:'fChargeItems',align:'center',editor:'textbox'" style="width: 25%">收费项目</th>
		<th data-options="field:'fChargeUnit',align:'center',editor:'textbox'" style="width: 20%">计费单位</th>
		<th data-options="field:'fChargeAdvice',align:'center',editor:'textbox'" style="width: 25%">收费标准意见</th>
		<th data-options="field:'fRemark',align:'left',editor:'textbox'" style="width: 33%">备注</th>
	</tr>
</thead>
</table>
<div id="tb" style="height:30px">
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
<script type="text/javascript">
//明细表格添加删除，保存方法
var editIndex = undefined;
//结束编辑状态
function endEditing() {
	if (editIndex == undefined) {
		return true;
	}
	if ($('#business_add_details_dg').datagrid('validateRow', editIndex)) {
		$('#business_add_details_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
//行被点击事件
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#business_add_details_dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#business_add_details_dg').datagrid('selectRow', editIndex);
		}
	}
}
//添加一行
function append() {
	if (endEditing()) {
		$('#business_add_details_dg').datagrid('appendRow', {});
		editIndex = $('#business_add_details_dg').datagrid('getRows').length - 1;
		$('#business_add_details_dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	} 
}
//删除一行
function removeit() {
	if (editIndex == undefined) {
		alert('请点击需要删除的行！');
		return;
	}
	$('#business_add_details_dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
//使列表结束编辑状态
function accept() {
	if (endEditing()) {
		$('#business_add_details_dg').datagrid('acceptChanges');
	}
}
//存入json
function getMingxiJson(){
	accept();
	var rows = $('#business_add_details_dg').datagrid('getRows');
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#mingxiJson').val(mingxi);
}
</script>



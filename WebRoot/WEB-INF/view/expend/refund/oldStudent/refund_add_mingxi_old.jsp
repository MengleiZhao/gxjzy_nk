<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="refund_add_mingxi_old_dg" class="easyui-datagrid" style="margin-left: 0px;padding-top: 10px;"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
striped:true,
url: '${base}/refund/mingxi?id=${bean.fRID }',
method: 'post',
onClickRow: onClickRow
">
<thead>
	<tr>
		<th data-options="field:'fId',hidden:true"></th>
		<th data-options="field:'studentName',align:'center',editor:'textbox'" style="width: 20%">学生姓名</th>
		<th data-options="field:'studentCollege',align:'center',editor:'textbox'" style="width: 20%">所属学院</th>
		<th data-options="field:'studentClass',align:'center',editor:'textbox'" style="width: 20%">专业班级</th>
		<th data-options="field:'idNumber',align:'center',editor:'textbox'" style="width: 25%">学号</th>
		<th data-options="field:'moneyCode',align:'center',editor:'textbox'" style="width: 20%">收费单号</th>
		<th data-options="field:'refundReason',align:'center',editor:'textbox'" style="width: 20%">退费原因</th>
		<th data-options="field:'payedTuition',align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 15%">已交学费[元]</th>
		<th data-options="field:'payedRoom',align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 15%">已交住宿费[元]</th>
		<th data-options="field:'refundTuition',align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 15%">应退学费[元]</th>
		<th data-options="field:'refundRoom',align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 15%">应退住宿费[元]</th>
		<th data-options="field:'tel',align:'center',editor:'textbox'" style="width: 20%">联系电话</th>
		<th data-options="field:'classTeacher',align:'center',editor:'textbox'" style="width: 15%">班主任</th>
		<th data-options="field:'sumMoney',hidden:true,align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 20%">合计金额</th>
		<th data-options="field:'filess',align:'center',formatter:lookFiles" style="width:8%">附件</th>
		<th data-options="field:'fileFid',align:'center',hidden:true" style="width:8%">附件ID</th>
	</tr>
</thead>
</table>
<div id="tb" style="height:30px;margin-top: 5px;">
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
	if ($('#refund_add_mingxi_old_dg').datagrid('validateRow', editIndex)) {
		$('#refund_add_mingxi_old_dg').datagrid('endEdit', editIndex);
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
			$('#refund_add_mingxi_old_dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#refund_add_mingxi_old_dg').datagrid('selectRow', editIndex);
		}
	}
}
//添加一行
function append() {
	if (endEditing()) {
		$('#refund_add_mingxi_old_dg').datagrid('appendRow', {});
		editIndex = $('#refund_add_mingxi_old_dg').datagrid('getRows').length - 1;
		$('#refund_add_mingxi_old_dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	} 
}
//删除一行
function removeit() {
	if (editIndex == undefined) {
		alert('请点击需要删除的行！');
		return;
	}
	$('#refund_add_mingxi_old_dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
//使列表结束编辑状态
function accept() {
	if (endEditing()) {
		$('#refund_add_mingxi_old_dg').datagrid('acceptChanges');
	}
}
//存入json
function getMingxiJson(){
	accept();
	var rows = $('#refund_add_mingxi_old_dg').datagrid('getRows');
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#mingxiJson').val(mingxi);
}



//点击查看附件
function lookFiles(val, row, index) {
	return '<a href="#" onclick="clickLookFiles(\'' + row.fId + '\',\'' + index + '\',\'' + row.fileFid + '\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + 
	'</a>';
}
//查看附件
function clickLookFiles(id,index,fileFid){
	var win = creatFirstWin('附件上传', 600, 300, 'icon-search','/refund/filesjsp/' + id+'?type=1&index=' + index + '&val='+fileFid+'&fliesType=refund_add_mingxi_old_dg');
	win.window('open');
}
</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>


<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<div id="trafficInCity_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-其他费用</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="traffic2Amount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsInMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<c:if test="${empty detail}">
		<a href="javascript:void(0)" id="removeInCityId" onclick="removeit8()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendInCityId" onclick="append8()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</c:if>
	</div>
	<table id="mingxi-trafficInCity-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: 'trafficInCity_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=traffic2',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow8,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'thId',hidden:true"></th>
				<th data-options="field:'costName',required:'required',align:'center',width:230,editor:{type:'textbox'}">费用名称</th>
				<c:if test="${empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:250,editor:{type:'numberbox',options:{onChange:addNum6,precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<c:if test="${!empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:250,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<th data-options="field:'remark',required:'required',align:'center',width:230,editor:{type:'textbox'}">备注</th>
		</tr>
	</thead>
	</table>
	
</div>

<input type="hidden" id="trafficJson2" name="trafficJson2"/>
<script type="text/javascript">
function getTrafficJson2(){
	accept8();
	var rows = $('#mingxi-trafficInCity-dg').datagrid('getRows');
	var trafficJson2 = "";
	for (var i = 0; i < rows.length; i++) {
		trafficJson2 = trafficJson2 + JSON.stringify(rows[i]) + ",";
	}
	$('#trafficJson2').val(trafficJson2);
}
function append8(){
	if (endEditing8()) {
		$('#mingxi-trafficInCity-dg').datagrid('appendRow', {});
		editIndex8 = $('#mingxi-trafficInCity-dg').datagrid('getRows').length - 1;
		$('#mingxi-trafficInCity-dg').datagrid('selectRow', editIndex8).datagrid('beginEdit',editIndex8);
	}
}
function removeit8(){
	if (editIndex8 == undefined) {
		return false;
	}
	$('#mingxi-trafficInCity-dg').datagrid('cancelEdit', editIndex8).datagrid('deleteRow',
			editIndex8);
	editIndex8 = undefined;
}
//接待人员表格添加删除，保存方法
var editIndex8 = undefined;
function endEditing8() {
	if (editIndex8 == undefined) {
		return true
	}
	if ($('#mingxi-trafficInCity-dg').datagrid('validateRow', editIndex8)) {
		$('#mingxi-trafficInCity-dg').datagrid('endEdit', editIndex8);
		editIndex8 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow8(index) {
		if (editIndex8 != index) {
			if (endEditing8()) {
				$('#mingxi-trafficInCity-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex8 = index;
			} else {
				$('#mingxi-trafficInCity-dg').datagrid('selectRow', editIndex8);
			}
		}
}
function accept8() {
	if (endEditing8()) {
		$('#mingxi-trafficInCity-dg').datagrid('acceptChanges');
	}
}
//计算申请金额
function addNum6(newValue,oldValue) {
		var num = 0;
		var rows = $('#mingxi-trafficInCity-dg').datagrid('getRows');
		var row = $('#mingxi-trafficInCity-dg').datagrid('getSelected');//获得选择行
		var index=$('#mingxi-trafficInCity-dg').datagrid('getRowIndex',row);//获得选中行的行号
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].applySum!=""&&rows[i].applySum!=null){
					num += parseFloat(rows[i].applySum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#lessonsInMoney').val(num.toFixed(2));
		$('#traffic2Amount').html(fomatMoney(num,2)+"[元]");
		addTotalAmount();
}
</script>

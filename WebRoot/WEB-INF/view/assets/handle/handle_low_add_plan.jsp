<%@ page language="java" pageEncoding="UTF-8"%>


<table id="low_handle_plan" class="easyui-datagrid"  style="height:auto;"
	data-options="
		iconCls: 'icon-edit',
		singleSelect: true,
		rownumbers:true,
		toolbar: '#tb',
		<c:if test="${bean.fId!=null}">url: '${base}/Handle/assetRegJson?fId=${bean.fId }&fAssType=${bean.fAssType.code }',</c:if>
		method: 'post',
		<c:if test="${openType=='add'||openType=='edit'}">onClickCell: onClickCellPlan</c:if>
	">
	<thead>
		<tr>
			<th data-options="field:'fAssName',align:'center',<c:if test="${empty fId}">editor:'textbox',</c:if>" style="width: 15%">资产名称</th>
			<th data-options="field:'fSPModel',align:'center'<c:if test="${empty fId}">,editor:'textbox'</c:if>" style="width: 15%">规格型号</th>
			<th data-options="field:'fMeasUnit',align:'center'<c:if test="${empty fId}">,editor:'textbox'</c:if>" style="width: 10%">计量单位</th>
			<th data-options="field:'fHandleNum',align:'center'<c:if test="${empty fId}">,editor:{type:'numberbox',options:{onChange:acountNum,precision:2}}</c:if>" style="width: 15%">数量</th>
			<th data-options="field:'fSignPrice',align:'right'<c:if test="${empty fId}">,editor:{type:'numberbox',options:{onChange:acountNum,precision:2}}</c:if>" style="width: 15%">单价(元)</th>
			<th data-options="field:'fAmount',align:'right'<c:if test="${empty fId}">,editor:{type:'numberbox',options:{onChange:sumAcount,precision:2}}</c:if>" style="width: 15%">总金额(元)</th>
			<th data-options="field:'fRemarkR',align:'left'<c:if test="${empty fId}">,editor:'textbox'</c:if>" style="width: 16%">备注</th>
		</tr>
	</thead>
</table>
<c:if test="${openType=='add'||openType=='edit'}">
<div id="tb" style="height:30px;">
	<a href="javascript:void(0)" onclick="removePlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" id="addFixedButton" onclick="appendPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<script type="text/javascript">
//填写总值的数据
function acountNum(newValue,oldValue){
	var row = $('#low_handle_plan').datagrid('getSelected');//获得选择行
	var index=$('#low_handle_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#low_handle_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[3].target.numberbox('getValue');//获得数量
	var price = tr[4].target.numberbox('getValue');//获得单价
	tr[5].target.numberbox('setValue',num*price);//设置给后面一个
	/* var sumAmounct = $('#H_fSumAmount').numberbox('getValue');//获得合计金额
	if(null==sumAmounct||sumAmounct==''){
		sumAmounct=0.00;
	}
	sumAmounct = parseFloat(sumAmounct)+(num*price);//parseFloat
	$('#H_fSumAmount').numberbox('setValue',sumAmounct);//设置到合计金额 */
	
}
//总值校验是否正确
function sumAcount(newValue,oldValue){
	var row = $('#low_handle_plan').datagrid('getSelected');//获得选择行
	var index=$('#low_handle_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#low_handle_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[3].target.numberbox('getValue');//获得数量
	var price = tr[4].target.numberbox('getValue');//获得单价
	if((num*price)!=newValue){
		tr[5].target.numberbox('setValue',num*price);//设置值一个正确的值给总值
	}
	
	//设置总额
	var rows = $('#low_handle_plan').datagrid('getRows');//获得选择行
	var num1 = 0;
	for (var i = 0; i < rows.length; i++) {
	  if (!isNaN(parseFloat(rows[i]['fAmount']))) {
	  	num1 += parseFloat(rows[i]['fAmount']);
	  }
	}
	var num = parseFloat(newValue);
	var numOld = parseFloat(row.fAmount);
	if (!isNaN(num)) {
		if (!isNaN(numOld) && isNaN(parseFloat(oldValue))) {
			return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			} else {
				num1 = num1 + num;
			}
		}
	}
	$('#H_fSumAmount').numberbox('setValue', num1);
	
	
}



function PayStauts(val) {
	$('#low_handle_plan').datagrid('updateRow',{
		index: editIndex,
		row: {
			fAssName_R: val.text,
			fMeasUnit_R: val.SftjCode,
			fAssCode_R: val.code
		}
	}); 
	if(val.text=='新增'){
		var win=creatFirstWin('新增资产品目',970,580,'icon-search','/AssetBasicInfo/lowAddOther');
		win.window('open');
	}
}
var editIndex = undefined;
function endEditingPlan(){
	if (editIndex == undefined){return true}
	if ($('#low_handle_plan').datagrid('validateRow', editIndex)){
		$('#low_handle_plan').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellPlan(index, field){
	if (editIndex != index){
		if (endEditingPlan()){
			$('#low_handle_plan').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#low_handle_plan').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex = index;
		} else {
			setTimeout(function(){
				$('#low_handle_plan').datagrid('selectRow', editIndex);
			},0);
		}
	}
}
function appendPlan(){
	if (endEditingPlan()){
		$('#low_handle_plan').datagrid('appendRow',{});
		editIndex = $('#low_handle_plan').datagrid('getRows').length-1;
		$('#low_handle_plan').datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	document.getElementById("low_handle_plan").scrollIntoView();
	}
}
function removePlan(){
	if (editIndex == undefined){return };
	$('#low_handle_plan').datagrid('cancelEdit', editIndex)
			.datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
function testPlan(){
	var entities= getPlan();
	 alert(entities);
}
function getPlan(){
	$('#low_handle_plan').datagrid('acceptChanges');
	var rows = $('#low_handle_plan').datagrid('getRows');
	var entities= '';
	for(i = 0;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	 entities = '[' + entities.substring(0,entities.length -1) + ']';
	 return entities;
}
</script>
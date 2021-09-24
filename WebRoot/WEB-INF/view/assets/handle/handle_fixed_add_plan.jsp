<%@ page language="java" pageEncoding="UTF-8"%>


<table id="fixed_add_plan" class="easyui-datagrid"  style="height:auto;"
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
			<th data-options="field:'fAssCode',align:'center',<c:if test="${empty fId}">editor:'textbox'</c:if>" style="width: 20%">资产编号</th>
			<th data-options="field:'fAssName',align:'center',<c:if test="${empty fId}">editor:'textbox'</c:if>" style="width: 20%">资产名称</th>
			<th data-options="field:'fSPModel',align:'center',<c:if test="${empty fId}">editor:'textbox'</c:if>" style="width: 15%">规格型号</th>
			<th data-options="field:'fWxTime',align:'center',<c:if test="${empty fId}">editor:{type:'numberbox',options:{precision:2}}</c:if>" style="width: 20%">规定使用年限(年)</th>
			<th data-options="field:'fUsedTime',align:'center',<c:if test="${empty fId}">editor:{type:'numberbox',options:{precision:2}}</c:if>" style="width: 20%">已使用年限(年)</th>
			<th data-options="field:'fUnusedTime',align:'center',<c:if test="${empty fId}">editor:{type:'numberbox',options:{precision:2}}</c:if>" style="width: 20%">还可以使用年限(年)</th>
			<th data-options="field:'fHandleNum',align:'center',<c:if test="${empty fId}">editor:{type:'numberbox',options:{precision:2}}</c:if>" style="width: 15%">数量</th>
			<th data-options="field:'fOldAmount',align:'right',<c:if test="${empty fId}">editor:{type:'numberbox',options:{precision:2}}</c:if>" style="width: 15%">资产原值(元)</th>
			<th data-options="field:'fResidualValue',align:'right',<c:if test="${empty fId}">editor:{type:'numberbox',options:{precision:2}}</c:if>" style="width: 15%">资产残值(元)</th>
			<th data-options="field:'fAddress',align:'center',<c:if test="${empty fId}">editor:'textbox'</c:if>" style="width: 20%">存放地点</th>
			<th data-options="field:'fRemarkR',align:'left',<c:if test="${empty fId}">editor:'textbox'</c:if>" style="width: 20%">备注</th>
			<th data-options="field:'fBuyTime',align:'center',<c:if test="${empty fId}">editor:{type:'datebox',options:{editable:false}},formatter:ChangeDateFormat</c:if>" style="width: 20%">验收日期</th>
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
/* //填写总值的数据
function acountNum(newValue,oldValue){
	var row = $('#fixed_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#fixed_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#fixed_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[7].target.numberbox('getValue');//获得数量
	var price = tr[8].target.numberbox('getValue');//获得单价
	tr[9].target.numberbox('setValue',num*price);//设置给后面一个
	$('#S_fSumAmount').numberbox('setValue',num*price);//设置到合计金额
	
}
//总值校验是否正确
function sumAcount(newValue,oldValue){
	var row = $('#fixed_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#fixed_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#fixed_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[7].target.numberbox('getValue');//获得数量
	var price = tr[8].target.numberbox('getValue');//获得单价
	if((num*price)!=newValue){
		alert("请输入正确总值！");
		tr[9].target.numberbox('setValue',num*price);//设置值一个正确的值给总值
		
	}
	
} */
	function PayStauts(val) {
		$('#fixed_add_plan').datagrid('updateRow',{
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
		if ($('#fixed_add_plan').datagrid('validateRow', editIndex)){
			$('#fixed_add_plan').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCellPlan(index, field){
		if (editIndex != index){
			if (endEditingPlan()){
				$('#fixed_add_plan').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				var ed = $('#fixed_add_plan').datagrid('getEditor', {index:index,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}
				editIndex = index;
			} else {
				setTimeout(function(){
					$('#fixed_add_plan').datagrid('selectRow', editIndex);
				},0);
			}
		}
	}
	function appendPlan(){
		if (endEditingPlan()){
			$('#fixed_add_plan').datagrid('appendRow',{});
			editIndex = $('#fixed_add_plan').datagrid('getRows').length-1;
			$('#fixed_add_plan').datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		document.getElementById("fixed_add_plan").scrollIntoView();
		}
	}
	function removePlan(){
		if (editIndex == undefined){return };
		$('#fixed_add_plan').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	function testPlan(){
		var entities= getPlan();
		 alert(entities);
	}
	function getPlan(){
		$('#fixed_add_plan').datagrid('acceptChanges');
		var rows = $('#fixed_add_plan').datagrid('getRows');
		var entities= '';
		for(i = 0;i < rows.length;i++){
		 entities = entities  + JSON.stringify(rows[i]) + ',';  
		}
		 entities = '[' + entities.substring(0,entities.length -1) + ']';
		 return entities;
	}
</script>
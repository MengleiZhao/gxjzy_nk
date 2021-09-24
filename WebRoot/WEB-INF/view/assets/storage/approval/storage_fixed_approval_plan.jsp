<%@ page language="java" pageEncoding="UTF-8"%>


   <table id="fixed_add_plan" class="easyui-datagrid"  style="height:auto;"
		data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
			rownumbers:true,
			toolbar: '#tb',
			<c:if test="${fpCode!=null}">url: '${base}/Storage/cgpmJsonPagination?fpCode=${fpCode }&fAssType=${bean.fAssType }',</c:if>
			<c:if test="${fpCode==null}">url: '${base}/Storage/lowJsonPagination?fAssStorageCode=${bean.fAssStorageCode }',</c:if>
			method: 'post',
			onClickCell: onClickCellPlan
		">
	<thead>
		<tr>
			<th data-options="field:'fSysCodeR',align:'center',<c:if test="${empty fpCode}">editor:'textbox'</c:if>" style="width: 20%">资产编号</th>
			<th data-options="field:'fAssCodeR',align:'center',<c:if test="${empty fpCode}">editor:'textbox'</c:if>" style="width: 20%">资产名称系统编号</th>
			<th data-options="field:'fFinancialCodeR',align:'center',<c:if test="${empty fpCode}">editor:'textbox'</c:if>" style="width: 20%">国资分类号</th>
			<th data-options="field:'fAssNameR',align:'center',<c:if test="${empty fpCode}">editor:{options:{readonly:true}},</c:if>" style="width: 20%">资产名称</th>
			<th data-options="field:'fmMode',align:'center'<c:if test="${empty fpCode}">,editor:'text'</c:if>" style="width: 20%">型号</th>
			<th data-options="field:'fmSpecif',align:'center'<c:if test="${empty fpCode}">,editor:'text'</c:if>" style="width: 20%">规格</th>
			<th data-options="field:'fMeasUnitR',align:'center'<c:if test="${empty fpCode}">,editor:'textbox'</c:if>" style="width: 10%">单位</th>
			<th data-options="field:'fInsNumR',align:'center'<c:if test="${empty fpCode}">,editor:{type:'numberbox',options:{readonly:true,onChange:acountNum,precision:2}}</c:if>" style="width: 10%">数量</th>
			<th data-options="field:'fSignPrice',align:'center'<c:if test="${empty fpCode}">,editor:{type:'numberbox',options:{onChange:acountNum,precision:2}}</c:if>" style="width: 10%">单价(元)</th>
			<th data-options="field:'fAmount',align:'center'<c:if test="${empty fpCode}">,editor:{type:'numberbox',options:{onChange:sumAcount,precision:2}}</c:if>" style="width: 10%">总金额(元)</th>
			<th data-options="field:'fActionDate',align:'center',editor:{type:'datebox'},formatter:ChangeDateFormat3" style="width: 20%">资产验收日期</th>
			<th data-options="field:'fRemarkR',align:'center'<c:if test="${empty fpCode}">,editor:{type:'textbox'}</c:if>" style="width: 30%">备注</th>
			
			<!-- <th data-options="field:'fSysCodeR',align:'center'" style="width: 20%">资产名称系统编号</th>
			<th data-options="field:'fAssCodeR',align:'center'" style="width: 20%">固定资产标签编号</th>
			<th data-options="field:'fAssStorageCodeR',align:'center'" style="width: 20%">财政编码</th>
			<th data-options="field:'fAssNameR',align:'center'" style="width: 20%">资产名称</th>
			<th data-options="field:'fmMode',align:'center'" style="width: 20%">型号</th>
			<th data-options="field:'fmSpecif',align:'center'" style="width: 20%">规格</th>
			<th data-options="field:'fMeasUnitR',align:'center'" style="width: 10%">单位</th>
			<th data-options="field:'fInsNumR',align:'center'" style="width: 10%">数量</th>
			<th data-options="field:'fSignPrice',align:'center'" style="width: 10%">单价(元)</th>
			<th data-options="field:'fAmount',align:'center'" style="width: 10%">总值(元)</th>
			<th data-options="field:'fActionDate',formatter:ChangeDateFormat,align:'center'" style="width: 20%">资产验收日期</th>
			<th data-options="field:'fRemarkR',align:'center'" style="width: 30%">备注</th> -->
		</tr>
	</thead>
</table>
<script type="text/javascript">
//填写总值的数据
function acountNum(newValue,oldValue){
	var row = $('#fixed_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#fixed_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#fixed_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[6].target.numberbox('getValue');//获得数量
	var price = tr[7].target.numberbox('getValue');//获得单价
	tr[8].target.numberbox('setValue',num*price);//设置给后面一个
	//$('#S_fSumAmount').numberbox('setValue',num*price);//设置到合计金额
	
}
//总值校验是否正确
function sumAcount(newValue,oldValue){
	var row = $('#fixed_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#fixed_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#fixed_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[6].target.numberbox('getValue');//获得数量
	var price = tr[7].target.numberbox('getValue');//获得单价
	if((num*price)!=newValue){
		//alert("请输入正确总值！");
		tr[8].target.numberbox('setValue',num*price);//设置值一个正确的值给总值
	}
	//设置总额
	var rows = $('#fixed_add_plan').datagrid('getRows');//获得选择行
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
	$('#S_fSumAmount').numberbox('setValue', num1);
}
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
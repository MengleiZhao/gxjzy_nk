<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/taglibs.jsp"%>

   <table id="alloca_add_plan" class="easyui-datagrid"  style="height:auto;"
		data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
			toolbar: '#tb',
			url: '${base}/Alloca/aListJsonPagination?fAssAllcoaCode=${bean.fAssAllcoaCode }',
			method: 'post',
			onClickCell: onClickCellPlan
		">
	<thead>
		<tr>
			<c:if test="${openType=='add'||openType=='edit'}">
				<th data-options="field:'fAssCode',editor:'textbox',align:'center'" style="width: 20%">资产编号</th>
				<th data-options="field:'fAssName',editor:'textbox',align:'center'" style="width: 20%">资产名称</th>
				<!-- <th data-options="field:'fAssSpecif',editor:'textbox',align:'center'" style="width: 15%">规格型号</th> -->
				<th data-options="field:'fSpecification',editor:'textbox',align:'center'" style="width: 15%">规格</th>
				<th data-options="field:'fModel',editor:'textbox',align:'center'" style="width: 15%">型号</th>
				<th data-options="field:'fMeasUnit',editor:'textbox',align:'center'" style="width: 10%">计量单位</th>
				<th data-options="field:'fAssNum',editor:{type:'numberbox',options:{precision:0,onChange:sumAmount}},align:'center'" style="width: 10%">数量</th>
				<th data-options="field:'fSignPrice',editor:{type:'numberbox',options:{precision:2,onChange:sumAmount}},align:'right'" style="width: 15%">单价(元)</th>
				<th data-options="field:'fAmount',editor:{type:'numberbox',options:{precision:2}},align:'right'" style="width: 15%">金额(元)</th>
<!-- 				<th data-options="field:'fOldAddress',editor:'textbox',align:'center'" style="width: 15%">原存放地点</th>
				<th data-options="field:'fOldUser',editor:'textbox',align:'center'" style="width: 15%">原资产管理人</th>
				<th data-options="field:'fNewAddress',editor:'textbox',align:'center'" style="width: 15%">现存放地点</th>
				<th data-options="field:'fNewUser',editor:'textbox',align:'center'" style="width: 15%">现资产管理人</th>
				<th data-options="field:'fRemark',editor:'textbox',align:'left'" style="width: 20%">资产内部转移原因</th> -->
			</c:if>
			<c:if test="${openType=='detail'}">
				<th data-options="field:'fAssCode',align:'center'" style="width: 20%">资产编号</th>
				<th data-options="field:'fAssName',align:'center'" style="width: 20%">资产名称</th>
				<!-- <th data-options="field:'fAssSpecif',align:'center'" style="width: 15%">规格型号</th> -->
				<th data-options="field:'fSpecification',editor:'textbox',align:'center'" style="width: 15%">规格</th>
				<th data-options="field:'fModel',editor:'textbox',align:'center'" style="width: 15%">型号</th>
				<th data-options="field:'fMeasUnit',align:'center'" style="width: 10%">计量单位</th>
				<th data-options="field:'fAssNum',align:'center'" style="width: 10%">数量</th>
				<th data-options="field:'fSignPrice',align:'right'" style="width: 15%">单价(元)</th>
				<th data-options="field:'fAmount',align:'right'" style="width: 15%">金额(元)</th>
<!-- 				<th data-options="field:'fOldAddress',align:'center'" style="width: 15%">原存放地点</th>
				<th data-options="field:'fOldUser',align:'center'" style="width: 15%">原资产管理人</th>
				<th data-options="field:'fNewAddress',align:'center'" style="width: 15%">现存放地点</th>
				<th data-options="field:'fNewUser',align:'center'" style="width: 15%">现资产管理人</th>
				<th data-options="field:'fRemark',align:'left'" style="width: 20%">资产内部转移原因</th> -->
			</c:if>
		</tr>
	</thead>
</table>
<c:if test="${openType=='add'||openType=='edit'}">
	<div id="tb" style="height:30px">
	<a href="javascript:void(0)" onclick="removePlan()" style="float: right;">
		<img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="appendPlan()" style="float: right;">
		<img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="choosePlan()" style="float: right;">
		<img src="${base}/resource-modality/${themenurl}/button/xuanzhe1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
	</div>
</c:if>

<script type="text/javascript">
 //填写总值的数据
function sumAmount(newValue,oldValue){
	var row = $('#alloca_add_plan').datagrid('getSelected');//获得选择行
	var rows = $('#alloca_add_plan').datagrid('getRows');//获得选择行
	var index=$('#alloca_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#alloca_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[3].target.numberbox('getValue');//获得数量
	var price = tr[5].target.numberbox('getValue');//获得单价
	tr[6].target.numberbox('setValue',num*price);//设置给后面一个
	/* //$('#A_fSumAmount').numberbox('setValue',null);//合计金额清零
	var sumAmounct = $('#A_fSumAmount').numberbox('getValue');//获得合计金额
	if(null==sumAmounct||sumAmounct==''){
		sumAmounct=0.00;
	}
	sumAmounct = parseFloat(sumAmounct)+(num*price);//parseFloat
	$('#A_fSumAmount').numberbox('setValue',sumAmounct);//设置到合计金额 */
	
}
//总值校验是否正确
function sumAcount(newValue,oldValue){
	var row = $('#alloca_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#alloca_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#alloca_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[3].target.numberbox('getValue');//获得数量
	var price = tr[5].target.numberbox('getValue');//获得单价
	if((num*price)!=newValue){
		tr[6].target.numberbox('setValue',num*price);//设置值一个正确的值给总值
		
	}
	
} 
/* function PayStauts(val) {
	$('#alloca_add_plan').datagrid('updateRow',{
		index: editIndex,
		row: {
			fAssName_RL: val.text,
			fMeasUnit_RL: val.SftjCode,
			fAssCode_RL: val.code
		}
	}); 
	if(val.text=='新增'){
		var win=creatFirstWin('新增资产品目',840,450,'icon-search','/AssetBasicInfo/lowAddOther');
		win.window('open');
	}
} */

function choosePlan(){
	var win=creatFirstWin('选择固定资产',840,560,'icon-search','/Alloca/chooseFixed');
	win.window('open');
}


var editIndex = undefined;
function endEditingPlan(){
	if (editIndex == undefined){return true}
	if ($('#alloca_add_plan').datagrid('validateRow', editIndex)){
		$('#alloca_add_plan').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellPlan(index, field){
	if (editIndex != index){
		if (endEditingPlan()){
			$('#alloca_add_plan').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#alloca_add_plan').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex = index;
		} else {
			setTimeout(function(){
				$('#alloca_add_plan').datagrid('selectRow', editIndex);
			},0);
		}
	}
}
function appendPlan(){
	if (endEditingPlan()){
		$('#alloca_add_plan').datagrid('appendRow',{});
		editIndex = $('#alloca_add_plan').datagrid('getRows').length-1;
		$('#alloca_add_plan').datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
	document.getElementById("alloca_add_plan").scrollIntoView();
}
function removePlan(){
	if (editIndex == undefined){return };
	$('#alloca_add_plan').datagrid('cancelEdit', editIndex)
			.datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
function testPlan(){
	var entities= getPlan();
	 alert(entities);
}
function getPlan(){
	$('#alloca_add_plan').datagrid('acceptChanges');
	var rows = $('#alloca_add_plan').datagrid('getRows');
	var entities= '';
	for(i = 0;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	 entities = '[' + entities.substring(0,entities.length -1) + ']';
	 return entities;
}
</script>
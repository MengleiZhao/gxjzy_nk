<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-bottom:10px">
	<div style="margin-right:0px;">
		<a href="javascript:void(0)" onclick="removeit1()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append1()" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="${base}/incomePrint/business" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/mbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="$('#f_daoru').click()" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<input type="file" multiple="multiple" id="f_daoru" onchange="upladExport(this, 'register', 'register01')" hidden="hidden">
	</div> 
	<table id="mingxi-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	<c:if test="${!empty bean.fincomeId}">
	url: '${base}/srregister/mingxiRegisterList?fincomeId=${bean.fincomeId}',
	</c:if>
	<c:if test="${empty bean.fincomeId}">
	url: '',
	</c:if>
	method: 'post',
	onClickRow: onClickRow1,
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'frId',hidden:true"></th>			
			<th data-options="field:'oppositeUnit',required:'required',align:'center',width:150,editor:{type:'textbox'}">人员姓名/单位名称</th>
			<th data-options="field:'idCard',required:'required',align:'center',width:140,editor:{type:'textbox'}">身份证号/税号</th>
			<th data-options="field:'planMoney',required:'required',align:'center',width:115,editor:{type:'numberbox',options:{onChange:addAmount2,editable: true}}">金额（元）</th>
			<th data-options="field:'planTime',required:'required',align:'center',width:145,editor:{type:'datebox',options:{editable: false}},formatter: ChangeDateFormat">预计收款日期</th>
			<th data-options="field:'invoiceKindShow',width:130,align:'center', editor:{
                 type:'combotree',
                 options:{
                 	editable:false,
                     valueField:'text',
                     textField:'text',
                     multiple: false,
                     url:base+'/Formulation/lookupsJson?parentCode=KPZL',
                 }}">开票种类</th>
		</tr>
	</thead>
	</table>
</div>
<input type="hidden" id="mingxiJson" name="mingxiJson"/>
<script type="text/javascript">

//计算餐费总额
function addAmount2(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var rows = $('#mingxi-dg').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['planMoney']))) {
	    	 num1 += parseFloat(rows[i]['planMoney']);
    	 }
	}
     var num = parseFloat(newValue);
     var row = $('#mingxi-dg').datagrid('getSelected');
     var numOld = parseFloat(row.planMoney);
     if(!isNaN(num)){
    	 if(!isNaN(numOld) && isNaN(parseFloat(oldValue))){
				return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			}else{
				num1 = num1 + num;
			}
		 }
	 } 
   //给两个框赋值
   $('#costOther_span').html(fomatMoney(num1,2)+" [元]");
	$('#fregisterAmount').val(num1.toFixed(2));
}
//接待人员表格添加删除，保存方法
var editIndex1 = undefined;
function endEditing1() {
	if (editIndex1 == undefined) {
		return true
	}
	if ($('#mingxi-dg').datagrid('validateRow', editIndex1)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#mingxi-dg').datagrid('getEditors', editIndex1);
		var text2=tr[4].target.combotree('getText');
		if(text2!='--请选择--'){
			tr[4].target.combotree('setValue',text2);
		}
		$('#mingxi-dg').datagrid('endEdit', editIndex1);
		editIndex1 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow1(index) {
	if (editIndex1 != index) {
		if (endEditing1()) {
			$('#mingxi-dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex1 = index;
		} else {
			$('#mingxi-dg').datagrid('selectRow', editIndex1);
		}
	}
}
//下载导入模板
function downloadExcel(){
	
	
}
function append1() {
	if (endEditing1()) {
		$('#mingxi-dg').datagrid('appendRow', {});
		editIndex1 = $('#mingxi-dg').datagrid('getRows').length - 1;
		$('#mingxi-dg').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
	}
	//页面随滚动条置底
	var div = document.getElementById('easyAcc');
	div.scrollTop = div.scrollHeight;
}
function removeit1() {
	if (editIndex1 == undefined) {
		return
	}
	$('#mingxi-dg').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
			editIndex1);
	editIndex1 = undefined;
	var rows = $('#mingxi-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['planMoney']))) {
	    	 num1 += parseFloat(rows[i]['planMoney']);
   	 }
	}
    //给两个框赋值
    $('#costOther_span').html(fomatMoney(num1,2)+" [元]");
 	$('#fregisterAmount').val(num1.toFixed(2));
}
function accept1() {
	if (endEditing1()) {
		$('#mingxi-dg').datagrid('acceptChanges');
	}
}
</script>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-fee-dg-reim" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#fee_ids',
	url: '${base}/reimburse/miscellaneousFee?rId=${abroadEdit.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0
	">
		<thead>
			<tr>
				<th data-options="field:'mId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fAddress',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >所在城市</th>
				<th data-options="field:'standard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true,precision:2}}" >费用标准(元/人天)</th>
				<th data-options="field:'fDays',hidden:true,align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true}}" >公杂费天数</th>
				<th data-options="field:'countStandard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true,precision:2}}" >总额标准(外币)</th>
				<th data-options="field:'currency',align:'center',width:87,editor:{type:'textbox',options:{editable:false,readonly:true}}" >币种</th>
				<th data-options="field:'fApplyAmount',align:'center',width:160,editor:{type:'numberbox',options:{editable:true,precision:2,onChange:feeAmounts}}" >报销金额(人民币)</th>
			</tr>
		</thead>
	</table>
	<div id="fee_ids" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">公杂费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id=""><fmt:formatNumber groupingUsed="true" value="${abroad.mixMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="feeAmounts"><fmt:formatNumber groupingUsed="true" value="${abroadEdit.mixMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndex4 = undefined;
function endEditing4() {
	if (editIndex4 == undefined) {
		return true
	}
	if ($('#rec-fee-dg-reim').datagrid('validateRow', editIndex4)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-fee-dg-reim').datagrid('endEdit', editIndex4);
		editIndex4 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow4(index) {
	if (editIndex4 != index) {
		if (endEditing4()) {
			$('#rec-fee-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex4 = index;
		} else {
			$('#rec-fee-dg-reim').datagrid('selectRow', editIndex4);
		}
	}
}
function append4() {
	if (endEditing4()) {
		$('#rec-fee-dg-reim').datagrid('appendRow', {});
		editIndex4 = $('#rec-fee-dg-reim').datagrid('getRows').length - 1;
		$('#rec-fee-dg-reim').datagrid('selectRow', editIndex4).datagrid('beginEdit',editIndex4);
	}
}
function removeit4() {
	if (editIndex4 == undefined) {
		return
	}
	$('#rec-fee-dg-reim').datagrid('cancelEdit', editIndex4).datagrid('deleteRow',
			editIndex4);
	editIndex4 = undefined;
	calcFeeCost();
	countMoney();
}
function accept4() {
	if (endEditing4()) {
		$('#rec-fee-dg-reim').datagrid('acceptChanges');
	}
}

//计算金额
function feeAmounts(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		if(newVal==''){
			newVal=0.00;
		}
		var rows = $('#rec-fee-dg-reim').datagrid('getRows');
		var index=$('#rec-fee-dg-reim').datagrid('getRowIndex',$('#rec-fee-dg-reim').datagrid('getSelected'));
	     var num1 = 0;
	     for(var i=0;i<rows.length;i++){
			if(i==index){
				num1+=parseFloat(newVal);
			}else{
				num1+=addNumsFee(rows,i);
			}
		}
			$("#feeAmounts").html(num1.toFixed(2)+"[元]");
			$("#mixMoney").val(num1.toFixed(2));
			countMoney();
}
function addNumsFee(rows,index){
	var num=0;
	if(rows[index].fApplyAmount!=''&&rows[index].fApplyAmount!='NaN'&&rows[index].fApplyAmount!=undefined){
		num = parseFloat(rows[index].fApplyAmount);
	}else{
		num =0;
	}
	return num;
}
function calcFeeCost(){
	//计算总额
	var rows = $('#rec-fee-dg-reim').datagrid('getRows');
	var feeAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fApplyAmount))?0.00:parseFloat(rows[i].fApplyAmount);
		feeAmount=feeAmount+money;
	}
	$('#feeAmounts').html(listToFixed(feeAmount)+'元');
	$('#mixMoney').val(feeAmount.toFixed(2));
}


function getFeeJson(){
	accept4();
	var rows1 = $('#rec-fee-dg-reim').datagrid('getRows');
	var fee = "";
	for (var i = 0; i < rows1.length; i++) {
		fee = fee + JSON.stringify(rows1[i]) + ",";
	}
	$('#feeJson').val(fee);
}
</script>
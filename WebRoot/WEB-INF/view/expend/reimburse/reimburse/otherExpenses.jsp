<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-other-dg-reim" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#other_ids',
	<c:if test="${!empty abroadEdit.rId}">
	url: '${base}/reimburse/receptionOther?rId=${abroadEdit.rId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow2, 
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'oID',hidden:true"></th>
				<th data-options="field:'fCostName',required:'required',align:'center',width:195,editor:'textbox'">费用名称</th>
				<th data-options="field:'fCost',required:'required',align:'center',width:191,editor:{type:'numberbox',options:{onChange:addNumOther,precision:2,groupSeparator:','}}">报销金额(人民币)</th>
				<th data-options="field:'fRemark',width:280,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<div id="other_ids" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">其他费用</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id=""><fmt:formatNumber groupingUsed="true" value="${abroad.totalOtherMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="otherAmounts"><fmt:formatNumber groupingUsed="true" value="${abroadEdit.totalOtherMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a href="javascript:void(0)" onclick="removeit2()" id="otherRemoveitId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append2()" id="otherAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndex2 = undefined;
function endEditing2() {
	if (editIndex2 == undefined) {
		return true
	}
	if ($('#rec-other-dg-reim').datagrid('validateRow', editIndex2)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-other-dg-reim').datagrid('endEdit', editIndex2);
		editIndex2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow2(index) {
	if(sign==1){
		if (editIndex2 != index) {
			if (endEditing2()) {
				$('#rec-other-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex2 = index;
			} else {
				$('#rec-other-dg-reim').datagrid('selectRow', editIndex2);
			}
		}
	}else{
		alert("请先保存出访计划！");
		return false;
	}
}
function append2() {
	if (endEditing2()) {
		$('#rec-other-dg-reim').datagrid('appendRow', {});
		editIndex2 = $('#rec-other-dg-reim').datagrid('getRows').length - 1;
		$('#rec-other-dg-reim').datagrid('selectRow', editIndex2).datagrid('beginEdit',editIndex2);
	}
}
function removeit2() {
	if (editIndex2 == undefined) {
		return
	}
	$('#rec-other-dg-reim').datagrid('cancelEdit', editIndex2).datagrid('deleteRow',
			editIndex2);
	editIndex2 = undefined;
	calcOtherCost();
	countMoney();
}
function accept2() {
	if (endEditing2()) {
		$('#rec-other-dg-reim').datagrid('acceptChanges');
	}
}

//计算金额
function addNumOther(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	var rows = $('#rec-other-dg-reim').datagrid('getRows');
	var index=$('#rec-other-dg-reim').datagrid('getRowIndex',$('#rec-other-dg-reim').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsOther(rows,i);
		}
	}
		$("#otherAmounts").html(fomatMoney(num1,2)+"[元]");
		$("#totalOtherMoney").val(num1.toFixed(2));
		countMoney();
}
function addNumsOther(rows,index){
	var num=0;
	if(rows[index].fCost!=''&&rows[index].fCost!='NaN'&&rows[index].fCost!=undefined){
		num = parseFloat(rows[index].fCost);
	}else{
		num =0;
	}
	return num;
}
function calcOtherCost(){
	//计算总额
	var rows = $('#rec-other-dg-reim').datagrid('getRows');
	var otherAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fCost))?0.00:parseFloat(rows[i].fCost);
		otherAmount=otherAmount+money;
	}
	$('#otherAmounts').html(listToFixed(otherAmount)+'元');
	$('#totalOtherMoney').val(otherAmount.toFixed(2));
}
function reloadOut(rec){
	var row = $('#rec-hotel-dg').datagrid('getSelected');
	var rindex = $('#rec-hotel-dg').datagrid('getRowIndex', row); 
	var ed = $('#rec-hotel-dg').datagrid('getEditor',{
		index:rindex,
		field : 'fRoomType'  
	});
	
		$(ed.target).combotree('setValue', '');
		var url = base+'/apply/lookupsJson?parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
}

function onClickCellType(){
	var row = $('#rec-hotel-dg').datagrid('getSelected');
	var rindex = $('#rec-hotel-dg').datagrid('getRowIndex', row); 
	var positions = $('#rec-hotel-dg').datagrid('getEditor',{
		index:rindex,
		field : 'position'  
	});
	var ed = $('#rec-hotel-dg').datagrid('getEditor',{
		index:rindex,
		field : 'fRoomType'  
	});
	
		var position = $(positions.target).combotree('getValues');
		$(ed.target).combotree('setValue', '');
		var url = base+'/apply/lookupsJson?parentCode='+position;
    	$(ed.target).combotree('reload', url);
}


function getOtherJson(){
	accept2();
	var rows3 = $('#rec-other-dg-reim').datagrid('getRows');
	var otherJson = "";
	for (var i = 0; i < rows3.length; i++) {
		otherJson = otherJson + JSON.stringify(rows3[i]) + ",";
	}
	$('#otherJson').val(otherJson);
}
</script>
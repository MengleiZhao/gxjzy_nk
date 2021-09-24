<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="foodtab" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#foodtool',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/foodJson?gId=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : true,
	onClickRow: onClickRowFood,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:countAmount
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'fAddress',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >所在城市</th>
				<th data-options="field:'standard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,precision:2,readonly:true}}" >费用标准(元/人天)</th>
				<th data-options="field:'fDays',hidden:true,align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true}}" >住宿天数</th>
				<th data-options="field:'countStandard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,precision:2,readonly:true}}" >总额标准(外币)</th>
				<th data-options="field:'currency',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >币种</th>
				<th data-options="field:'fApplyAmount',align:'center',width:160,editor:{type:'numberbox',options:{editable:true,precision:2,onChange:foodAmounts}}" >申请金额(人民币)</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="foodtool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyFoodAmount"><fmt:formatNumber groupingUsed="true" value="${abroad.foodMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<%-- <a href="javascript:void(0)" onclick="removefood()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendfood()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
	</div>
	</c:if>
</div>
<script type="text/javascript">

//伙食表格添加删除
var editIndexFoodAboard = undefined;
function endEditingfood() {
	if (editIndexFoodAboard == undefined) {
		return true;
	}
	if ($('#foodtab').datagrid('validateRow', editIndexFoodAboard)) {
		$('#foodtab').datagrid('endEdit', editIndexFoodAboard);
		calcFoodCost();
		editIndexFoodAboard = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowFood(index) {
	$('#tracel_itinerary_tab_id').datagrid('acceptChanges');
	if(sign==1){
		if (editIndexFoodAboard != index) {
			if (endEditingfood()) {
				$('#foodtab').datagrid('selectRow', index).datagrid('beginEdit',index);
				editIndexFoodAboard = index;
			} else {
				$('#foodtab').datagrid('selectRow', editIndexFoodAboard);
			}
		}
	}else{
		alert("请先保存出访计划！");
		return false;
	}
}
function appendfood() {
	if (endEditingfood()) {
		$('#foodtab').datagrid('appendRow', {});
		editIndexFoodAboard = $('#foodtab').datagrid('getRows').length - 1;
		$('#foodtab').datagrid('selectRow', editIndexFoodAboard).datagrid('beginEdit',editIndexFoodAboard);
	}
}
function removefood() {
	if (editIndexFoodAboard == undefined) {
		return
	}
	$('#foodtab').datagrid('cancelEdit', editIndexFoodAboard).datagrid('deleteRow',editIndexFoodAboard);
	editIndexFoodAboard = undefined;
	calcFoodCost();
	countMoney();
}
function acceptfood() {
	if (endEditingfood()) {
		$('#foodtab').datagrid('acceptChanges');
		calcFoodCost();
	}
}
//获得json数据
function getfoodJson(){
	acceptfood();
	$('#foodtab').datagrid('acceptChanges');
	var rows = $('#foodtab').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#foodJson").val(entities);
}	
function calcFoodCost(){
	//计算总额
	var rows = $('#foodtab').datagrid('getRows');
	var foodAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fApplyAmount))?0.00:parseFloat(rows[i].fApplyAmount);
		foodAmount=foodAmount+money;
	}
	$('#applyFoodAmount').html(listToFixed(foodAmount)+'[元]');
	$('#foodMoney').val(foodAmount.toFixed(2));
}	
function reload(rec){
	var row = $('#foodtab').datagrid('getSelected');
	var rindex = $('#foodtab').datagrid('getRowIndex', row); 
	var ed = $('#foodtab').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}
}
function countAmount(){
	var rows = $('#foodtab').datagrid('getRows');
	var num1 = 0;
    for(var i=0;i<rows.length;i++){
			num1+=addNumsFood(rows,i);
		}
		$("#applyFoodAmount").html(listToFixed(num1)+"元");
		$("#foodMoney").val(num1.toFixed(2));
		countMoney();
}

function foodAmounts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	var rows = $('#foodtab').datagrid('getRows');
	var index=$('#foodtab').datagrid('getRowIndex',$('#foodtab').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsFood(rows,i);
		}
	}
		$("#applyFoodAmount").html(fomatMoney(num1,2)+"[元]");
		$("#foodMoney").val(num1.toFixed(2));
		countMoney();
}

function addNumsFood(rows,index){
	var num=0;
	if(rows[index].fApplyAmount!=''&&rows[index].fApplyAmount!='NaN'&&rows[index].fApplyAmount!=undefined){
		num = parseFloat(rows[index].fApplyAmount);
	}else{
		num =0;
	}
	return num;
}


</script>
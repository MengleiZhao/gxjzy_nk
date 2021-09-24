<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="foodtabTripReim" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#foodtoolTripReim1',
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/foodJson?rId=${bean.rId}',
	</c:if>
	<c:if test="${!empty applyBean.gId&&operation=='add'}">
	url: '${base}/apply/foodJson?gId=${applyBean.gId}&travelType=GWCX',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	onClickRow:onClickRowfoodTripReim,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'travelType',hidden:true"></th>
				<th data-options="field:'fname',align:'center',width:160,editor:{type:'textbox',readonly:true,options:{editable:false}}" >姓名</th>
				<th data-options="field:'fDays',align:'center',width:260,editor:{type:'numberbox',options:{editable:true,onChange:dayCountFood}}" >补贴天数</th>
				<th data-options="field:'fApplyAmount',align:'center',width:255,editor:{type:'numberbox',options:{editable:false,precision:2,onChange:fApplyAmountFood}}" >报销金额</th>
				<th data-options="field:'fnameId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<div id="foodtoolTripReim1" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食补助费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">原申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${applyBean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="applyFoodAmountTripReim"><fmt:formatNumber groupingUsed="true" value="${applyBean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="applyFoodAmountTripReim"><fmt:formatNumber groupingUsed="true" value="${bean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
	</div>
</div>
<script type="text/javascript">

//伙食表格添加删除
var editIndexTripReim = undefined;
function endEditingfoodTripReim() {
	if (editIndexTripReim == undefined) {
		return true;
	}
	if ($('#foodtabTripReim').datagrid('validateRow', editIndexTripReim)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#foodtabTripReim').datagrid('getEditors', editIndexTripReim);
		/* var text=tr[5].target.combotree('getText');
		if(text!='--请选择--'){
			tr[5].target.combotree('setValue',text);
		}
		var text1=tr[4].target.combotree('getText');
		if(text1!='--请选择--'){
			tr[4].target.combotree('setValue',text1);
		} */
		$('#foodtabTripReim').datagrid('endEdit', editIndexTripReim);
		calcFoodCostTripReim();
		editIndexTripReim = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowfoodTripReim(index) {
	$('#tracel_itinerary_tab_id').datagrid('acceptChanges');
	if(sign==1){
		if (editIndexTripReim != index) {
			if (endEditingfoodTripReim()) {
				$('#foodtabTripReim').datagrid('selectRow', index).datagrid('beginEdit',index);
				editIndexTripReim = index;
			} else {
				$('#foodtabTripReim').datagrid('selectRow', editIndexTripReim);
			}
		}
	}else{
		alert('请保存行程清单!');
		return false;
	}
}
function appendfoodTripReim() {
	if (endEditingfoodTripReim()) {
		$('#foodtabTripReim').datagrid('appendRow', {});
		editIndexTripReim = $('#foodtabTripReim').datagrid('getRows').length - 1;
		$('#foodtabTripReim').datagrid('selectRow', editIndexTripReim).datagrid('beginEdit',editIndexTripReim);
	}
}
function removefoodTripReim() {
	if (editIndexTripReim == undefined) {
		return
	}
	$('#foodtabTripReim').datagrid('cancelEdit', editIndexTripReim).datagrid('deleteRow',editIndexTripReim);
	editIndexTripReim = undefined;
	calcFoodCostTripReim();
}
function acceptfoodTripReim() {
	if (endEditingfoodTripReim()) {
		$('#foodtabTripReim').datagrid('acceptChanges');
		calcFoodCostTripReim();
	}
}
//获得json数据
function getfoodJsonTripReim(){
	acceptfoodTripReim();
	$('#foodtabTripReim').datagrid('acceptChanges');
	var rows = $('#foodtabTripReim').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#foodJson").val(entities);
}	
function calcFoodCostTripReim(){
	//计算总额
	var rows = $('#foodtabTripReim').datagrid('getRows');
	var foodAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fApplyAmount))?0.00:parseFloat(rows[i].fApplyAmount);
		foodAmount=foodAmount+money;
	}
	$('#applyFoodAmountTripReim').html(listToFixed(foodAmount)+'[元]');
	$('#foodAmount').val(foodAmount.toFixed(2));
}	
function reload(rec){
	var row = $('#foodtabTripReim').datagrid('getSelected');
	var rindex = $('#foodtabTripReim').datagrid('getRowIndex', row); 
	var ed = $('#foodtabTripReim').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}
}
function countAmount(){
	var rows = $('#foodtabTripReim').datagrid('getRows');
	var num1 = 0;
    for(var i=0;i<rows.length;i++){
			num1+=addNumsFood(rows,i);
		}
		$("#applyFoodAmountTripReim").html(listToFixed(num1)+"[元]");
		$("#foodAmount").val(num1.toFixed(2));
		
		
		var cityAmount = $("#cityAmount").val();
		var hotelAmount = $("#hotelAmount").val();
		var outAmount = $("#outsideAmount").val();
		if(cityAmount=='NaN'||cityAmount==''||cityAmount==undefined||cityAmount==null){
			cityAmount=0;
		}
		if(hotelAmount=='NaN'||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
			hotelAmount=0;
		}
		if(outAmount=='NaN'||outAmount==''||outAmount==undefined||outAmount==null){
			outAmount=0;
		}
		$("#applyTotalAmountTripReim").html(listToFixed((parseFloat(outAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(num1)))+"元");
		$("#reimburseAmount").val((parseFloat(outAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(num1)).toFixed(2));
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


function dayCountFood(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var index=$('#foodtabTripReim').datagrid('getRowIndex',$('#foodtabTripReim').datagrid('getSelected'));
    var editors = $('#foodtabTripReim').datagrid('getEditors', index);
    var fDays = parseInt(newVal);
    if(isNaN(fDays)){
    	fDays=0;
    }
    editors[2].target.numberbox('setValue', fDays*50);
}

function fApplyAmountFood(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	
	var rows = $('#foodtabTripReim').datagrid('getRows');
	var index=$('#foodtabTripReim').datagrid('getRowIndex',$('#foodtabTripReim').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsFood(rows,i);
		}
	}
		$("#applyFoodAmountTripReim").html(num1.toFixed(2)+"[元]");
		$("#foodAmount").val(num1.toFixed(2));
		var hotelAmount = $("#hotelAmount").val();
		var cityAmount = $("#cityAmount").val();
		if(hotelAmount=='NaN'||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
			hotelAmount=0;
		}
		if(cityAmount=='NaN'||cityAmount==''||cityAmount==undefined||cityAmount==null){
			cityAmount=0;
		}
		$("#applyTotalAmountTripReim").html(listToFixed((parseFloat(cityAmount)+parseFloat(hotelAmount)+parseFloat(num1)))+"[元]");
		$("#p_amount").html(listToFixed((parseFloat(cityAmount)+parseFloat(hotelAmount)+parseFloat(num1)))+"[元]");
		$("#reimburseAmount").val((parseFloat(cityAmount)+parseFloat(hotelAmount)+parseFloat(num1)).toFixed(2));
}

</script>
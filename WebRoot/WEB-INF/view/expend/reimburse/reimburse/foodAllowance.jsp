<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 伙食费 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="reimbursein_foodtab" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_foodtool',
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/foodJson?rId=${bean.rId}',
	</c:if>
	method: 'post',
	<c:if test="${!empty operation}">
	onClickRow: onClickRowfood,
	</c:if>
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'fname',width:220,align:'center',editor:{type:'textbox',options:{editable:false}}" >姓名</th>
				<th data-options="field:'fDays',width:220,align:'center',editor:{type:'numberbox',options:{editable:true,onChange:onChangeDay}}" >补贴天数</th>
				<th data-options="field:'fApplyAmount',width:227,align:'center',editor:{type:'numberbox',options:{editable:false,precision:2,onChange:foodAmounts}}">报销金额</th>
				<th data-options="field:'fnameId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fStdAmount',hidden:true"></th>
			</tr>
		</thead>
	</table>
	<c:if test="${!empty operation}">
	<div id="reimburse_foodtool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食补助费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rfoodAmount"><fmt:formatNumber groupingUsed="true" value="${applyBean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rfoodAmount"><fmt:formatNumber groupingUsed="true" value="${bean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
	</div>
	</c:if>
</div>
<script type="text/javascript">
$('#foodTeacherAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var foodAmount = isNaN($('#foodAmount').val())?0:parseFloat($('#foodAmount').val());
		var foodTeacherAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(foodAmount==0){
			return false;
		}
		var a = foodAmount-foodTeacherAmount;
		$('#foodStudentAmounts').numberbox('setValue',a);
		$('#foodTeacherAmount').val(foodTeacherAmount);
		allTeacherList();
	}
});

$('#foodStudentAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var foodAmount = isNaN($('#foodAmount').val())?0:parseFloat($('#foodAmount').val());
		var foodStudentAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(foodAmount==0){
			return false;
		}
		var a = foodAmount-foodStudentAmount;
		$('#foodTeacherAmounts').numberbox('setValue',a);
		$('#foodStudentAmount').val(foodStudentAmount);
		allStudentList();
	}
});


//伙食表格添加删除
var editIndexFood = undefined;
function endEditingfood() {
	if (editIndexFood == undefined) {
		return true;
	}
	if ($('#reimbursein_foodtab').datagrid('validateRow', editIndexFood)) {
		$('#reimbursein_foodtab').datagrid('endEdit', editIndexFood);
		editIndexFood = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowfood(index) {
	if (editIndexFood != index) {
		if (endEditingfood()) {
			$('#reimbursein_foodtab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexFood = index;
		} else {
			$('#reimbursein_foodtab').datagrid('selectRow', editIndexFood);
		}
	}
}
function appendfood() {
	if (endEditingfood()) {
		$('#reimbursein_foodtab').datagrid('appendRow', {});
		editIndexFood = $('#reimbursein_foodtab').datagrid('getRows').length - 1;
		$('#reimbursein_foodtab').datagrid('selectRow', editIndexFood).datagrid('beginEdit',editIndexFood);
	}
}
function removefood() {
	if (editIndexFood == undefined) {
		return
	}
	$('#reimbursein_foodtab').datagrid('cancelEdit', editIndexFood).datagrid('deleteRow',editIndexFood);
	editIndexFood = undefined;
	calcFoodCost();
}
function acceptfoodReim() {
	if (endEditingfood()) {
		$('#reimbursein_foodtab').datagrid('acceptChanges');
		calcFoodCost();
	}
}
//获得json数据
function getfoodJson(){
	acceptfoodReim();
	$('#reimbursein_foodtab').datagrid('acceptChanges');
	var rows = $('#reimbursein_foodtab').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#foodJson").val(entities);
}	
function calcFoodCost(){
	//计算总额
	var rows = $('#reimbursein_foodtab').datagrid('getRows');
	var foodAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fApplyAmount))?0.00:parseFloat(rows[i].fApplyAmount);
		foodAmount=foodAmount+money;
	}
	$('#rfoodAmount').html(foodAmount.toFixed(2)+'[元]');
	$('#foodAmount').val(foodAmount.toFixed(2));
}	

function reload(rec){
	var row = $('#reimbursein_foodtab').datagrid('getSelected');
	var rindex = $('#reimbursein_foodtab').datagrid('getRowIndex', row); 
	var ed = $('#reimbursein_foodtab').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}
}
function foodAmounts(newVal,oldVal){
		
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		var rows = $('#reimbursein_foodtab').datagrid('getRows');
		var index=$('#reimbursein_foodtab').datagrid('getRowIndex',$('#reimbursein_foodtab').datagrid('getSelected'));
		
		var std = parseFloat(rows[index].fStdAmount);//市内交通费标准
		var ed = $('#reimbursein_foodtab').datagrid('getEditor',{
			index:index,
			field : 'fDays'  
		});
		var fApplyAmount = $('#reimbursein_foodtab').datagrid('getEditor',{
			index:index,
			field : 'fApplyAmount'  
		});
		var day = $(ed.target).numberbox('getValue');
		if(isNaN(newVal)||newVal==''){
			newVal = 0;
		}
		if(isNaN(day)){
			day = 0;
		}
		var allStd = std*day;
		if(newVal>allStd){
			alert('伙食费超额报销，请重新填写！');
			$(fApplyAmount.target).numberbox('setValue',0.00);
			return false;
		}
		
	    var num1 = 0;
	    for(var i=0;i<rows.length;i++){
			if(i==index){
				num1+=parseFloat(newVal);
			}else{
				num1+=addNumsFood(rows,i);
			}
		}
		$("#rfoodAmount").html(num1.toFixed(2)+"[元]");
		$("#foodAmount").val(num1.toFixed(2));
		allProIndexList();
		cx();
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
function onChangeDay(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var day = isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var index=$('#reimbursein_foodtab').datagrid('getRowIndex',$('#reimbursein_foodtab').datagrid('getSelected'));
	var fApplyAmount = $('#reimbursein_foodtab').datagrid('getEditor',{
		index:index,
		field : 'fApplyAmount'  
	});
	var fnameId = $('#reimbursein_foodtab').datagrid('getEditor',{
		index:index,
		field : 'fnameId'  
	});
	var fDays = $('#reimbursein_foodtab').datagrid('getEditor',{
		index:index,
		field : 'fDays'
	});
	var fnameIds = $(fnameId.target).textbox('getValue');
	var verifyDay = stdFoodDay(fnameIds,day);
	if(!verifyDay){
		alert("超出出差补助天数！");
		$(fDays.target).numberbox('setValue',0);
		return false;
	}
	$(fApplyAmount.target).numberbox('setValue',day*100);
}
function stdFoodAndCityDay(id,day){
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	var arrs = new Array();
	if(rows==''){
		return false;
	}else{
		for (var h = 0; h < rows.length; h++){
			var days;//天数
			var day1 = Date.parse(new Date(rows[h].travelDateEnd));
			var day2 = Date.parse(new Date(rows[h].travelDateStart));
			days = parseInt((day1-day2)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
			if(!isNaN(day2)&&!isNaN(day1)){
				days+=1;
			}
			days=isNaN(days)?0:days;
			var travelPeop = rows[h].travelAttendPeop.split(',');
			var travelPeopId = rows[h].travelAttendPeopId.split(',');
			for (var y = 0; y < travelPeop.length; y++) {
				var idAndName = {};
				idAndName.id = travelPeopId[y];
				idAndName.name = travelPeop[y];
				idAndName.day = days;
				arrs.push(idAndName);
			}
		}
	}
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h].id == arrs[c].id ) {//通过id属性进行匹配；
		    	arrs[h].day = arrs[h].day+arrs[c].day;
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
		}
	for (var p = 0; p < arrs.length; p++) {
		if (arrs[p].id == id ) {//通过id属性进行匹配；
			if(arrs[p].day<parseInt(day)){
				return false;
			}
		}
	}
	return true;
}
</script>
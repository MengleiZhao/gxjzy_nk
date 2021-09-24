<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="reimbursein_city_tabs_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_in_city_id',
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyInCityPage?rId=${bean.rId}',
	</c:if>
	method: 'post',
	<c:if test="${!empty operation}">
	onClickRow: onClickRowInCity,
	</c:if>
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ftId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'fPerson',width:220,align:'center',editor:{type:'textbox',options:{editable:false}}">姓名</th>
				<th data-options="field:'fSubsidyDay',width:220,align:'center',editor:{type:'numberbox',options:{editable:true,onChange:onChangeSubsidyDay}}">补助天数</th>
				<th data-options="field:'fApplyAmount',width:227,align:'center',editor:{type:'numberbox',options:{editable:false,precision:2,onChange:cityAmounts}}">报销金额</th>
				<th data-options="field:'fStdAmount',hidden:true"></th>
				<th data-options="field:'fPersonId',hidden:true,width:220,align:'center',editor:{type:'textbox',options:{editable:false}}">姓名ID</th>
			</tr>
		</thead>
	</table>
	<c:if test="${!empty operation}">
	<div id="reimburse_in_city_id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">市内交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rInCityAmount"><fmt:formatNumber groupingUsed="true" value="${applyBean.cityAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rInCityAmount"><fmt:formatNumber groupingUsed="true" value="${bean.cityAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
	</div>
	</c:if>
</div>
<script type="text/javascript">
$('#cityTeacherAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var cityAmount = isNaN($('#cityAmount').val())?0:parseFloat($('#cityAmount').val());
		var cityTeacherAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(cityAmount==0){
			return false;
		}
		var a = cityAmount-cityTeacherAmount;
		$('#cityStudentAmounts').numberbox('setValue',a);
		$('#cityTeacherAmount').val(cityTeacherAmount);
		allTeacherList();
	}
});

$('#cityStudentAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var cityAmount = isNaN($('#cityAmount').val())?0:parseFloat($('#cityAmount').val());
		var cityStudentAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(cityAmount==0){
			return false;
		}
		var a = cityAmount-cityStudentAmount;
		$('#cityTeacherAmounts').numberbox('setValue',a);
		$('#cityStudentAmount').val(cityStudentAmount);
		allStudentList();
	}
});


//接待人员表格添加删除，保存方法
var editIndexInCity = undefined;
function endEditingInCity() {
	if (editIndexInCity == undefined) {
		return true
	}
	if ($('#reimbursein_city_tabs_id').datagrid('validateRow', editIndexInCity)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#reimbursein_city_tabs_id').datagrid('getEditors', editIndexInCity);
		$('#reimbursein_city_tabs_id').datagrid('endEdit', editIndexInCity);
		editIndexInCity = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowInCity(index) {
	if (editIndexInCity != index) {
		if (endEditingInCity()) {
			$('#reimbursein_city_tabs_id').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexInCity = index;
		} else {
			$('#reimbursein_city_tabs_id').datagrid('selectRow', editIndexInCity);
		}
	}
}
function appendCityTraffic() {
	if (endEditingInCity()) {
		$('#reimbursein_city_tabs_id').datagrid('appendRow', {
		});
		editIndexInCity = $('#reimbursein_city_tabs_id').datagrid('getRows').length - 1;
		$('#reimbursein_city_tabs_id').datagrid('selectRow', editIndexInCity).datagrid('beginEdit',editIndexInCity);
	}
}
function removeitCityTraffic() {
	if (editIndexInCity == undefined) {
		return
	}
	$('#reimbursein_city_tabs_id').datagrid('cancelEdit', editIndexInCity).datagrid('deleteRow',
			editIndexInCity);
	editIndexInCity = undefined;
	var rows = $('#reimbursein_city_tabs_id').datagrid('getRows');
	var travelDays=0;
	var hotelDays=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].travelDays!=""&&rows[i].travelDays!=null){
			travelDays += parseInt(rows[i].travelDays);
		}
		if(rows[i].hotelDays!=""&&rows[i].hotelDays!=null){
			hotelDays += parseInt(rows[i].hotelDays);
		}
	}
	$('#travelTotalDays').val(travelDays);
	$('#hotelTotalDays').val(hotelDays);
}
function acceptInCityReim() {
	if (endEditingInCity()) {
		$('#reimbursein_city_tabs_id').datagrid('acceptChanges');
	}
}
	
//计算天数
function setDays5(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#reimbursein_city_tabs_id').datagrid('getRowIndex',$('#reimbursein_city_tabs_id').datagrid('getSelected'));
	var rows = $('#reimbursein_city_tabs_id').datagrid('getRows');
    var editors = $('#reimbursein_city_tabs_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[0].target.datebox('setValue', '');
    	}
    }
}

function setDays6(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#reimbursein_city_tabs_id').datagrid('getRowIndex',$('#reimbursein_city_tabs_id').datagrid('getSelected'));
	var rows = $('#reimbursein_city_tabs_id').datagrid('getRows');
    var editors = $('#reimbursein_city_tabs_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[1].target.datebox('setValue', '');
    	}
    }
}
//未编辑或者已经编辑完毕的行，计算天数
function addNum(rows,index){
	var totalDays=0;
	var startday=new Date(rows[index]['startTime']);
	var endday=new Date (rows[index]['endTime']);
	if(startday!="" && startday!=null && endday!="" && endday!=null){
		totalDays = (endday - startday) / 86400000 + 1;
	}
	return totalDays;
}

function inCityJson(){
	acceptInCityReim();
	var rows2 = $('#reimbursein_city_tabs_id').datagrid('getRows');
	var inCity = "";
	if(rows2==''){
	}else{
		for (var i = 0; i < rows2.length; i++) {
			inCity = inCity + JSON.stringify(rows2[i]) + ",";
			}
		$('#inCityJson').val(inCity);
	}
}

function calcInCity(){
	//计算总额
	var rows = $('#reimbursein_city_tabs_id').datagrid('getRows');
	var inCityAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fApplyAmount))?0.00:parseFloat(rows[i].fApplyAmount);
		inCityAmount=inCityAmount+money;
	}
	$('#rInCityAmount').html(inCityAmount.toFixed(2)+'[元]');
	$('#cityAmount').val(inCityAmount.toFixed(2));
}

function cityAmounts(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		if(isNaN(newVal)||newVal==''){
			newVal = 0;
		}
		var rows = $('#reimbursein_city_tabs_id').datagrid('getRows');
		var index=$('#reimbursein_city_tabs_id').datagrid('getRowIndex',$('#reimbursein_city_tabs_id').datagrid('getSelected'));
		
		var std = parseFloat(rows[index].fStdAmount);//市内交通费标准
		var ed = $('#reimbursein_city_tabs_id').datagrid('getEditor',{
			index:index,
			field : 'fSubsidyDay'  
		});
		var fApplyAmount = $('#reimbursein_city_tabs_id').datagrid('getEditor',{
			index:index,
			field : 'fApplyAmount'  
		});
		var day = $(ed.target).numberbox('getValue');
		if(isNaN(newVal)){
			newVal = 0;
		}
		if(isNaN(day)){
			day = 0;
		}
		var allStd = std*day;
		if(newVal>allStd){
			alert('市内交通费超额报销，请重新填写！');
			$(fApplyAmount.target).numberbox('setValue',0.00);
			return false;
		}
	     var num1 = 0;
	     for(var i=0;i<rows.length;i++){
			if(i==index){
				num1+=parseFloat(newVal);
			}else{
				num1+=addNumsCity(rows,i);
			}
		}
		$("#rInCityAmount").html(num1.toFixed(2)+"[元]");
		$("#cityAmount").val(num1.toFixed(2));
		allProIndexList();
		cx();
}
function addNumsCity(rows,index){
	var num=0;
	if(rows[index].fApplyAmount!=''&&rows[index].fApplyAmount!='NaN'&&rows[index].fApplyAmount!=undefined){
		num = parseFloat(rows[index].fApplyAmount);
	}else{
		num =0;
	}
	return num;
}

function onChangeSubsidyDay(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	
	var day = isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var index=$('#reimbursein_city_tabs_id').datagrid('getRowIndex',$('#reimbursein_city_tabs_id').datagrid('getSelected'));
	var fApplyAmount = $('#reimbursein_city_tabs_id').datagrid('getEditor',{
		index:index,
		field : 'fApplyAmount'  
	});
	var fPersonId = $('#reimbursein_city_tabs_id').datagrid('getEditor',{
		index:index,
		field : 'fPersonId'  
	});
	var fSubsidyDay = $('#reimbursein_city_tabs_id').datagrid('getEditor',{
		index:index,
		field : 'fSubsidyDay'
	});
	var fPersonId = $(fPersonId.target).textbox('getValue');
	var verifyDay = stdFoodAndCityDay(fPersonId,day);
	if(!verifyDay){
		alert("超出出差补助天数！");
		$(fSubsidyDay.target).numberbox('setValue',0);
		return false;
	}
	$(fApplyAmount.target).numberbox('setValue',day*80);
}
</script>
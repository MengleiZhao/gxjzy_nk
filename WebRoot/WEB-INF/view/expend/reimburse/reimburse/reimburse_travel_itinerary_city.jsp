<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="reim_tracel_itinerary_city_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#itinerary_toolbar_city_Id',
	<c:if test="${!empty applyBean.gId&&operation=='add'}">
	url: '${base}/apply/applyTravelPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyTravelPage?rId=${bean.rId}',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowItineraryCityReim,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:onLoadSuccessCityReim
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'tripType',width:130,align:'center',editor:{type:'combobox',options:{
				editable:false,
				valueField:'text',
       			multiple: false,
				textField:'text',
				method:'post',
				data:
				[{'id':'去程','text':'去程'},{'id':'返程','text':'返程'}]}}">出行类型</th>
				<th data-options="field:'travelDateStart',width:140,align:'center',editor:{type:'datetimebox', options:{onChange:setDaysCityReim1,editable:false,showSeconds: false}},formatter:ChangeDateFormatIndex">出发时间</th>
				<th data-options="field:'travelDateEnd',width:140,align:'center',editor:{type:'datetimebox',options:{onChange:setDaysCityReim2,editable:false,showSeconds: false}},formatter:ChangeDateFormatIndex">返回时间</th>
				<th data-options="field:'placeStart',width:130,align:'center',editor:{type:'textbox',options:{editable:true}}">起始地</th>
				<th data-options="field:'placeEnd',width:130,align:'center',editor:{type:'textbox',options:{editable:true}}">目的地</th>
				<th data-options="field:'distance',width:130,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2,onChange:onChangeDistanceReim}}">距离（公里）</th>
			</tr>
		</thead>
	</table>
	<div id="itinerary_toolbar_city_Id" style="height:30px;padding-top : 8px">
	<c:if test="${empty detail}">
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="removeReimId" onclick="removeitItineraryCityReim()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendReimId" onclick="appendItineraryCityReim()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		
	</c:if>
		<a style="float: left;color: #666666;font-size:12px;">补助标准：1.3元/公里&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">公里数合计：<span id="reimDistanceShow"></span>&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="reimAmountShow"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<input type="hidden" id="travelPeopJson" name="travelPeop" />
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexItineraryCity = undefined;
function endEditingItineraryCity() {
	if (editIndexItineraryCity == undefined) {
		return true;
	}
	if ($('#reim_tracel_itinerary_city_tab_id').datagrid('validateRow', editIndexItineraryCity)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#reim_tracel_itinerary_city_tab_id').datagrid('getEditors', editIndexItineraryCity);
		var text0=tr[0].target.combobox('getText');
		if(text0!='--请选择--'){
			tr[0].target.combobox('setValue',text0);
		}
		$('#reim_tracel_itinerary_city_tab_id').datagrid('endEdit', editIndexItineraryCity);
		
		editIndexItineraryCity = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowItineraryCityReim(index) {
	if(updateradio==1){
		if (editIndexItineraryCity != index) {
			if (endEditingItineraryCity()) {
				$('#reim_tracel_itinerary_city_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
				editIndexItineraryCity = index;
			} else {
				$('#reim_tracel_itinerary_city_tab_id').datagrid('selectRow', editIndexItineraryCity);
			}
		}
	}else{
		alert('请点击调整按钮！');
		return false;
	}
}
function appendItineraryCityReim() {
	if (endEditingItineraryCity()) {
		$('#reim_tracel_itinerary_city_tab_id').datagrid('appendRow', {
		});
		editIndexItineraryCity = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows').length - 1;
		$('#reim_tracel_itinerary_city_tab_id').datagrid('selectRow', editIndexItineraryCity).datagrid('beginEdit',editIndexItineraryCity);
	}
}
function removeitItineraryCityReim() {
	if (editIndexItineraryCity == undefined) {
		return
	}
	$('#reim_tracel_itinerary_city_tab_id').datagrid('cancelEdit', editIndexItineraryCity).datagrid('deleteRow',
			editIndexItineraryCity);
	editIndexItineraryCity = undefined;
}
function acceptItineraryCityReim() {
	if (endEditingItineraryCity()) {
		$('#reim_tracel_itinerary_city_tab_id').datagrid('acceptChanges');
	}
}

function isineraryJsonCityReim(){
	acceptItineraryCityReim();
	var rows2 = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows');
	var travelPeop = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			travelPeop = travelPeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#travelPeopJson').val(travelPeop);
		return true;
	}
}

function onChangeDistanceReim(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var rows = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows');
	var index=$('#reim_tracel_itinerary_city_tab_id').datagrid('getRowIndex',$('#reim_tracel_itinerary_city_tab_id').datagrid('getSelected'));
	if(isNaN(newVal)){
		newVal = 0;
	}
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsCity(rows,i);
		}
	}
	$("#reimAmountShow").html((num1*1.3).toFixed(2)+"[元]");
	$("#reimDistanceShow").html(num1.toFixed(2)+"[公里]");
	$("#reimburseAmount").val((num1*1.3).toFixed(2));
}

function addNumsCity(rows,index){
	var num=0;
	if(rows[index].distance!=''&&rows[index].distance!='NaN'&&rows[index].distance!=undefined){
		num = parseFloat(rows[index].distance);
	}else{
		num =0;
	}
	return num;
}

//计算天数
function setDaysCityReim1(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#reim_tracel_itinerary_city_tab_id').datagrid('getRowIndex',$('#reim_tracel_itinerary_city_tab_id').datagrid('getSelected'));
	var rows = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows');
    var editors = $('#reim_tracel_itinerary_city_tab_id').datagrid('getEditors', index);  
    var day1 = editors[1]; 
    var day2 = editors[2]; 
    startday = new Date(day1.target.datebox('getValue'));
    endday = new Date(day2.target.datebox('getValue'));
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[1].target.datetimebox('setValue', '');
    	}
    }
}

function setDaysCityReim2(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#reim_tracel_itinerary_city_tab_id').datagrid('getRowIndex',$('#reim_tracel_itinerary_city_tab_id').datagrid('getSelected'));
	var rows = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows');
    var editors = $('#reim_tracel_itinerary_city_tab_id').datagrid('getEditors', index);  
    var day1 = editors[1]; 
    var day2 = editors[2]; 
    startday = new Date(day1.target.datebox('getValue'));
    endday = new Date(day2.target.datebox('getValue'));
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[2].target.datetimebox('setValue', '');
    	}
    }
}

function onLoadSuccessCityReim(){
	var rows = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows');
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
		num1+=addNumsCity(rows,i);
	}
	$("#reimDistanceShow").html(num1.toFixed(2)+"[公里]");
}
</script>
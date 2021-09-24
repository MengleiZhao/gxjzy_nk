<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="width:705px;margin-left: 0px;padding-top: 10px">
	<table id="tracel_itinerary_city_tab_apply_id" class="easyui-datagrid" style="width:700px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#itinerary_toolbar_city_apply_reim_Id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/applyTravelPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:onLoadSuccessCityApply
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'tripType',width:110,align:'center',editor:{type:'combobox',options:{
				editable:true,
				valueField:'text',
       			multiple: true,
				textField:'text',
				method:'post',
				data:
				[{'id':'去程','text':'去程'},{'id':'返程','text':'返程'}]}}">出行类型</th>
				<th data-options="field:'travelDateStart',width:150,align:'center',editor:{type:'datetimebox', options:{editable:false,showSeconds: false}},formatter:ChangeDateFormatIndex">出发日期</th>
				<th data-options="field:'travelDateEnd',width:150,align:'center',editor:{type:'datetimebox',options:{editable:false,showSeconds: false}},formatter:ChangeDateFormatIndex">撤离日期</th>
				<th data-options="field:'placeStart',width:110,align:'center',editor:{type:'textbox',options:{editable:true}}">起始地</th>
				<th data-options="field:'placeEnd',width:110,align:'center',editor:{type:'textbox',options:{editable:true}}">目的地</th>
				<th data-options="field:'distance',width:110,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">距离（公里）</th>
			</tr>
		</thead>
	</table>
	<div id="itinerary_toolbar_city_apply_reim_Id" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;">补助标准：1.3元/公里&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">公里数合计：<span id="applyDistanceShow"></span>&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyAmountShow"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">

function onLoadSuccessCityApply(){
	var rows = $('#tracel_itinerary_city_tab_apply_id').datagrid('getRows');
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
		num1+=addNumsCity(rows,i);
	}
	$("#applyDistanceShow").html(num1.toFixed(2)+"[公里]");
}

</script>
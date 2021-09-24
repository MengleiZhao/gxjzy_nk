<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="reim_tracel_itinerary_city_detail_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#itinerary_toolbar_city_detail_Id',
	url: '${base}/reimburse/applyTravelPage?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:onLoadSuccessCityReimDetail
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'tripType',width:130,align:'center'">出行类型</th>
				<th data-options="field:'travelDateStart',width:120,align:'center',editor:{type:'datetimebox', options:{editable:false,showSeconds: false}},formatter:ChangeDateFormatIndex">出发时间</th>
				<th data-options="field:'travelDateEnd',width:120,align:'center',editor:{type:'datetimebox',options:{editable:false,showSeconds: false}},formatter:ChangeDateFormatIndex">返回时间</th>
				<th data-options="field:'placeStart',width:130,align:'center',editor:{type:'textbox',options:{editable:true}}">起始地</th>
				<th data-options="field:'placeEnd',width:130,align:'center',editor:{type:'textbox',options:{editable:true}}">目的地</th>
				<th data-options="field:'distance',width:130,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">距离（公里）</th>
			</tr>
		</thead>
	</table>
	<div id="itinerary_toolbar_city_detail_Id" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;">补助标准：1.3元/公里&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">公里数合计：<span id="reimDistanceShowDetail"></span>&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="reimAmountShow"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
function onLoadSuccessCityReimDetail(){
	debugger;
	var rows = $('#reim_tracel_itinerary_city_detail_tab_id').datagrid('getRows');
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
		num1+=addNumsCityReim(rows,i);
	}
	$("#reimDistanceShowDetail").html(num1.toFixed(2)+"[公里]");
}

function addNumsCityReim(rows,index){
	var num=0;
	if(rows[index].distance!=''&&rows[index].distance!='NaN'&&rows[index].distance!=undefined){
		num = parseFloat(rows[index].distance);
	}else{
		num =0;
	}
	return num;
}
</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-top:10px;padding-top: 0px;margin-left: 0px;">
	<table id="abroad-plan-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: '#dmp',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/abroadPlan?id=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'planId',hidden:true"></th>			
			<th data-options="field:'gId',hidden:true"></th>			
			<th data-options="field:'abroadDate',required:'required',align:'center',width:140,editor:{type:'datebox' },formatter:ChangeDateFormat1">出发日期</th>
			<th data-options="field:'timeEnd',required:'required',align:'center',width:140,editor:{type:'datebox' },formatter:ChangeDateFormat1">撤离日期/抵华日期</th>
			<th data-options="field:'arriveCountryId',editor:'textbox',hidden:true">目的国ID</th>
			<th data-options="field:'arriveCountry',required:'required',align:'center',width:130,editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     var row = $('#abroad-plan-dg').datagrid('getSelected');
									     var index = $('#abroad-plan-dg').datagrid('getRowIndex',row);
									     selectAbroadDetail(index)
									     }}]}}">目的国</th>
			<th data-options="field:'arriveCity',required:'required',align:'center',width:130,editor:{type:'textbox',options:{editable:false}}">城市</th>
			<th data-options="field:'remark',required:'required',align:'center',width:138,editor:'textbox'">备注</th>
		</tr>
	</thead>
</table>
</div>
<input type="hidden" id="abroadPlan" name="abroadPlan"/>
<script type="text/javascript">
var sign = 0;

var gId = '${applyBean.gId}';

if(gId!=''){
	$("#editAbroadId").show();
	$("#addAbroadId").hide();
	$("#removeit1Id").hide();
	$("#append1Id").hide();
	$("#travelingExpenseId").show();
	$("#outsideAppendId").show();
	$("#outsideRemoveitId").show();
	$("#travelingAppendId").show();
	$("#hotelRemoveId").show();
	$("#hotelAppendId").show();
	$("#feteCostRemoveitId").show();
	$("#feteCostAppendId").show();
	$("#otherRemoveitId").show();
	$("#otherAppendId").show();
	$('#chooseuserId').removeAttr('onclick');
	sign =1;
}
function addAbroad(){
	sign = 1;
	$('#gName').textbox('readonly',true);
	$('#fTeamName').textbox('readonly',true);
	$('#fAbroadPlace').textbox('readonly',true);
	$('#fTeamLeader').textbox('readonly',true);
	$('#fTeamPersonNum').textbox('readonly',true);
	$('#abroadDateStart').textbox('readonly',true);
	$('#abroadDateEnd').textbox('readonly',true);
	$('#abroadDay').textbox('readonly',true);
	$("#fDiningPlaceId1").attr('disabled','disabled');
	$("#fDiningPlaceId2").attr('disabled','disabled');
	$('#chooseuserId').removeAttr('onclick');
	$("#editAbroadId").show();
	$("#addAbroadId").hide();
	$("#removeit1Id").hide();
	$("#append1Id").hide();
	$("#travelingExpenseId").show();
	$("#outsideAppendId").show();
	$("#outsideRemoveitId").show();
	$("#travelingAppendId").show();
	$("#hotelRemoveId").show();
	$("#hotelAppendId").show();
	$("#feteCostRemoveitId").show();
	$("#feteCostAppendId").show();
	$("#otherRemoveitId").show();
	$("#otherAppendId").show();
	
	var international = $('#international_traveling_expense_id').datagrid('getRows');
	for(var i = international.length-1 ; i >= 0 ; i--){
		$('#international_traveling_expense_id').datagrid('deleteRow',i);
	}
	var outside = $('#apply_outside_traffic_tab_id').datagrid('getRows');
	for(var i = outside.length-1 ; i >= 0 ; i--){
		$('#apply_outside_traffic_tab_id').datagrid('deleteRow',i);
	}
	var hoteltab = $('#hoteltabApply').datagrid('getRows');
	for(var i = hoteltab.length-1 ; i >= 0 ; i--){
		$('#hoteltabApply').datagrid('deleteRow',i);
	}
	var foodrows = $('#foodtab').datagrid('getRows');
	for(var i = foodrows.length-1 ; i >= 0 ; i--){
		$('#foodtab').datagrid('deleteRow',i);
	}
	var feeRows = $('#rec-fee-dg').datagrid('getRows');
	for(var i = feeRows.length-1 ; i >= 0 ; i--){
		$('#rec-fee-dg').datagrid('deleteRow',i);
	}
	var fete = $('#rec-fete-dg').datagrid('getRows');
	for(var i = fete.length-1 ; i >= 0 ; i--){
		$('#rec-fete-dg').datagrid('deleteRow',i);
	}
	var other = $('#rec-other-dg').datagrid('getRows');
	for(var i = other.length-1 ; i >= 0 ; i--){
		$('#rec-other-dg').datagrid('deleteRow',i);
	}
	addMiscellaneousFeeAndFoodInfo();
}
function editAbroad(){
	sign = 0;
	$('#gName').textbox('readonly',false);
	$('#fTeamName').textbox('readonly',false);
	$('#fAbroadPlace').textbox('readonly',false);
	$('#fTeamLeader').textbox('readonly',false);
	$('#fTeamPersonNum').textbox('readonly',false);
	$('#abroadDateStart').textbox('readonly',false);
	$('#abroadDateEnd').textbox('readonly',false);
	$('#abroadDay').textbox('readonly',false);
	$('#fDiningPlaceId1').removeAttr("disabled");
	$('#fDiningPlaceId2').removeAttr("disabled");
	$("#chooseuserId").attr("onclick","chooseuser();");
	$("#editAbroadId").hide();
	$("#addAbroadId").show();
	$("#removeit1Id").show();
	$("#append1Id").show();
	$("#travelingExpenseId").hide();
	$("#outsideAppendId").hide();
	$("#outsideRemoveitId").hide();
	$("#travelingAppendId").hide();
	$("#hotelRemoveId").hide();
	$("#hotelAppendId").hide();
	$("#feteCostRemoveitId").hide();
	$("#feteCostAppendId").hide();
	$("#otherRemoveitId").hide();
	$("#otherAppendId").hide();
	acceptTravelingExpense();
	acceptInternational();
	accepthotel();
	accept2();
}
</script>
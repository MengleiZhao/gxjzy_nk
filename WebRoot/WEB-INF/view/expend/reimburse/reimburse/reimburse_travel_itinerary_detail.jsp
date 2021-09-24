<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="reimburse_itinerary_detail_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/reimburse/applyTravelPage?rId=${bean.rId}&travelType=GWCC',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'travelAttendPeop',width:255,align:'center'">同行人（可多选）</th>
				<th data-options="field:'travelDateStart',width:110,align:'center',formatter:ChangeDateFormat">出发日期</th>
				<th data-options="field:'travelDateEnd',width:120,align:'center',formatter:ChangeDateFormat">撤离日期/抵津日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center'">目的地</th>
			</tr>
		</thead>
	</table>
</div>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div id="dlgdivMap" class="easyui-dialog"
     style="width: 1280px; height: 590px; padding: 10px 20px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlargeMap"></div>
</div>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="tracel_itinerary_detail_trip_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyTravelPage?gId=${bean.gId}&travelType=GWCX',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
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
				<th data-options="field:'travelAttendPeop',width:100,align:'center'">出行人员</th>
				<th data-options="field:'travelAttendPeopId',align:'center',hidden:true,align:'center'"></th>
				<th data-options="field:'fName',width:130,align:'center',align:'center'">学生人员</th>
				<th data-options="field:'fIdentityNumber',hidden:true,align:'center'">使用身份证号作为学生id区分姓名相同的</th>
				<th data-options="field:'travelAreaTime',width:110,align:'center'">出行日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center'">目的地</th>
				<th data-options="field:'travelAreaId',hidden:true,align:'center'"></th>
				<th data-options=" field:'areaNames',width:150,align:'center'">出行区域</th>
				<th data-options="field:'areaCode',hidden:true,align:'center'">乘车方式</th>
				<th data-options="field:'fDriveWayCode',hidden:true,align:'center'"></th>
				<th data-options="field:'reason',width:165,align:'center'">主要工作内容</th>
			</tr>
		</thead>
	</table>
</div>
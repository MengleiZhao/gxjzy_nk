<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 0px;">
	<table id="rec-other-detail-dg" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#other_detail_id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/receptionOthers?gId=${bean.gId}&fType=1',
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
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'fCostStd',hidden:true"></th>
				<th data-options="field:'fType',hidden:true"></th>
				<th data-options="field:'fCostName',required:'required',align:'center',width:195">费用名称</th>
				<th data-options="field:'fTeacherCost',required:'required',align:'center',width:239">教师金额[元]</th>
				<th data-options="field:'fStudentCost',required:'required',align:'center',width:239">学生金额[元]</th>
				<th data-options="field:'fCost',required:'required',align:'center',hidden:true,width:191">申请金额[元]</th>
			</tr>
		</thead>
	</table>
	<div id="other_detail_id" style="height:20px;">
		<a style="float: left;">差旅费</a>
	</div>
</div>
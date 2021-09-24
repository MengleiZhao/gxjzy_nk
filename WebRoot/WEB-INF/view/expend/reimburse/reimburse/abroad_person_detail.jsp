<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-top:10px;padding-top: 0px;margin-left: 0px;">
	<table id="abroad-person-detail-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: '#dmp',
	<c:if test="${!empty abroad.faId}">
	url: '${base}/apply/abroadPeople?id=${abroad.faId}',
	</c:if>
	<c:if test="${empty abroad.faId}">
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
			<th data-options="field:'frId',hidden:true"></th>			
			<th data-options="field:'travelPeopName',align:'center',width:100">姓名</th>
			<th data-options="field:'idCard',align:'center',width:140">身份证号</th>
			<th data-options="field:'fPassport',align:'center',width:140">护照号</th>
			<th data-options="field:'position',align:'center',width:140">职务</th>
			<th data-options="field:'phoneNum',align:'center',width:140">联系方式</th>
		</tr>
	</thead>
</table>
</div>

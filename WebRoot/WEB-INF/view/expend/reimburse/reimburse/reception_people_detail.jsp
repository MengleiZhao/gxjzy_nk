<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-table">

	<table id="dg_reception_people_detail" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty receptionBean.jId}">
	url: '${base}/apply/recep?id=${receptionBean.jId}',
	</c:if>
	<c:if test="${empty receptionBean.jId}">
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
				<th data-options="field:'travelRId',hidden:true"></th>
				<th data-options="field:'receptionPeopName',width:333,align:'center',">姓名</th>
				<th data-options="field:'position',width:333,align:'center'">职务/级别</th>
				<th data-options="field:'positionCode',hidden:true"></th>				
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">


</script>
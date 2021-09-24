<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-table">
	<table id="dg_accompany_people_reimb" class="easyui-datagrid" style="width:694px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty receptionBeanEdit.jId}">
	url: '${base}/apply/accompanyPeop?id=${receptionBeanEdit.jId}',
	</c:if>
	<c:if test="${empty receptionBeanEdit.jId}">
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
				<th data-options="field:'acId',hidden:true"></th>
				<th data-options="field:'receptionPeopName',width:330,align:'center'">姓名</th>
				<th data-options="field:'position',width:335,align:'center'">职务</th>				
			</tr>
		</thead>
	</table>
	
</div>
<script type="text/javascript">
</script>
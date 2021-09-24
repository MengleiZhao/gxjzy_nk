<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-table">

	<table id="dg_observe_plan_detail" class="easyui-datagrid" style="width:694px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/apply/observe?id=${receptionBean.jId}',
	method: 'post',
	<c:if test="${empty detail}">
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'oId',hidden:true"></th>
				<th data-options="field:'observeTime',width:150,align:'center',formatter:ChangeDateFormatIndex">时间</th>
				<th data-options="field:'fProject',width:200,align:'center'">项目</th>
				<th data-options="field:'personNum',width:150,align:'center'">人数</th>
				<th data-options="field:'accompanyPerson',width:180,align:'center'">其中陪同人员</th>				
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
</script>
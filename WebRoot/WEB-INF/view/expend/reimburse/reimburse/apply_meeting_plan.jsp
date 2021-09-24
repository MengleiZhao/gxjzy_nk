<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="dg_meet_plan1" class="easyui-datagrid" 
	style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/apply/meetPlan?id=${applyBean.gId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'planId',hidden:true"></th>
				<th data-options="field:'times',width:195,align:'center',formatter:ChangeDateFormat">起始时间</th>
				<th data-options="field:'timee',width:195,align:'center',formatter:ChangeDateFormat">结束时间</th>
				<th data-options="field:'content',width:276,align:'center'">会议事项</th>
			</tr>
		</thead>
	</table>
</div>
	
	
<script type="text/javascript">

	
</script>
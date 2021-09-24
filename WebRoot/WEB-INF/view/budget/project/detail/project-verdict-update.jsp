<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="checkUpdRecordTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/project/checkUpdatePage?proId=${proId }',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'updId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 14%">修改人</th>
					<th data-options="field:'updateTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormatIndex" style="width: 20%">修改时间</th>
					<th data-options="field:'columnName',align:'center',resizable:false,sortable:true" style="width: 20%">修改项</th>
					<th data-options="field:'oldValue',align:'center',resizable:false,sortable:true" style="width: 22%">修改前</th>
					<th data-options="field:'newValue',align:'center',resizable:false,sortable:true" style="width: 22%">修改后</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	//分页样式调整
	$(function(){
		var pager = $('#checkUpdRecordTab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});
	});
</script>
</body>
</html>
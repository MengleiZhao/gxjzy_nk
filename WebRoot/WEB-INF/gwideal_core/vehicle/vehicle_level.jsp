<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="vehicleAdd('${parentCode}')">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="list-table">
		<table id="vehicle_list2" class="easyui-datagrid" data-options="collapsible:true,url:'${base}/vehicle/pageData?parentCode=${parentCode}',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,selectOnCheck: true,
		checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
			<thead>
				<tr>
					<th data-options="field:'fId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 10%">序号</th>
					<th data-options="field:'parentCode',align:'left',resizable:false" style="width: 22.5%">父节点编号</th>
					<th data-options="field:'code',align:'left',resizable:false" style="width: 22.5%">编号</th>
					<th data-options="field:'name',align:'left',resizable:false" style="width: 22.5%">名称</th>
					<th data-options="field:'cz',align:'left',resizable:false,formatter:vehicleCZ" style="width: 22.5%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>


<script type="text/javascript">

</script>
</body>

<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div style="height: 400px">
<table class="easyui-datagrid" id="index-xdmx"
	data-options="collapsible:true,url:'${base}/transmit/xdmxPage?id=${bId}',
	method:'post',fit:true,pagination:true,singleSelect: true,rownumbers:true,
	checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
		<thead>
			<tr>
				<th data-options="field:'dId',hidden:true"></th>
				<th data-options="field:'releaseTime',align:'left',formatter: ChangeDate" style="width: 15%">下达时间</th>
				<th data-options="field:'indexName',align:'left'" style="width: 30%">指标名称</th>
				<th data-options="field:'bcReleaseAmount',align:'left',formatter:xdjeColor" style="width: 20%">下达金额[万元]</th>
				<th data-options="field:'releaseUserName',align:'left'" style="width: 15%">执行人</th>
				<th data-options="field:'releaseDepart',align:'left'" style="width: 20%">部门</th>
			</tr>
		</thead>
	</table>
</div>
<div class="win-left-bottom-div">
	<a href="javascript:void(0)" onclick="closeFirstWindow()">
	<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
</div>
<script type="text/javascript">
function xdjeColor(val, row){
	return "<a style='color:red'>-"+val+"</a>";
}
</script>

<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	 <div class="list-table-tab">
		<div style="height: 440px ;width: 100%">
			<table id="project-review-history-table" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/project/findReviewHistory',
				method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="align:'center',field:'num'" style="width: 5%">序号</th>
						<th data-options="align:'left',field:'proName'" style="width: 20%">项目名称</th>
						<th data-options="align:'left',field:'oldValue'" style="width: 20%">项目名称复核前</th>
						<th data-options="align:'left',field:'newValue'" style="width: 20%">项目名称复核后</th>
						<th data-options="align:'left',field:'operator'" style="width: 10%">复核人</th>
						<th data-options="align:'left',field:'updateTime',formatter: ChangeDateFormat" style="width: 15%">复核时间</th>
						<th data-options="align:'left',field:'proId' ,formatter:xiadaStatue" style="width: 10%">信息下达</th>
					</tr>
				</thead>
			</table>
		</div>
	</div> 
</div>
<script type="text/javascript">
//下达状态
function xiadaStatue(val, row) {
	return '<a style="color:#666666;">' + " 已下达" + '</a>';
 }


</script>

</body>

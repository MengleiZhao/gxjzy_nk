<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" class="queryth">
						&nbsp;&nbsp;姓名&nbsp;
						<input id="query_name" style="width: 150px;height:25px;" class="easyui-textbox"/>
						
						<!-- &nbsp;&nbsp;部门&nbsp;
						<input id="query_dept" style="width: 150px;height:25px;" class="easyui-textbox"/> -->
						
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						<a href="#" onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>           
		</div>
			<div class="list-table">
			<table id="choose_nameAndDept_dg" 
			data-options="collapsible:true,url:'${base}/user/jsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'Id',hidden:true"></th>
						<th data-options="field:'accountNo',align:'center'" width="25%">账号</th>
						<th data-options="field:'name',align:'center'" width="25%">姓名</th>
						<th data-options="field:'departName',align:'center',resizable:false,sortable:true" width="25%">部门</th>
						<th data-options="field:'dpcode',align:'center',resizable:false,sortable:true" width="25%">部门编码</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">

//查询
function queryCF() {
	$("#choose_nameAndDept_dg").datagrid('load',{
		name:$("#query_name").textbox('getValue').trim(),
	//	gName:$("#query_dept").textbox('getValue').trim(),
	});
}

//清除查询条件
function clearTable() {
	
	$("#query_name").textbox('setValue','');
	//$("#query_dept").textbox('setValue','');
	
	$("#choose_nameAndDept_dg").datagrid('load',{});
}
//双击选择页面
$('#choose_nameAndDept_dg').datagrid({
	onDblClickRow: function(rowIndex, rowData){
		//$(this).datagrid('beginEdit', index);
		//var ed = $(this).datagrid('getEditor', {index:index,field:field});
		$("#fuserId").val(rowData.id);
		$("#userName2").textbox('setValue',rowData.name);
		//$(ed.target).focus();
		closeSecondWindow();
	}
});
</script>
</body>
</html>


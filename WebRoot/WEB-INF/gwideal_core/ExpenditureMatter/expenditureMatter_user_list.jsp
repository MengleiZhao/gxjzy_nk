<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div" style="background-color: #ffffff">
	<div class="list-table">
		<table id="expenditure_role_dg" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/ExpenditureMatter/roleList',
				method:'post',fit:true,pagination:false,singleSelect: false,scrollbarSize:0,
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,rownumbers:true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'id',hidden:true"></th>
					<th data-options="field:'code',align:'center',resizable:false,sortable:true" width="15%">角色代码</th>
					<th data-options="field:'name',align:'center',resizable:false" width="15%">角色名称</th>
					<th data-options="field:'description',align:'left',resizable:false" width="67%">说明</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div class="win-left-bottom-div">
		<a href="javascript:void(0)" onclick="saveRoleIds()">
		<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="saveAllRoleId()">
		<img src="${base}/resource-modality/${themenurl}/button/qbbc1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</div>


<script type="text/javascript">
function saveRoleIds() {
	
	var row = $('#expenditure_role_dg').datagrid('getSelections');//获得选择行
	var roleids = "";
	var roleName = "";
	for(var i=0;i<row.length;i++){
		if(i==0) {
			roleids = roleids + row[i].id;
			roleName = roleName + row[i].name;
			
		} else {
			roleids = roleids + "@" + row[i].id;
			roleName = roleName + "@" + row[i].name;
		}
	}
	$('#roleIds').textbox('setValue',roleids);
	$('#roleName').textbox('setValue',roleName);
	closeFirstWindow();
}

function saveAllRoleId() {
	$('#roleIds').textbox('setValue','*');
	$('#roleName').textbox('setValue','*');
	closeFirstWindow();
}
</script>
</body>

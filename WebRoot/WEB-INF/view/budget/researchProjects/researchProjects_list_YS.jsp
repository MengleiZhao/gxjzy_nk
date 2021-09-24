<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">
	<div class="list-div">
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table id="researchProjects_dg"  class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">
						&nbsp;&nbsp;登记编号&nbsp;
						<input id="project_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;登记项目名称&nbsp;
						<input id="project_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;登记部门&nbsp;
						<input id="project_dept" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;科研类型&nbsp;
						<input id="project_researchType" class="easyui-combobox" name="" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=KYJFLX',method:'POST',valueField:'code',textField:'text'" style="width: 150px;height: 25px"/>
						&nbsp;&nbsp;
						<a href="#" onclick="queryProject();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearProject();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>
		</div>
		
		<div style="margin: 0 10px 0 10px;height: 385px;">	
			<table id="researchProjects_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/researchProjects/getProjectUserAndProjectMemberById?userName=${userName}',
			method:'post',
			fit:true,
			pagination:true,
			singleSelect: true,
			remoteSort:true,
			nowrap:false,
			striped: true,
			fitColumns: true,
			onDblClickRow:confirmOutcome1">
				<thead>
					<tr>
						<th data-options="field:'fpId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
						<th data-options="field:'fpCode',align:'center'" style="width: 20%">登记编号</th>
						<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">登记日期</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 10%">登记部门</th>
						<th data-options="field:'fUserName',align:'center',resizable:false,sortable:true" style="width: 10%">登记人</th>
						<th data-options="field:'projectCode',align:'center',resizable:false,sortable:true" style="width: 10%">项目编号</th>
						<th data-options="field:'projectName',align:'center',resizable:false,sortable:true" style="width: 10%">项目名称</th>
						<th data-options="field:'projectUser',align:'center',resizable:false,sortable:true" style="width: 10%">项目负责人</th>
						<th data-options="field:'researchTypeName',align:'center',resizable:false,sortable:true" style="width: 8%">科研类型</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 7%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		
	<div data-options="region:'south'" border="false" style="height: 80px;line-height: 80px;text-align: center;">
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
		</div>
		<div style="height: 20px;">
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
			<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
		</div>
	</div>
			
	</div>

<script type="text/javascript">
//点击查询
function queryProject() {
	$('#researchProjects_tab').datagrid('load', {
		fpCode : $('#project_code').textbox('getValue'),
		projectName : $('#project_name').textbox('getValue'),
		fDeptName : $('#project_dept').textbox('getValue'),
		researchType : $('#project_researchType').textbox('getValue')
	});                            
}

//清除查询条件
function clearProject() {
	$('#project_code').textbox('setValue', '');
	$('#project_name').textbox('setValue', '');
	$('#project_dept').textbox('setValue', '');
	$('#project_researchType').textbox('setValue', '');
	queryTable();
}

function confirmOutcome1(index,row){
	$("#scientificProName").textbox('setValue', row.projectName);
	$("#scientificProId").val(row.fpId);
	closeFirstWindow();
}


//操作栏创建
function CZ(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="detail_project(' + row.fpId + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td></tr></table>';
}

//查看
function detail_project(id) {
	var win = creatSecondWin('查看', 1105, 580, 'icon-search', '/researchProjects/detailYS?id='+id);
	win.window('open');
}
</script>
</body>
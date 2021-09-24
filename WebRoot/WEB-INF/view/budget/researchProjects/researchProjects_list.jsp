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
						<input id="project_researchTypeName" name="" style="width: 150px; height:25px;" class="easyui-combobox" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=KYJFLX&selected=${bean.researchType}',method:'POST',valueField:'code',textField:'text'"></input>
						
						&nbsp;&nbsp;审批状态&nbsp;
						<select id="project_type" class="easyui-combobox" style="width: 150px; height:25px;" data-options="required:true,editable:false">
							<option value="">-请选择-</option>
							<option value="1">待审批</option>
							<option value="0">暂存</option>
							<option value="-4">已撤回</option>
							<option value="-1">已退回</option>
							<option value="9">已审批</option>
						</select>&nbsp;
						<a href="#" onclick="queryProject();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearProject();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="add_project()">
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>
		</div>
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="researchProjects_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/researchProjects/pageData',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fpId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
						<th data-options="field:'fpCode',align:'center'" style="width: 10%">登记编号</th>
						<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">登记日期</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 10%">登记部门</th>
						<th data-options="field:'fUserName',align:'center',resizable:false,sortable:true" style="width: 8%">登记人</th>
						<th data-options="field:'projectCode',align:'center',resizable:false,sortable:true" style="width: 10%">项目编号</th>
						<th data-options="field:'projectName',align:'center',resizable:false,sortable:true" style="width: 10%">项目名称</th>
						<th data-options="field:'projectUser',align:'center',resizable:false,sortable:true" style="width: 8%">项目负责人</th>
						<th data-options="field:'researchTypeName',align:'center',resizable:false,sortable:true" style="width: 10%">科研类型</th>
						<th data-options="field:'flowStatus',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>

<script type="text/javascript">
//点击查询
function queryProject() {
	$('#researchProjects_tab').datagrid('load', {
		fpCode : $('#project_code').textbox('getValue'),
		projectName : $('#project_name').textbox('getValue'),
		fDeptName : $('#project_dept').textbox('getValue'),
		flowStatus : $('#project_type').combobox('getValue'),
		researchType : $('#project_researchTypeName').combobox('getValue'),
	});                            
}

//清除查询条件
function clearProject() {
	$('#project_code').textbox('setValue', '');
	$('#project_name').textbox('setValue', '');
	$('#project_dept').textbox('setValue', '');
	$('#project_type').combobox('setValue', '');
	$('#project_researchTypeName').combobox('setValue', '');
	queryProject();
}
//设置审批状态
function flowStautsSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
	} else if (val == -4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	var c = row.flowStatus;
	if ( c == 1 || c == 2) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   		'<a href="#" onclick="detail_project(' + row.fpId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   	 '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="reCall(\'researchProjects_tab\',' + row.fpId + ',\'/researchProjects/reCall\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
		   		'</a></td></tr></table>';
	}else if(c == 0 || c == -1|| c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail_project(' + row.fpId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="update_project(' + row.fpId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="delete_project(' + row.fpId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}else if (c == 9 ) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
   		'<a href="#" onclick="detail_project(' + row.fpId + ')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
   		'</a></td></tr></table>';
	}
}


//新增
function add_project() {
	var win = creatWin('新增', 1105, 580, 'icon-search', '/researchProjects/add');
	win.window('open');
}
//查看
function detail_project(id) {
	var win = creatWin('查看', 1105, 580, 'icon-search', '/researchProjects/detail?id='+id);
	win.window('open');
}
//查看
function update_project(id) {
	var win = creatWin('修改', 1105, 580, 'icon-search', '/researchProjects/edit?id='+id);
	win.window('open');
}
//删除
function delete_project(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/researchProjects/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#researchProjects_tab').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
</script>
</body>
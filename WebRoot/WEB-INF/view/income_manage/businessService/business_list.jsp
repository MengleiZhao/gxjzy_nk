<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table id="register_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">
					&nbsp;&nbsp;立项编号&nbsp;
					<input id="business_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;立项项目名称&nbsp;
					<input id="business_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="business_dept" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;审批状态&nbsp;
					<select id="business_type" class="easyui-combobox" style="width: 150px; height:25px;" data-options="required:true,editable:false">
						<option value="">-请选择-</option>
						<option value="1">待审批</option>
						<option value="0">暂存</option>
						<option value="-4">已撤回</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select>&nbsp;
					<a href="#" onclick="queryTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="add_business()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="business_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/business/jsonPagination',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fBusiId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fBusiCode',align:'center'" style="width: 17%">立项编号</th>
					<th data-options="field:'fProName',align:'center',resizable:false,sortable:true" style="width: 25%">立项项目名称</th>
					<th data-options="field:'fOperatorName',align:'center',resizable:false,sortable:true" style="width: 10%">申请人</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 10%">申请部门</th>
					<th data-options="field:'fBusiTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 14%">申请日期</th>
					<th data-options="field:'fFlowStatus',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#business_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});
});
	
//点击查询
function queryTable() {
	$('#business_tab').datagrid('load', {
		fBusiCode : $('#business_code').textbox('getValue'),
		fProName : $('#business_name').textbox('getValue'),
		fDeptName : $('#business_dept').textbox('getValue'),
		fType : $('#business_type').combobox('getValue'),
	});                            
}

//清除查询条件
function clearTable() {
	$('#business_code').textbox('setValue', '');
	$('#business_name').textbox('setValue', '');
	$('#business_dept').textbox('setValue', '');
	$('#business_type').combobox('setValue', '');
	queryTable();
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
	var c = row.fFlowStatus;
	if ( c == 1 || c == 2) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   		'<a href="#" onclick="detail_business(' + row.fBusiId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   	 '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="reCall(\'business_tab\',' + row.fBusiId + ',\'/business/reCall\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
		   		'</a></td></tr></table>';
	}else if(c == 0 || c == -1|| c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail_business(' + row.fBusiId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="update_business(' + row.fBusiId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="delete_business(' + row.fBusiId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}else if (c == 9 ) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
   		'<a href="#" onclick="detail_business(' + row.fBusiId + ')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
   		'</a></td><td style="width: 25px">'+
		'<a href="#" onclick="exportHtml(' + row.fBusiId + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
	   '</a></td></tr></table>';
}
}

//新增
function add_business() {
	var win = creatWin('新增', 1105, 580, 'icon-search', '/business/add');
	win.window('open');
}

//修改
function update_business(id) {
	var win = creatWin('修改', 1105, 580, 'icon-search', '/business/edit?id=' + id);
	win.window('open');
}

//查看
function detail_business(id) {
	var win = creatWin('查看', 1105, 580, 'icon-search', '/business/detail?id=' + id);
	win.window('open');
} 

//打印
function exportHtml(id) {
	window.open(base+"/incomeExport/business?id="+ id);
}	

//删除
function delete_business(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/business/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#business_tab').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
} 
</script>
</body>
</html>


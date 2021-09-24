<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="refund_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">申请单编号&nbsp;
					<input id="refund_infoCode" name="fInfoCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="refund_deptName" name="fDeptName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;
					<a href="#" onclick="queryTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="add_refund()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="refund_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/refund/jsonPagination?fNewOrOld=${fNewOrOld}',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fRID',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fInfoCode',align:'center'" style="width: 20%">申请单号</th>
					<th data-options="field:'fNewOrOld',align:'center',formatter:studentType" style="width: 11%">学生类型</th>
					<th data-options="field:'fUserName',align:'center'" style="width: 15%">申请人</th>
					<th data-options="field:'fDeptName',align:'center'" style="width: 15%">申请部门</th>
					<th data-options="field:'fReqTime',align:'center',formatter:ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'flowStauts',align:'center',formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#refund_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});
});
	
//点击查询
function queryTable() {
	$('#refund_tab').datagrid('load', {
		fInfoCode : $('#refund_infoCode').textbox('getValue'),
		fDeptName :	$('#refund_deptName').textbox('getValue')
	});                            
}

//清除查询条件
function clearTable() {
	$('#refund_infoCode').textbox('setValue', '');
	$('#refund_deptName').textbox('setValue', '');
	$('#refund_tab').datagrid('load', {});//重新加载
}

//学生类型
function studentType(val){
	if (val == 0) {
		return '新生';
	}else {
		return '老生';
	}
}

//设置审批状态
function flowStautsSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	}else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	}else if (val == -4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	}else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
	}else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	var c = row.flowStauts;
	if (c == 1 || c == 2) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   		'<a href="#" onclick="detail_refund(' + row.fRID + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a></td><td style="width: 25px">'+ '<a href="#" onclick="reCall(\'refund_tab\' ,'+ row.fRID+',\'/refund/reCall\''+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">' + '</a>'
				+'</td></tr></table>';
	}else if(c == 0 || c == -1 || c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail_refund(' + row.fRID + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="update_refund(' + row.fRID + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="delete_refund(' + row.fRID + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}else if(c == 9){
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   		'<a href="#" onclick="detail_refund(' + row.fRID + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			    '</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="exportHtml(' + row.fRID + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
		   		'</a></td></tr></table>';
	}
}
//打印
function exportHtml(id) {
	window.open(base+'/refund/export?id='+ id);
}

//新增
function add_refund() {
	var win = creatWin('退费-申请', 1110, 600, 'icon-search', '/refund/add?fNewOrOld=${fNewOrOld}');
	win.window('open');
}

//修改
function update_refund(id) {
	var win = creatWin('退费-修改', 1110, 600, 'icon-search', '/refund/edit/'+id);
	win.window('open');
}

//查看
function detail_refund(id) {
	var win = creatWin('退费明细', 1110, 600, 'icon-search', '/refund/detail/'+id);
	win.window('open');
} 
		
//删除
function delete_refund(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/refund/delete/'+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#refund_tab').datagrid('reload');
				}else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
} 
</script>
</body>
</html>
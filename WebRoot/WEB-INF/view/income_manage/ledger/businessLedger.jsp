<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table id="register_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">
					立项单号&nbsp;
					<input id="business_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;项目名称&nbsp;
					<input id="business_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="business_dept" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					<a href="#" onclick="queryTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="business_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/incomeManagerledger/businessPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fBusiId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fBusiCode',align:'center'" style="width: 15%">立项单号</th>
					<th data-options="field:'fProName',align:'center',resizable:false,sortable:true" style="width: 20%">项目名称</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 10%">申请部门</th>
					<th data-options="field:'fOperatorName',align:'center',resizable:false,sortable:true" style="width: 8%">申请人</th>
					<th data-options="field:'incomeMoney',align:'center',resizable:false" style="width: 14%">登记金额（汇总金额-终止缴款金额）</th>
					<th data-options="field:'paymentMoney',align:'center',resizable:false" style="width: 8%">确认金额</th>
					<th data-options="field:'fBusiTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 8%">立项时间</th>
					<th data-options="field:'fFlowStatus',align:'center',resizable:false,formatter:flowStautsSet" style="width: 8%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 5%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	
//点击查询
function queryTable() {
	$('#business_tab').datagrid('load', {
		fBusiCode : $('#business_code').textbox('getValue'),
		fProName : $('#business_name').textbox('getValue'),
		fDeptName : $('#business_dept').textbox('getValue'),
	});                            
}

//清除查询条件
function clearTable() {
	$('#business_code').textbox('setValue', '');
	$('#business_name').textbox('setValue', '');
	$('#business_dept').textbox('setValue', '');
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
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="detail_business(' + row.fBusiId + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td></tr></table>';
}

//查看
function detail_business(id) {
	var win = creatWin('查看', 1115, 580, 'icon-search', '/business/detail?id=' + id);
	win.window('open');
} 
		
</script>
</body>
</html>
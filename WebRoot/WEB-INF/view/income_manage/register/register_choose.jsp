<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="register_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">&nbsp;&nbsp;
					&nbsp;&nbsp;登记编号&nbsp;
					<input id="register_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;立项项目名称&nbsp;
					<input id="register_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;登记部门&nbsp;
					<input id="register_dept" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;审批状态&nbsp;
					<select id="register_type" class="easyui-combobox" style="width: 150px; height:25px;" data-options="required:true,editable:false">
						<option value="">-请选择-</option>
						<option value="1">待审批</option>
						<option value="0">暂存</option>
						<option value="-4">已撤回</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select>&nbsp;
					<a href="#" onclick="queryRegistChoose();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearRegistTableChoose();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
				</td>
			</tr>
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="registerChooseTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/incomeConfirm/choosePage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fincomeId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fincomeNum',align:'center'" style="width: 20%">登记编号</th>
					<th data-options="field:'fproName',align:'center',resizable:false,sortable:true" style="width: 15%">立项项目名称</th>
					<th data-options="field:'fregisterPerson',align:'center',resizable:false,sortable:true" style="width: 15%">登记人</th>
					<th data-options="field:'fregisterDepart',align:'center',resizable:false,sortable:true" style="width: 15%">登记部门</th>
					<th data-options="field:'fregisterTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 17.5%">登记日期</th>
					<th data-options="field:'fFlowStauts',align:'center',resizable:false,formatter:flowStautsSet" style="width: 15%">审批状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
//点击查询
function queryRegistChoose() {
	$('#registerChooseTab').datagrid('load', {
		fCode : $('#register_code').textbox('getValue'),
		fProName : $('#register_name').textbox('getValue'),
		fDeptName : $('#register_dept').textbox('getValue'),
		fType : $('#register_type').combobox('getValue'),
	});                            
}

//清除查询条件
function clearRegistTableChoose() {
	$('#register_code').textbox('setValue',''),
	$('#register_name').textbox('setValue',''),
	$('#register_dept').textbox('setValue',''),
	$('#register_type').combobox('setValue',''),
	queryRegist();
}

$(function() {
	//定义双击事件
	$('#registerChooseTab').datagrid({
		onDblClickRow : function(rowIndex, rowData) {
			var win = creatSecondWin('非合同收入确认-新增', 1105,580, 'icon-search', '/incomeConfirm/confirm?id='+rowData.fincomeId);
			win.window('open');
		}
	});
});
</script>
</body>
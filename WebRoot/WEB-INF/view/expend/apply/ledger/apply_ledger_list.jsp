<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;申请单编号&nbsp;
					<input id="apply_ledger_list_top_gCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请摘要名称&nbsp;
					<input id="apply_ledger_list_top_gName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="apply_ledger_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryApplyLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearApplyLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="text-align: right; padding-right: 10px;">
					<a href="#" onclick="applyLedgerDaochu()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"/>
					</a>
				</td>
			</tr>
		</table>
	</div>



	<div class="list-table">
		<table id="applyLedgerTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/applyLedger/applyPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'gId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'gCode',align:'center',resizable:false" style="width: 15%">申请单编号</th>
					<th data-options="field:'gName',align:'center',resizable:false" style="width: 15%">申请摘要名称</th>
					<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 10%">申请事项</th>
					<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 10%">申请部门</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">申请人</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>


<script type="text/javascript">
//设置申请事项
function typeSet(val, row) {
	if (val == 1) {
		return '<span>' + "通用事项申请" + '</span>';
	} else if (val == 2) {
		return '<span>' + "会议申请" + '</span>';
	} else if (val == 3) {
		return '<span>' + "培训申请" + '</span>';
	} else if (val == 4) {
		return '<span>' + "差旅申请" + '</span>';
	} else if (val == 5) {
		return '<span>' + "接待申请" + '</span>';
	} else if (val == 6) {
		return '<span>' + "公车运维申请" + '</span>';
	} else if (val == 7) {
		return '<span>' + "公务出国申请" + '</span>';
	}
}
	
	
//设置审批状态
var c;
function flowStautsSet(val, row) {
	c = val;
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
	}

//操作栏创建
function CZ(val, row) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editApply(' + row.gId + ',0,'+row.type+')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
}
	
//修改
function editApply(id,type,applyType) {
	/*type为修改或查看1位修改，0位查看  */
	if(applyType=="1"){
	var win = creatWin('申请事项明细', 800, 600, 'icon-search', "/apply/edit?id="+ id+"&editType="+type+"&applyType="+ applyType);
	win.window('open');
	}else{
		var win = creatWin('申请事项明细', 1105, 580, 'icon-search', "/apply/edit?id="+ id+"&editType="+type+"&applyType="+ applyType);
		win.window('open');
	}
}
	
//查询
function queryApplyLedger() {
	var gCode="apply_ledger_list_top_gCode";
	var gName="apply_ledger_list_top_gName";
	var deptName="apply_ledger_list_top_deptName";
	
	$("#applyLedgerTab").datagrid('load',{
		gCode:$("#"+gCode).textbox('getValue').trim(),
		gName:$("#"+gName).textbox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
	
//清除查询条件
function clearApplyLedger() {
	var gCode="apply_ledger_list_top_gCode";
	var gName="apply_ledger_list_top_gName";
	var deptName="apply_ledger_list_top_deptName";
	
	$("#"+gCode).textbox('setValue',''),
	$("#"+gName).textbox('setValue',''),
	$("#"+deptName).textbox('setValue',''),
	
	$("#applyLedgerTab").datagrid('load',{});
}
	
function applyLedgerDaochu(){
	var url=base+"/apply/export";
	
	var gCode=$("#apply_ledger_list_top_gCode").textbox('getValue');
	var gName=$("#apply_ledger_list_top_gName").textbox('getValue');
	var deptName=$("#apply_ledger_list_top_deptName").textbox('getValue');
	
	url = url+"?gCode="+gCode+"&gName="+gName+"&deptName="+deptName;
	
	window.location.href=url;
	
}

</script>
</body>


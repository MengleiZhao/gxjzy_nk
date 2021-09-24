<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/loadingDiv.jsp"%>
<body >

<div class="list-div">
<div style="height: 10px;background-color:#f0f5f7 "></div>
<div class="list-top">
	<table class="top-table" cellpadding="0" cellspacing="0">
		<tr>
			<tr id="directly_ledger_top">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="directly_ledger_list_top_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销部门&nbsp;
					<input id="directly_ledger_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryDirectlyLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearDirectlyLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="text-align: right; padding-right: 10px;">
					<a href="${base}/reimburse/export?applyString=0">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"/>
					</a>
				</td>
			</tr>
				
			<tr id="reimburse_ledger_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="reimburse_ledger_list_top_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销类型&nbsp;
					<select id="reimburse_ledger_list_top_type" class="easyui-combobox" style="width: 150px;height:25px;">
						<option value="">--请选择--</option>
						<option value="1">通用事项报销</option>
						<option value="2">会议报销</option>
						<option value="3">培训报销</option>
						<option value="4">差旅报销</option>
						<option value="5">公务接待报销</option>
						<option value="6">公务用车报销</option>
						<option value="7">公务出国报销</option>
					</select>
					
					&nbsp;&nbsp;报销部门&nbsp;
					<input id="reimburse_ledger_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryReimburseLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearReimburseLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="text-align: right; padding-right: 10px;">
					<a href="${base}/reimburse/export?applyString=0">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"/>
					</a>
				</td>
			</tr>
	</table>   
</div>
	

<div class="list-table-tab">
		<div class="tab-wrapper" id="rc-ledger-tab">
			<ul class="tab-menu">
				<li class="active" onclick="directlyLedgerTopClick();">直接报销</li>
			    <li onclick="reimburseLedgerTopClick();">申请报销</li>
			</ul>
				
			<div class="tab-content">
				<div style="height: 440px">
					<table id="directlyReimbLedgerTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=0&applyString=0',
					method:'post',fit:true,pagination:true,singleSelect: true,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'drId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'drCode',align:'left',resizable:false,sortable:true" style="width: 15%">报销单编号</th>
								<th data-options="field:'type',align:'left',formatter:typeSet" style="width: 10%">报销类型</th>
								<th data-options="field:'reason',align:'left'" style="width: 15%">报销事由</th>
								<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 10%">报销部门</th>
								<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 10%">报销请人</th>
								<th data-options="field:'reqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">报销时间</th>
								<th data-options="field:'amount',align:'left',resizable:false,sortable:true" style="width: 10%">报销总金额</th>
								<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ1" style="width: 13%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div style="height: 440px">
					<table id="reimburseLedgerTab" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=${reimburseType}&applyString=0',
						method:'post',fit:true,pagination:true,singleSelect: true,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'rId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'rCode',align:'left',resizable:false,sortable:true" style="width: 15%">报销单编号</th>
								<th data-options="field:'type',align:'left',formatter:typeSet" style="width: 10%">报销类型</th>
								<th data-options="field:'reimburseReason',align:'left'" style="width: 15%">报销事由</th>
								<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 10%">报销部门</th>
								<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 10%">报销请人</th>
								<th data-options="field:'reimburseReqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">报销时间</th>
								<th data-options="field:'amount',align:'left',resizable:false,sortable:true" style="width: 10%">报销总金额</th>
								<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ2" style="width: 10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
//加载tab页
flashtab('rc-ledger-tab');

//设置申请事项
function typeSet(val, row) {
	if (val == 0) {
		return '<span>' + "直接报销" + '</span>';
	} else if (val == 1) {
		return '<span>' + "通用事项报销" + '</span>';
	} else if (val == 2) {
		return '<span>' + "会议报销" + '</span>';
	} else if (val == 3) {
		return '<span>' + "培训报销" + '</span>';
	} else if (val == 4) {
		return '<span>' + "差旅报销" + '</span>';
	} else if (val == 5) {
		return '<span>' + "公务接待报销" + '</span>';
	} else if (val == 9) {
		return '<span>' + "合同报销" + '</span>';
	} else if (val == 6) {
		return '<span>' + "公务用车报销" + '</span>';
	} else if (val == 7) {
		return '<span>' + "公务出国报销" + '</span>';
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
function CZ1(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	   '<a href="#" onclick="editReimburse1(' + row.drId + ',0)" class="easyui-linkbutton">'+
	   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	   '</a></td></tr></table>';
}
function CZ2(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	   '<a href="#" onclick="editReimburse2(' + row.rId + ',0,'+row.type+')" class="easyui-linkbutton">'+
	   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	   '</a></td></tr></table>';
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}


//查看
function editReimburse1(id,type) {
	/*type为修改或查看1位修改，0位查看  */
	var win = creatWin(' ', 980,600, 'icon-search', "/directlyReimburse/edit?id="+ id+"&editType="+type);
	win.window('open');
}
function editReimburse2(id,type,reimburseType) {
	
	if(reimburseType==1){
		/*type为修改或查看1位修改，0位查看  */
		var win = creatWin(' ', 800,600, 'icon-search', "/reimburse/edit?id="+ id+"&editType="+type);
		win.window('open');
	}else{
	/*type为修改或查看1位修改，0位查看  */
	var win = creatWin(' ', 1060,600, 'icon-search', "/reimburse/edit?id="+ id+"&editType="+type);
	win.window('open');
	}
}

function directlyLedgerTopClick(){
	$("#directlyReimbLedgerTab").datagrid('reload');
	
	$("#directly_ledger_top").show();
	$("#reimburse_ledger_top").hide();
}
function reimburseLedgerTopClick(){
	$("#reimburseLedgerTab").datagrid('reload');
	
	$("#directly_ledger_top").hide();
	$("#reimburse_ledger_top").show();
}

//直接报销查询
function queryDirectlyLedger() {
	var drCode="directly_ledger_list_top_code";
	var deptName="directly_ledger_list_top_deptName";
	
	
	$("#directlyReimbLedgerTab").datagrid('load',{
		drCode:$("#"+drCode).textbox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}

//直接报销清除查询条件
function clearDirectlyLedger() {
	var drCode="directly_ledger_list_top_code";
	var deptName="directly_ledger_list_top_deptName";
	
	$("#"+drCode).textbox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#directlyReimbLedgerTab").datagrid('load',{});
}

//申请报销查询
function queryReimburseLedger() {
	var rCode="reimburse_ledger_list_top_code";
	var type="reimburse_ledger_list_top_type";
	var deptName="reimburse_ledger_list_top_deptName";
	
	
	$("#reimburseLedgerTab").datagrid('load',{
		rCode:$("#"+rCode).textbox('getValue').trim(),
		type:$("#"+type).combobox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//申请报销清除查询条件
function clearReimburseLedger() {
	var rCode="reimburse_ledger_list_top_code";
	var type="reimburse_ledger_list_top_type";
	var deptName="reimburse_ledger_list_top_deptName";
	
	$("#"+rCode).textbox('setValue','');
	$("#"+type).textbox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#reimburseLedgerTab").datagrid('load',{});
}

//导出 
function reimburseLedgerDochu() {
	var url=base+"/reimburse/export?applyString=0";
}

</script>
</body>
</html>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body >
<div class="list-div">
<div style="height: 10px;background-color:#f0f5f7 "></div>
<div class="list-top">
	<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
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
					<a href="#" onclick="reimburseLedgerDochu();">
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
					<a href="${base}/reimburse/export">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"/>
					</a>
				</td>
			</tr>
			<tr id="purchase_ledger_top" style="display: none;">
				<td class="top-table-search">采购批次编号&nbsp;
					<input id="cgbx_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称&nbsp;
					<input id="cgbx_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					
					
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="cgbx_fDeptName" name="fDeptName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;
					<a href="#" onclick="queryCgApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCgApplyTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			<tr id="contract_ledger_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="contract_ledger_list_top_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销部门&nbsp;
					<input id="contract_ledger_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="querycontractLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearcontractLedger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="text-align: right; padding-right: 10px;">
					<a href="${base}/reimburse/export">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"/>
					</a>
				</td>
			</tr>
			<tr id="current_ledger_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;单据编号&nbsp;
					<input id="current_list_top_rCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;报销日期&nbsp;
					<input id="current_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[current_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="current_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[current_list_top_reqTime1]"/>
					&nbsp;&nbsp;审批状态&nbsp;
					<a href="#" onclick="current_query_ledger();">
						<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="current_clear_ledger();">
						<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
			    <li onclick="purchaseLedgerTopClick();">采购报销</li>
			    <li onclick="contractLedgerTopClick();">合同报销</li>
			    <li onclick="currentLedgerTopClick();">往来款报销</li>
			</ul>
				
			<div class="tab-content">
				<div style="height: 440px">
					<table id="directlyReimbLedgerTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=0',
					method:'post',fit:true,pagination:true,singleSelect: true,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'drId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'drCode',align:'center',resizable:false,sortable:true" style="width: 18%">报销单编号</th>
								<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 10%">报销类型</th>
								<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 16%">报销部门</th>
								<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">报销申请人</th>
								<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 14%">报销时间</th>
								<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
								<th data-options="field:'cashierType',align:'center',resizable:false,sortable:true,formatter:cashierTypeSet" style="width: 10%">付款状态</th>
								<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ1" style="width: 8%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div style="height: 440px">
					<table id="reimburseLedgerTab" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=${reimburseType}',
						method:'post',fit:true,pagination:true,singleSelect: true,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
							<thead>
								<tr>
									<th data-options="field:'rId',hidden:true"></th>
									<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
									<th data-options="field:'rCode',align:'center',resizable:false,sortable:true" style="width: 18%">报销单编号</th>
									<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 10%">报销类型</th>
									<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 15%">报销部门</th>
									<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">报销申请人</th>
									<th data-options="field:'reimburseReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">报销时间</th>
									<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
									<th data-options="field:'cashierType',align:'center',resizable:false,sortable:true,formatter:cashierTypeSet" style="width: 10%">付款状态</th>
									<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ2" style="width: 8%">操作</th>
								</tr>
							</thead>
						</table>
				</div>
				<div style="height: 440px">
					<table id="purchaseLedgerTab" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=10',
						method:'post',fit:true,pagination:true,singleSelect: true,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
							<thead>
								<tr>
									<th data-options="field:'fpId',hidden:true"></th>
									<th data-options="field:'number',align:'center'" style="width: 4%">序号</th>
									<th data-options="field:'fpCode',align:'center'" style="width: 14%">采购批次编号</th>
									<th data-options="field:'fpName',align:'center',resizable:false" style="width: 15%">采购名称</th>
									<th data-options="field:'fpAmount',align:'right',resizable:false,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">采购金额[元]</th>
									<th data-options="field:'payAmount',align:'right',resizable:false,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">付款金额[元]</th>
									<th data-options="field:'fDeptName',align:'center',resizable:false" style="width: 13%">申报部门</th>
									<th data-options="field:'fReqTime',align:'center',resizable:false,formatter: ChangeDateFormat" style="width: 9%">申报时间</th>
									<th data-options="field:'cashierType',align:'center',resizable:false,sortable:true,formatter:cashierTypeSet" style="width: 10%">付款状态</th>
									<th data-options="field:'zc',align:'left',resizable:false,sortable:true,formatter:CZ6" style="width: 15%">操作</th>
								</tr>
							</thead>
						</table>
				</div>
				<div style="height: 440px">
					<table id="contractreimburseLedgerTab" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/cashier/contractLegerPage?isLedger=1',
						method:'post',fit:true,pagination:true,singleSelect: true,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
							<thead>
								<tr>
									<th data-options="field:'fcId',hidden:true"></th>
									<th data-options="field:'payId',hidden:true"></th>
									<th data-options="field:'fPlanId',hidden:true"></th>
									<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
									<th data-options="field:'fcCode',align:'center',resizable:false" style="width: 15%">合同编号</th>
									<th data-options="field:'fcTitle',align:'center',resizable:false" style="width: 15%">合同名称</th>
									<th data-options="field:'fRecePlanAmount',align:'center',resizable:false,formatter:listToFixed" style="width: 15%">本次付款金额（元）</th>
									<th data-options="field:'fReceProperty',align:'center',resizable:false" style="width: 10%">付款性质</th>
									<th data-options="field:'deptName',align:'center',resizable:false" style="width: 10%">申请部门</th>
									<th data-options="field:'userName',align:'center',resizable:false" style="width: 10%">申请人</th>
									<th data-options="field:'payStauts',align:'center',resizable:false,formatter:cashierTypeSet" style="width: 10%">付款状态</th>
									<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ2" style="width: 8%">操作</th>
								</tr>
							</thead>
						</table>
				</div>
				<div style="height: 440px">
					<table id="current_ledger_dg" class="easyui-datagrid"
							data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=9',
							method:'post',fit:true,pagination:true,singleSelect: true,
							selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'gId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'gCode',align:'center',resizable:false" style="width: 25%">单据编号</th>
								<th data-options="field:'gName',align:'center',resizable:false" style="width: 25%">单据摘要</th>
								<th data-options="field:'amount',align:'center',resizable:false,formatter: BaoxiaochaoeLedger" style="width: 15%">报销金额(元)</th>
								<th data-options="field:'reimburseReqTime',align:'center',resizable:false,formatter: ChangeDateFormat" style="width: 11%">报销日期</th>
								<th data-options="field:'flowStauts',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
								<th data-options="field:'name',align:'center',resizable:false,formatter:CZ3" style="width: 10%">操作</th>
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
	   '<a href="#" onclick="detailContract(' + row.fcId + ',' + row.fPlanId + ','+row.payId+')" class="easyui-linkbutton">'+
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
	var win = creatWin(' ', 1070,580, 'icon-search', "/directlyReimburse/edit?id="+ id+"&editType="+type);
	win.window('open');
}
function editReimburse2(id,type,reimburseType) {
	/*type为修改或查看1位修改，0位查看  */
	var win = null;
	if(reimburseType=='1'){
		win = creatWin(' ', 800, 600, 'icon-search', "/reimburse/edit?id="+ id+"&editType="+type);
	}else {
		win = creatWin(' ', 1095, 580, 'icon-search', "/reimburse/edit?id="+ id+"&editType="+type);
	}
	win.window('open');
}
//跳转合同付款查看页面	
function detailContract(id,fPlanId,payId) {
	var win = creatFirstWin('查看', 1115, 580, 'icon-search', '/Enforcing/detailPay?id='+id+'&fPlanId='+fPlanId+'&payId='+payId+'&cashier=1');
	win.window('open');
}
function directlyLedgerTopClick(){
	$("#directlyReimbLedgerTab").datagrid('reload');
	$("#directly_ledger_top").show();
	$("#reimburse_ledger_top").hide();
	$("#current_ledger_top").hide();
	$("#contract_ledger_top").hide();
	$("#purchase_ledger_top").hide();
}
function reimburseLedgerTopClick(){
	$("#reimburseLedgerTab").datagrid('reload');
	$("#directly_ledger_top").hide();
	$("#contract_ledger_top").hide();
	$("#current_ledger_top").hide();
	$("#reimburse_ledger_top").show();
	$("#purchase_ledger_top").hide();
}
function contractLedgerTopClick(){
	$("#contractreimburseLedgerTab").datagrid('reload');
	$("#directly_ledger_top").hide();
	$("#reimburse_ledger_top").hide();
	$("#current_ledger_top").hide();
	$("#contract_ledger_top").show();
	$("#purchase_ledger_top").hide();
}
function currentLedgerTopClick(){
	$("#current_ledger_dg").datagrid('reload');
	$("#directly_ledger_top").hide();
	$("#reimburse_ledger_top").hide();
	$("#contract_ledger_top").hide();
	$("#current_ledger_top").show();
	$("#purchase_ledger_top").hide();
}
function purchaseLedgerTopClick(){
	$("#purchaseLedgerTab").datagrid('reload');
	$("#directly_ledger_top").hide();
	$("#reimburse_ledger_top").hide();
	$("#contract_ledger_top").hide();
	$("#current_ledger_top").hide();
	$("#purchase_ledger_top").show();
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
//申请报销查询
function querycontractLedger() {
	var rCode="contract_ledger_list_top_code";
	var deptName="contract_ledger_list_top_deptName";
	
	
	$("#contractreimburseLedgerTab").datagrid('load',{
		rCode:$("#"+rCode).textbox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//申请报销清除查询条件
function clearcontractLedger() {
	var rCode="contract_ledger_list_top_code";
	var deptName="contract_ledger_list_top_deptName";
	
	$("#"+rCode).textbox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#contractreimburseLedgerTab").datagrid('load',{});
}

//导出 
function reimburseLedgerDochu() {
	var url=base+"/reimburse/export";
	
	
	
}
function cashierTypeSet(val, row) {
	if (val == 0||val == ''||val == null) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;'
				+ "未付讫" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;'
				+ "已付讫" + '</a>';
	}
}

function current_query_ledger() {
	
	$("#current_ledger_dg").datagrid('load',{
		gCode:$("#current_list_top_rCode").textbox('getValue').trim(),
		reimburseReqTime1:$("#current_list_top_reqTime1").datebox('getValue').trim(),
		reimburseReqTime2:$("#current_list_top_reqTime2").datebox('getValue').trim(),
	});
}

//清除查询条件
function current_clear_ledger() {
	$('#current_list_top_rCode').textbox('setValue',null);
	$('#current_list_top_reqTime1').datebox('setValue',null);
	$('#current_list_top_reqTime2').datebox('setValue',null);
	current_query_ledger();
}

function BaoxiaochaoeLedger(val, row){
	
	var a = row.amount;
	if(val>a){
		return '<span style="color:red">'+fomatMoney(val,2)+"【报销超额】"+'</span>';
	}else{
		return fomatMoney(val,2);
	}
}

//操作栏创建
function CZ3(val, row) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="detailCurrentLedger(' + row.rId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
}
//操作栏创建
function CZ6(val, row) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="detailPurchase(' + row.rId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
}
//查看
function detailCurrentLedger(id){
	win = creatWin('查看', 1115, 600, 'icon-search', '/reimburse/detailCurrent?id='+id+'&editType=1');
	win.window('open');
}
//跳转采购查看页面
function detailPurchase(id) {
	var win = creatWin('查看', 1115, 580, 'icon-search', '/cgsqsp/editReimb?id='+ id +'&editType=0');
	win.window('open');
}
//点击查询
function queryCgApply() {
	$('#purchaseLedgerTab').datagrid('load', {
		fpCode:$('#cgbx_fpCode').val(),
		fpName:$('#cgbx_fpName').val(),
		fDeptName:$('#cgbx_fDeptName').val(),
	});
}
//清除查询条件
function clearCgApplyTable() {
	$("#cgbx_fpCode").textbox('setValue','');
	$("#cgbx_fpName").textbox('setValue','');
	$("#cgbx_fDeptName").textbox('setValue','');
	$('#purchaseLedgerTab').datagrid('load',{//清空以后，重新查一次
	});
}
</script>
</body>
</html>


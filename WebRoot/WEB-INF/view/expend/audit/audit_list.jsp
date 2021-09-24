<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body >
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr id="directly_audit_top">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="directly_audit_list_top_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销部门&nbsp;
					<input id="directly_audit_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销时间&nbsp;
					<input id="directly_audit_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[directly_audit_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="directly_audit_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[directly_audit_list_top_reqTime1]"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryDirectlyAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearDirectlyAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
			<tr id="reimburse_audit_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="reimburse_audit_list_top_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销部门&nbsp;
					<input id="reimburse_audit_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销时间&nbsp;
					<input id="reimburse_audit_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[reimburse_audit_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="reimburse_audit_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[reimburse_audit_list_top_reqTime1]"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryReimburseAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearReimburseAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
			
			<tr id="purchase_audit_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;采购批次编号&nbsp;
					<input id="purchase_audit_list_top_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;采购金额&nbsp;
					<input id="purchase_audit_list_top_fpAmount1" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					&nbsp;-&nbsp;
					<input id="purchase_audit_list_top_fpAmount2" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					
					&nbsp;&nbsp;采购方式&nbsp;
					<input id="purchase_audit_list_top_fpMethodStr" class="easyui-combobox" style="width: 150px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=PURCHASE_METHOD',method:'get',valueField:'code',textField:'text',editable:false" />
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryPurchaseAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearPurchaseAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
			<tr id="contract_enforcing_audit_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;合同编号&nbsp;
					<input id="contract_enforcing_audit_list_top_fcCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;合同名称&nbsp;
					<input id="contract_enforcing_audit_list_top_fcTitle" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryContractEnforcingAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearContractEnforcingAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
			<tr id="capital_audit_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;借款单编号&nbsp;
					<input id="capital_audit_list_top_lCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;借款金额&nbsp;
					<input id="capital_audit_list_top_lAmount1" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					&nbsp;-&nbsp;
					<input id="capital_audit_list_top_lAmount2" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					&nbsp;&nbsp;所属部门&nbsp;
					<input id="capital_audit_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryCapitalAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearCapitalAudit();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
		</table>
	</div>
	<div class="list-table-tab">
		<div class="tab-wrapper" id="audit-tab">
			<ul class="tab-menu">
				<li class="active" onclick="directlyAuditTopClick();">直接报销</li>
			    <li onclick="reimburseAuditTopClick();">申请报销</li>
			    <li onclick="purchaseAuditTopClick();">采购支付</li>
			    <li onclick="contractAuditTopClick();">合同报销</li>
			    <li onclick="capitalAuditTopClick();">资金归垫</li>
			</ul>
			
			<div class="tab-content">
				<div style="height: 440px">
					<table id="directlyReimbAuditTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/audit/reimbursePage?reimburseType=0',
					method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'drId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'drCode',align:'left',resizable:false,sortable:true" style="width: 15%">报销单编号</th>
								<th data-options="field:'type',align:'left',formatter:typeSet" style="width: 13%">报销类型</th>
								<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 13%">报销部门</th>
								<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 13%">报销请人</th>
								<th data-options="field:'reqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 13%">报销时间</th>
								<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 13%">审批状态</th>
								<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ1" style="width: 15%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div style="height: 440px">
					<table id="reimburseAuditTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/audit/reimbursePage?reimburseType=1',
					method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'rId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'rCode',align:'left',resizable:false,sortable:true" style="width: 15%">报销单编号</th>
								<th data-options="field:'type',align:'left',formatter:typeSet" style="width: 13%">报销类型</th>
								<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 13%">报销部门</th>
								<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 13%">报销请人</th>
								<th data-options="field:'reimburseReqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 13%">报销时间</th>
								<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 13%">审批状态</th>
								<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ2" style="width: 15%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				<div style="height: 440px">
					<table id="purchaseAuditTab" class="easyui-datagrid" 
					data-options="collapsible:true,url:'${base}/audit/purchasePage',
					method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'fpId',hidden:true"></th>
								<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'fpCode',align:'left'" style="width: 15%">采购批次编号</th>
								<th data-options="field:'fpAmount',align:'left',resizable:false,sortable:true" style="width: 10%">采购金额（万元）</th>
								<th data-options="field:'fDeptName',align:'left',resizable:false,sortable:true" style="width: 10%">申报部门</th>
								<th data-options="field:'fReqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">申报时间</th>
								<th data-options="field:'fUserName',align:'left',resizable:false,sortable:true" style="width: 10%">申请人</th>
								<!-- <th data-options="field:'fpMethod',align:'left',resizable:false,sortable:true" style="width: 8%">采购方式</th> -->
								<th data-options="field:'fCheckStauts',align:'left',resizable:false,sortable:true,formatter:formatPrice" style="width: 10%">审批状态</th>
								<th data-options="field:'fIsReceive',align:'left',resizable:false,sortable:true,formatter:formatRecive" style="width: 10%">验收状态</th>
								<th data-options="field:'fpayStauts',align:'left',resizable:false,sortable:true,formatter:formatPay" style="width: 10%">付款审批状态</th>
								<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ3" style="width: 10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				<div style="height: 440px">
					<table id="contractAuditTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/audit/contractPage',
					method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'fcId',hidden:true"></th>
								<th data-options="field:'payId',hidden:true"></th>
								<th data-options="field:'fPlanId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'fcCode',align:'left',resizable:false,sortable:true" style="width: 15%">合同编号</th>
								<th data-options="field:'fcTitle',align:'left',resizable:false,sortable:true" style="width: 13%">合同名称</th>
								<th data-options="field:'fReceProperty',align:'left',resizable:false,sortable:true,formatter: paytype" style="width: 13%">付款名称</th>
								<th data-options="field:'fRecePlanTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 13%">计划付款时间</th>
								<th data-options="field:'fRecePlanAmount',align:'left',resizable:false,sortable:true" style="width: 13%">计划付款金额</th>
								<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 13%">审批状态</th>
								<th data-options="field:'cz',align:'left',resizable:false,sortable:true,formatter:CZ4" style="width: 15%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div style="height: 440px">
					<table id="capitalAuditTab" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/srcapital/srcapitalPage?type=1',
					method:'post',fit:true,pagination:true,singleSelect: true,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'lId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'lCode',align:'left',resizable:false,sortable:true" style="width: 12%">借款单编号</th>
								<th data-options="field:'lAmount',align:'left',resizable:false,sortable:true" style="width: 10%">借款金额[元]</th>
								<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 12%">借款人</th>
								<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 12%">所属部门</th>
								<th data-options="field:'reqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 12%">申请时间</th>
								<th data-options="field:'estChargeTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 12%">预计冲账时间</th>
								<th data-options="field:'frepayStatus',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">还款状态</th>
								<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:capitalAuditCZ" style="width: 15%">操作</th>
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
flashtab('audit-tab');

//合同付款名称（什么阶段的款）
function paytype(val, row) {
	if (val == "FKXZ-01") {
		return '<span >' + "首款" + '</span>';
	} else if (val == "FKXZ-02") {
		return '<span >' + "阶段款" + '</span>';
	}else if (val == "FKXZ-03") {
		return '<span >' + "验收款" + '</span>';
	}else if (val == "FKXZ-04") {
		return '<span >' + "质保款" + '</span>';
	}
}

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
function flowStautsSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审定" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审定" + '</a>';
	}
}

//设置采购审批状态
function formatPrice(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	}
}
//设置付款申请状态
function formatPay(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	}
}
//设置验收状态
function formatRecive(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未验收" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已验收" + '</a>';
	}
}

//操作栏创建
function CZ1(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="auditReimburse(' + row.drId + ',0)" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td></tr></table>';
}
function CZ2(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="auditReimburse(' + row.rId + ',1)" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td></tr></table>';
}
//操作栏创建
function CZ3(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="auditPurchase(' + row.fpId + ')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td></tr></table>';
}
function CZ4(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="auditContract(' + row.fcId + ',' + row.fPlanId + ','+row.payId+')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td></tr></table>';
}

//跳转报销审批页面
function auditReimburse(id,reimburseType) {
	//0为直接报销1位申请报销2位采购支付3位合同支付
	var win = creatWin('报销审定', 1075, 580, 'icon-search', '/audit/auditReimburse?id='+id+'&reimburseType='+reimburseType+'&cashier=0');
	win.window('open');
}
//跳转采购审批页面
function auditPurchase(id) {
	var win = creatWin('报销审定', 1075, 580, 'icon-search', '/audit/auditPurchase?id='+ id+'&cashier=0');
	win.window('open');
}
//跳转合同付款审批页面	
function auditContract(id,fPlanId,payId) {
	var win = creatWin('报销审定', 1075, 580, 'icon-search', '/audit/auditContract?id='+id+'&fPlanId='+fPlanId+'&payId='+payId+'&cashier=0');
	win.window('open');
}

//资金归垫操作
function capitalAuditCZ(val, row) {
	return 	'<table><tr style="width: 75px;height:20px">'+
	'<td style="width: 25px">'+
	'<a href="#" onclick="cwVerdict(' + row.lId + ')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td></tr></table>';
}

function cwVerdict(id){
	var win = creatWin('财务审定', 765, 580, 'icon-search',"/audit/cwVerdict?id=" + id);
	win.window('open');
}

function directlyAuditTopClick(){
	$("#directlyReimbAuditTab").datagrid('reload');
	
	$("#directly_audit_top").show();
	$("#reimburse_audit_top").hide();
	$("#purchase_audit_top").hide();
	$("#contract_enforcing_audit_top").hide();
	$("#capital_audit_top").hide();
}
function reimburseAuditTopClick(){
	$("#reimburseAuditTab").datagrid('reload');
	
	$("#directly_audit_top").hide();
	$("#reimburse_audit_top").show();
	$("#purchase_audit_top").hide();
	$("#contract_enforcing_audit_top").hide();
	$("#capital_audit_top").hide();
}
function purchaseAuditTopClick(){
	$("#purchaseAuditTab").datagrid('reload');
	
	$("#directly_audit_top").hide();
	$("#reimburse_audit_top").hide();
	$("#purchase_audit_top").show();
	$("#contract_enforcing_audit_top").hide();
	$("#capital_audit_top").hide();
}
function contractAuditTopClick(){
	$("#contractAuditTab").datagrid('reload');
	
	$("#directly_audit_top").hide();
	$("#reimburse_audit_top").hide();
	$("#purchase_audit_top").hide();
	$("#contract_enforcing_audit_top").show();
	$("#capital_audit_top").hide();
}
function capitalAuditTopClick(){
	$("#capitalAuditTab").datagrid('reload');
	
	$("#directly_audit_top").hide();
	$("#reimburse_audit_top").hide();
	$("#purchase_audit_top").hide();
	$("#contract_enforcing_audit_top").hide();
	$("#capital_audit_top").show();
}

//直接报销查询
function queryDirectlyAudit() {
	var drCode="directly_audit_list_top_code";
	var deptName="directly_audit_list_top_deptName";
	var reqTime1="directly_audit_list_top_reqTime1";
	var reqTime2="directly_audit_list_top_reqTime2";
	
	
	$("#directlyReimbAuditTab").datagrid('load',{
		drCode:$("#"+drCode).textbox('getValue').trim(),
		reqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reqTime2:$("#"+reqTime2).datebox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//直接报销清除查询条件
function clearDirectlyAudit() {
	var drCode="directly_audit_list_top_code";
	var deptName="directly_audit_list_top_deptName";
	var reqTime1="directly_audit_list_top_reqTime1";
	var reqTime2="directly_audit_list_top_reqTime2";
	
	$("#"+drCode).textbox('setValue','');
	$("#"+reqTime1).datebox('setValue','');
	$("#"+reqTime2).datebox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#directlyReimbAuditTab").datagrid('load',{});
}

//申请报销查询
function queryReimburseAudit() {
	var rCode="reimburse_audit_list_top_code";
	var deptName="reimburse_audit_list_top_deptName";
	var reqTime1="reimburse_audit_list_top_reqTime1";
	var reqTime2="reimburse_audit_list_top_reqTime2";
	
	
	$("#reimburseAuditTab").datagrid('load',{
		rCode:$("#"+rCode).textbox('getValue').trim(),
		reimburseReqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reimburseReqTime2:$("#"+reqTime2).datebox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//申请报销清除查询条件
function clearReimburseAudit() {
	var rCode="reimburse_audit_list_top_code";
	var deptName="reimburse_audit_list_top_deptName";
	var reqTime1="reimburse_audit_list_top_reqTime1";
	var reqTime2="reimburse_audit_list_top_reqTime2";
	
	$("#"+rCode).textbox('setValue','');
	$("#"+reqTime1).datebox('setValue','');
	$("#"+reqTime2).datebox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#reimburseAuditTab").datagrid('load',{});
}

//采购支付查询
function queryPurchaseAudit() {
	var fpCode="purchase_audit_list_top_code";
	var fpAmount1="purchase_audit_list_top_fpAmount1";
	var fpAmount2="purchase_audit_list_top_fpAmount2";
	var fpMethodStr="purchase_audit_list_top_fpMethodStr";
	
	
	$("#purchaseAuditTab").datagrid('load',{
		fpCode:$("#"+fpCode).textbox('getValue').trim(),
		fpAmount1:$("#"+fpAmount1).numberbox('getValue').trim(),
		fpAmount2:$("#"+fpAmount2).numberbox('getValue').trim(),
		fpMethodStr:$("#"+fpMethodStr).textbox('getValue').trim(),
	});
}
//采购支付清除查询条件
function clearPurchaseAudit() {
	var fpCode="purchase_audit_list_top_code";
	var fpAmount1="purchase_audit_list_top_fpAmount1";
	var fpAmount2="purchase_audit_list_top_fpAmount2";
	var fpMethodStr="purchase_audit_list_top_fpMethodStr";
	
	$("#"+fpCode).textbox('setValue','');
	$("#"+fpAmount1).numberbox('setValue','');
	$("#"+fpAmount2).numberbox('setValue','');
	$("#"+fpMethodStr).textbox('setValue','');
	
	$("#purchaseAuditTab").datagrid('load',{});
}

//合同报销查询
function queryContractEnforcingAudit() {
	var fcCode="contract_enforcing_audit_list_top_fcCode";
	var fcTitle="contract_enforcing_audit_list_top_fcTitle";
	
	$("#contractAuditTab").datagrid('load',{
		fcCode:$("#"+fcCode).textbox('getValue').trim(),
		fcTitle:$("#"+fcTitle).textbox('getValue').trim(),
	});
}

//合同报销清除查询条件
function clearContractEnforcingAudit() {
	var fcCode="contract_enforcing_audit_list_top_fcCode";
	var fcTitle="contract_enforcing_audit_list_top_fcTitle";
	
	$("#"+fcCode).textbox('setValue');
	$("#"+fcTitle).textbox('setValue');
	
	$("#contractAuditTab").datagrid('load',{});
}

//资金归垫
function queryCapitalAudit() {
	var lCode="capital_audit_list_top_lCode";
	var lAmount1="capital_audit_list_top_lAmount1";
	var lAmount2="capital_audit_list_top_lAmount2";
	var deptName="capital_audit_list_top_deptName";
	
	
	$("#capitalAuditTab").datagrid('load',{
		lCode:$("#"+lCode).textbox('getValue').trim(),
		lAmount1:$("#"+lAmount1).numberbox('getValue').trim(),
		lAmount2:$("#"+lAmount2).numberbox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}

//资金归垫清除查询条件
function clearCapitalAudit() {
	var lCode="capital_audit_list_top_lCode";
	var lAmount1="capital_audit_list_top_lAmount1";
	var lAmount2="capital_audit_list_top_lAmount2";
	var deptName="capital_audit_list_top_deptName";
	
	$("#"+lCode).textbox('setValue','');
	$("#"+lAmount1).numberbox('setValue','');
	$("#"+lAmount2).numberbox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#capitalAuditTab").datagrid('load',{});
}


$("#directly_audit_list_top_reqTime1").datebox({
    onSelect : function(beginDate){
        $('#directly_audit_list_top_reqTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

$("#reimburse_audit_list_top_reqTime1").datebox({
    onSelect : function(beginDate){
        $('#reimburse_audit_list_top_reqTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
</script>
</body>
</html>


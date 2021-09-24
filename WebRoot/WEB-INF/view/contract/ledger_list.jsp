<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body >
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr id="contract_top">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;合同编号&nbsp;
					<input id="contract_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;合同名称&nbsp;
					<input id="contract_name" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;
					<a href="#" onclick="queryContract();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearContract();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="exportContract(0)">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			<%-- <tr id="UpdateOrending_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;变更合同编号&nbsp;
					<input id="UpdateOrending_code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;变更合同名称&nbsp;
					<input id="UpdateOrending_name" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;合同编号&nbsp;
					<input id="contract_code_upt" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;合同名称&nbsp;
					<input id="contract_name_upt" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;
					<a href="#" onclick="queryUpdateOrending();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearUpdateOrending();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="exportUpt(1)">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr> --%>
		</table>   
	</div>
	<div class="list-table-tab">
		<div class="tab-wrapper" id="contract-ledger-tab">
			<ul class="tab-menu">
				<li class="active" onclick="contractClick();">合同信息</li>
			   <!--  <li onclick="updateOrendingClick();">变更合同</li> -->
			</ul>
			<div class="tab-content">
				<div style="height: 440px">
					<table id="contractTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/Ledger/JsonPagination',pageSize:500,
					method:'post',fit:true,pagination:true,singleSelect: false,selectOnCheck: true,
					checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fcId',hidden:true"></th>
								<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
								<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="20%">合同编号</th>
								<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="15%">合同名称</th>
								<th data-options="field:'fReqtIME',align:'center',formatter:ChangeDateFormat,resizable:false,sortable:true" width="10%" >合同签订日期</th>
								<th data-options="field:'fcTypeName',align:'center',resizable:false,sortable:true" width="15%">合同类型</th>
								<th data-options="field:'fContStartTime',align:'center',formatter:ChangeDateFormat,resizable:false,sortable:true" width="10%" >合同开始时间</th>
								<th data-options="field:'fContEndTime',align:'center',formatter:ChangeDateFormat,resizable:false,sortable:true" width="10%" >合同结束时间</th>
								<th data-options="field:'fcAmount',align:'center',resizable:false,sortable:true,formatter:htflOrNot" width="10%">合同金额(元)</th>
								<th data-options="field:'fAllAmount',align:'center',resizable:false,sortable:true,formatter:updateOrNot" width="10%">收/付款金额(元)</th>
								<th data-options="field:'percentage',align:'center',resizable:false,sortable:true,formatter:updateOrNot" width="10%">执行率（%）</th>
								<th data-options="field:'fContractor',align:'center',resizable:false,sortable:true" width="15%">签约方名称</th>
								<th data-options="field:'fUpdateStatus',align:'center',resizable:false,sortable:true,formatter:htUpdateSts" width="10%">变更状态</th>
								<!-- <th data-options="field:'fDisputeStatus',align:'center',resizable:false,sortable:true,formatter:htDisputeSts" width="10%">纠纷状态</th> -->
								<th data-options="field:'fgdStauts',align:'center',resizable:false,sortable:true,formatter:archiving1" width="10%">是否归档</th>
								<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
								<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
								<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZRaw" width="8%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				<%-- <div style="height: 440px">
					<table id="updateOrendingTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/Ledger/ChangeJsonPagination',pageSize:500,
					method:'post',fit:true,pagination:true,singleSelect: false,selectOnCheck: true,
					checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fId_U',hidden:true"></th>
								<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
								<th data-options="field:'fUptCode',align:'center',resizable:false,sortable:true" width="20%">变更合同编号</th>
								<th data-options="field:'fContName',align:'center',resizable:false,sortable:true" width="12%">变更合同名称</th>
								<th data-options="field:'fContCodeOld',align:'center',resizable:false,sortable:true" width="20%">原合同编号</th>
								<th data-options="field:'fContNameOld',align:'center',resizable:false,sortable:true" width="15%">原合同名称</th>
								<th data-options="field:'fReqTime',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="10%" >签订日期</th>
								<th data-options="field:'fContUptType',align:'center',resizable:false,sortable:true,formatter: ChangeUptType" width="15%">合同类型</th>
								<th data-options="field:'fAmount',align:'center',resizable:false,sortable:true,formatter:bghtflOrNot" width="10%">合同金额(元)</th>
								<th data-options="field:'fAllAmount',align:'center',resizable:false,sortable:true,formatter:bghtflOrNot" width="10%">收/付款金额(元)</th>
								<th data-options="field:'percentage',align:'center',resizable:false,sortable:true,formatter:bghtflOrNot" width="10%">执行率（%）</th>
								<th data-options="field:'fContractor',align:'center',resizable:false,sortable:true" width="15%">签约方名称</th>
								<th data-options="field:'fgdstatus',align:'center',resizable:false,sortable:true,formatter:archiving2" width="10%">是否归档</th>
								<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
								<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
								<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZChange" width="8%">操作</th>
							</tr>
						</thead>
					</table>
				</div> --%>
			</div>
		</div>
	</div>
</div>
<form id="form_contract_export" method="post" enctype="multipart/form-data">
	<input id="form_contract_export_fCIds" type="hidden" name="fCIds">
	<input id="form_contract_export_fcCode" type="hidden" name="fcCode">
	<input id="form_contract_export_fcTitle" type="hidden" name="fcTitle">
	<input id="form_contract_export_type" type="hidden" name="type">
</form>
<form id="form_upt_export" method="post" enctype="multipart/form-data">
	<input id="form_upt_export_fId_Us" type="hidden" name="fId_Us">
	<input id="form_upt_export_fcCode" type="hidden" name="fUptCode">
	<input id="form_upt_export_fcTitle" type="hidden" name="fContName">
	<input id="form_upt_contract_export_fcCode" type="hidden" name="fContCodeOld">
	<input id="form_upt_contract_export_fcTitle" type="hidden" name="fContNameOld">
	<input id="form_upt_contract_export_type" type="hidden" name="type">
</form>
<script type="text/javascript">
//加载tab页
flashtab('contract-ledger-tab');

function cashierTypeSet(val, row) {
	if (val == "0"||val == null) {
		return '<span >' + "未付款" + '</span>';
	}else if (val == "1") {
		return '<span >' + "已付款" + '</span>';
	}
}
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
//操作栏创建
function CZRaw(val, row) {
	if(row.fcType =='HTFL-01'){
		return	 '<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="ledger_detail(' + row.fcId + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td><td style="width: 25px">'
		+'<a href="#" onclick="detailCG(' + row.fPurchNo
		+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/cg1.png">'
		+'</a>'+ '</td></tr></table>'; 
		/* <td style="width: 25px">'
		+'<a href="#" onclick="detailZC(' + row.fcId
		+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/zcjl1.png">'
		+'</a></td> */
	}else{
		return	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="ledger_detail(' + row.fcId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a></td></tr></table>';
	}
}
//操作栏创建
function CZChange(val, row) {
	return	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="ledger_detailUpt(' + row.fId_U + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a></td></tr></table>';
}

//跳转查看采购页面
function detailCG(id) {
	var win = creatWin('采购明细', 850, 550, 'icon-search', "/cgsqsp/ledgerdetail?id="+ id);
	win.window('open');
}

//设置审批状态
function flowStautsSet(val, row) {
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

/** 查看操作 **/

//跳转报销查看页面
function detailReimburse(id,reimburseType) {
	//0为直接报销1位申请报销2位采购支付3位合同支付
	var win = creatWin('出纳受理', 970, 580, 'icon-search', '/directlyReimburse/edit?id='+id+'&editType=0');
	win.window('open');
}
function detailReimburseOpen(id,reimburseType) {
	//0为直接报销1位申请报销2位采购支付3位合同支付
	var win = creatWin('出纳受理', 1070, 580, 'icon-search', '/directlyReimburse/edit?id='+id+'&editType=0');
	win.window('open');
}
//跳转申请报销查看页面
function detail(id,reimburseType) {
	
	if(reimburseType==1){
	var win = creatWin('出纳受理', 770, 580, 'icon-search', '/reimburse/edit?id='+id+'&editType=0');
	win.window('open');
	}else{
		var win = creatWin('出纳受理',1060, 580, 'icon-search', '/reimburse/edit?id='+id+'&editType=0');
		win.window('open');
	}
}
//跳转合同付款查看页面	
function detailContract(id,fPlanId,payId) {
	var win = creatWin('出纳受理', 970, 580, 'icon-search', '/Enforcing/detail?id='+id+'&fPlanId='+fPlanId+'&payId='+payId+'&cashier=1');
	win.window('open');
}

function contractClick(){
	$("#contractTab").datagrid('reload');
	$("#contract_top").show();
	$("#UpdateOrending_top").hide();
}
function updateOrendingClick(){
	$("#updateOrendingTab").datagrid('reload');
	$("#contract_top").hide();
	$("#UpdateOrending_top").show();
}
//直接报销查询
function queryContract() {
	var fcCode="contract_code";
	var deptName="contract_name";
	$("#contractTab").datagrid('load',{
		fcCode:$("#"+fcCode).textbox('getValue').trim(),
		fcTitle:$("#"+deptName).textbox('getValue').trim(),
	});
}
//直接报销清除查询条件
function clearContract() {
	var fcCode="contract_code";
	var fcTitle="contract_name";
	$("#"+fcCode).textbox('setValue','');
	$("#"+fcTitle).textbox('setValue','');
	$("#contractTab").datagrid('load',{});
}

//申请报销查询
function queryUpdateOrending() {
	var rCode="UpdateOrending_code";
	var fcTitle="UpdateOrending_name";
	var yCode="contract_code_upt";
	var yTitle="contract_name_upt";
	$("#updateOrendingTab").datagrid('load',{
		fUptCode:$("#"+rCode).textbox('getValue').trim(),
		fContName:$("#"+fcTitle).textbox('getValue').trim(),
		fContCodeOld:$("#"+yCode).textbox('getValue').trim(),
		fContNameOld:$("#"+yTitle).textbox('getValue').trim(),
	});
}
//申请报销清除查询条件
function clearUpdateOrending() {
	var rCode="UpdateOrending_code";
	var fcTitle="UpdateOrending_name";
	var yCode="contract_code_upt";
	var yTitle="contract_name_upt";
	$("#"+rCode).textbox('setValue','');
	$("#"+fcTitle).textbox('setValue','');
	$("#"+yCode).textbox('setValue','');
	$("#"+yTitle).textbox('setValue','');
	$("#updateOrendingTab").datagrid('load',{});
}
//是否归档
function archiving1(val, row) {
	if (row.fgdStauts == 1) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已归档" + '</span>';
	} else {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未归档" + '</span>';
	}
}
function archiving2(val, row) {
	if (val == '0' || val=='' || val==undefined) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未归档" + '</span>';
	} else if (val == '1') {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已归档" + '</span>';
	}
}

//台账查看
function ledger_detail(id) {
	var win = creatWin('查看', 790, 580, 'icon-search', '/Ledger/detailContract/'+id+'?type=0');
	win.window('open');
}
//台账查看
function ledger_detailUpt(id) {
	var win = creatWin('查看', 790, 580, 'icon-search', '/Ledger/detailUpt/'+id+'?type=1');
	win.window('open');
}

//合同台账导出
function exportContract(type){
	if(confirm('是否导出？')){
		var fCIds = "";
		var rows2 = $('#contractTab').datagrid('getSelections');
		if(rows2.length==0){
			alert('请选择要导出数据！');
			return false;
		}else{
			for (var i = 0; i < rows2.length; i++) {
				fCIds += rows2[i].fcId +",";
			}
			fCIds = fCIds.substring(0, fCIds.length-1);
			$('#form_contract_export_fCIds').val(fCIds);
			$('#form_contract_export_type').val(0);
			$('#form_contract_export').attr('action','${base}/Ledger/export');
			$('#form_contract_export').submit();
		}
	}
}
//变更合同台账导出
function exportUpt(type){
	if(confirm('是否导出？')){
		var fId_Us = "";
		var rows2 = $('#updateOrendingTab').datagrid('getSelections');
		if(rows2.length==0){
			alert('请选择要导出数据！');
			return false;
		}else{
			for (var i = 0; i < rows2.length; i++) {
				fId_Us += rows2[i].fId_U +",";
			}
			fId_Us = fId_Us.substring(0, fId_Us.length-1);
			$('#form_upt_export_fId_Us').val(fId_Us);
			$('#form_upt_contract_export_type').val(1);
			$('#form_upt_export').attr('action','${base}/Ledger/export');
			$('#form_upt_export').submit();
		}
	}
}
function htUpdateSts(val, row){
	if (val == '0' || val=='' || val==undefined) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未变更" + '</span>';
	} else if (val == '1') {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已变更" + '</span>';
	} else if (val == '2') {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 变更中" + '</span>';
	}
}
function htDisputeSts(val, row){
	if (val == '0' || val=='' || val==undefined) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 无纠纷" + '</span>';
	} else if (val == '1') {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 有纠纷" + '</span>';
	}
}
function ChangeUptType(val, row){
	if (val == 'HTFL-01'){
		return '采购类合同';
	} else if (val == 'HTFL-02'){
		return '收入类合同';
	}else if (val == 'HTFL-03'){
		return '非经济类合同';
	}
}
//判断是否变更 变更不显示金额
function updateOrNot(val,row){
	if(row.fUpdateStatus == '1'){
		return "-";
	}else{
		return fomatMoney(val,2);
	}
}
//判断原合同是否为非经济类合同 非经济类不显示金额
function htflOrNot(val,row){
	if(row.fcTypeName == '非经济类合同'){
		return "-";
	}else{
		return fomatMoney(val,2);
	}
}
//判断变更合同是否为非经济类合同 非经济类不显示金额
function bghtflOrNot(val,row){
	if(row.fContUptType == 'HTFL-03'){
		return "-";
	}else{
		return fomatMoney(val,2);
	}
}
</script>
</body>
</html>


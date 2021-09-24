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
					<input id="contract_code_Seal" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;合同名称&nbsp;
					<input id="contract_name_Seal" style="width: 150px;height:25px;" class="easyui-textbox"/>
					<!-- 
					&nbsp;&nbsp;报销时间&nbsp;
					<input id="directly_cashier_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[directly_cashier_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="directly_cashier_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[directly_cashier_list_top_reqTime1]"/>
					 -->
					&nbsp;&nbsp;
					<a href="#" onclick="queryContractSeal();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearContractSeal();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			<tr id="UpdateOrending_top" style="display: none;">
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;合同编号&nbsp;
					<input id="UpdateOrending_code_Seal" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;合同名称&nbsp;
					<input id="UpdateOrending_name_Seal" style="width: 150px;height:25px;" class="easyui-textbox"/>
					<!-- 
					&nbsp;&nbsp;报销时间&nbsp;
					<input id="reimburse_cashier_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[reimburse_cashier_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="reimburse_cashier_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[reimburse_cashier_list_top_reqTime1]"/>
					 -->
					&nbsp;&nbsp;
					<a href="#" onclick="queryUpdateOrendingSeal();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearUpdateOrendingSeal();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>
	<div class="list-table-tab">
		<div class="tab-wrapper" id="contract-ledger-tab">
			<ul class="tab-menu">
				<li class="active" onclick="contractClickSeal();">原合同</li>
			    <li onclick="updateOrendingClickSeal();">变更合同</li>
			</ul>
			<div class="tab-content">
				<div style="height: 440px">
					<table id="contractTabSeal" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/sealInfo/JsonPagination',method:'post',
					method:'post',fit:true,pagination:true,singleSelect: true,selectOnCheck: true,
					checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fcId',hidden:true"></th>
								<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
								<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="25%">合同编号</th>
								<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="25%">合同名称</th>
								<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
								<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
								<th data-options="field:'fReqtIME',align:'center',formatter:ChangeDateFormat,resizable:false,sortable:true" width="10%" >申请时间</th>
								<th data-options="field:'fsealedStatus',align:'center',resizable:false,sortable:true,formatter:returnfsealedStatus" width="10%">印章状态</th>
								<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ1" width="5%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				<div style="height: 440px">
					<table id="updateOrendingTabSeal" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/sealInfo/ChangeJsonPagination',
					method:'post',fit:true,pagination:true,singleSelect: true,selectOnCheck: true,
					checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fId_U',hidden:true"></th>
								<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
								<th data-options="field:'fUptCode',align:'center',resizable:false,sortable:true" width="15%">变更合同编号</th>
								<th data-options="field:'fContCodeOld',align:'center',resizable:false,sortable:true" width="15%">原合同编号</th>
								<th data-options="field:'fContNameOld',align:'center',resizable:false,sortable:true" width="15%">原合同名称</th>
								<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
								<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
								<th data-options="field:'fReqTime',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="10%" >申请时间</th>
								<th data-options="field:'fsealedStatus',align:'center',resizable:false,sortable:true,formatter:returnfsealedStatus" width="10%">印章状态</th>
								<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ2" width="5%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="form_contract_export" method="post" enctype="multipart/form-data">
	<input type="hidden" name="sbkLx" value="xmtz">
	<input id="form_contract_export_fcCode" type="hidden" name="fcCode">
	<input id="form_contract_export_fcTitle" type="hidden" name="fcTitle">
</form>
<script type="text/javascript">
//加载tab页
flashtab('contract-ledger-tab');

//操作栏创建
function CZ1(val, row) {
	if(row.fsealedStatus==0||row.fsealedStatus==null||row.fsealedStatus==''){
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="detail(' + row.fcId + ',0)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>'+
		'<td style="width: 25px">'+
		'<a href="#" onclick="seal(' + row.fcId + ',0)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yy1.png">'+
		'</a></td>'+
		'</tr></table>';
	}else {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="detail(' + row.fcId + ',0)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td></tr></table>';
	}
}
function CZ2(val, row) {
	if(row.fsealedStatus==0||row.fsealedStatus==''||row.fsealedStatus==null){
		return 	'<table><tr style="width: 75px;height:20px">'+
		'<td style="width: 25px">'+
		'<a href="#" onclick="detail(' + row.fId_U + ',1)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>'+
		'<td style="width: 25px">'+
		'<a href="#" onclick="seal(' + row.fId_U + ',1)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yy1.png">'+
		'</a></td>'+
		'</tr></table>';
	}else if(row.fsealedStatus==1){
		return 	'<table><tr style="width: 75px;height:20px">'+
		'<td style="width: 25px">'+
		'<a href="#" onclick="detail(' + row.fId_U + ',1)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>'+
		'</tr></table>';
	}
}

//跳转合同付款查看页面	
function detail(id,type) {
	if(type==0){//原合同
		var win = creatWin('查看', 1115, 600,  'icon-search', '/Formulation/detail/'+id);
		win.window('open');
	}else if(type==1){//变更
		var win = creatWin('查看', 1115, 600,  'icon-search', '/Change/detail/'+id);
		win.window('open');			
	}
}
function seal(id,type) {
	if(type==0){//原合同
		var win = creatWin('盖章', 795, 580, 'icon-search', '/sealInfo/sealEdit?id='+id+'&type='+type);
		win.window('open');
	}else if(type==1){//变更
		var win = creatWin('盖章', 795, 580, 'icon-search', '/sealInfo/sealEdit?id='+id+'&type='+type);
		win.window('open');			
	}
}

function contractClickSeal(){
	$("#contractTabSeal").datagrid('reload');
	$("#contract_top").show();
	$("#UpdateOrending_top").hide();
}
function updateOrendingClickSeal(){
	$("#updateOrendingTabSeal").datagrid('reload');
	$("#contract_top").hide();
	$("#UpdateOrending_top").show();
}
//直接报销查询
function queryContractSeal() {
	var fcCode="contract_code_Seal";
	var deptName="contract_name_Seal";
	$("#contractTabSeal").datagrid('load',{
		fcCode:$("#"+fcCode).textbox('getValue').trim(),
		fcTitle:$("#"+deptName).textbox('getValue').trim(),
	});
}
//直接报销清除查询条件
function clearContractSeal() {
	var fcCode="contract_code_Seal";
	var fcTitle="contract_name_Seal";
	$("#"+fcCode).textbox('setValue','');
	$("#"+fcTitle).textbox('setValue','');
	$("#contractTabSeal").datagrid('load',{});
}

//申请报销查询
function queryUpdateOrendingSeal() {
	var rCode="UpdateOrending_code_Seal";
	var fcTitle="UpdateOrending_name_Seal";
	$("#updateOrendingTabSeal").datagrid('load',{
		fcCode:$("#"+rCode).textbox('getValue').trim(),
		fcTitle:$("#"+fcTitle).textbox('getValue').trim(),
	});
}
//申请报销清除查询条件
function clearUpdateOrendingSeal() {
	var rCode="UpdateOrending_code_Seal";
	var fcTitle="UpdateOrending_name_Seal";
	$("#"+rCode).textbox('setValue','');
	$("#"+fcTitle).textbox('setValue','');
	$("#updateOrendingTabSeal").datagrid('load',{});
}
//是否归档
function returnfsealedStatus(val, row) {
	var c = row.fsealedStatus;
	if (c == 0||c == ''||c == null) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 未盖章" + '</span>';
	} else {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 已盖章" + '</span>';
	}
}

//合同台账导出
function exportContract() {
	if(confirm('是否按查询条件导出？')){
		var fcCode =$('#ledger_fcCode').val();
		var fcTitle = $('#ledger_fcTitle').val();
		
		$('#form_contract_export_fcCode').val(fcCode);
		$('#form_contract_export_fcTitle').val(fcTitle);
		
		$('#form_contract_export').attr('action','${base}/Ledger/export');
		$('#form_contract_export').submit();
	}
}
</script>
</body>
</html>


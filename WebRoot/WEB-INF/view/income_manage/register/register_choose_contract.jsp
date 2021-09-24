<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" >合同编号&nbsp;
						<input id="lendger_fBudgetIndexCode" hidden="hidden" name="fBudgetIndexCode" value="${fBudgetIndexCode }">
						<input id="ledger_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="ledger_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="queryledger();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="ledger_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> 
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="choose_ledger_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Ledger/JsonPagination?fcType=HTFL-02',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="10%">序号</th>
						<th data-options="field:'fcCode',align:'left',resizable:false,sortable:true" width="30%">合同编号</th>
						<th data-options="field:'fcTitle',align:'left',resizable:false,sortable:true" width="30%">合同名称</th>
						<th data-options="field:'fOperator',align:'left',resizable:false,sortable:true" width="15%">申请人</th>
						<th data-options="field:'fSignUser',align:'left',resizable:false,sortable:true" width="15%">签署人</th>
					</tr>
				</thead>
			</table>
		</div>
		<form id="form_contract_export" method="post" enctype="multipart/form-data">
			<input type="hidden" name="sbkLx" value="xmtz">
			<input id="form_contract_export_fcCode" type="hidden" name="fcCode">
			<input id="form_contract_export_fcTitle" type="hidden" name="fcTitle">
			<input id="form_contract_export_fContStauts" type="hidden" name="fContStauts">
			<input id="form_contract_export_fBudgetIndexCode" type="hidden" name="fBudgetIndexCode">
		</form>
		
		
	</div>
	


<script type="text/javascript">
	$(function(){
		initDg_contract_choose();
	});
	//清除查询条件
	function ledger_clearTable() {
		$('#ledger_fcCode').textbox('setValue',null);
		$('#ledger_fcTitle').textbox('setValue',null);
		//$('#ledger_fReqtIME').datebox('setValue',null);
		$('#ledger_fcTitle').combobox('setValue',null);
		queryledger();
	}
	function queryledger() {
		$('#choose_ledger_dg').datagrid('load', {
			fcCode : $('#ledger_fcCode').val(),
			fcTitle : $('#ledger_fcTitle').val()
		});
	}
	//双击事件
	function initDg_contract_choose(){
		$('#choose_ledger_dg').datagrid({
			onDblClickRow:function(index,row){
				$('#F_contractCode').textbox('setValue',row.fcCode);
				$('#F_contractName').textbox('setValue',row.fcTitle);
				closeFirstWindow();
			}
		});
	}
</script>
</body>
</html>


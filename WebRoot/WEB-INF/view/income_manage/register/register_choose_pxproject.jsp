<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" >立项编号&nbsp;
						<input id="lendger_fBudgetIndexCode" hidden="hidden" name="fBudgetIndexCode" value="${fBudgetIndexCode }">
						<input id="ledger_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;立项项目名称&nbsp;
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
			data-options="collapsible:true,url:'${base}/business/chooseProjectList',
			method:'post',fit:true,pagination:false,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,rownumbers:true,fitColumns: true">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fBusiId',hidden:true"></th>
						<th data-options="field:'fBusiCode',align:'center',resizable:false" width="30%">立项编号</th>
						<th data-options="field:'fProName',align:'center',resizable:false" width="30%">立项项目名称</th>
						<th data-options="field:'fOperatorName',align:'center',resizable:false" width="20%">申请人</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false" width="23%">申请部门</th>
					</tr>
				</thead>
			</table>
		</div>
		
		
	</div>
	


<script type="text/javascript">
	$(function(){
		initDg_contract_choose();
	});
	//清除查询条件
	function ledger_clearTable() {
		$('#ledger_fcCode').textbox('setValue',null);
		$('#ledger_fcTitle').textbox('setValue',null);
		queryledger();
	}
	function queryledger() {
		$('#choose_ledger_dg').datagrid('load', {
			fBusiCode : $('#ledger_fcCode').val(),
			fProName : $('#ledger_fcTitle').val()
		});
	}
	//双击事件
	function initDg_contract_choose(){
		$('#choose_ledger_dg').datagrid({
			onDblClickRow:function(index,row){
				$('#fproName').textbox('setValue',row.fProName);
				$('#F_fPlanPrice').textbox('setValue',row.fPlanPrice);
				$('#F_fProPlan').textbox('setValue',row.fProPlan);
				$('#F_fRemark').textbox('setValue',row.fRemark);
				$('#fBusiId').val(row.fBusiId);
				closeFirstWindow();
			}
		});
	}
</script>
</body>
</html>


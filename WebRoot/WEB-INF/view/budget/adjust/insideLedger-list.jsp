<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top" >
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="inside_ledger_top">
				<td class="top-table-search-pro">调出指标名称&nbsp;
					<input id="inside_ledger_indexNameOut" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;调入指标名称
					<input id="inside_ledger_indexNameIn" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="inside_ledger_query();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="inside_ledger_clear();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="exportLedger();">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" 
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
						/>
					</a>
				</td>
			</tr>
		</table>   
	</div>
	
	<div class="list-table">
		<table id="insideLedgerTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/insideAdjust/adjustPage?flowStauts=9',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'inId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'opUser',align:'center',resizable:false,sortable:true" style="width: 10%">操作人</th>
					<th data-options="field:'indexNameOut',align:'center',resizable:false,sortable:true" style="width: 15%">调出指标名称</th>
					<th data-options="field:'changeAmountOut',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 13%">调出金额[万元]</th>
					<th data-options="field:'indexNameIn',align:'center',resizable:false,sortable:true" style="width: 15%">调入指标名称</th>
					<th data-options="field:'changeAmountIn',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 13%">调入金额[万元]</th>
					<th data-options="field:'opTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">调整时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter: flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:insideLedgerCZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
</div>
<form id="form_data_export_ledger" method="post">
	<input type="hidden" id="inside_ledger_indexNameOut_out" name="inside_indexNameOut" value="">
	<input type="hidden" id="inside_ledger_indexNameIn_in"  name="inside_indexNameIn" value="">
</form>
<script type="text/javascript">
function getMoney(money){
	if(money==null){
		money=0.00;
	}
	return money.toFixed(2);
}
function exportLedger(){
	if(confirm('是否按查询条件导出？')){
		var inside_ledger_indexNameOut=$('#inside_ledger_indexNameOut').val();
		var inside_ledger_indexNameIn=$('#inside_ledger_indexNameIn').val();
		$("#inside_ledger_indexNameOut_out").val(inside_ledger_indexNameOut);
		$("#inside_ledger_indexNameIn_in").val(inside_ledger_indexNameIn);
		$('#form_data_export_ledger').attr('action','${base}/insideAdjust/exportLedger');
		$('#form_data_export_ledger').submit();
	}
}
//加载tab页
/* flashtab('side-ledger-tab'); */

//操作栏创建
function insideLedgerCZ(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="editinsideAdjust(' + row.inId + ',0)" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td></tr></table>';
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

//修改
function editinsideAdjust(id,type) {
	var win = creatWin('内部调整明细', 970, 580, 'icon-search', '/insideAdjust/detail?id='+id+'&type='+type);
	win.window('open');
}

function insideLedgerTabClick(){
	$("#insideLedgerTab").datagrid('reload');
	$("#inside_ledger_top").show();
}

//查询
function inside_ledger_query() {
	$('#insideLedgerTab').datagrid('load', {
		indexNameOut:$('#inside_ledger_indexNameOut').val(),
		indexNameIn:$('#inside_ledger_indexNameIn').val(),
	});
	
}

//清除查询条件
function inside_ledger_clear() {
	$("#inside_ledger_indexNameOut").textbox('setValue','');
	$("#inside_ledger_indexNameIn").textbox('setValue','');
	$('#insideLedgerTab').datagrid('load',{//清空以后，重新查一次
	});
}


</script>
</body>
</html>


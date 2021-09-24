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
				
			<tr id="outside_ledger_top" style="display: none;">
				<td class="top-table-search-pro">调整指标名称&nbsp;
					<input id="outside_ledger_indexName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;调整金额&nbsp;
					<input id="outside_ledger_changeAmountBegin"  name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
					&nbsp;-&nbsp;
					<input id="outside_ledger_changeAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" class="easyui-numberbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="outside_ledger_query();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="outside_ledger_clear();">
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
	
	<div class="list-table-tab">
		<table id="outsideLedgerTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/outsideAdjust/adjustPage?flowStauts=9',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'aId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'opUser',align:'left',resizable:false,sortable:true" style="width: 10%">操作人</th>
					<th data-options="field:'indexName',align:'left',resizable:false,sortable:true" style="width: 25%">调整指标名称</th>
					<th data-options="field:'changeAmount',align:'left',resizable:false,sortable:true,formatter:getMoney" style="width: 15%">调整金额[万元]</th>
					<th data-options="field:'opTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">调整时间</th>
					<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 15%">审批状态</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:outsideLedgerCZ" style="width: 15%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
</div>
<form id="form_data_export_ledger" method="post">
	<input type="hidden" id="outside_ledger_indexName_tz" name="outside_indexName" value="">
	<input type="hidden" id="outside_ledger_changeAmountBegin_start"  name="outside_changeAmountBegin" value="">
	<input type="hidden" id="outside_ledger_changeAmountEnd_end"  name="outside_changeAmountEnd" value="">
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
		var outside_ledger_indexName=$('#outside_ledger_indexName').val();
		var outside_ledger_changeAmountBegin=$('#outside_ledger_changeAmountBegin').val();
		var outside_ledger_changeAmountEnd=$('#outside_ledger_changeAmountEnd').val();
		$("#outside_ledger_indexName_tz").val(outside_ledger_indexName);
		$("#outside_ledger_changeAmountBegin_start").val(outside_ledger_changeAmountBegin);
		$("#outside_ledger_changeAmountEnd_end").val(outside_ledger_changeAmountEnd);
		$('#form_data_export_ledger').attr('action','${base}/outsideAdjust/exportLedger');
		$('#form_data_export_ledger').submit();
	}
}
//加载tab页
/* flashtab('side-ledger-tab'); */

//操作栏创建
function outsideLedgerCZ(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="editoutsideAdjust(' + row.aId + ',0)" class="easyui-linkbutton">'+
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
function editoutsideAdjust(id,type) {
	/*type为修改或查看1位修改，0位查看  */
	var win = creatWin(' ', 970, 580, 'icon-search', "/outsideAdjust/edit?id="+ id+"&editType="+type);
	win.window('open');
}

function outsideLedgerTabClick(){
	$("#outsideLedgerTab").datagrid('reload');
	$("#outside_ledger_top").show();
}

//查询
function outside_ledger_query() {
	$('#outsideLedgerTab').datagrid('load', {
		indexName:$('#outside_ledger_indexName').val(),
		changeAmountBegin:$('#outside_ledger_changeAmountBegin').val(),
		changeAmountEnd:$('#outside_ledger_changeAmountEnd').val(),
		flowStauts:$('#outside_flowStauts').val()
	});
}
//清除查询条件
function outside_ledger_clear() {
	$("#outside_ledger_indexName").textbox('setValue','');
	$("#outside_ledger_changeAmountBegin").textbox('setValue','');
	$("#outside_ledger_changeAmountEnd").textbox('setValue','');
	$('#outsideLedgerTab').datagrid('load',{//清空以后，重新查一次
	});
}
	

</script>
</body>
</html>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th class="top-table-td1">相关单据号：</th> 
					<td class="top-table-td2">
						<input id="ledger_flow_flowCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">操作部门：</th> 
					<td class="top-table-td2">
						<input id="ledger_flow_flowDeptName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">操作类型：</th> 
					<td class="top-table-td2">
						<input id="ledger_flow_fOptType" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=ZCLSCZLX',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" onclick="ledger_flow_queryCF();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="ledger_flow_clear();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height:450px">
			<table id="ledger_fixed_flow" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/AssetsLedger/fixedFlow?flowStockCode=${code}',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'flowId',hidden:true"></th>
						<th data-options="field:'flowTime',align:'center',resizable:false,sortable:true,formatter:ChangeDateFormatIndex" width="15%">操作时间</th>
						<th data-options="field:'optType',align:'center',resizable:false,sortable:true" width="10%">操作方式</th>
						<th data-options="field:'flowUser',align:'center',resizable:false,sortable:true" width="10%">操作人</th>
						<th data-options="field:'flowAssName',align:'center',resizable:false,sortable:true" width="15%">资产名称</th>
						<th data-options="field:'flowStockCode',align:'center',resizable:false,sortable:true" width="15%">资产编码</th>
						<th data-options="field:'flowDeptName',align:'center',resizable:false,sortable:true" width="10%">操作部门</th>
						<th data-options="field:'flowCode',align:'center',resizable:false,sortable:true" width="20%">相关单据号</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="5%">操作</th>
					</tr>
				</thead>
			</table>
		</div>

	</div>
	


<script type="text/javascript">


function formatPrice(val,row){
	
	
}
function CZ(val,row){
	return '<a href="#" onclick="PitchOn('+row.flowId+',\''+row.fOptType.code+'\',\''+row.flowCode+'\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png"></a>';
}
function PitchOn(id,optType,flowCode){
	if('ZCLSCZLX-01'==optType){
		var win = creatFirstWin('入库单', 770,590, 'icon-search',"/Storage/detail/"+flowCode+"?optType="+optType+"&ledger=detailLedger");
	}else if('ZCLSCZLX-02'==optType){
		var win = creatFirstWin('领用单', 970,580, 'icon-search',"/Rece/detail/"+flowCode+"?optType="+optType+"&ledger=detailLedger");
	}else if('ZCLSCZLX-03'==optType){
		var win = creatFirstWin('调拨单', 970,580, 'icon-search',"/Alloca/detail/"+flowCode+"?optType="+optType+"&ledger=detailLedger");
	}else if('ZCLSCZLX-04'==optType){
		var win = creatFirstWin('处置单', 970,580, 'icon-search',"/Handle/detail/"+flowCode+"?optType="+optType+"&ledger=detailLedger");
	}else if('ZCLSCZLX-05'==optType){
		var win = creatFirstWin('维修单', 970,580, 'icon-search',"/Rece/detail/"+flowCode+"?optType="+optType+"&ledger=detailLedger");
	}
	win.window('open');
}
function ledger_flow_queryCF(){  
	$('#ledger_fixed_flow').datagrid('load',{ 
		flowCode:$('#ledger_flow_flowCode').textbox('getValue'),
		flowDeptName:$('#ledger_flow_flowDeptName').textbox('getValue'),
		optType:$('#ledger_flow_fOptType').combobox('getValue'),
	} ); 
}
//清除查询条件
function ledger_flow_clear() {
	$('#ledger_flow_flowCode').textbox('setValue',null),
	$('#ledger_flow_flowDeptName').textbox('setValue',null),
	$('#ledger_flow_fOptType').combobox('setValue',null),
	ledger_flow_queryCF();
}
</script>
</body>
</html>


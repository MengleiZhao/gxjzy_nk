<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body >
<%-- <%@ include file="../../../cockpitStatistics/divbase.jsp"%> --%>
<div class="list-div">
<div style="height: 10px;background-color:#f0f5f7 "></div>
<div class="list-top">
	<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
				
			<tr id="contract_ledger_top">
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
				
				<%-- <td style="text-align: right; padding-right: 10px;">
					<a href="${base}/reimburse/export">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"/>
					</a>
				</td> --%>
				<td align="right" style="padding-right: 10px;width:70px;">
					<a href="javascript:void(0)"  onclick="window.location.href='${base}/cockpit/list';">
						<img src="${base}/resource-modality/${themenurl}/button/tuihui1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
	</table>   
</div>
	

<div class="list-table-tab">
		<div class="tab-wrapper" id="rc-ledger-tab">
			<ul class="tab-menu">
				<!-- <li class="active" onclick="directlyLedgerTopClick();">直接报销</li>
			    <li onclick="reimburseLedgerTopClick();">申请报销</li> -->
			    <li onclick="contractLedgerTopClick();">合同报销</li>
			</ul>
				
			<div class="tab-content">
				
				<div style="height: 440px">
					<table id="contractreimburseLedgerTab" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/reimburseLedger/reimbursePage?reimburseType=8',
						method:'post',fit:true,pagination:true,singleSelect: true,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
							<thead>
								<tr>
									<th data-options="field:'rId',hidden:true"></th>
									<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
									<th data-options="field:'rCode',align:'center',resizable:false,sortable:true" style="width: 15%">报销单编号</th>
									<th data-options="field:'contCode',align:'center'" width="15%">合同编号</th>
									<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="17%">合同名称</th>
									<th data-options="field:'amount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">付款金额(元)</th>
									<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">报销申请人</th>
									<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
									<th data-options="field:'cashierType',align:'center',resizable:false,sortable:true,formatter:cashierTypeSet" style="width: 10%">付款状态</th>
									<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ2" style="width: 8%">操作</th>
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

function contractLedgerTopClick(){
	$("#contractreimburseLedgerTab").datagrid('reload');
}

//合同报销查询
function querycontractLedger() {
	var rCode="contract_ledger_list_top_code";
	var deptName="contract_ledger_list_top_deptName";
	
	
	$("#contractreimburseLedgerTab").datagrid('load',{
		rCode:$("#"+rCode).textbox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//合同报销清除查询条件
function clearcontractLedger() {
	var rCode="contract_ledger_list_top_code";
	var deptName="contract_ledger_list_top_deptName";
	
	$("#"+rCode).textbox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#contractreimburseLedgerTab").datagrid('load',{});
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
</script>
</body>
</html>


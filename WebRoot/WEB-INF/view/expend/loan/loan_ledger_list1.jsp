<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<script type="text/javascript">
var base='${base}';
var queryYear = '${year}';
var queryDepartId = '${departId}';
</script>

<style type="text/css">
.datagrid-body{
	height: 358px;
}
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">借款单编号&nbsp;
						<input id="loan_ledger_list_top_lCode" style="width: 130px;height:22px;" class="easyui-textbox"/>
						<!-- <span style="font-size: 12px; color: #182C4D;">预计冲账时间：</span>
						
						<input id="loan_ledger_list_top_estChargeTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[loan_ledger_list_top_estChargeTime2]"/>
						&nbsp;-&nbsp;
						<input id="loan_ledger_list_top_estChargeTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[loan_ledger_list_top_estChargeTime1]"/>
						 -->
						 &nbsp;&nbsp;所属部门&nbsp;
						<input id="loan_ledger_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
						&nbsp;&nbsp;
						<a href="#" onclick="queryLoanLedger();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="#" onclick="clearLoanLedger();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="#" onclick="loanLedgerDaochu()">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>
				</tr>
		</table>  
	</div>


	<!-- 列表区 -->
	<div data-options="region:'center'">
	  	<div class="list-table" style="height: 475px">
			<table id="loanLedgerTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/loanLedger/loanPage?loanString=0',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'lId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
						<th data-options="field:'lCode',align:'left',resizable:false,sortable:true" style="width: 17%">借款单编号</th>
						<th data-options="field:'loanPurpose',align:'left',resizable:false,sortable:true" style="width: 15%">用途</th>
						<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 10%">借款人</th>
						<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 10%">所属部门</th>
						<th data-options="field:'reqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
						<th data-options="field:'estChargeTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">预计冲账时间</th>
						<!-- <th data-options="field:'indexAmount',align:'left',resizable:false,sortable:true" style="width: 10%">可用预算金额</th> -->
						<th data-options="field:'lAmount',align:'left',resizable:false,sortable:true" style="width: 8%">借款金额</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 5%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
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
function CZ(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="editLoan(' + row.lId + ',0)" class="easyui-linkbutton">'+
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
function editLoan(id,type) {
	/*type为修改或查看1位修改，0位查看  */
	var win = creatWin(' ', 970, 580, 'icon-search', "/loan/edit?id="+ id+"&editType="+type);
	win.window('open');
}

//查询
function queryLoanLedger() {
	var lCode="loan_ledger_list_top_lCode";
	/* var estChargeTime1="loan_ledger_list_top_estChargeTime1";
	var estChargeTime2="loan_ledger_list_top_estChargeTime2"; */
	var deptName="loan_ledger_list_top_deptName";
	
	
	$("#loanLedgerTab").datagrid('load',{
		lCode:$("#"+lCode).textbox('getValue').trim(),
		/* estChargeTime1:$("#"+estChargeTime1).datebox('getValue').trim(),
		estChargeTime2:$("#"+estChargeTime2).datebox('getValue').trim(), */
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//清除查询条件
function clearLoanLedger() {
	var lCode="loan_ledger_list_top_lCode";
	/* var estChargeTime1="loan_ledger_list_top_estChargeTime1";
	var estChargeTime2="loan_ledger_list_top_estChargeTime2"; */
	var deptName="loan_ledger_list_top_deptName";
	
	$("#"+lCode).textbox('setValue','');
	/* $("#"+estChargeTime1).datebox('setValue','');
	$("#"+estChargeTime2).datebox('setValue',''); */
	$("#"+deptName).textbox('setValue','');
	
	$("#loanLedgerTab").datagrid('load',{});

}

//导出
function loanLedgerDaochu() {
	var url=base+"/loan/export";
	var loanString = "0";
	var lCode=$("#loan_ledger_list_top_lCode").textbox('getValue').trim();
	//var estChargeTime1=$("#loan_ledger_list_top_estChargeTime1").datebox('getValue').trim();
	//var estChargeTime2=$("#loan_ledger_list_top_estChargeTime2").datebox('getValue').trim();
	var deptName=$("#loan_ledger_list_top_deptName").textbox('getValue').trim();
	
	url=url+"?lCode="+lCode+"&estChargeTime1="+estChargeTime1+"&estChargeTime2="+estChargeTime2+"&deptName="+deptName+"&loanString="+loanString;
	
	window.location.href=url;
}


$("#loan_ledger_list_top_estChargeTime1").datebox({
    onSelect : function(beginDate){
        $('#loan_ledger_list_top_estChargeTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
</script>
</body>
</html>


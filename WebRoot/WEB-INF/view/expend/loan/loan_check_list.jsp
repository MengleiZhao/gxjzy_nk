<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;借款单编号&nbsp;
					<input id="loan_check_list_top_lCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;预计冲账时间&nbsp;
					<input id="loan_check_list_top_estChargeTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[loan_check_list_top_estChargeTime2]"/>
					&nbsp;-&nbsp;
					<input id="loan_check_list_top_estChargeTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[loan_check_list_top_estChargeTime1]"/>
					
					&nbsp;&nbsp;所属部门&nbsp;
					<input id="loan_check_list_top_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryLoanCheck();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearLoanCheck();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>  
	</div>
	


	<div class="list-table">
		<table id="loanCheckTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/loanCheck/loanPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'lId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'lCode',align:'center',resizable:false,sortable:true" style="width: 15%">借款单编号</th>
					<th data-options="field:'lAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">借款金额[元]</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">借款人</th>
					<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 10%">所属部门</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'estChargeTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">预计冲账时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
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
	if (c == 9 ) {
		return null;
	} else {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="checkLoan(' + row.lId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
				'</a></td></tr></table>';
	}
}

//审批页面跳转
function checkLoan(id) {
	var win = creatWin('审批', 1115, 580, 'icon-search', "/loanCheck/check?id="+ id+"&cashier=0");
	win.window('open');
}


//查询
function queryLoanCheck() {
	var lCode="loan_check_list_top_lCode";
	var estChargeTime1="loan_check_list_top_estChargeTime1";
	var estChargeTime2="loan_check_list_top_estChargeTime2";
	var deptName="loan_check_list_top_deptName";
	
	
	$("#loanCheckTab").datagrid('load',{
		lCode:$("#"+lCode).textbox('getValue').trim(),
		estChargeTime1:$("#"+estChargeTime1).datebox('getValue').trim(),
		estChargeTime2:$("#"+estChargeTime2).datebox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//清除查询条件
function clearLoanCheck() {
	var lCode="loan_check_list_top_lCode";
	var estChargeTime1="loan_check_list_top_estChargeTime1";
	var estChargeTime2="loan_check_list_top_estChargeTime2";
	var deptName="loan_check_list_top_deptName";
	
	$("#"+lCode).textbox('setValue','');
	$("#"+estChargeTime1).datebox('setValue','');
	$("#"+estChargeTime2).datebox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#loanCheckTab").datagrid('load',{});
}


$("#loan_check_list_top_estChargeTime1").datebox({
    onSelect : function(beginDate){
        $('#loan_check_list_top_estChargeTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
</script>
</body>


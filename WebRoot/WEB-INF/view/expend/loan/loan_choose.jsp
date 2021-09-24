<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<!-- <style type="text/css">
.datagrid-btable{
	width:100%;
}
</style> -->
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">借款用途：</td> 
					<td class="top-table-td2">
						<input id="loanPurpose" name="loanPurpose"  style="width: 150px;height:25px;" class="easyui-textbox"/>
					</td>
					<td style="width: 30px;"></td>
					<td style="width: 26px;">
						<a href="javascript:void(0)"  onclick="query_hstd();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 8px;"></td>
					<td>
						<a href="javascript:void(0)"  onclick="clearTable_hstd();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table" >
			<table id="loan_choose_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/loan/loanPage?sign=0',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'lId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'lCode',align:'center',resizable:false,sortable:true" style="width: 15%">借款单编号</th>
					<th data-options="field:'leastAmount',align:'right',resizable:false,sortable:true" style="width: 13%">剩余还款金额[元]</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 8%">借款人</th>
					<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 12%">所属部门</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'frepayStatus',align:'center',resizable:false,sortable:true,formatter: hkztFormat" style="width: 10%">还款状态</th>
					<th data-options="field:'estChargeTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">预计冲账时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	


<script type="text/javascript">

$(function(){
	initDg_hotel_add();
});

//初始化datagrid点击事件
function initDg_hotel_add(){
	$('#loan_choose_dg').datagrid({
		onDblClickRow:function(index,row){
			if ('fromBxsq'=='${menuType}') {
				//申请报销-选择借款单
			}
			$('#input_jkdbh').textbox('setValue',row.lCode);
			$('#input_jkdid').val(row.lId);
			$('#input_jkdamonut').val(row.leastAmount);
			$('#cxAmounts').val(row.leastAmount);
			closeFirstWindow();
			cx();
		}
	});
}

//清除查询条件
function clearTable_hstd() {
	$('#loanPurpose').textbox('setValue',null);
	query_hstd();
}


function query_hstd() {
	var loanPurpose = $('#loanPurpose').textbox('getValue');
	$('#loan_choose_dg').datagrid('load', {
		loanPurpose : loanPurpose
	});
}


function format_strToDate(value){
	if (value != null) {
		var date = new Date(value);
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return (m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
		//return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
	} else {
		return '无';
	}
}

function format_wjsfbl(value){
	if (value=='' || value==null) {
		return '无';
	} else {
		return value;
	}
}

function hkztFormat(val,row){
	// 0待还款  1待审定 -1已退回  2已还款
	if (val=='0') {
		return '待还款';
	} else if (val=='1') {
		return '待审定';
	} else if (val=='-1') {
		return '已退回';
	} else if (val=='2') {
		return '已还款';
	}
	return val;
}
</script>
</body>


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
					<input id="loan_list_top_lCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;预计冲账时间&nbsp;
					<input id="loan_list_top_estChargeTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[loan_list_top_estChargeTime2]"/>
					&nbsp;-&nbsp;
					<input id="loan_list_top_estChargeTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[loan_list_top_estChargeTime1]"/>
					
					<!-- &nbsp;&nbsp;审批状态&nbsp;
					
					<select id="loan_list_top_flowStauts" class="easyui-combobox" style="width: 150px;height:25px;">
						<option value="">--请选择--</option>
						<option value="0">暂存</option>
						<option value="1">待审批</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select> -->
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<%-- <td align="right" style="padding-right: 10px">
					<a href="#" onclick="addLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			 --%>
			
				<%-- <td class="top-table-td1">申请时间：</td> 
				<td class="top-table-td2">
					<input id="loanReqTime" name=""  style="width: 150px;height:25px;" class="easyui-datebox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">预计冲账时间：</td> 
				<td class="top-table-td2">
					<input id="loanEstChargeTime" name=""  style="width: 150px;height:25px;" class="easyui-datebox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td> --%>
			</tr>
		</table>  
	</div>
	
	<div class="list-table">
		<table id="loanTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/loan/loanPage?flowStauts=9&sign=0',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'lId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'lCode',align:'left',resizable:false,sortable:true" style="width: 16%">借款单编号</th>
					<th data-options="field:'lAmount',align:'left',resizable:false,sortable:true" style="width: 8%">借款金额</th>
					<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 8%">借款人</th>
					<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 10%">所属部门</th>
					<th data-options="field:'reqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'frepayStatus',align:'left',resizable:false,sortable:true,formatter: hkztFormat" style="width: 7%">还款状态</th>
					<th data-options="field:'estChargeTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 13%">预计冲账时间</th>
					<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 10%">借款人</th>
					<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="text-align: left;height: 10px">
		<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
	</div>
</div>
<script type="text/javascript">
//双击选择
$('#loanTab').datagrid({
	onDblClickRow: function(rowIndex, rowData){
		$('#payAmount').numberbox('setValue',rowData.leastAmount);//借款金额
		$('#payment_lId').textbox('setValue',rowData.lId);//借款id
		$('#payPerson').textbox('setValue',rowData.userName);//借款人
		$('#code').textbox('setValue',rowData.lCode);//借款单
		$('#freqTime').val(ChangeDateFormat(rowData.reqTime));//借款单时间
		closeFirstWindow();		
	}
});

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
	if (c == 9 || c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editLoan(' + row.lId + ',0)" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
	} else if(c == 0 || c == -1) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="editLoan(' + row.lId + ',0)" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="editLoan(' + row.lId + ',1)" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteLoan(' + row.lId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}
}

//查询
function queryLoan() {
	var lCode="loan_list_top_lCode";
	var estChargeTime1="loan_list_top_estChargeTime1";
	var estChargeTime2="loan_list_top_estChargeTime2";
	
	
	$("#loanTab").datagrid('load',{
		lCode:$("#"+lCode).textbox('getValue').trim(),
		estChargeTime1:$("#"+estChargeTime1).datebox('getValue').trim(),
		estChargeTime2:$("#"+estChargeTime2).datebox('getValue').trim(),
	});

}
//清除查询条件
function clearLoan() {
	var lCode="loan_list_top_lCode";
	var estChargeTime1="loan_list_top_estChargeTime1";
	var estChargeTime2="loan_list_top_estChargeTime2";
	var flowStauts="loan_list_top_flowStauts";
	
	$("#"+lCode).textbox('setValue',''),
	$("#"+estChargeTime1).datebox('setValue',''),
	$("#"+estChargeTime2).datebox('setValue',''),
	$("#"+flowStauts).textbox('setValue',''),
	
	$("#loanTab").datagrid('load',{});
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



$("#loan_list_top_estChargeTime1").datebox({
    onSelect : function(beginDate){
        $('#loan_list_top_estChargeTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
</script>
</body>
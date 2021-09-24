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
					
					&nbsp;&nbsp;审批状态&nbsp;
					
					<select id="loan_list_top_flowStauts" class="easyui-combobox" style="width: 150px;height:25px;">
						<option value="">--请选择--</option>
						<option value="0">暂存</option>
						<option value="1">待审批</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addLoan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			
			
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
		data-options="collapsible:true,url:'${base}/loan/loanPage',
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
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">申请时间</th>
					<th data-options="field:'frepayStatus',align:'center',resizable:false,sortable:true,formatter: hkztFormat" style="width: 10%">还款状态</th>
					<th data-options="field:'estChargeTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">预计冲账时间</th>
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
	} else if (val == -4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	if ( c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editLoan(' + row.lId + ',0)" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
			   '<a href="#" onclick="reCall(\'loanTab\',' + row.lId + ',\'/loan/loanReCall\')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			   '</a></td></tr></table>';
	} else if(c == 0 || c == -1  || c == -4) {
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
	}else if(c == 9 ){
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="editLoan(' + row.lId + ',0)" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a>'+ '</td><td style="width: 25px">'+
			'<a href="#" onclick="exportHtml(' + row.lId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
		   '</a></td></tr></table>';
	}
	
}
function exportHtml(id) {
	window.open(base+"/exportApplyAndReim/loanyExprot?id="+ id);
}

//新增页面
function addLoan() {
	var win = creatWin('借款申请', 1115, 580, 'icon-search', '/loan/add');
	win.window('open');
}

//删除
function deleteLoan(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/loan/delete?id='+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#loanTab').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

//修改
function editLoan(id,type) {
	/*type为修改或查看1位修改，0位查看  */
	var title = null;
	if(type==1){
		title = "借款申请-修改";
	}else {
		title = "借款明细";
	}
	var win = creatWin(title, 1115, 580, 'icon-search', "/loan/edit?id="+ id +"&editType="+ type);
	win.window('open');
}

//查询
function queryLoan() {
	var lCode="loan_list_top_lCode";
	var estChargeTime1="loan_list_top_estChargeTime1";
	var estChargeTime2="loan_list_top_estChargeTime2";
	var flowStauts="loan_list_top_flowStauts";
	
	
	$("#loanTab").datagrid('load',{
		lCode:$("#"+lCode).textbox('getValue').trim(),
		estChargeTime1:$("#"+estChargeTime1).datebox('getValue').trim(),
		estChargeTime2:$("#"+estChargeTime2).datebox('getValue').trim(),
		flowStauts:$("#"+flowStauts).textbox('getValue').trim(),
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
	// 还款（归垫）状态        0待还款  1待审定 -1已退回  9已还款
	
	if (val=='0') {
		return '待还款';
	} else if (val=='1') {
		return '待审定';
	} else if (val=='-1') {
		return '已退回';
	} else if (val=='9') {
		return '已还款';
	}else{
		return '已退回';
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
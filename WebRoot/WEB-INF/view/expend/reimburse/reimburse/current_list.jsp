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
						&nbsp;&nbsp;单据编号&nbsp;
						<input id="reimburse_list_top_rCode_9" style="width: 150px;height:25px;" class="easyui-textbox"/>
						
						&nbsp;&nbsp;报销日期&nbsp;
						<input id="reimburse_list_top_reqTime1_9" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[reimburse_list_top_reqTime2_9]"/>
						&nbsp;-&nbsp;
						<input id="reimburse_list_top_reqTime2_9" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[reimburse_list_top_reqTime1_9]"/>
						
						&nbsp;&nbsp;审批状态&nbsp;
						
						<select id="reimburse_list_top_flowStauts_9" class="easyui-combobox" style="width: 150px;height:25px;">
							<option value="">--请选择--</option>
							<option value="99">未发起</option>
							<option value="0">暂存</option>
							<option value="1">待审批</option>
							<option value="-1">已退回</option>
							<option value="9">已审批</option>
						</select>
						
						&nbsp;&nbsp;
						<a href="#" onclick="current_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="#" onclick="current_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="addcurrent()">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="list-table">
			<table id="current_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/reimburse/reimbursePage?reimburseType=9',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'gId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
						<th data-options="field:'gCode',align:'center',resizable:false" style="width: 25%">单据编号</th>
						<th data-options="field:'gName',align:'center',resizable:false" style="width: 25%">单据摘要</th>
						<th data-options="field:'amount',align:'center',resizable:false,formatter: Baoxiaochaoe" style="width: 15%">报销金额(元)</th>
						<th data-options="field:'reimburseReqTime',align:'center',resizable:false,formatter: ChangeDateFormatCurrent" style="width: 11%">报销日期</th>
						<th data-options="field:'flowStauts',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,formatter:CZ" style="width: 10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
$('#e_percentageTempEnd').val(1);
//清除查询条件
function current_clearTable() {
	$('#reimburse_list_top_rCode_9').textbox('setValue',null);
	$('#reimburse_list_top_reqTime1_9').datebox('setValue',null);
	$('#reimburse_list_top_reqTime2_9').datebox('setValue',null);
	$('#reimburse_list_top_flowStauts_9').combobox('setValue',null);
	current_query();
}
function Baoxiaochaoe(val, row){
	
	var a = row.amount;
	if(val>a){
		return '<span style="color:red">'+fomatMoney(val,2)+"【报销超额】"+'</span>';
	}else{
		return fomatMoney(val,2);
	}
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
	} else if (val == -4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	}  else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}
//操作栏创建
function CZ(val, row) {
	console.log(row.reimbFlowStauts);
	if (c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="detailCurrent(' + row.rId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
			   '<a href="#" onclick="reCall(\'current_dg\',' + row.rId + ',\'/reimburse/reimburseReCall\')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			   '</a></td></tr></table>';
	}else if(c == 0 || c == -1 || c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detailCurrent(' + row.rId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="editcurrent(' + row.rId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'</a></td></tr></table>';
			/* 	
				'<a href="#" onclick="deleteReimburse(' + row.rId + ',' + row.type + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>'; */
	}else {
		//c==9审批通过无法撤回
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="detailCurrent(' + row.rId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="exportcurrentHtml(' + row.rId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
			   '</a></td></tr></table>';
	}
}
//新增方法
function addcurrent(){
	win = creatWin('新增', 1115, 600, 'icon-search', '/reimburse/addCurrent');
	win.window('open');
}
//修改方法
function editcurrent(id){
	win = creatWin('修改', 1115, 600, 'icon-search', '/reimburse/editCurrent?id='+id+'&editType=1');
	win.window('open');
}
//查看
function detailCurrent(id){
	win = creatWin('查看', 1115, 600, 'icon-search', '/reimburse/detailCurrent?id='+id+'&editType=1');
	win.window('open');
}
//打印
function exportcurrentHtml(id) {
	window.open(base+"/exportApplyAndReim/currentExprot?id="+ id);//事后报销单
}
/* $(function() {
	//定义双击事件
	$('#current_dg').datagrid({
		onDblClickRow : function(rowIndex, rowData) {
			detailDemo();
		}
	});
}); */
function current_query() {
	$("#current_dg").datagrid('load',{
		gCode:$("#reimburse_list_top_rCode_9").textbox('getValue').trim(),
		reqTime1:$("#reimburse_list_top_reqTime1_9").datebox('getValue').trim(),
		reqTime2:$("#reimburse_list_top_reqTime2_9").datebox('getValue').trim(),
		rFlowStauts:$("#reimburse_list_top_flowStauts_9").textbox('getValue').trim(),
	});
}
function detailDemo() {
	var row = $('#current_dg').datagrid('getSelected');
	var selections = $('#current_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		var win = creatWin('查看-合同拟定', 600, 600, 'icon-search',
				"/demo/detail/" + row.id);
		win.window('open');
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function plan(id) {
	var row = $('#current_dg').datagrid('getSelected');
	var selections = $('#current_dg').datagrid('getSelections');
	var win = creatWin(' ', 970, 580, 'icon-search',
			"/Enforcing/plan/" + id);
	win.window('open'); 
}
function deleteCF() {
	var row = $('#current_dg').datagrid('getSelected');
	var selections = $('#current_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Enforcing/delete/' + row.fcId,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$("#current_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function expListlawHelp() {
	//var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
	//win.window('open');
	if (confirm("按当前查询条件导出？")) {
		var queryForm = document.getElementById("lawHelp_list_form");
		queryForm.setAttribute("action", "${base}/demo/expList");
		queryForm.submit();
	}
}

//时间格式化
function ChangeDateFormatCurrent(val) {
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
		return "";
	}
	t = new Date(val);
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
</script>
</body>
</html>
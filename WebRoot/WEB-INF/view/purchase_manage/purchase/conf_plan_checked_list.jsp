<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">申请部门
						<input id="sq_check_freqDept" name="freqDept" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;采购类型&nbsp;
						<select class="easyui-combobox" id="sq_check_fprocurType" name="fprocurType"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
							<option value="">--请选择--</option>
							<option value="A10" >货物</option>
							<option value="A20" >工程采购</option>
							<option value="A30" >服务</option>
							<option value="A40" >办公用品及耗材</option>
						 </select>
						&nbsp;&nbsp;<a href="#" onclick="queryConfPlanCheck();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearConfPlanCheck();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>	
				</tr>
			</table> 
		</div>
		<div style="margin: 0 10px 0 10px;height: 340px;">	
			<table id="confplan_checked_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cgconfplan/confplanResolvePageData?status=0&secondIssuedStatus=1',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr >
						<th data-options="field:'fplId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'flistNum',align:'left'" width="25%">单据编号</th>
						<th data-options="field:'freqDept',align:'left'" width="17%">申请部门</th>
						<th data-options="field:'freqTime',align:'left',formatter:ChangeDateFormat" width="12%">申请日期</th>
						<th data-options="field:'fprocurType',align:'left',formatter:formatter_confleixing" width="11%">采购类型</th>
						<th data-options="field:'freqLinkMen',align:'left'" width="10%">联系人</th>
						<th data-options="field:'flinkTel',align:'left'" width="16%">联系电话</th>
						<th data-options="field:'operation',align:'left',formatter:format_confplan" width="5%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
		</div>
		<%-- <div class="win-left-bottom-div" style="text-align: center;">
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div> --%>
</div>

<script type="text/javascript">

//分页样式调整
$(document).ready(function() {
	$("#confplan_checked_tab").datagrid({
		 onDblClickRow:function(index, row){
			 var row = $('#confplan_checked_tab').datagrid('getSelected');
				var selections = $('#confplan_checked_tab').datagrid('getSelections');
				if (row != null && selections.length == 1) {
					$("#F_fplId").val(row.fplId);
					$("#F_fplCode").textbox('setValue', row.flistNum);
					$("#F_fpPype").combobox('setValue', row.fprocurType);
					$('#plan_dg').datagrid('reload',base+'/cgconfplangl/mingxi?id='+row.fplId);
					closeFirstWindow();
				} else {
					$.messager.alert('系统提示', '请选择一条数据！', 'info');
				} 
		 }
	});
});
//选择 选中数据  进行校验
function check(fplId,flistNum) {
	$("#F_fplId").val(fplId);
	$("#F_fpCode").textbox('setValue', flistNum);
	closeFirstWindow();
}
function formatter_confleixing(val,row){
	if (val == "A10") {
		return "货物";
	} else if (val == "A20") {
		return "工程采购" ;
	} else if (val == "A30") {
		return "服务";
	} else if (val == "A40") {
		return "办公用品及耗材";
	} 
	
}

//点击查询
function queryConfPlanCheck() {
	
	$('#confplan_checked_tab').datagrid('load',{
		freqDept : $('#sq_check_freqDept').textbox('getValue'),
		fprocurType : $('#sq_check_fprocurType').textbox('getValue')
	});
}
//清除查询条件
function clearConfPlanCheck() {
	$("#sq_check_freqDept").textbox('setValue','');
	$("#sq_check_fprocurType").combobox('setValue','');
	$('#confplan_checked_tab').datagrid('load',{//清空以后，重新查一次
	});
}
	
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}		
	
//操作栏创建
function format_confplan(val,row) {		
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="confplan_detail(' + row.fplId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td></tr></table>';
	
}
//查看
function confplan_detail(id) {
	var win = parent.creatWin(' ', 970, 580, 'icon-search',"/cgconfplan/detail?id=" + id);
	win.window('open'); 
} 
</script>
</body>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 ">
		<!-- 隐藏域 -->
		<!-- 申报类型  yssb:一上申报 ，essb:二上申报 -->
		<input type="hidden" id="cgconfplan_list_sblx" value="${sblx }" />
		<!-- 上报阶段  1：一上   2：二上 -->
		<input type="hidden" id="cgconfplan_list_freportStage" value="${freportStage }" />
	</div>
		
	<div class="list-top">
		<table id="confplan_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">采购计划编号&nbsp;
					<input id="cgconfplan_list_flistNum" name="flistNum" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="cgconfplan_list_freqDept" name="freqDept" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购类型&nbsp;
					<select class="easyui-combobox" id="cgconfplan_list_fprocurType" name="fprocurType"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="A10" >货物</option>
						<option value="A20" >工程</option>
						<option value="A30" >服务</option>
						<option value="A40" >办公用品及耗材</option>
					 </select>
					&nbsp;
					<a href="#" onclick="queryConfplan();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;
					<a href="#" onclick="clearConfplanTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>		
			</tr>
		</table>
	</div>
		
	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="confplan_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgconfplan/confplanPageData?freportStage=${freportStage }&sblx=${sblx }',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fplId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" width="5%">序号</th>
					<th data-options="field:'flistNum',align:'center'" width="13%">采购计划编号</th>
					<th data-options="field:'freqDept',align:'center'" width="10%">申请部门</th>
					<th data-options="field:'freqTime',align:'center',formatter:ChangeDateFormat" width="13%">申请日期</th>
					<th data-options="field:'fprocurType',align:'center',formatter:formatProcurType" width="12%">采购类型</th>
					<th data-options="field:'freqLinkMen',align:'center'" width="12%">申请人</th>
					<th data-options="field:'flinkTel',align:'center'" width="12%">联系电话</th>
					<th data-options="field:'fcheckStauts',align:'center',resizable:false,sortable:true,formatter:formatCheckStauts" style="width: 12%">审批状态</th>
					<th data-options="field:'operation',align:'center',formatter:format_confplan" width="12%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
//分页样式调整
$(document).ready(function() {
	var pager = $('#confplan_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});	
});

//点击查询
function queryConfplan() {
	$('#confplan_tab').datagrid('load', {
		flistNum : $('#cgconfplan_list_flistNum').textbox('getValue'),
		freqDept : $('#cgconfplan_list_freqDept').textbox('getValue'),
		fprocurType : $('#cgconfplan_list_fprocurType').textbox('getValue')
	});
}

//清除查询条件
function clearConfplanTable() {
	$('#cgconfplan_list_flistNum').textbox('setValue','');
	$('#cgconfplan_list_freqDept').textbox('setValue','');
	$('#cgconfplan_list_fprocurType').combobox('setValue','');
	$('#confplan_tab').datagrid('load',{//清空以后，重新查一次
	});
}

//采购类型
function formatProcurType(val,row){
	if(val == 'A10') {
		return '货物';
	}else if(val == 'A20') {
		return '工程';
	}else if(val == 'A30') {
		return '服务';
	}else if(val == 'A40') {
		return '办公用品及耗材';
	} 
}
	
//设置审批状态
function formatCheckStauts(val, row) {
	if(val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	}else if(val == -21) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
	}else if(val == 29) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
	}else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	}
}
	
//操作栏创建
function format_confplan(val, row) {	
	var c = row.fcheckStauts;
	if(c == 29 || c == 21) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="confplan_detail(' + row.fplId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a></td></tr></table>';
	}else if(c == 9 || c == -21) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="confplan_detail(' + row.fplId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="confplan_update(' + row.fplId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a></td></tr></table>';
	}			
}

//上报阶段
var reportStage = $('#cgconfplan_list_freportStage').val();

//查看
function confplan_detail(id) {
	var win = parent.creatWin('查看', 970, 580, 'icon-search', '/cgconfplan/secondDetail?id='+id);
	win.window('open'); 
}

//修改
function confplan_update(id) {
	var win = parent.creatWin('修改', 970, 580, 'icon-search', '/cgconfplan/secondEdit?fplId='+id+'&freportStage='+reportStage);
	win.window('open'); 
}

</script>
</body>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">项目名称&nbsp;
					<input id="pro_list_query_fproName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;项目编码&nbsp;
					<input id="pro_list_query_FProCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;支出类型&nbsp;
					<select id="pro_list_query_FProOrBasic" class="easyui-combobox" data-options="required:true,editable:false" name="FProOrBasic" style="height:25px; width: 150px;">
		     			<option value="">-请选择-</option>
		     			<option value="0">基本支出</option>
		     			<option value="1">项目支出</option>
		     		</select>
					&nbsp;
					<a href="#" onclick="queryProList();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;
					<a href="#" onclick="clearProList();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
		</table>   
	</div>

	<div class="list-table">
		<table id="choose_pro_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgconfplan/proLibTypePageData?FFlowStauts=11',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'center'" width="16%">项目编号</th>
						<th data-options="field:'fproName',align:'center',formatter:formatCellTooltip" width="20%">项目名称</th>
						<th data-options="field:'fproOrBasic',align:'center',formatter:transitionType" width="10%">支出类型</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">项目预算[万元]</th>
						<th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="10%">审批状态</th>
					</tr>
				</thead>
			</table>
	</div>
	<div style="text-align: left;height: 20px">
		<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击选择预算项目</span>
	</div>
</div>
<script type="text/javascript">
$('#choose_pro_dg').datagrid({
	onDblClickRow : function (rowIndex, rowData) {
		var proId = rowData.fproId;
		var win = parent.creatFirstWin('预算支出明细', 970, 580, 'icon-search', '/cgconfplan/probyExpend?FProId='+proId);
		win.window('open');
	}
	
});

function queryProList(){//查询
	$('#choose_pro_dg').datagrid('load',{
		FProName:$('#pro_list_query_fproName').textbox('getValue').trim(),
		FProCode:$('#pro_list_query_FProCode').textbox('getValue').trim(),
		FProOrBasic:$('#pro_list_query_FProOrBasic').combobox('getValue').trim(),
	});
}

function clearProList(){//清除
	$('#pro_list_query_fproName').textbox('setValue','');
	$('#pro_list_query_FProCode').textbox('setValue','');
	$('#pro_list_query_FProOrBasic').combobox('setValue','');
	queryProList();
}

function transitionType(val){
	if(val == 0){
		return '基本支出';
	}
	if(val == 1){
		return '项目支出';
	}
}

function format_fflowStauts(val, row){
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	} else if (val == 11) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	} else if (val == 12) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	} else if (val == 19) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
	} else if (val == -11) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
	}else if (val == -14) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
	}
}
</script>
</body>
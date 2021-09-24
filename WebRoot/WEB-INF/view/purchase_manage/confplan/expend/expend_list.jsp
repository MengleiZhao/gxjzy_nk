<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 ">
		<!-- 隐藏域 -->
		<input type="hidden" id="project_FProId" value="${FProId }" />
	</div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="reBack();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/fanhui1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
		</table>   
	</div>

	<div class="list-table">
		<table id="choose_expend_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgconfplan/probyExpendPageData?FProId=${FProId}',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'pid',hidden:true"></th>
						<th data-options="field:'activity',align:'center'" width="25%">具体业务</th>
						<th data-options="field:'subName',align:'center',formatter:formatCellTooltip" width="25%">经济分类科目</th>
						<th data-options="field:'outAmount',align:'center'" width="25%">支出金额(元)</th>
						<th data-options="field:'actDesc',align:'center'" width="25%">摘要</th>
					</tr>
				</thead>
			</table>
	</div>
	<div style="text-align: left;height: 20px">
		<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击选择支出明细</span>
		<input hidden="hidden" id="project_FProName" value="${FProName }">
	</div>
</div>
<script type="text/javascript">
$('#choose_expend_dg').datagrid({
	onDblClickRow : function (rowIndex, rowData) {
		var b = $('#project_FProName').val();
		$('#F_subName').textbox('setValue',(b+'-'+rowData.subName));//项目名称+明细名称
		$('#F_outAmount').numberbox('setValue',rowData.outAmount);//金额
		$('#F_pid').val(rowData.pid);//主键
		$('#F_expCode').val(rowData.expCode);//支出明细名称
		$('#F_subCode').val(rowData.subCode);//支出明细编码
		closeFirstWindow();
	}
});

//返回上一级
function reBack(){
	var win = parent.creatFirstWin('预算', 970, 580, 'icon-search', '/cgconfplan/probyProLibType');
	win.window('open');
}

function queryExpend(){//查询
	$('#choose_expend_dg').datagrid('load',{
		outAmount:$('#expend_list_query_outAmount').numberbox('getValue'),
		subName:$('#expend_list_query_subName').textbox('getValue').trim(),
	});
}
function clearExpend(){//清除
	$('#expend_list_query_outAmount').numbertbox('setValue','');
	$('#expend_list_query_subName').textbox('setValue','');
	queryProList();
}
</script>
</body>
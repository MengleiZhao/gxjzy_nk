<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search-pro">调出指标名称&nbsp;
					<input id="inside_check_indexNameOut" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;调入指标名称
					<input id="inside_check_indexNameIn" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="insideCheckquery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="insideCheckclearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>



	<div class="list-table">
		<table id="insideCheckTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/insideCheck/adjustPage?flowStauts=2',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'inId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'opUser',align:'center',resizable:false,sortable:true" style="width: 10%">操作人</th>
					<th data-options="field:'indexNameOut',align:'center',resizable:false,sortable:true" style="width: 15%">调出指标名称</th>
					<th data-options="field:'changeAmountOut',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 13%">调出金额[万元]</th>
					<th data-options="field:'indexNameIn',align:'center',resizable:false,sortable:true" style="width: 15%">调入指标名称</th>
					<th data-options="field:'changeAmountIn',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 13%">调入金额[万元]</th>
					<th data-options="field:'opTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">调整时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter: flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:nbtzspCZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
</div>
<script type="text/javascript">
	//点击查询
	function insideCheckquery() {
		//alert($('#apply_time').val());
		$('#insideCheckTab').datagrid('load', {
			indexNameOut:$('#inside_check_indexNameOut').val(),
			indexNameIn:$('#inside_check_indexNameIn').val(),
		});
	}
	//清除查询条件
	function insideCheckclearTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#inside_check_indexNameOut").textbox('setValue','');
		$("#inside_check_indexNameIn").textbox('setValue','');
		$('#insideCheckTab').datagrid('load',{//清空以后，重新查一次
		});
	}
	
	//操作栏创建
	function nbtzspCZ(val, row) {
		if (row.flowStauts == 9 ) {
			return null;
		}else {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="checkInside(' + row.inId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
					'</a></td></tr></table>';
		}
	}
	
	//审批页面跳转
	function checkInside(id) {
		var win = creatWin('审批', 970, 580, 'icon-search', "/insideCheck/check?id="+ id);
		win.window('open');
	}
	
	//设置审批状态
	function flowStautsSet(val, row) {
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
</script>
</body>


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
					<input id="inside_indexNameOut" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;调入指标名称
					<input id="inside_indexNameIn" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;审批状态&nbsp;
					 <select class="easyui-combobox" id="inside_flowStauts" name=""  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="0" >暂存</option>
						<option value="-1" >已退回</option>
						<option value="9" >已审批</option>
						<option value="2" >待审批</option>
					 </select>
					&nbsp;&nbsp;<a href="#" onclick="query();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addInsideAdjust()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>



	<div class="list-table">
		<table id="insideTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/insideAdjust/adjustPage',
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
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
</div>
<script type="text/javascript">
	//操作栏创建
	function CZ(val, row) {
		var c = row.flowStauts;
		if (c == 9 ) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="detailinsideAdjust(' + row.inId + ')" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
		} else if(c == 0 || c == -1 || c == -4) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="detailinsideAdjust(' + row.inId + ')" class="easyui-linkbutton">'+
			   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   		'</a>'+ '</td><td style="width: 25px">'+
					'<a href="#" onclick="editinsideAdjust(' + row.inId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="deleteInside(' + row.inId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a></td></tr></table>';
		} else if(c == 1 || c == 2){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="detailinsideAdjust(' + row.inId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
			   '<a href="#" onclick="reCall(\'insideTab\',' + row.inId + ',\'/insideAdjust/reCall\')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			   '</a></td></tr></table>';
		}
	}
	//修改
	function editinsideAdjust(id) {
		var win = creatWin('内部调整-修改', 970, 580, 'icon-search', '/insideAdjust/edit?id='+id);
		win.window('open');
	}
	
	//查看
	function detailinsideAdjust(id)	{
		var win = creatWin('内部调整明细', 970, 580, 'icon-search', '/insideAdjust/detail?id='+id);
		win.window('open');
	}
	
	//新增页面
	function addInsideAdjust() {
		var win = creatWin('内部调整-新增', 985, 590, 'icon-search', '/insideAdjust/add');
		win.window('open');
	}
	
	//点击查询
	function query() {
		//alert($('#apply_time').val());
		$('#insideTab').datagrid('load', {
			indexNameOut:$('#inside_indexNameOut').val(),
			indexNameIn:$('#inside_indexNameIn').val(),
			flowStauts:$('#inside_flowStauts').val()
		});
	}
	//清除查询条件
	function clearTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#inside_indexNameOut").textbox('setValue','');
		$("#inside_indexNameIn").textbox('setValue','');
		$("#inside_flowStauts").combobox('setValue','');
		$('#insideTab').datagrid('load',{//清空以后，重新查一次
		});
	}
	//设置审批状态
	function flowStautsSet(val, row) {
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
		} else if (val == -4) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
		}
	}
	//删除
	function deleteInside(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/insideAdjust/delete?id=' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#insideTab').datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
</script>
</body>


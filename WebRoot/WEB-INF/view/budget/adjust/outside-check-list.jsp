<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>


<body style="background-color: #f0f5f7;text-align: center;">
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search-pro">指标名称&nbsp;
					<input id="outside_check_indexName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;调整金额&nbsp;
					<input id="outside_check_changeAmountBegin"  name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
					&nbsp;-&nbsp;
					<input id="outside_check_changeAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" class="easyui-numberbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="outsidecheckquery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="outsidecheckclearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
			</table>   
		</div>



	<div class="list-table">
		<table id="outsideCheckTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/outsideCheck/adjustPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'aId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'opUser',align:'left',resizable:false,sortable:true" style="width: 10%">操作人</th>
					<th data-options="field:'indexName',align:'left',resizable:false,sortable:true" style="width: 25%">调整指标名称</th>
					<th data-options="field:'changeAmount',align:'left',resizable:false,sortable:true" style="width: 10%">调整金额[万元]</th>
					<th data-options="field:'opTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">调整时间</th>
					<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 25%">审批状态</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
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
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	if (c == 9 ) {
		return null;
	} else {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="checkOutside(' + row.aId + ',1)" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
				'</a></td></tr></table>';
	}
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/check1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/check2.png';
}

//审批页面跳转
function checkOutside(id) {
	var win = creatWin(' ', 970, 580, 'icon-search', "/outsideCheck/check?id="+ id);
	win.window('open');
}

//点击查询
function outsidecheckquery() {
	//alert($('#apply_time').val());
	$('#outsideCheckTab').datagrid('load', {
		indexName:$('#outside_check_indexName').val(),
		changeAmountBegin:$('#outside_check_changeAmountBegin').val(),
		changeAmountEnd:$('#outside_check_changeAmountEnd').val(),
	});
}
//清除查询条件
function outsidecheckclearTable() {
	/* $(".topTable :input[type='text']").each(function(){
		$(this).val("a");
	}); */
	$("#outside_check_indexName").textbox('setValue','');
	$("#outside_check__changeAmountBegin").textbox('setValue','');
	$("#outside_check_changeAmountEnd").textbox('setValue','');
	$('#outsideCheckTab').datagrid('load',{//清空以后，重新查一次
	});
}

</script>
</body>



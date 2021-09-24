<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>

<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
</style>

</head>
<body style="background-color: #f0f5f7;text-align: center;">

	<div style="height: 10px;background-color:#f0f5f7 ">
	</div>

	<div class="tabletop">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
				<td style="width: 80px;">&nbsp;&nbsp;&nbsp;&nbsp;申请时间：</td> 
				<td style="width: 140px">
					<input id="apply_reqTime" name=""  style="width: 150px;height:25px;" class="easyui-datebox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryApply();">
						<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td>
					<a href="#" onclick="clearTable();">
						<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
				
		</table>   
	</div>



	<div style="margin: 0 10px 0 10px;height: 320px;">
		<table id="applyLedgerTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/applyLedger/reimburseList?applyType=${applyType}',
		method:'post',fit:true,pagination:false,singleSelect: true,onDblClickRow:choiceApplyCZ,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'gId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 6%">序号</th>
					<th data-options="field:'gCode',align:'center',resizable:false,sortable:true" style="width: 25%">申请单编号</th>
					<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 15%">申请事项</th>
					<th data-options="field:'gName',align:'center',resizable:false,sortable:true" style="width: 15%">申请摘要名称</th>
					<th data-options="field:'amount',align:'center',resizable:false,sortable:true" style="width: 15%">申请总金额</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:reimburseApplyCZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>



<script type="text/javascript">

	//设置申请事项
	function typeSet(val, row) {
		if (val == 1) {
			return '<span>' + "通用事项申请" + '</span>';
		} else if (val == 2) {
			return '<span>' + "会议申请" + '</span>';
		} else if (val == 3) {
			return '<span>' + "培训申请" + '</span>';
		} else if (val == 4) {
			return '<span>' + "差旅申请" + '</span>';
		} else if (val == 5) {
			return '<span>' + "公务接待申请" + '</span>';
		} else if (val = 6) {
			return '<span>' + "公务用车申请" + '</span>';
		} else if (bal = 7) {
			return '<span>' + "公务出国申请" + '</span>';
		}
	}
	
	
	//操作栏创建
	function reimburseApplyCZ(val, row) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editApply(' + row.gId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
	
	}
	
	//修改
	function editApply(id) {
		var win = creatWin(' ', 1075, 580, 'icon-search', "/apply/edit?id="+ id+"&editType=0");
		win.window('open');
	}

	//双击选择
	function choiceApplyCZ(val, row) {
		choiceApply(row.gId,${applyType});

	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}

	
	//查询
	function queryApply() {
		$('#applyLedgerTab').datagrid('load',{ 
			reqTime:$('#apply_reqTime').datebox('getValue'),
		}); 
	}
	//清除查询条件
	function clearTable() {
		$("#apply_reqTime").datebox('setValue','');
		queryApply();
	}



</script>
</body>
</html>


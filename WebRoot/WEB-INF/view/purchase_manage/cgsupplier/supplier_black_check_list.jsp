<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="supplier_check_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">供应商编码&nbsp;
				<input id="supplier_ck_fwCode" name="fwCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;供应商名称
				<input id="supplier_ck_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;<a href="#" onclick="queryCKSupplier();">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="#" onclick="clearCKSupplierTable();">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</td>
			</tr>
		</table>
	</div>
		
		
		
	<div class="list-table">	
		<table id="balck_check" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliercheck/supplierCheckPageData',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="6%">序号</th>
						<th data-options="field:'fwCode',align:'center',formatter:formatCellTooltip" width="14%">供应商编码</th>
						<th data-options="field:'fwName',align:'center',formatter:formatCellTooltip" width="16%">供应商名称</th>
						<th data-options="field:'fwuserName',align:'center'" width="6%">联系人</th>
						<th data-options="field:'fblackTime',align:'center',formatter: ChangeDateFormat" width="10%">移入黑名单时间</th>
						<th data-options="field:'faccFreq',align:'right'" width="10%">累计移入黑名单次数</th>
						<th data-options="field:'fopName',align:'center'" width="6%">操作人</th>
						<th data-options="field:'fblackDesc',align:'center',formatter:formatCellTooltip" width="16%">移入黑名单原因</th>
						<th data-options="field:'fCheckStatus',align:'center',resizable:false,sortable:true,formatter:formatCkstauts" style="width:8%">审批状态</th> 
						<th data-options="field:'operation',align:'left',formatter:format_CKsupplier" width="8%">操作</th>
				</tr>
				</thead>
			</table>
	</div>
</div>

	<script type="text/javascript">
	
	
	
	//点击查询
	function queryCKSupplier() {
		//alert($('#apply_time').val());
		$('#balck_check').datagrid('load', {
			fwCode:$('#supplier_ck_fwCode').val(),
			fwName:$('#supplier_ck_fwName').val()
		});
	}
	//清除查询条件
	function clearCKSupplierTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#supplier_ck_fwCode").textbox('setValue','');
		$("#supplier_ck_fwName").textbox('setValue','');
		$('#balck_check').datagrid('load',{//清空以后，重新查一次
		});
	}
	

	
	//设置审批状态
	var c;
	function formatCkstauts(val, row) {
		c = val;
		if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}

	//操作栏创建
	function format_CKsupplier(val, row) {
		if (c == 9 ) {
			return null;
		} else {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="checkSupplierApply(' + row.fwId + ')" class="easyui-linkbutton">'+
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
	
	//跳转审批页面
	function checkSupplierApply(id) {
		var win = creatWin(' ', 970, 580, 'icon-search', "/suppliercheck/checkBlack?id="+ id);
		win.window('open');
	}

	//鼠标悬浮单元格提示信息  
	function formatCellTooltip(value){  
	    return "<span title='" + value + "'>" + value + "</span>";  
	}  
	</script>
</body>


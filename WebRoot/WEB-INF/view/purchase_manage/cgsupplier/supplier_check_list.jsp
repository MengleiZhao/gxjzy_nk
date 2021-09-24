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
		<table id="check_supplier" 
			data-options="collapsible:true,url:'${base}/suppliercheck/supplierCheckPageData',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fwId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" width="5%">序号</th>
					<th data-options="field:'fwCode',align:'center'" width="12%">供应商编码</th>
					<th data-options="field:'fwName',align:'center'" width="15%">供应商名称</th>
					<!-- <th data-options="field:'fwAddr',align:'left'" width="15%">办公地址</th> -->
					<th data-options="field:'fregistCapital',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">注册资本[元]</th>
					<th data-options="field:'findustry',align:'center'" width="12%">行业</th>
					<th data-options="field:'fLegalRep',align:'center'" width="10%">法人代表</th>
					<th data-options="field:'festablistDate',align:'center',formatter:ChangeDateFormat" width="12%">成立日期</th>
					<th data-options="field:'fcheckType',align:'center',formatter:format_checkType" width="8%">审批类型</th>
					<th data-options="field:'fcheckStauts',align:'center',resizable:false,sortable:true,formatter:formatCkstauts" style="width: 8%">审批状态</th>
					<th data-options="field:'operation',align:'left',formatter:format_CKsupplier" width="8%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

	<script type="text/javascript">
	//审批类型
	function format_checkType(val,row){
		//入库
		if(val=="in"){
			return "入库审批";
		}else if(val=="out"){
		//出库
			return "出库审批";
		}else if(val=="black"){
		//黑名单
			t="black";
			return "黑名单审批";
		}else{
			return "无";
		}
	}
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#check_supplier').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	function queryCKSupplier() {
		//alert($('#apply_time').val());
		$('#check_supplier').datagrid('load', {
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
		$('#check_supplier').datagrid('load',{//清空以后，重新查一次
		});
	}
	

	
	//设置审批状态
	function formatCkstauts(val, row) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	}

	//操作栏创建
	function format_CKsupplier(val, row) {
		var checkType=row.fcheckType;
		if(row.fcheckType=="in" && row.fcheckStauts==9 && row.fisOutStatus!=9){
			checkType="out";
		}
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="checkSupplierApply(' + row.fwId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
				'</a></td></tr></table>';
	}
	
	//跳转审批页面
	function checkSupplierApply(id,checkType) {
		var win = creatWin(' ', 970, 580, 'icon-search', "/suppliercheck/check?id="+ id+"&checkType="+checkType);
		win.window('open');
	}


	</script>
</body>


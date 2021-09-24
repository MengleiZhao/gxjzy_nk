<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="supplier_count_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">供应商编码&nbsp;
					<input id="supplier_count_fwCode" name="fwCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;供应商名称
					<input id="supplier_count_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryCountSupplier();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCountSupplierTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addSupplier()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="count_supplier_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliergl/cgselPage',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fwCode',align:'left'" width="10%">供应商编码</th>
						<th data-options="field:'fwName',align:'left'" width="12%">供应商名称</th>
						<th data-options="field:'fwAddr',align:'left'" width="15%">办公地址</th>
						<th data-options="field:'fwuserName',align:'left'" width="7%">联系人</th>
						<th data-options="field:'fwTel',align:'left'" width="10%">联系电话</th>
						<th data-options="field:'fpayeeName',align:'left'" width="7%">收款人</th>
						<th data-options="field:'fpayeeBank',align:'left'" width="12%">开户行</th>
						<th data-options="field:'fcheckStauts',align:'left',resizable:false,sortable:true,formatter:formatPrice" style="width: 12%">审批状态</th>
						<th data-options="field:'operation',align:'left',formatter:format_supplierCount" width="10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#count_supplier_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	function queryCountSupplier() {
		//alert($('#apply_time').val());
		$('#count_supplier_tab').datagrid('load', {
			fwCode:$('#supplier_count_fwCode').val(),
			fwName:$('#supplier_count_fwName').val()
		});
	}
	//清除查询条件
	function clearCountSupplierTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#supplier_count_fwCode").textbox('setValue','');
		$("#supplier_count_fwName").textbox('setValue','');
		$('#count_supplier_tab').datagrid('load',{//清空以后，重新查一次
		});
	}


	//设置审批状态
	var c;
	function formatPrice(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}
	
	//操作栏创建
	function format_supplierCount(val,row) {		
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="count_supplier_detail(' + row.fwId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}

	
	 //查看
	 function count_supplier_detail(id) {
		var win = parent.creatWin('供应商统计信息 ', 970, 580, 'icon-search',"/suppliercount/echart?id=" + id);
		win.window('open'); 
	} 

	
	
	</script>
</body>


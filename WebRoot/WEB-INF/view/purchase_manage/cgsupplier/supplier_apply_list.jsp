<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="white_SUP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">供应商编码&nbsp;
					<input id="supplier_apply_fwCode" name="fwCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;供应商名称
					<input id="supplier_apply_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="querySupplier();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearWhiteTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="apply_supplier" 
				data-options="collapsible:true,url:'${base}/suppliergl/supplierPageData?fcheckType=${checkType}',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fwCode',align:'center'" width="20%">供应商编码</th>
						<th data-options="field:'fwName',align:'center',formatter:formatCellTooltip" width="25%">供应商名称</th>
						<th data-options="field:'findustry',align:'center',formatter:formatCellTooltip" width="14%">行业</th>
						<th data-options="field:'fLegalRep',align:'center'" width="10%">法人代表</th>
						<th data-options="field:'festablistDate',align:'center',formatter:ChangeDateFormat" width="12%">成立日期</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="13%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>
</div>

	<script type="text/javascript">
	
	$('#apply_supplier').datagrid({
		onDblClickRow :function (rowIndex ,rowData){
			var t='${checkType}';
			if(t=="in"){
				var win =parent.creatWin(' ',750, 480, 'icon-search',"/supplierglOut/outJsp?id=" + rowData.fwId+"&type=2");
				win.window('open'); 
			}else if(t=="out"){
				var win =parent.creatWin(' ',750, 480, 'icon-search',"/supplierglOut/outJsp?id=" + rowData.fwId+"&type=1");
				win.window('open'); 
			}else if(t=="black"){
				var win =parent.creatWin(' ',750, 480, 'icon-search',"/blacksuppliergl/inblack?id=" + rowData.fwId);
				win.window('open'); 
			}
			
		}
		
	});
	
	//点击查询
	function querySupplier() {
		alert($('#supplier_apply_fwName').val());
		$('#apply_supplier').datagrid('load', {
			fwCode:$('#supplier_apply_fwCode').val(),
			fwName:$('#supplier_apply_fwName').val()
		});
	}
	//清除查询条件
	function clearWhiteTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#supplier_apply_fwCode").textbox('setValue','');
		$("#supplier_apply_fwName").textbox('setValue','');
		$('#apply_supplier').datagrid('load',{//清空以后，重新查一次
		});
	}

	
	//操作栏创建
	function method_operation(val,row) {
		var checkType=row.fcheckType;
		if(row.fcheckType=="in" && row.fcheckStauts==9 && row.fisOutStatus!=9 && row.fisOutStatus!=0){
			checkType="out";
		}
		var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="supplier_detail_lend(' + row.fwId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
   		'</a>'+ '</td><td style="width: 25px">'+
		'<a href="#" onclick="count_supplier_detail(' + row.fwId + ')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/countsup1.png">'+
   		'</a>'+ '</td><td style="width: 25px">'+
		'<a href="#" onclick="tr_his_discuss(' + row.fwId + ')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/watcheval1.png">'+
   		'</a></td>';
		//alert(row.fcheckType+"---"+row.fisOutStatus+"---"+row.fisBlackStatus+"---"+row.fcheckStauts);
		//在库
		return 	str+ '</tr></table>';
	}

	 //查看
	 function supplier_detail_lend(id,checkType) {
		var win = parent.creatWin(' ', 970, 580, 'icon-search',"/suppliergl/detail?checkType="+checkType+"&id=" + id);
		win.window('open'); 
	} 
	 //统计
	 function count_supplier_detail(id) {
		var win = parent.creatWin('供应商统计信息 ', 970, 580, 'icon-search',"/suppliercount/echart?id=" + id);
		win.window('open'); 
	} 
	 //评价
	 function tr_his_discuss(id) {
		var win = parent.creatWin(' 历史成交信息', 970, 580, 'icon-search',"/evalsupplier/seeEvalSupplierList?id=" + id);
		win.window('open'); 
	} 
	</script>
</body>


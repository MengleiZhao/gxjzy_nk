<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="white_SUP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">
					供应商名称
					<input id="supplier_white_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;行业
					<input id="supplier_white_findustry" name="findustry" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;注册资本&nbsp;
					<input id="supplier_white_amount_a" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" validType="numberBegin[supplier_white_amount_b]"  class="easyui-numberbox"></input>
					&nbsp;-&nbsp;
					<input id="supplier_white_amount_b" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2"   class="easyui-numberbox"></input>
					&nbsp;&nbsp;供应商状态
					<select class="easyui-combobox" id="supplier_fcheckType" name="fcheckType"  style="width: 120px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="in" >在库</option>
						<option value="out">已出库</option>
						<option value="black" >黑名单</option>
					 </select>	
					&nbsp;&nbsp;<a href="#" onclick="queryWhite();">
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
			<table id="white_supplier" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliergl/whitesupPage',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fwCode',align:'center'" width="14%">供应商编码</th>
						<th data-options="field:'fwName',align:'center',formatter:formatCellTooltip" width="16%">供应商名称</th>
						<!-- <th data-options="field:'fwAddr',align:'left'" width="15%">办公地址</th> -->
						<th data-options="field:'fregistCapital',align:'right'" width="10%">注册资本[元]</th>
						<th data-options="field:'findustry',align:'center',formatter:formatCellTooltip" width="12%">行业</th>
						<th data-options="field:'fLegalRep',align:'center'" width="8%">法人代表</th>
						<th data-options="field:'festablistDate',align:'center',formatter:ChangeDateFormat" width="12%">成立日期</th>
						<th data-options="field:'fcheckType',align:'center',resizable:false,sortable:true,formatter:formatStauts" style="width: 10%">供应商状态</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="13%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
</div>

	<script type="text/javascript">
	
	//点击查询
	function queryWhite() {
		//alert($('#apply_time').val());
		$('#white_supplier').datagrid('load', {
			fwName:$('#supplier_white_fwName').val(),
			findustry:$('#supplier_white_findustry').val(),
			fcheckType:$('#supplier_fcheckType').val(),
			amounta:$('#supplier_white_amount_a').val(),
			amountb:$('#supplier_white_amount_b').val()
		});
	}
	//清除查询条件
	function clearWhiteTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#supplier_white_fwName").textbox('setValue','');
		$("#supplier_white_findustry").textbox('setValue','');
		$("#supplier_fcheckType").combobox('setValue','');
		$("#supplier_white_amount_a").textbox('setValue','');
		$("#supplier_white_amount_b").textbox('setValue','');
		$('#white_supplier').datagrid('load',{//清空以后，重新查一次
		});
	}

	//设置供应商状态
	function formatStauts(val, row) {
		if (val == "out") {
			if(row.fisOutStatus==9 || row.fisOutStatus==-2){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 已出库" + '</a>';
			}
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 出库中" + '</a>';
		} else if (val == "black") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 黑名单" + '</a>';
		}
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 在库" + '</a>';
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
		//显示查看和移除黑名单按钮 
		if(row.fcheckType=="black" && row.fisBlackStatus==9){
			return str+'<td style="width: 25px"><a href="#" onclick="OUT_BLACK(' + row.fwId + ')" class="easyui-linkbutton">'+
		       '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/outblack1.png">'+
		       '</a></td></tr></table>';
     //显示查看和出库按钮 
		}else if(row.fcheckType=="out" && (row.fisOutStatus==-2||row.fisOutStatus==9 )){
				return  str+'<td style="width: 25px"><a href="#" onclick="inOut_suppliers(' + row.fwId + ','+"2"+')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ruku1.png">'+
					'</a></td></tr></table>';
		}
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
	//供应商出入库
	function inOut_suppliers(id,type) {
		var win =parent.creatWin(' ', 810, 580, 'icon-search',"/supplierglOut/outJsp?id=" + id+"&type="+type);
		win.window('open'); 
  	}
	//移出黑名单
	function OUT_BLACK(id) {
		var win =parent.creatWin(' ', 540, 300, 'icon-search',"/blacksuppliergl/moveoutblack?id=" + id);
		win.window('open'); 
  	}
	</script>
</body>


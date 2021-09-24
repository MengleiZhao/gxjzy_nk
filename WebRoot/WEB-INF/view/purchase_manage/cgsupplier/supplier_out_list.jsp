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
		
		
		<!-- //获取list错误 添加白名单 -->
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="black_supplier" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliergl/whitesupPage?fwRemark=out',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fwCode',align:'left'" width="15%">供应商编码</th>
						<th data-options="field:'fwName',align:'left'" width="15%">供应商名称</th>
						<!-- <th data-options="field:'fwAddr',align:'left'" width="15%">办公地址</th> -->
						<th data-options="field:'fregistCapital',align:'left'" width="12%">注册资本[元]</th>
						<th data-options="field:'findustry',align:'left'" width="12%">行业</th>
						<th data-options="field:'fLegalRep',align:'left'" width="10%">法人代表</th>
						<th data-options="field:'festablistDate',align:'left',formatter:ChangeDateFormat" width="12%">成立日期</th>
						<!-- <th data-options="field:'fcheckStauts',align:'left',resizable:false,sortable:true,formatter:formatPrice" style="width: 6%">审批状态</th> -->
						<th data-options="field:'fcheckType',align:'left',resizable:false,sortable:true,formatter:formatStauts" style="width: 10%">供应商状态</th>
						<th data-options="field:'operation',align:'left',formatter:format_operation" width="8%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	
	
	
	//点击查询
	function queryWhite() {
		//alert($('#apply_time').val());
		$('#black_supplier').datagrid('load', {
			fwName:$('#supplier_white_fwName').val(),
			findustry:$('#supplier_white_findustry').val(),
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
		$("#supplier_white_amount_a").textbox('setValue','');
		$("#supplier_white_amount_b").textbox('setValue','');
		$('#black_supplier').datagrid('load',{//清空以后，重新查一次
		});
	}

	//设置审批状态
	function formatStauts(val, row) {
		if (val == "out" && row.fisOutStatus==9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 已出库" + '</a>';
		} else if (val == "out" && row.fisOutStatus==-1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		}else if (val == "out" && row.fisOutStatus==1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 待审批" + '</a>';
		}
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 在库" + '</a>';
		
	}
	
	//操作栏创建
	function format_operation(val,row) {
		//显示查看和出库按钮 
		if((row.fcheckType=="out" && row.fisOutStatus==-1) || (row.fcheckType=="in" && row.fcheckStauts==9)){
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="supplier_detail_lend(' + row.fwId + ')" class="easyui-linkbutton">'+
	   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	   		'</a>'+ '</td><td style="width: 25px">'+
			'<a href="#" onclick="out_suppliers(' + row.fwId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="showY(this)" onmouseout="showX(this)" src="'+base+'/resource-modality/${themenurl}/list/inblack1.png">'+
			'</a></td></tr></table>';
		}
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="supplier_detail_lend(' + row.fwId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td></tr></table>';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/countsup1.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/countsup2.png';
	}
	function showE(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/watcheval1.png';
	}
	function showF(obj){
		obj.src=base+'/resource-modality/${themenurl}/watcheval2.png';
	}
	function showX(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/inblack1.png';
	}
	function showY(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/inblack2.png';
	}

	 //查看
	 function supplier_detail_lend(id) {
		var win = parent.creatWin(' ', 970, 580, 'icon-search',"/suppliergl/detail?id=" + id+"&type=black");
		win.window('open'); 
	} 

	//供应商出库
	function out_suppliers(id) {
		var win =parent.creatWin(' ', 810, 580, 'icon-search',"/supplierglOut/outJsp?id=" + id);
		win.window('open'); 
  	}
	</script>
</body>


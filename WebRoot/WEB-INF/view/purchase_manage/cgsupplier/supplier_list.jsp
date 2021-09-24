<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="SUP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" style="width:70%;">供应商编码&nbsp;
					<input id="supplier_fwCode" name="fwCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;供应商名称
					<input id="supplier_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;
					<a href="#" onclick="querySupplier();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearSupplierTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addSupplier()">
						<img src="${base}/resource-modality/${themenurl}/button/rksq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;<a href="#" onclick="supplierApply('out')">
						<img src="${base}/resource-modality/${themenurl}/button/cksq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;<a href="#" onclick="supplierApply('black')">
						<img src="${base}/resource-modality/${themenurl}/button/hmdsq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="supplier_data_tb" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliergl/supplierPageData?fcheckStauts=1',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fwCode',align:'center'" width="15%">供应商编码</th>
						<th data-options="field:'fwName',align:'center',formatter:formatCellTooltip" width="10%">供应商名称</th>
						<!-- <th data-options="field:'fwAddr',align:'left'" width="15%">办公地址</th> -->
						<th data-options="field:'fregistCapital',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">注册资本[元]</th>
						<th data-options="field:'findustry',align:'center'" width="10%">行业</th>
						<th data-options="field:'fLegalRep',align:'center'" width="10%">法人代表</th>
						<th data-options="field:'festablistDate',align:'center',formatter:ChangeDateFormat" width="10%">成立日期</th>
						<th data-options="field:'fcheckType',align:'center',resizable:false,sortable:true,formatter:formatStauts" style="width: 10%">操作类型</th>
						<th data-options="field:'fcheckStauts',align:'center',resizable:false,sortable:true,formatter:checkStatus" style="width: 10%">审批状态</th>
						<th data-options="field:'operation',align:'center',formatter:method_operation" width="10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	//申请
	function supplierApply(checkType){
		var win=creatFirstWin('选择-供应商',800,580,' ','/suppliergl/supplierApply?checkType='+checkType);
		win.window('open');
	}
	
	//点击查询
	function querySupplier() {
		//alert($('#apply_time').val());
		$('#supplier_data_tb').datagrid('load', {
			fwCode:$('#supplier_fwCode').val(),
			fwName:$('#supplier_fwName').val()
		});
	}
	//清除查询条件
	function clearSupplierTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#supplier_fwCode").textbox('setValue','');
		$("#supplier_fwName").textbox('setValue','');
		$('#supplier_data_tb').datagrid('load',{//清空以后，重新查一次
		});
	}


	//设置操作类型
	function formatStauts(val, row) {
		//(row.fisBlackStatus== -1 && row.fisOutStatus==0)||row.fisOutStatus== -1)
		if (val == "out") {
			if(row.fisOutStatus==-2){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 入库申请" + '</a>';
			}
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 出库申请" + '</a>';
		} else if (val == "black") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 黑名单申请" + '</a>';
		}else{
			if(row.fcheckStauts==0){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 暂存" + '</a>';
			}else if(row.fisBlackStatus== -1){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 黑名单申请" + '</a>';
			}else if(row.fisOutStatus== -1){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 出库申请" + '</a>';
			}
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 入库申请" + '</a>';
		}
	}
	function checkStatus(val,row){
		if (row.fcheckType == "out") {
			if(row.fisOutStatus==9){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
			}else if (row.fisOutStatus==-2) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
			}else if(row.fisOutStatus== -4 ) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
			}else{
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
			}
		}else if (row.fcheckType == "black") {
			if(row.fisBlackStatus==9){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
			}else if(row.fisBlackStatus== -4) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
			}else{
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
			}
		}else{
			if(row.fisBlackStatus== -1 ||row.fisOutStatus== -1 || row.fcheckStauts==-1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
			}else if(row.fisBlackStatus== -4 ||row.fisOutStatus== -4 || row.fcheckStauts==-4) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
			}else if(row.fisOutStatus== 1||row.fcheckStauts==1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
			}else if(row.fcheckStauts==0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
			}else{
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
			}
		}
	}
	
	//操作栏创建
	function method_operation(val,row) {
		var checkType=row.fcheckType;
		
		if(row.fcheckType=="in" && row.fcheckStauts==9){
			if(row.fisOutStatus==-2 || row.fisOutStatus==-1){	//-1：出库被退回;-2：入库被退回
				checkType="out";
			}else if(row.fisBlackStatus==-1){
				//黑名单移入被退回
				checkType="black";
			}	
		}
		
		var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="supplier_detail(' + row.fwId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
   		'</a></td>';
   		//撤回按钮
		var inRecall='<td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'supplier_data_tb\',' + row.fwId + ',\'/suppliercheck/inRecall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td>';
		var outRecall='<td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'supplier_data_tb\',' + row.fwId + ',\'/suppliercheck/outRecall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td>';
		var blackRecall='<td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'supplier_data_tb\',' + row.fwId + ',\'/suppliercheck/blackRecall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td>';
		//alert(row.fcheckType+"---|"+row.fisOutStatus+"---|"+row.fisBlackStatus+"---|"+row.fcheckStauts);
		//显示查看和出库按钮 
		if(row.fcheckType=="out"){
			if(row.fisOutStatus==-2){//出库后再入库被退回
				// 查看、修改（重新申请）、删除入库记录
				return str+'<td style="width: 25px">'+
				'<a href="#" onclick="inOut_suppliers(' + row.fwId + ','+"2"+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="supplier_delete(' + row.fwId + ',\''+row.fcheckType+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
			}
		}else if(row.fcheckType=="in" ){
			var t=""; //类型 t=checktype
			if(row.fisOutStatus==-1){
				t="out";
				//出库被退回，     查看、修改（重新申请）、删除出库记录
				return str+'<td style="width: 25px">'+
				'<a href="#" onclick="inOut_suppliers(' + row.fwId + ','+"1"+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="supplier_delete(' + row.fwId + ',\''+t+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
			}else if(row.fisBlackStatus==-1){
				t="black";
				//移入黑名单被退回     查看、修改（重新申请）、删除黑名单记录
				return str+'<td style="width: 25px">'+
				'<a href="#" onclick="IN_BLACK(' + row.fwId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="supplier_delete(' + row.fwId + ',\''+t+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
			}else if(row.fcheckStauts==1){
				//待审批 只查看、撤回
				return 	str+inRecall+'</tr></table>';
			}else if(row.fisOutStatus==1){
				//待审批 只查看、撤回
				return 	str+outRecall+'</tr></table>';
			}else if(row.fisBlackStatus==1){
				//待审批 只查看、撤回
				return 	str+blackRecall+'</tr></table>';
			}else if(row.fcheckStauts==9){
				return 	str+ '</tr></table>';
			}else{
					//暂存
				t="in";
				return str+'<td style="width: 25px">'+
				'<a href="#" onclick="supplier_update(' + row.fwId + ',\''+t+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="supplier_delete(' + row.fwId + ',\''+t+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
			}
		}
		//在库
		return 	str+ '</tr></table>';
	}
	
	//新增页面
	function addSupplier() {
		var win = parent.creatWin('新增', 970, 580, 'icon-search', '/suppliergl/add');
		win.window('open');
	}
	
	 //查看
	 function supplier_detail(id,checkType) {
		var win = parent.creatWin(' ', 970, 580, 'icon-search',"/suppliergl/detail?checkType="+checkType+"&id=" + id);
		win.window('open'); 
	} 
	//修改
	function supplier_update(id,checkType) {
		var win =parent.creatWin(' ', 970, 580, 'icon-search',"/suppliergl/edit?id=" + id+"&checkType="+checkType);
		win.window('open'); 
  }
	//供应商出库
	function inOut_suppliers(id,type) {
		var win =parent.creatWin(' ',750, 480, 'icon-search',"/supplierglOut/outJsp?id=" + id+"&type="+type);
		win.window('open'); 
  	}
	 
	//移入黑名单
	function IN_BLACK(id) {
		var win =parent.creatWin(' ',750, 480, 'icon-search',"/blacksuppliergl/inblack?id=" + id);
		win.window('open'); 
  	}

	 //删除
	function supplier_delete(id,checkType) {
		if (confirm("确认删除吗？")) {
			var url="";
			if(checkType=="in"){
				url='${base}/suppliergl/delete?id='+id;
			}else if(checkType=="out"){
				url='${base}/supplierglOut/deleteOut?fwId='+id;
			}else if(checkType=="black"){
				url='${base}/blacksuppliergl/deleteBlack?fwId='+id;
			}
			$.ajax({
				type : 'POST',
				url : url,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#supplier_data_tb').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	
	
	</script>
</body>


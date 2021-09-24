<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" class="queryth">资产新增单号&nbsp;
						<input id="storage_fixed_fAssStorageCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请人&nbsp;
						<input id="storage_fixed_fOperator" name=""  style="width: 150px;height:25px;"  class="easyui-textbox"></input>
						&nbsp;&nbsp;申请日期&nbsp;
						<input id="storage_fixed_fPurchaseDateStart" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>
						&nbsp;-&nbsp;
						<input id="storage_fixed_fPurchaseDateEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="storage_fixed_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="storage_fixed_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					 
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="storage_fixed_add()" >
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- <td class="top-table-td1">入库单号：</td> 
					<td class="top-table-td2">
						<input id="storage_fixed_fAssStorageCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">经办人：</td> 
					<td class="top-table-td2">
						<input id="storage_fOperator" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">入库时间：</td> 
					<td class="top-table-td2" >
						<input id="storage_fPurchaseDate" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td class="top-table-td1">发票编号：</td> 
					<td class="top-table-td2" >
						 <input id="storage_fStorageInvoice" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="storage_fixed_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="storage_fixed_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td >
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#" onclick="storage_fixed_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<td style="width: 14px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="storage_fixed_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Storage/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fId_S',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssStorageCode',align:'center'" width="15%">资产新增单号</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="15%">申请部门</th>
						<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="15%">申请时间</th>
						<th data-options="field:'fFlowStatus',align:'center',formatter: formatPrice" width="10%" >审批状态</th>
						<th data-options="field:'fRemark_S',align:'left',resizable:false,sortable:true" width="21%">备注</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">

$("#storage_fixed_fPurchaseDateStart").datebox({
    onSelect : function(beginDate){
        $('#storage_fixed_fPurchaseDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
//清除查询条件
function storage_fixed_clearTable() {
	$('#storage_fixed_fAssStorageCode').textbox('setValue',null),
	$('#storage_fixed_fOperator').textbox('setValue',null),
	$('#storage_fixed_fPurchaseDateStart').datebox('setValue',null),
	$('#storage_fixed_fPurchaseDateEnd').datebox('setValue',null);
	storage_fixed_query();
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
}
	 function CheckYou() {
		var flag = true;
		var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
		 if(!regu.test($('#"storage_fixed_fAssStorageCode"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} 
	var fs
	function formatPrice(val, row) {
		fs=val;
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
		}else if (val == 9) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
		}else if (val == 99) {
			return '<span style="color:#666666;">' + " 已删除" + '</span>';
		} else if (val == -1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</span>';
		}else if (val == -4) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</span>';
		}
	}
	function CZ(val, row) {
		if(row.fFlowStatus==0||row.fFlowStatus==-1){
			return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_update(' + row.fId_S
					+ ')" class="easyui-linkbutton"><img <img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_delete(' + row.fId_S
					+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
					+'</td></tr></table>';
		}else if(row.fFlowStatus==1){
			return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
					+ '</a>'+'</td><td style="width: 25px">'
					+ '<a href="#" onclick="reCall(\'storage_fixed_dg\' ,'+ row.fId_S+',\'/Storage/reCall\''+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">' + '</a>'
					+'</td></tr></table>';
		}else if(row.fFlowStatus==-4){
					return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_update(' + row.fId_S
					+ ')" class="easyui-linkbutton"><img <img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_delete(' + row.fId_S
					+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
					+'</td></tr></table>';
		}else {
			return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="storage_fixed_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
					+ '</a>'
					+'</td></tr></table>';
		}
		
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/update2.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
	}
	function showE(obj){
		obj.src=base+'/resource-modality/${themenurl}/delete2.png';
	}
	function showF(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#storage_fixed_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function storage_fixed_query() {
		$('#storage_fixed_dg').datagrid('load', {
			fAssStorageCode : $('#storage_fixed_fAssStorageCode').val(),
			fOperator : $('#storage_fixed_fOperator').val(),
			fPurchaseDateStart : $('#storage_fixed_fPurchaseDateStart').val(),
			fPurchaseDateEnd : $('#storage_fixed_fPurchaseDateEnd').val()
		});
	}
	function storage_fixed_add() {
		var node = $('#storage_fixed_dg').datagrid('getSelected');
		var win = creatWin('资产申请', 970,580, 'icon-search', '/Storage/fixedadd');
		if (null != node) {
			win = creatWin('资产申请', 970,580, 'icon-search',
					'/Storage/fixedadd');
		}
		win.window('open');
	}
	function storage_fixed_detail(id) {
			var win = creatWin('资产明细', 970 ,580, 'icon-search',"/Storage/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#storage_fixed_dg').datagrid('getSelected');
		var selections = $('#storage_fixed_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Storage/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function storage_fixed_update(id) {
		//var row = $('#storage_fixed_dg').datagrid('getSelected');
		var selections = $('#storage_fixed_dg').datagrid('getSelections');
		var win = creatWin('资产-修改', 970, 580, 'icon-search',
				"/Storage/edit/" + id);
		win.window('open');
	}
	function storage_fixed_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Storage/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#storage_fixed_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	function expListlawHelp() {
		//var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
		//win.window('open');
		if (confirm("按当前查询条件导出？")) {
			var queryForm = document.getElementById("lawHelp_list_form");
			queryForm.setAttribute("action", "${base}/demo/expList");
			queryForm.submit();
		}
	}
</script>
</body>
</html>


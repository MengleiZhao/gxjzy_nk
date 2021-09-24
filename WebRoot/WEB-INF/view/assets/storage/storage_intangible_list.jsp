<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search">入库单号&nbsp;
						<input id="storage_intangible_fAssStorageCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;经办人&nbsp;
						<input id="storage_intangible_fOperator" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;登记日期&nbsp;
						<input id="storage_intangible_fPurchaseDateStart" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
						&nbsp;-&nbsp;
						<input id="storage_intangible_fPurchaseDateEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="storage_intangible_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="storage_intangible_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					
					</td> 
					<td align="right" style="padding-right: 10px">
						<a href="#"  onclick="storage_intangible_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<%-- <td class="top-table-td1">登记单号：</td> 
					<td class="top-table-td2">
						<input id="storage_intangible_fAssStorageCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">经办人：</td> 
					<td class="top-table-td2">
						<input id="storage_intangible_fOperator" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">登记日期：</td> 
					<td class="top-table-td2">
						<input id="storage_intangible_fPurchaseDateStart" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td class="top-table-td1">发票编号：</td> 
					<td class="top-table-td2">
						 <input id="storage_intangible_fPurchaseDateEnd" name="" style="width: 150px;height:25px;" data-options=""prompt:'(万元)'"" class="easyui-textbox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="storage_intangible_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="storage_intangible_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td >
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#"  onclick="storage_intangible_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="storage_intangible_dg"  class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Storage/JsonPagination?fAssType=ZCLX-03',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fId_S',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssStorageCode',align:'left'" width="10%">资产登记单</th>
						<th data-options="field:'fAssCode',align:'left'" width="10%">资产编号</th>
						<th data-options="field:'fStorageName',align:'left',resizable:false,sortable:true" width="15%">资产名称</th>
						<th data-options="field:'fOperator',align:'left',resizable:false,sortable:true" width="10%">经办人</th>
						<th data-options="field:'fPurchaseDate',align:'left',formatter: ChangeDateFormat" width="10%" >登记日期</th>
						<th data-options="field:'fSpecificationModel',align:'left',resizable:false,sortable:true" width="15%">规格型号</th>
						<th data-options="field:'fRemark_S',align:'left',resizable:false,sortable:true" width="10%">备注</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="15%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">

$("#storage_intangible_fPurchaseDateStart").datebox({
    onSelect : function(beginDate){
        $('#storage_intangible_fPurchaseDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
//清除查询条件
function storage_intangible_clearTable() {
	$('#storage_intangible_fAssStorageCode').textbox('setValue',null),
	$('#storage_intangible_fOperator').textbox('setValue',null),
	$('#storage_intangible_fPurchaseDateStart').datebox('setValue',null),
	$('#storage_intangible_fPurchaseDateEnd').datebox('setValue',null),
	storage_intangible_query();
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
		 if(!regu.test($('#"storage_intangible_fAssStorageCode"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} 
	var fs
	function formatPrice(val, row) {
		fs=val;
		if (val == 0) {
			return '<span style="color:blue;">' + "暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:red;">' + "待审批" + '</span>';
		}else if (val == 9) {
			return '<span style="color:green;">' + "已审批" + '</span>';
		}else if (val == 99) {
			return '<span style="color:black;">' + "已删除" + '</span>';
		} else if (val == -1) {
			return '<span style="color:red;">' + "已退回" + '</span>';
		}
	}
	function CZ(val, row) {
		return 	'<a href="#" onclick="storage_intangible_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'&nbsp;&nbsp;'
				+'<a href="#" onclick="storage_intangible_update(' + row.fId_S
				+ ')" class="easyui-linkbutton"><img <img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'&nbsp;&nbsp;'
				+'<a href="#" onclick="storage_intangible_delete(' + row.fId_S
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>';
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
		$('#storage_intangible_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function storage_intangible_query() {
		$('#storage_intangible_dg').datagrid('load', {
			fAssStorageCode : $('#storage_intangible_fAssStorageCode').val(),
			fOperator : $('#storage_intangible_fOperator').val(),
			fPurchaseDateStart : $('#storage_intangible_fPurchaseDateStart').val(),
			fPurchaseDateEnd : $('#storage_intangible_fPurchaseDateEnd').val()
		});
	}
	function storage_intangible_add() {
		var node = $('#storage_intangible_dg').datagrid('getSelected');
		var win = creatWin('新增', 770, 580, 'icon-search', '/Storage/intangibleadd');
		if (null != node) {
			win = creatWin('新增', 770, 580, 'icon-search',
					'/Storage/intangibleadd?departId=' + node.id);
		}
		win.window('open');
	}
	function storage_intangible_detail(id) {
			var win = creatWin('查看', 770, 580, 'icon-search',"/Storage/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#storage_intangible_dg').datagrid('getSelected');
		var selections = $('#storage_intangible_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Storage/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function storage_intangible_update(id) {
		//var row = $('#storage_intangible_dg').datagrid('getSelected');
		console.log(id);
		var selections = $('#storage_intangible_dg').datagrid('getSelections');
		var win = creatWin('修改', 770, 580, 'icon-search',
				"/Storage/intangibleedit/" + id);
		win.window('open');
	}
	function storage_intangible_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Storage/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#storage_intangible_dg").datagrid('reload');
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
	//日期格式化
	function ChangeDateFormat(val) {
		//alert(val)
		var t, y, m, d, h, i, s;
		if (val == null) {
			return "";
		}
		t = new Date(val)
		y = t.getFullYear();
		m = t.getMonth() + 1;
		d = t.getDate();
		h = t.getHours();
		i = t.getMinutes();
		s = t.getSeconds();
		// 可根据需要在这里定义日期格式  
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
</script>
</body>
</html>


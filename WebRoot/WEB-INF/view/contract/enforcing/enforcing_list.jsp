<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" class="queryth">合同编号&nbsp;
						<input id="e_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="e_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="enforcing_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="enforcing_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					
					</td>
					<%-- <td class="top-table-td1" class="queryth">合同编号：</td> 
					<td class="top-table-td2">
						<input id="e_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1" class="queryth">合同名称：</td> 
					<td class="top-table-td2">
						<input id="e_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<!-- <td class="top-table-td1" class="queryth">合同金额：</td> 
					<td class="top-table-td2">
						<input id="e_fcAmount" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}]"  class="easyui-textbox"></input>
					</td> -->
					<td class="top-table-td1" class="queryth">申请日期：</td> 
					<td class="top-table-td2">
						<input id="e_fReqtIME" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="enforcing_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="enforcing_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<td style="width: 30px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>
		</div>
		<div class="list-table">
			<table id="enforcing_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Enforcing/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center'" width="15%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="19%">合同名称</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="12%">合同金额(元)</th>
						<th data-options="field:'fAllAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="12%">已付款金额(元)</th>
						<th data-options="field:'fNotAllAmountL',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="13%">未付款金额(元)</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="15%">所属部门</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
$('#e_percentageTempEnd').val(1);
//清除查询条件
function enforcing_clearTable() {
	$('#e_fcCode').textbox('setValue',null);
	$('#e_fcTitle').textbox('setValue',null);
	enforcing_query();
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
	/* function CheckYou() {
		var flag = true;
		var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
		 if(!regu.test($('#"e_fcCode"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} */

	/* function formatPrice(val, row) {
		if (val == 0) {
			return '<span style="color:yellow;">' + "暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:red;">' + "待审核" + '</span>';
		}
	} */
	function CZ(val, row) {
		return '<a href="#" onclick="plan(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="enforcingshowB(this)" onmouseout="enforcingshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/pay1.png">' + '</a>';
	}
	function enforcingshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/pay2.png';
	}
	function enforcingshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/pay1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#enforcing_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function enforcing_query() {
		$('#enforcing_dg').datagrid('load', {
			fcCode : $('#e_fcCode').val(),
			fcTitle : $('#e_fcTitle').val(),
		});
	}
	function detailDemo() {
		var row = $('#enforcing_dg').datagrid('getSelected');
		var selections = $('#enforcing_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin('查看-合同拟定', 600, 600, 'icon-search',
					"/demo/detail/" + row.id);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	}
	function plan(id) {
		var row = $('#enforcing_dg').datagrid('getSelected');
		var selections = $('#enforcing_dg').datagrid('getSelections');
		var win = creatWin('选择-付款条目 ', 970, 580, 'icon-search',
				"/Enforcing/plan/" + id);
		win.window('open'); 
	}
	function deleteCF() {
		var row = $('#enforcing_dg').datagrid('getSelected');
		var selections = $('#enforcing_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/Enforcing/delete/' + row.fcId,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$("#enforcing_dg").datagrid('reload');
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
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
	//时间格式化
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
		// 可根据需要在这里定义时间格式  
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
	//搜索栏百分比第一个框校验时间
	$('#e_percentageTempStart').combobox({
		onChange:function(newValue, oldValue){
			//var start=record.value;
			var end=$('#e_percentageTempEnd').val();
			if(newValue>end){
				$('#e_percentageTempStart').combobox('setValue',0.0);
				$('#e_percentageTempEnd').combobox('setValue',1);
				alert("起始值不得大于终止值");
			}
		}
	});
</script>
</body>
</html>
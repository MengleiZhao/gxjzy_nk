<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body >
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;流水金额&nbsp;
					<input id="cashier_robot_list_top_amount1" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					&nbsp;-&nbsp;
					<input id="cashier_robot_list_top_amount2" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					&nbsp;&nbsp;受理人&nbsp;
					<input id="cashier_robot_list_top_user" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryCashierRobot()">
						<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					
					&nbsp;&nbsp;
					<a href="#" onclick="clearCashierRobot();">
						<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			
			
				<%-- <td class="top-table-td1">&nbsp;&nbsp;&nbsp;&nbsp;受理时间：</td> 
				<td class="top-table-td2">
					<input id="" name=""  style="width: 150px;height:25px;" class="easyui-datebox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">&nbsp;&nbsp;&nbsp;流水金额：</td> 
				<td class="top-table-td2">
					<input id="" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="">
						<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td>
					<a href="#" onclick="clearTable();">
						<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td> --%>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="$('#xlsx').click()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<form method="post" id="collect" enctype="multipart/form-data">
						<input type="file" id="xlsx" name="xlsx" onchange="upCollectFile()" hidden="hidden">
					</form>
				</td>
				
			</tr>

		</table>   
	</div>



	<div class="list-table">
		<table id="cashierCollectTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/cashierCollect/page',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'collectId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'user',align:'left',resizable:false,sortable:true" style="width: 15%">受理人</th>
					<th data-options="field:'time',align:'left',resizable:false,sortable:true,formatter:ChangeDateFormat" style="width: 15%">受理时间</th>
					<th data-options="field:'payee',align:'left',resizable:false,sortable:true" style="width: 15%">收款人</th>
					<th data-options="field:'bank',align:'left',resizable:false,sortable:true" style="width: 10%">开户银行</th>
					<th data-options="field:'account',align:'left',resizable:false,sortable:true" style="width: 15%">账户</th>
					<th data-options="field:'amount',align:'left',resizable:false,sortable:true" style="width: 15%">流水金额</th>
					<th data-options="field:'cz',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>

</div>

<script type="text/javascript">
//设置审批状态
var c;
function flowStautsSet(val, row) {
	c = val;
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	if (c == 9 || c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editApply(' + row.gId + ',0)" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
	} else if(c == 0 || c == -1) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="editApply(' + row.gId + ',0)" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="editApply(' + row.gId + ',1)" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteApply(' + row.gId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}
}

//删除
function deleteApply(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/apply/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#applyTab').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

//xlsx文件导入
function upCollectFile() {
	var formData = new FormData($('#collect')[0]);
	var fileurl = $('#xlsx').val();
	if(fileurl != "") {
		$.ajax({
        	type: 'post',
            url: base+'/cashierCollect/collect',
			data: formData,
			cache: false,
			processData: false,
			contentType: false,
			dataType: 'json',
		}).success(function (data) {
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
			$('#collect').form('clear');
			$('#cashierCollectTab').datagrid('reload');
		}).error(function () {
			alert('上传失败！');
		});
	}
}

function queryCashierRobot() {
	var amount1="cashier_robot_list_top_amount1";
	var amount2="cashier_robot_list_top_amount2";
	var user="cashier_robot_list_top_user";
	

	$("#cashierCollectTab").datagrid('load',{
		amount1:$("#"+amount1).numberbox('getValue').trim(),
		amount2:$("#"+amount2).numberbox('getValue').trim(),
		user:$("#"+user).textbox('getValue').trim(),
	});
}

function clearCashierRobot() {
	var amount1="cashier_robot_list_top_amount1";
	var amount2="cashier_robot_list_top_amount2";
	var user="cashier_robot_list_top_user";
	
	$("#"+amount1).numberbox('getValue');
	$("#"+amount2).numberbox('getValue');
	$("#"+user).textbox('getValue');
	
	$("#cashierCollectTab").datagrid('load',{});
}
</script>
</body>
</html>


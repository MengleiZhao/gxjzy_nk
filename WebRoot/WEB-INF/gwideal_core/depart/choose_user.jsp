<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">姓名：</td> 
					<td class="top-table-td2">
						<input id="user_name"  style="width: 150px;height:25px;" class="easyui-textbox"/>
					</td>
					<td style="width: 30px;"></td>
					<td style="width: 26px;">
						<a href="javascript:void(0)"  onclick="query_hstd();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 8px;"></td>
					<td>
						<a href="javascript:void(0)"  onclick="clearTable_hstd();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="user_choose_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/user/jsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'departName',align:'center',resizable:false" width="25%">部门名称</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="25%">姓名</th>
						<th data-options="field:'statusName',align:'center',resizable:false" width="24%">在岗状态</th>
						<th data-options="field:'mobileNo',align:'center',resizable:false,sortable:true" width="25%">手机号</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	


<script type="text/javascript">

$(function(){
	initDg_user_add();
});

//初始化datagrid点击事件
function initDg_user_add(){
	$('#user_choose_dg').datagrid({
		
		onDblClickRow:function(index,row){
			$('#depart_add_mgrName').textbox('setValue',row.name);
			$('#depart_add_mgrId').val(row.id);
			closeFirstWindow();
		}
	});
}

//清除查询条件
function clearTable_hstd() {
	$('#user_name').textbox('setValue',null);
	query_hstd();
}


function query_hstd() {
	var name = $('#user_name').textbox('getValue');
	$('#user_choose_dg').datagrid('load', {
		name : name,
		
	});
}


function format_strToDate(value){
	if (value != null) {
		var date = new Date(value);
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return (m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
		//return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
	} else {
		return '无';
	}
}

function format_wjsfbl(value){
	if (value=='' || value==null) {
		return '无';
	} else {
		return value;
	}
}


</script>
</body>


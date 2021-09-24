<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="vehicleAdd()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="list-table">
		<table id="vehicle_list" class="easyui-datagrid" data-options="collapsible:true,url:'${base}/vehicle/pageData',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,selectOnCheck: true,
		checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
			<thead>
				<tr>
					<th data-options="field:'fId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 10%">序号</th>
					<th data-options="field:'code',align:'center',resizable:false" style="width: 30%">编号</th>
					<th data-options="field:'name',align:'center',resizable:false" style="width: 30%">名称</th>
					<th data-options="field:'cz',align:'center',resizable:false,formatter:vehicleCZ" style="width: 30%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>


<script type="text/javascript">
function vehicleAdd(code) {
	var win = creatWin('新增', 420, 265, 'icon-search', '/vehicle/add?code='+code);
	win.window('open');
}

function vehicleCZ(value, row) {
	var code = "'"+row.code+"'";
	
	var btn3 = '<a href="#" onclick="vehicleLevel(' + code + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>' + '</td><td style="width: 25px">';
	
	var btn1 ='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="editVehicle(' + row.fId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
			'</a>'+ '</td><td style="width: 25px">';
	
	var btn2 ='<a href="#" onclick="deleteVehicle(' + row.fId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
			'</a></td></tr></table>';
	
	var btn="";
	if(row.parentCode==null) {
		btn = btn1 + btn3 +btn2;
	} else {
		btn = btn1 +btn2;
	}
			
	return btn;
}

function editVehicle(id) {
	var win = creatWin('修改', 420, 265, 'icon-search', '/vehicle/edit?id='+id);
	win.window('open');
}

function vehicleLevel(code) {
	var win = creatFirstWin('交通工具等级', 970, 580, 'icon-search', '/vehicle/level?code='+code);
	win.window('open');
}
function deleteVehicle(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/vehicle/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#vehicle_list').datagrid('reload');
					$('#vehicle_list2').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
</script>
</body>

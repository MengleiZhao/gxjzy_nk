<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<style type="text/css">
 /* 边框样式 */
.datagrid-body td{
  border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-htable tr td{
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
}
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 ">
	</div>
<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
				<td>
					
					<%-- &nbsp;<a href="#" onclick="outsidequery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;
					<a href="#" onclick="outsideclearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a> --%>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="backupsClick('BFSJ')">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/bf1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>
	<div class="list-table" style="height:460px;">
		<table id="backups_tab" class="easyui-datagrid" 
			data-options="url:'${base}/backups/pageData',method:'post',fit:true,scrollbarSize:0,triped: true,nowrap : false,rownumbers : true,
			pagination:true,singleSelect: true,checkOnSelect: true, selectOnCheck: true, pageSize: 50,remoteSort:true">
			<thead>
				<tr>
					<th data-options="field:'fName',align:'left',halign:'center',sortable:true,formatter:formatCellTooltip" style="width:16%;">文件名称</th>
					<th data-options="field:'fSize',align:'left',halign:'center',sortable:true,formatter:formatCellTooltip" style="width:10%;">文件大小</th>
					<th data-options="field:'fType',align:'left',halign:'center',sortable:true,formatter:formatCellTooltip" style="width:10%;">备份类型</th>
					<th data-options="field:'fCreateUser',align:'left',halign:'center',sortable:true,formatter:formatCellTooltip" style="width:10%;">备份人</th>
					<th data-options="field:'fCreateTime',align:'left',halign:'center',sortable:true,formatter:ChangeDateFormatIndex" style="width:12%;">备份时间</th>
					<th data-options="field:'fDescribe',align:'left',halign:'center',sortable:true,formatter:formatCellTooltip" style="width:30%;">备份描述</th>
					<th data-options="field:'operation',align:'center',formatter:formatOperation" width="10%" >操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<form id="backup_download_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<input type="hidden" id="backup_id" name="id">
</form>

<script type="text/javascript">
function formatOperation(val, row){
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px;border:none;">'+
	'<a href="#" onclick="backupDownload(\''+row.fBId+'\')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/download1.png">'+
	'</a></td><td style="width: 25px;border:none;">'+
	'<a href="#" onclick="restoreClick(\''+row.fName+'\')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/hy1.png">'+
	'</a></td></tr></table>';
}


function backupsClick(type){
	var win = creatWin('填写-备份描述',580, 360, 'icon-search', '/backups/addMsg?type='+type);
	win.window('open');
}

function restoreClick(name){
	$.messager.confirm('系统提示', '是否确定还原到“'+name+'”备份文件？', function(flag){
		if(flag){
			$.messager.progress();
			$.ajax({
				url: base+'/backups/saveBackups',
				type: 'post',
				dataType: 'json',
				data: {'type': 'HYSJ', 'fileName': name},
				success: function(data){
					$.messager.progress('close');
					$.messager.alert('系统提示',data.info,'info');
					$('#backups_tab').datagrid('reload');
				},
				error: function() {
					//请求出错处理
					$.messager.alert('系统提示','请求服务器失败！','error');
				}
			});
		}
	});
}

function backupDownload(id){
	$('#backup_id').val(id);
	// $('#backup_download_form').attr('action', base+'/backups/download');
	// $('#backup_download_form').submit();
	//提交
	$('#backup_download_form').form('submit', {
		onSubmit : function(param) {
		},
		url: base+'/backups/download',
		success:function(data){
			$.messager.progress('close');
			data=eval("("+data+")");
			if(data.success){
				
			}else{
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}
</script>
</body>



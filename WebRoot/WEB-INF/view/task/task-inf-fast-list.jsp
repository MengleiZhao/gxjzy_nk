<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body >
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-table-tab" >
		<div class="tab-wrapper" id="inf-tab">
			<div class="tab-content">
				<div style="height: 520px">
					<table id="infFastTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/PrivateInfor/unreadJsonPagination?fMessageStauts=0',
					method:'post',fit:true,pagination:false,singleSelect: true,scrollbarSize:0,toolbar: '#tb1',
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
						<thead>
							<tr>
								<th data-options="field:'number',align:'center'" style="width: 10%">序号</th>
								<th data-options="field:'fTitle',align:'left'" style="width:60%">消息</th>
								<th data-options="field:'fSendTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 30%">日期</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
//加载tab页
flashtab('inf-tab');

//未读粗体
$('#infFastTab').datagrid({
	rowStyler:function(index,row){
		if (row.fReadStauts==0){
			return 'font-weight:bold;';
		}
	}
});

var num=null;
$(function(){
	$("#infFastTab").datagrid({
		onClickRow:function(index, row){
			num=index;
			var rows = $('#infFastTab').datagrid('getSelected');
			var selections = $('#infFastTab').datagrid('getSelections');
			if (rows != null && selections.length == 1) {
				var win = creatWin('查看', 800, 480, 'icon-search',"/PrivateInfor/detail/" + rows.ifID);
				win.window('open');
				$('#infFastTab').datagrid({
					rowStyler:function(index,row){
						if (num==index){
							return 'font-weight:normal;';
						}else {
							return 'font-weight:bold;';
						}
					}
				});
			} else {
				$.messager.alert('系统提示', '请选择一条数据！', 'info');
			} 
		 }
	});
});

//设置申请事项
function typeSet(val, row) {
	if (val == 0) {
		return '<span>' + "未收藏" + '</span>';
	} else if (val == 1) {
		return '<span>' + "已收藏" + '</span>';
	}
}

//操作栏创建
function CZ1(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="detail(' + row.ifID + ',\''+row.fUrl+'\''+')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	'</a></td></tr></table>';
}

function select(id,url){
	if(null==url||''==url){
		var win = creatWin('查看', 760, 580, 'icon-search',"/PrivateInfor/detail/" + id+"?furl="+url);
	}else {
		var win = creatWin('查看', 970, 580, 'icon-search',"/PrivateInfor/detail/" + id+"?furl="+url);
	}
	win.window('open');
}
function detail(id,url){
	if(null==url||''==url){
		var win = creatFirstWin('查看', 860, 500, 'icon-search',"/PrivateInfor/detail/" + id);
	}
	win.window('open');
}


function infClick(){
	$("#infFastTab").datagrid('reload');
}
function starClick(){
	$("#starTab").datagrid('reload');
}

function queryInf() {
	$("#infFastTab").datagrid('load',{
		fMessage:$("#inf_message").textbox('getValue'),
	});
}

</script>
</body>
</html>


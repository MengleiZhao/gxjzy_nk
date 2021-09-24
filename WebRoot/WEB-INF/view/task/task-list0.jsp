<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<script type="text/javascript">
var base='${base}';
var queryYear = '${year}';
var queryDepartId = '${departId}';
</script>

<style type="text/css">
.datagrid-body{
	height: 358px;
}
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="td1">任务名称：</td> 
				<td class="top-table-td2">
					<input id="apply_taskName0" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="td1">提交人：</td> 
				<td class="top-table-td2">
					<input id="apply_beforeUser0" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryTask0();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="clearTaskQuery0();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
				</td>
			</tr>
		</table>
	</div>



	<div class="list-table">
		<%-- <table class="easyui-datagrid" style="height: 300px" id="task_dg0"
		data-options="collapsible:true,url:'${base}/psersonalWork/PageList?taskStauts=0',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'fId',hidden:true"></th>
					<th data-options="field:'taskId',hidden:true"></th>
					<th data-options="field:'url',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">任务编号</th>
					<th data-options="field:'taskName',align:'left'" style="width: 20%">任务名称</th>
					<th data-options="field:'beforeUser',align:'left'" style="width: 20%">提交人</th>
					<th data-options="field:'beforeTime',align:'left',formatter: ChangeDateFormat" style="width: 20%">提交时间</th>
					<th data-options="field:'userName',align:'left'" style="width: 20%">处理人</th>
					<th data-options="field:'cz',align:'left',formatter:indexCZ0" style="width: 15%">操作</th>
				</tr>
			</thead>
		</table> --%>
		
		<jsp:include page="../../../newMain/index-tabs/dbsx.jsp" />
	</div>
</div>

<script type="text/javascript">
function indexCZ0(val, row) {
	var url = "'"+row.url+"'";
	var url1 = "'"+row.url1+"'";
	var a = '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="indexCheck(' + row.taskId + ',' + url + ')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td>'+
	'</tr></table>';
	return a;
}
function queryTask0(){
	$('#indexdb').datagrid({
		url:'${base}/psersonalWork/PageList?taskStauts=0',
		queryParams:{
			taskName:$('#apply_taskName0').textbox('getValue'),
			beforeUser:$('#apply_beforeUser0').textbox('getValue')
		}
	});
}
function clearTaskQuery0(){
	$('#apply_taskName0').textbox('setValue','');
	$('#apply_beforeUser0').textbox('setValue','');
	queryTask0();
}
/* //审批页面跳转
function indexCheck0(id,url) {
	var win = parent.creatWin('待办事项-审批', 970, 580, 'icon-search',url);
	win.window('open');
}

function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/check1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/check2.png';
} */
</script>

<script>
	//消息推送 更新待办事项数字
	var url1 = window.location.host;//localhost:8080
	var url2 = base;//nkgl
	var websocket;
	if ('WebSocket' in window) {
        //websocket = new WebSocket("ws://localhost:8080/nkgl/socket");
        websocket = new WebSocket("ws://" + url1 + url2 + "/socket");
    }
    else if ('MozWebSocket' in window) {
        //websocket = new MozWebSocket("ws://localhost:8080/nkgl/socket");
        websocket = new MozWebSocket("ws://" + url1 + url2 + "/socket");
    }
    else {
        //websocket = new SockJS("http://localhost:8080/nkgl/socket");
        websocket = new SockJS("ws://" + url1 + url2 + "/socket");
    }
	websocket.onopen = function(event) {
		/* console.log("WebSocket:已连接");
		console.log(event); */
	};
	websocket.onmessage = function(event) {
		var data = JSON.parse(event.data);
		/* console.log("WebSocket:收到一条消息-norm", data);
		alert("WebSocket:收到一条消息" + data); */
		
		//重新刷新首页任务列表
		reloaddb();
		reloadyb();
		reloadbj();
	};
	websocket.onerror = function(event) {
		/* console.log("WebSocket:发生错误 ");
		console.log(event); */
	};
	websocket.onclose = function(event) {
		/* console.log("WebSocket:已关闭");
		console.log(event); */
	}
	
	//加载待办信息
	function reloaddb() {
		$('#indexdb').datagrid('reload');
	}
	function reloadyb() {
		$('#indexyb').datagrid('reload');
	}
	function reloadbj() {
		$('#indexbj').datagrid('reload');
	}
	
</script>

</body>


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
<div class="easyui-layout" style="width:100%;height:100%; 
  	background: #fff;">
  	<div data-options="region:'north'" style="height:50px; ">
	<div style="height:100% ">
		<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
			<tr>
				<td style="width:42%;text-align:left;padding-left: 16px;">
				<span style="font-size: 12px; color: #182C4D;">任务名称：</span>
					<input id="apply_taskName2" style="width: 130px;height:22px;" class="easyui-textbox"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span style="font-size: 12px; color: #182C4D;">提交人：</span>
					<input id="apply_beforeUser2" style="width: 130px;height:22px;" class="easyui-textbox"></input>
				</td>
				<td >
					<a href="#" onclick="queryTask2();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearTaskQuery0();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	</div>



	<!-- 列表区 -->
	<div data-options="region:'center'">
  	<div style="height: 100%; width:98%; margin-left: 1%;">
		<table class="easyui-datagrid" style="height: 300px" id="indexbj"
		data-options="collapsible:true,url:'${base}/psersonalWork/PageList?taskStauts=4',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>
			<th data-options="field:'taskId',hidden:true"></th>
			<th data-options="field:'url',hidden:true"></th>
			<th data-options="field:'taskCode',align:'center',sortable:true" style="width: 20%">任务编号</th>
			<th data-options="field:'taskType',align:'center',formatter: taskType" style="width: 15%">任务类型</th>
			<th data-options="field:'taskName',align:'center',formatter: taskName" style="width: 25%">任务名称</th>
			<th data-options="field:'beforeUser',align:'center'" style="width: 10%">提交人</th>
			<!-- <th data-options="field:'beforeDepart',align:'left'" style="width: 20%">所属部门</th> -->
			<th data-options="field:'beforeTime',align:'center',sortable:true,formatter: ChangeDateFormatIndex" style="width: 15%">提交时间</th>
			<!-- <th data-options="field:'userName',align:'left'" style="width: 20%">处理人</th> -->
			<!-- <th data-options="field:'bjzhs',align:'left',formatter:bjzhs" style="width: 24%">审批总耗时</th> -->
			<th data-options="field:'cz',align:'center',formatter:indexCZ2" style="width: 15%">操作</th>
		</tr>
	</thead>
</table>
	</div>
	</div>
	 <!-- 导航区 -->
  <div data-options="region:'south'" style="height:40px; ">
  		<div style="text-align: center;">
			<%-- <a href="javascript:void(0)" onclick="goback()">
				<img src="${base}/resource-modality/${themenurl}/button/fanhui1.png"
					onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui2.png')"
					onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui1.png')"
				/>
			</a> --%>
			&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeSearchDateWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
  </div>
</div>
<script type="text/javascript">
/* function indexCZ2(val, row){
	var url = "'"+row.url+"'";
	var a = '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="indexCheck2(' + row.taskId + ',' + url + ')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	'</a></td>'+
	'</tr></table>';
	return a;
} */

//办结任务类型
function taskType(val, row) {
	// [...]...
	var val = row.taskName;
	if(val != null){
		var index = val.indexOf(']');
		val = val.substring(1, index); 
		return val;
	}
	return "";
}

//办结任务名称
function taskName(val, row) {
	if(val != null){
		var index = val.indexOf(']');
		val = val.substring(index+1, val.length); 
	}
	return val;
}

//已办审批总耗时
function bjzhs(val, row) {
	var bdate = new Date(row.beforeTime);//任务提交时间（申请人的申请时间）
	var odate = new Date(row.overTime);;//任务结束时间（审批完成时的时间）
	var time = odate.getTime() - bdate.getTime();
	return timeChange(time); 
}

function queryTask2(){
	$('#indexbj').datagrid({
		url:'${base}/psersonalWork/PageList?taskStauts=4',
		queryParams:{
			taskName:$('#apply_taskName2').textbox('getValue'),
			beforeUser:$('#apply_beforeUser2').textbox('getValue')
		}
	});
}
function clearTaskQuery0(){
	$('#apply_taskName2').textbox('setValue','');
	$('#apply_beforeUser2').textbox('setValue','');
	queryTask2();
}
/* //审批页面跳转
function indexCheck2(id,url) {
	var win = parent.creatWin('已办事项-查看', 970, 580, 'icon-search',url);
	win.window('open');
}
function showC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showD(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
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
<script>
function indexCZ2(val, row) {
	//判断任务类型
	if("1"==row.type) {		//审批任务类型
		var url = "'"+row.url+"'";
		var a = '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="indexCheck(' + row.taskId + ',' + url + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
		'</a></td>'+
		'</tr></table>';
		return a;
	} else if("2"==row.type) {	//查看任务类型
		var url1 = "'"+row.url1+"'";
		var a = '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="indexDetail(' + row.taskId + ',' + url1 + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>'+
		'</tr></table>';
		return a;
	} else if("3"==row.type) {	//退回修改任务类型
		var url = "'"+row.url+"'";
		var url2 = "'"+row.url2+"'";
		var a = '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="indexEdit(' + row.taskId + ',' + url + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
		'</a></td>'+
		'<td style="width: 25px">'+
		'<a href="#" onclick="indexDelete(' + row.taskId + ',' + url2 + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
		'</a></td>'+
		'</tr></table>';
		return a;
	} else {
		return "";
	}
}
/* //查看页面跳转
function indexDetail(id,url){
	var type = url.substring(1,8);
	if(type=='project'){
		var win = parent.creatWin('查看', 1300,630, 'icon-search',url);
		win.window('open');
	} else {
		var win = parent.creatWin('查看', 970, 580, 'icon-search',url);
		win.window('open');
	}
} */
</script>
</body>


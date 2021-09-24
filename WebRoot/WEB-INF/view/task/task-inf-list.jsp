<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body >
<style>
.tab-1{
color: #333333;
}
.tab-1:hover{
color: #008DFF;
}
</style>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<div id="infolist" class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div style="margin: 0 10px 10px 10px;border: 1px #d9e3e7 solid;background-color: #ffffff;height: 500px">
		<div class="tab-wrapper" id="inf-tab">
			<ul class="tab-menu">
				<li class="active" onclick="infClick();">我的消息</li>
			    <li onclick="starClick();">星标信息<img style="padding-bottom: 3px;padding-left:2px" src="${base}/resource-modality/${themenurl}/button/star2.png" ></li>
			</ul>
			<div class="tab-content" style="margin-left: 10px;margin-right: 10px;">
				<div style="height: 450px">
					<table id="infTab" class="easyui-datagrid" 
					data-options="collapsible:true,url:'${base}/PrivateInfor/JsonPagination',
					method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,toolbar: '#tb1',fitColumns:true,pageSize:8,
					selectOnCheck: false,checkOnSelect:false,remoteSort:true,nowrap:false,striped: true,fitColumns: true,
					view:groupview,groupField:'today',groupFormatter:function(value,rows){
						if(value==1){
		                     return ' 今天  - 共 ' + rows.length + ' 条信息';
						}else if(value==0){
		                     return ' 更早  - 共 ' + rows.length + ' 条信息';
		                     }
		                }" >
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'today'" hidden="hidden"></th>
								<th data-options="field:'fSendUser',align:'left'" style="width: 10%">发件人</th>
								<th data-options="field:'fReadStauts',align:'left',formatter:readSet" style="width:8%">阅读状态</th>
								<th data-options="field:'fTitle',align:'left',formatter:meassgerHref1" style="width: 62%" >消息</th>
								<th data-options="field:'fSendTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat2" style="width: 12%">时间</th>
								<th data-options="field:'fMessageStauts',align:'left',resizable:false,sortable:true,formatter:typeSet" style="width: 6%">标记</th>
								<!-- <th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ1" style="width: 10%">操作</th> -->
							</tr>
						</thead>
					</table>
					<div id="tb1" style="height:40px;margin-top: 15px">
						
						<div  style="width: 500px;float: left;margin-left: 5px">
							您有<span id="infsapn" style="font-size:12px;color: red;">${countInfor}</span>条信息未读
							<span style="margin-left: 27px"></span>
							<input id="inf_message" style="width: 169px;height:25px;" data-options="prompt: '' ,icons: [{iconCls:'icon-sousuo'}]" class="easyui-textbox"/>
							&nbsp;&nbsp;
							<a href="#" onclick="queryInf();">
								<img style="vertical-align:bottom"  src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
							<%-- &nbsp;&nbsp;
							<a href="#" onclick="clearDirectlyAudit();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a> --%>
						</div>
						<div  style="margin-top: 6px;float:right;margin-right: 10px">
							<a style="margin-left: 5px;width: 25px;" href="#" onclick="read('infTab')"><img style="vertical-align:bottom;padding-bottom: 1px;"  src="${base}/resource-modality/${themenurl}/button/read1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" >&nbsp;<span class="tab-1">标记为已读</span></a>
							<a style="margin-left: 25px;width: 25px;" href="#" onclick="unread('infTab')"><img style="vertical-align:bottom;padding-bottom: 1px;"  src="${base}/resource-modality/${themenurl}/button/unread1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">&nbsp;<span class="tab-1">标记为未读</span></a>
							<a style="margin-left: 25px;width: 25px;" href="#" onclick="deletePart('infTab')"><img style="vertical-align:bottom;padding-bottom: 1px;" src="${base}/resource-modality/${themenurl}/button/deletetool1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">&nbsp;<span class="tab-1">删除</span></a>
						</div>
					</div>
				</div>
				<div style="height: 450px;">
					<table id="starTab" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/PrivateInfor/JsonPagination?fMessageStauts=1',
					method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,toolbar: '#tb2',pageSize:8,
					selectOnCheck: false,checkOnSelect:false,remoteSort:true,nowrap:false,striped: true,fitColumns: true,fitColumns: true,
					view:groupview,groupField:'today',groupFormatter:function(value,rows){
						if(value==0){
		                     return ' 更早 - 共 ' + rows.length + ' 条信息';
						}else if(value==1){
		                     return ' 今天    - 共 ' + rows.length + ' 条信息';
		                     }
		                }" >
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'number',align:'left'" style="width: 5%">序号</th>
								<th data-options="field:'fTitle',align:'left',formatter:meassgerHref2" style="width: 78%">消息</th>
								<th data-options="field:'fSendTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat2" style="width: 15%">时间</th>
								<!-- <th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ2" style="width: 10%">操作</th> -->
							</tr>
						</thead>
					</table>
					<div id="tb2" style="height:40px;margin-top: 15px">
						<div style="width:500px;float: left;margin-left: 5px">
							您有<span id="starsapn" style="font-size:12px;color: red;" >${countInfor}</span>条信息未读
							<span style="margin-left: 27px"></span>
							<input id="stat_message" style="width: 169px;height:25px;" data-options="prompt: '' ,icons: [{iconCls:'icon-sousuo'}]" class="easyui-textbox"/>
							&nbsp;&nbsp;
							<a href="#" onclick="querystar();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</div>
						<div style="margin-top: 6px;float:right;margin-right: 50px">
							<a style="margin-left: 5px;width: 25px;" href="#" onclick="read('starTab')"><img style="vertical-align:bottom;padding-bottom: 1px;"  src="${base}/resource-modality/${themenurl}/button/read1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">&nbsp;<span class="tab-1">标记为已读</span></a>
							<a style="margin-left: 25px;width: 25px;" href="#" onclick="unread('starTab')"><img style="vertical-align:bottom;padding-bottom: 1px;;"  src="${base}/resource-modality/${themenurl}/button/unread1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">&nbsp;<span class="tab-1">标记为未读</span></a>
							<a style="margin-left: 25px;width: 25px;" href="#" onclick="deletePart('starTab')"><img style="vertical-align:bottom;padding-bottom: 1px;" src="${base}/resource-modality/${themenurl}/button/deletetool1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">&nbsp;<span class="tab-1">删除</span></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
//加载tab页
flashtab('inf-tab');

//更改分组样式
$('#infTab').datagrid({
	groupStyler: function(value,rows){
		return 'background-color:write;color:#666666;font-weight:normal;height: 30px;padding-top:5px;'; // return inline style
		// the function can return predefined css class and inline style
		// return {class:'r1', style:{'color:#fff'}};
	}
});
$('#starTab').datagrid({
	groupStyler: function(value,rows){
		return 'background-color:write;color:#666666;font-weight:normal;height: 30px;padding-top:5px;'; // return inline style
		// the function can return predefined css class and inline style
		// return {class:'r1', style:{'color:#fff'}};
	}
});
/* //未读粗体
$('#infTab').datagrid({
	rowStyler:function(index,row){
		if (row.fReadStauts==0){
			return 'font-weight:bold;';
		}
	}
});
$('#starTab').datagrid({
	rowStyler:function(index,row){
		if (row.fReadStauts==0){
			return 'font-weight:bold;';
		}
	}
}); */

//打开事件s
function openhref(id){
	var win = creatWin('查看', 800, 500, 'icon-search',"/PrivateInfor/detail/" + id);
	win.window('open');
}

//返回链接
function meassgerHref1(index ,val){
	if(val.fReadStauts==0){
		return '<a href="#" onclick="openhref('+val.ifID+'); "><span style="font-size:12px;font-family:Microsoft YaHei;font-weight:400;line-height:16px;color:#000000;">' + val.fTitle + '</span></a>';
	}else if(val.fReadStauts==1){
		return '<a href="#" onclick="openhref('+val.ifID+'); "><span style="font-size:12px;font-family:Microsoft YaHei;font-weight:400;line-height:16px;color:#999999;">' + val.fTitle + '</span></a>';
	}
}
function meassgerHref2(index ,val){
	if(val.fReadStauts==0){
		return '<a href="#" onclick="openhref('+val.ifID+'); "><span style="font-size:12px;font-family:Microsoft YaHei;font-weight:400;line-height:16px;color:#000000;">' + val.fTitle + '</span></a>';
	}else if(val.fReadStauts==1){
		return '<a href="#" onclick="openhref('+val.ifID+'); "><span style="font-size:12px;font-family:Microsoft YaHei;font-weight:400;line-height:16px;color:#999999;">' + val.fTitle + '</span></a>';
	}
}

/* //双击打开事件
$('#infTab').datagrid({
	onClickRow: function(index, rowData){
		var win = creatWin('查看', 760, 580, 'icon-search',"/PrivateInfor/detail/" + rowData.ifID);
		win.window('open');
	}
});

//双击打开事件
$('#starTab').datagrid({
	onClickRow: function(index, rowData){
		var win = creatWin('查看', 760, 580, 'icon-search',"/PrivateInfor/detail/" + rowData.ifID);
		win.window('open');
	}
}); */


//单击星标事件
$('#infTab').datagrid({
	onClickCell: function(index,field,value){
		//判断是不是点击星标这一列
		if("fMessageStauts"==field){
			//判断是否是已收藏状态
			if("0"==value){
				//变红
			    $('#infTab').datagrid('updateRow',{
			    	index: index,
			    	row: {
			    		fMessageStauts: '1',
			    	}
			    });
			}else if("1"==value){
				//变灰
			    $('#infTab').datagrid('updateRow',{
			    	index: index,
			    	row: {
			    		fMessageStauts: '0',
			    	}
			    });
			}
			//获得选中主键
			var rows = $("#infTab").datagrid("getRows");
			var row = rows[index];//index为行号
			var id = row.ifID;
			//传输到后台改变数据库状态
			$.ajax({ 
				type: 'POST', 
				url: '${base}/PrivateInfor/updateMessageStauts/'+id+'?fMessageStauts='+value,
				dataType: 'json', 
				success: function(data){ 
					if(data.success){
						//$.messager.alert('系统提示',data.info,'info');
						//$('#'+tabid).datagrid('reload');
					}else{
						//$.messager.alert('系统提示',data.info,'error');
					}
				} 
			}); 	
			
		}
	}
});


//标为已读方法
function read(tabid){
	var selections = $('#'+tabid).datagrid('getChecked');
	var pi='';
	for (var i = 0; i < selections.length; i++) {
		if((selections.length-1)==i){
			pi = pi + selections[i].ifID;
		}else {
			pi = pi + selections[i].ifID + ",";
		}
	}
	if(selections.length>0){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/PrivateInfor/read',
			dataType: 'json', 
			data:{'selections' : pi},
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$('#'+tabid).datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}else {
		alert("请选择一条数据");
	}
	
}
//标为未读方法
function unread(tabid){
	var selections = $('#'+tabid).datagrid('getChecked');
	var pi='';
	for (var i = 0; i < selections.length; i++) {
		if((selections.length-1)==i){
			pi = pi + selections[i].ifID;
		}else {
			pi = pi + selections[i].ifID + ",";
		}
	}
	if(selections.length>0){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/PrivateInfor/unread',
			dataType: 'json', 
			data:{'selections' : pi},
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$('#'+tabid).datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}else {
		alert("请选择一条数据");
	}
}
//标为删除方法
function deletePart(tabid){
	var selections = $('#'+tabid).datagrid('getChecked');
	var pi='';
	for (var i = 0; i < selections.length; i++) {
		if((selections.length-1)==i){
			pi = pi + selections[i].ifID;
		}else {
			pi = pi + selections[i].ifID + ",";
		}
	}
	if(selections.length>0){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/PrivateInfor/delete',
			dataType: 'json', 
			data:{'selections' : pi},
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$('#'+tabid).datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}else {
		alert("请选择一条数据");
	}
}

//合同付款名称（什么阶段的款）
function paytype(val, row) {
	if (val == "FKXZ-01") {
		return '<span >' + "首款" + '</span>';
	} else if (val == "FKXZ-02") {
		return '<span >' + "阶段款" + '</span>';
	}else if (val == "FKXZ-03") {
		return '<span >' + "验收款" + '</span>';
	}else if (val == "FKXZ-04") {
		return '<span >' + "质保款" + '</span>';
	}
}

//设置星标
function typeSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/button/star1.png">' + "" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/button/star2.png">' + "" + '</a>';
	}
}
//设置阅读状态
function readSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/button/unread3.png">' + "" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/button/read3.png">' + "" + '</a>';
	}
}


//设置审批状态
function flowStautsSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审定" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审定" + '</a>';
	}
}

//操作栏创建
function CZ1(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="detail(' + row.ifID + ',\''+row.fUrl+'\''+')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	'</a></td></tr></table>';
}
function CZ2(val, row) {
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="detail(' + row.ifID + ',\''+row.fUrl+'\''+')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	'</a></td></tr></table>';
}

/* function select(id,url){
	if(null==url||''==url){
		var win = creatWin('查看', 760, 580, 'icon-search',"/PrivateInfor/detail/" + id+"?furl="+url);
	}else {
		var win = creatWin('查看', 970, 580, 'icon-search',"/PrivateInfor/detail/" + id+"?furl="+url);
	}
	win.window('open');
} */
function detail(id,url){
	var win = creatWin('查看', 760, 580, 'icon-search',"/PrivateInfor/detail/" + id);
	win.window('open');
}

function infClick(){
	$("#infTab").datagrid('reload');
	$("#inf_message").textbox(null);
}
function starClick(){
	$("#stat_message").textbox(null);
	$("#starTab").datagrid('reload');
}

//消息中心查询
function queryInf() {
	$("#infTab").datagrid('load',{
		fMessage:$("#inf_message").textbox('getValue'),
	});
}
//星标查询
function querystar() {
	$("#starTab").datagrid('load',{
		fMessage:$("#stat_message").textbox('getValue'),
	});
}
//直接报销清除查询条件
function clearDirectlyAudit() {
	var drCode="directly_audit_list_top_code";
	var deptName="directly_audit_list_top_deptName";
	var reqTime1="directly_audit_list_top_reqTime1";
	var reqTime2="directly_audit_list_top_reqTime2";
	
	$("#"+drCode).textbox('setValue','');
	$("#"+reqTime1).datebox('setValue','');
	$("#"+reqTime2).datebox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#infTab").datagrid('load',{});
}

//申请报销查询
function queryReimburseAudit() {
	var rCode="reimburse_audit_list_top_code";
	var deptName="reimburse_audit_list_top_deptName";
	var reqTime1="reimburse_audit_list_top_reqTime1";
	var reqTime2="reimburse_audit_list_top_reqTime2";
	
	
	$("#starTab").datagrid('load',{
		rCode:$("#"+rCode).textbox('getValue').trim(),
		reimburseReqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reimburseReqTime2:$("#"+reqTime2).datebox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}
//申请报销清除查询条件
function clearReimburseAudit() {
	var rCode="reimburse_audit_list_top_code";
	var deptName="reimburse_audit_list_top_deptName";
	var reqTime1="reimburse_audit_list_top_reqTime1";
	var reqTime2="reimburse_audit_list_top_reqTime2";
	
	$("#"+rCode).textbox('setValue','');
	$("#"+reqTime1).datebox('setValue','');
	$("#"+reqTime2).datebox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#starTab").datagrid('load',{});
}

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
	//设值到标题中
	document.getElementById('infsapn').innerHtml = data;
	document.getElementById('starsapn').innerHtml = data;
};
websocket.onerror = function(event) {
	console.log("WebSocket:发生错误 ");
	console.log(event);
};
websocket.onclose = function(event) {
	/* console.log("WebSocket:已关闭");
	console.log(event); */
}


</script>
</body>
</html>


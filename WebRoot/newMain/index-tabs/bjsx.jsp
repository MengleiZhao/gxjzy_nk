<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<c:if test="${!empty index}">
<table class="easyui-datagrid" style="height: 300px" id="indexbj"
		data-options="collapsible:true,url:'${base}/psersonalWork/PageList?taskStauts=4',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,pageSize:4,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>
			<th data-options="field:'taskId',hidden:true"></th>
			<th data-options="field:'url',hidden:true"></th>
			<th data-options="field:'taskCode',align:'center',sortable:true" style="width: 15%">任务编号</th>
			<th data-options="field:'taskType',align:'center',formatter: taskType" style="width: 15%">任务类型</th>
			<th data-options="field:'taskName',align:'center',formatter: taskName" style="width: 20%">任务名称</th>
			<th data-options="field:'beforeUser',align:'center'" style="width: 10%">提交人</th>
			<!-- <th data-options="field:'beforeDepart',align:'left'" style="width: 20%">所属部门</th> -->
			<th data-options="field:'beforeTime',align:'center',sortable:true,formatter: ChangeDateFormatIndex" style="width: 15%">提交时间</th>
			<!-- <th data-options="field:'userName',align:'left'" style="width: 20%">处理人</th> -->
			<th data-options="field:'bjzhs',align:'center',formatter:bjzhs" style="width: 15%">审批总耗时</th>
			<th data-options="field:'cz',align:'center',formatter:indexCZ2" style="width: 10%">操作</th>
		</tr>
	</thead>
</table>
</c:if>

<c:if test="${empty index}">
<table class="easyui-datagrid" style="height: 300px" id="indexbj"
		data-options="collapsible:true,url:'${base}/psersonalWork/PageList?taskStauts=4',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>
			<th data-options="field:'taskId',hidden:true"></th>
			<th data-options="field:'url',hidden:true"></th>
			<th data-options="field:'taskCode',align:'center',sortable:true" style="width: 15%">任务编号</th>
			<th data-options="field:'taskType',align:'center',formatter: taskType" style="width: 15%">任务类型</th>
			<th data-options="field:'taskName',align:'center',formatter: taskName" style="width: 20%">任务名称</th>
			<th data-options="field:'beforeUser',align:'center'" style="width: 10%">提交人</th>
			<!-- <th data-options="field:'beforeDepart',align:'left'" style="width: 20%">所属部门</th> -->
			<th data-options="field:'beforeTime',align:'center',sortable:true,formatter: ChangeDateFormatIndex" style="width: 15%">提交时间</th>
			<!-- <th data-options="field:'userName',align:'left'" style="width: 20%">处理人</th> -->
			<th data-options="field:'bjzhs',align:'center',formatter:bjzhs" style="width: 15%">审批总耗时</th>
			<th data-options="field:'cz',align:'center',formatter:indexCZ2" style="width: 10%">操作</th>
		</tr>
	</thead>
</table>
</c:if>
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
</script>
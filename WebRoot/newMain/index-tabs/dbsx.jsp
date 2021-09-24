<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${!empty index}">
<table class="easyui-datagrid" style="height: 300px" id="indexdb"
		data-options="collapsible:true,url:'${base}/psersonalWork/PageList?taskStauts=0',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,pageSize:4,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>
			<th data-options="field:'taskId',hidden:true"></th>
			<th data-options="field:'url',hidden:true"></th>
			<th data-options="field:'taskCode',align:'center',sortable:true" style="width: 15%">任务编号</th>
			<th data-options="field:'taskType',align:'center',formatter: taskType" style="width: 10%">任务类型</th>
			<th data-options="field:'taskName',align:'center',formatter: taskName" style="width: 15%">任务名称</th>
			<th data-options="field:'beforeUser',align:'center'" style="width: 10%">提交人</th>
			<!-- <th data-options="field:'beforeDepart',align:'left'" style="width: 20%">所属部门</th> -->
			<th data-options="field:'beforeTime',align:'center',sortable:true,formatter: ChangeDateFormatIndex" style="width: 10%">提交时间</th>
			<!-- <th data-options="field:'userName',align:'left'" style="width: 20%">处理人</th> -->
			<th data-options="field:'dbhjhs',align:'center',formatter:dbhjhs" style="width: 15%">本环节耗时</th>
			<th data-options="field:'dbzhs',align:'center',formatter:dbzhs" style="width: 15%">审批总耗时</th>
			<th data-options="field:'cz',align:'center',formatter:indexCZ" style="width: 10%">操作</th>
		</tr>
	</thead>
</table>
</c:if>

<c:if test="${empty index}">
<table class="easyui-datagrid" style="height: 300px" id="indexdb"
		data-options="collapsible:true,url:'${base}/psersonalWork/PageList?taskStauts=0',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>
			<th data-options="field:'taskId',hidden:true"></th>
			<th data-options="field:'url',hidden:true"></th>
			<th data-options="field:'taskCode',align:'center',sortable:true" style="width: 15%">任务编号</th>
			<th data-options="field:'taskType',align:'center',formatter: taskType" style="width: 10%">任务类型</th>
			<th data-options="field:'taskName',align:'center',formatter: taskName" style="width: 15%">任务名称</th>
			<th data-options="field:'beforeUser',align:'center'" style="width: 10%">提交人</th>
			<!-- <th data-options="field:'beforeDepart',align:'left'" style="width: 20%">所属部门</th> -->
			<th data-options="field:'beforeTime',align:'center',sortable:true,formatter: ChangeDateFormatIndex" style="width: 10%">提交时间</th>
			<!-- <th data-options="field:'userName',align:'left'" style="width: 20%">处理人</th> -->
			<th data-options="field:'dbhjhs',align:'center',formatter:dbhjhs" style="width: 15%">本环节耗时</th>
			<th data-options="field:'dbzhs',align:'center',formatter:dbzhs" style="width: 15%">审批总耗时</th>
			<th data-options="field:'cz',align:'center',formatter:indexCZ" style="width: 10%">操作</th>
		</tr>
	</thead>
</table>
</c:if>
<script>
function indexCZ(val, row) {
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
		'<a href="#" onclick="indexDelete(' + row.fId + ',' + url2 + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
		'</a></td>'+
		'</tr></table>';
		var b= '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="indexEdit(' + row.taskId + ',' + url + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
		'</a></td>'+'</tr></table>';
		if(url2.indexOf("/reimburse") != -1){
			return b;
		}else{
			return a;
		}
	} else {
		return "";
	}
}

//待办任务类型
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

//待办任务名称
function taskName(val, row) {
	if(val != null){
		var index = val.indexOf(']');
		val = val.substring(index+1, val.length); 
	}
	if("1"==row.type) {	//审批任务类型
		return "<span style='color:#ff6800'>[待审批] </span>"+val;
	} else if("3"==row.type) {
		return "<span style='color:red'>[已退回] </span>"+val;
	} else {
		return val;
	}
}

//待办环节耗时
function dbhjhs(val, row) {
	var sdate = new Date(row.referTime);//上环节处理人提交时间
	if(row.type==3) {//退回
		return "-";
	} else {//审批耗时
		var now = new Date();
		var time = now.getTime() - sdate.getTime();
		return timeChange(time); 
	}
}

//待办审批总耗时
function dbzhs(val, row) {
	var bdate = new Date(row.beforeTime);//任务提交时间（申请人的申请时间）
	if(row.type==3) {//退回
		return "-";
	} else {//审批耗时
		var now = new Date();
		var time = now.getTime() - bdate.getTime();
		return timeChange(time);  
	}
}
</script>
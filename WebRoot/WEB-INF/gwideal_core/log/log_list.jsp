<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<form action="" id="query_log_form" class="easyui-form" style="margin: 0px 0px 0px 0px;" onkeydown="if(event.keyCode==13){queryLog();return false; }">
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">操作人:</td> 
				<td class="top-table-td2">
					<input id="logName" size="15" class="easyui-textbox" maxlength="10" style="width: 150px;height:25px;"/>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">操作部门：</td> 
				<td class="top-table-td2">
					<input class="easyui-textbox" id="syslog_list_jwh" style="width: 150px;height:25px;">
				</td>
			
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">操作时间：</td> 
				<td style="width: 310px">
					<input type="text" id="startTime" style="width: 150px;height:25px;"/>-<input type="text" id="endTime" style="width: 150px;height:25px;"/>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryLog();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="logListArchive();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/rzgd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px"></td>
			</tr>
		</table>
	</div>
		
	<div class="list-table">
		<table id="log_dg" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/log/jsonPagination?jwhId=${bean.jwhId }&operateContent=${bean.operateContent }',
				method:'post',fit:true,pagination:true,toolbar:'#log_tb',singleSelect: true,scrollbarSize:0,
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150]">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'id',hidden:true"></th>
					<th data-options="field:'userName',align:'left',resizable:false" style="width: 7%">操作人</th>
					<!-- <th data-options="field:'jwhName',align:'left',resizable:false" style="width: 8%">操作居委</th> -->
					<th data-options="field:'createDateStr',align:'center',resizable:false" style="width: 15%">操作时间</th>
					<th data-options="field:'operateUrl',align:'center',resizable:false" style="width: 20%">操作路径</th>
					<th data-options="field:'macaddress',align:'center',resizable:false" style="width: 15%">mac地址</th>
					<th data-options="field:'ipaddress',align:'center',resizable:false" style="width: 15%">IP地址</th>
					<th data-options="field:'operateContent',align:'center',resizable:false" style="width: 20%">操作内容</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
</form>
<script type="text/javascript">
	$('#startTime').datetimebox({
        showSeconds: false,
        editable:false
    });
	$('#endTime').datetimebox({
        showSeconds: false,
        editable:false
    });
	function queryLog(){
		$('#log_dg').datagrid({
			url:'${base}/log/jsonPagination',
			queryParams:{
				logName:$('#logName').val(),
				startTime:$("#startTime").datetimebox('getValue'),
				endTime:$("#endTime").datetimebox('getValue'),
				operateContent:$("#operateContent").val(),
				jwhId:$("#syslog_list_jwh").combobox('getValue')
			}
		}); 
	}
	function logListArchive(){
		var win=creatWin('归档-操作日志',450,170,'icon-edit','/log/toArchive');
	    win.window('open');
	}
</script>
</body>

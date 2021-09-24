<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>${title}</title>
</head>
<body>
<div class="easyui-layout" fit="true">
		<div region="north" border="false" style="margin-bottom: 5px;">
			<form action=""  class="easyui-form" method="post">
				<table cellpadding="5" cellspacing="0" class="a_search_table" width="100%">
					<tr>
						<th width="100px" class="br">
						所属<c:if test="${currentUser.hasRole('QU_ROLE')==true}">街道/</c:if>居委：
						</th>
						<td width="220px" class="br">
							<div style="float: left;<c:if test="${currentUser.hasRole('QU_ROLE')==false}">display: none;</c:if>">
	          				<input id="userRefInspectorListStreet" style="width: 100px;" class="easyui-combobox" data-options="url:'${base}/street/getStreet',method:'get',valueField:'id',textField:'text',editable:false"/>
							&nbsp;
	          				</div>
							<input id="userRefInspectorListJwh" style="width: 90px;" class="easyui-combobox" data-options="url:'${base}/street/jwh?streetCode=${bean.jddm.streetCode}&jwhCode=${bean.jwhdm.jwhCode}',method:'get',valueField:'id',textField:'text',editable:false"/>
						</td>
						<th width="70px" class="br">姓名：</th>
						<td width="150px" class="br">
							<input type="text" id="refInspectorName" class="easyui-textbox"/>
						</td>
						<td class="br">
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="queryRefInspector()">查询</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div  region="center" border="false">
			<table id="inspectInspectorRefList_dg" class="easyui-datagrid"
			data-options="singleSelect:false,collapsible:true,url:'${base}/user/refInspectorJsonPagination',
			method:'post',fit:true,pagination:true,selectOnCheck: true,checkOnSelect: true,remoteSort:true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'streetName',align:'left',resizable:false,sortable:true<c:if test="${currentUser.hasRole('QU_ROLE')==false}">,hidden:true</c:if>" width="20%">街道</th>
						<th data-options="field:'jwhName',align:'left',resizable:false,sortable:true" width="20%">居委</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="20%">姓名</th>
						<th data-options="field:'job_title',align:'center',resizable:false,sortable:true" width="20%">职务</th>
						<th data-options="field:'mobile',align:'center',resizable:false,sortable:true" width="18%">手机</th>
					</tr>
				</thead>
			</table>
		</div>
		<div region="south" border="false" style="text-align: center; height: 32px; line-height: 30px;padding-left: 5px;">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="inspectInspectorRefListSure();">确认</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeFreeWindow('third_window');">关闭</a>
		</div>
</div>
<script type="text/javascript">
function inspectInspectorRefListSure(){
	var row = $('#inspectInspectorRefList_dg').datagrid('getSelected');
	var selections = $('#inspectInspectorRefList_dg').datagrid('getSelections');
	if(row!=null&&selections.length>=1){
		var inspectRuleAddItemDiv = $("#divAddRuleInspector");
		for(var i=0;i<selections.length;i++){
			if(!addRuleExist(selections[i].id)){
				refRuleArr.push(selections[i].id);
				var divInspector="<div style='float:left;margin-left:8px;margin-top:8px;' id='"+selections[i].id+"'>";
				divInspector+="<input type='hidden' name='inspectInspectorIds' value='"+selections[i].id+"'/>"+selections[i].name;
				divInspector+="<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick=\"cancelAddRule('"+selections[i].id+"')\" title='删除'/>";
				divInspector+="</div>";
				inspectRuleAddItemDiv.append(divInspector);
			}
		}
		closeFreeWindow('third_window');
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}

$(document).ready(function () {
	$("#userRefInspectorListStreet").combobox({
		onChange: function (streetCode,o) {
			$('#userRefInspectorListJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
		}
	});
});

function queryRefInspector(){
	$('#inspectInspectorRefList_dg').datagrid('load',{ 
		name:$('#refInspectorName').val(),
		jdId:$('#userRefInspectorListStreet').combobox('getValue'),
		jwhId:$('#userRefInspectorListJwh').combobox('getValue')
	} ); 
}
</script>
</body>
</html>


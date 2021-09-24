<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<div class="easyui-layout" fit="true" >
		<div data-options="region:'north'" border="false" 
			style="margin-bottom: 5px">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th width="80px">
						单位名称：
					</th> 
					<td width="100px">
						<input id="depart_cquery_name" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">
						单位代码：
					</th> 
					<td width="140px">
						<input id="depart_cquery_code" style="width: 150px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="queryChooseQuota();">查询</a>
					</td>
				</tr>
			</table>           
		</div>
		
		
		
		<div  region="center" border="false">
			
			<table id="depart_choose_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/depart/jsonPagination',
			method:'post',fit:true,pagination:false,singleSelect: true,rownumbers:true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'name',align:'center'" width="20%">单位名称</th>
						<th data-options="field:'code',align:'center'" width="20%">单位代码</th>
					</tr>
				</thead>
			</table>
		<div class="easyui-pagination" data-options="
					total:114,
					layout:['list','sep','first','prev','links','next','last','sep','refresh','info']
				"></div>
		</div>
		<div region="south" border="false">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconcls="icon-edit" onclick="confirmDepart()">确认选择</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconcls="icon-cancel" onclick="closeFirstWindow()">取消</a> 
		</div>
	</div>
	


<script type="text/javascript">

function queryChooseQuota(){  
	$('#depart_choose_dg').datagrid({
		url:'${base}/depart/jsonPagination',
		queryParams:{
			name:$('#depart_cquery_name').textbox('getValue'),
			code:$('#depart_cquery_code').textbox('getValue')
		}
	});
}
function confirmDepart(){
	var row = $('#depart_choose_dg').datagrid('getSelected');
	var selections = $('#depart_choose_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		$('#quota_add_FDeptID').val(row.id);
		$('#quota_add_FDeptName').textbox('setValue',row.name);
		closeFirstWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
</script>
</body>
</html>


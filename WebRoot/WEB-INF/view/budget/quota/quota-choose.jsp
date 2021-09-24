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
						指标名称：
					</th> 
					<td width="100px">
						<input id="quota_query_FBIndexName" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">
						指标类型：
					</th> 
					<td width="140px">
						<input id="quota_query_FIndexType" style="width: 150px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">
						使用部门：
					</th> 
					<td width="140px">
						<input id="quota_query_FDeptName" style="width: 150px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="queryChooseQuota();">查询</a>
					</td>
				</tr>
			</table>           
		</div>
		
		
		
		<div  region="center" border="false">
			
			<table id="quota_choose_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/quota/dataList',
			method:'post',fit:true,pagination:false,singleSelect: true,rownumbers:true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'fbindexName',align:'center'" width="20%">指标名称</th>
						<th data-options="field:'fbindexCode',align:'center'" width="20%">指标编号</th>
						<th data-options="field:'findexTypeName',align:'center'" width="20%">指标类型</th>
						<th data-options="field:'fdeptName',align:'center'" width="20%">使用部门</th>
						<th data-options="field:'fisOpen',align:'center'" width="20%">是否公共指标</th>
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
				iconcls="icon-edit" onclick="confirmParentQuota()">确认选择</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconcls="icon-cancel" onclick="closeFirstWindow()">取消</a> 
		</div>
	</div>
	


<script type="text/javascript">

function queryChooseQuota(){  
	$('#quota_choose_dg').datagrid({
		url:'${base}/quota/dataList',
		queryParams:{
			FBIndexName:$('#quota_query_FBIndexName').textbox('getValue'),
			FIndexType:$('#quota_query_FIndexType').textbox('getValue'),
			FDeptName:$('#quota_query_FDeptName').textbox('getValue')
		}
	});
}
function confirmParentQuota(){
	var row = $('#quota_choose_dg').datagrid('getSelected');
	var selections = $('#quota_choose_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		$('#quota_add_FEcCode').numberbox('setValue',row.fbindexCode);
		$('#quota_add_FEcName').textbox('setValue',row.fbindexName);
		closeFirstWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
</script>
</body>
</html>


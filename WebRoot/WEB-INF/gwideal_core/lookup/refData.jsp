<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"></meta>
<title></title>
<script type="text/javascript">

</script>
</head>
<body>
	
	<div class="easyui-layout" fit="true">
		<div data-options="region:'north'" border="false" style="margin-bottom: 5px;">
			<form action="" id="query_lookupref_form" class="easyui-form" style="margin: 0px 0px 0px 0px;">
				<table cellpadding="5" cellspacing="0" class="a_search_table" width="100%" border="0" >
				    <input type="hidden" value="${selectType}" id="selectType_lookups"></input>
					<tr>
						<th class="br" width="80">
							名称：
						</th>
						<td class="br" width="20%">
							<input class="easyui-textbox" style="width:170px" id="ref_lookupname"></input>
						</td>
						<td class="br">
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="querystdLookups()">查询</a>&nbsp;&nbsp;
							
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="selectLookups()">选定</a>
						</td>
					</tr>
					
				</table>
			</form>
		</div>
		<div region="center" border="false">
			<table id="lookupref_selectdg" class="easyui-datagrid"
					data-options="collapsible:true,rownumbers:true,url:'${base}/lookup/jsonPagination?categoryCode=YHZGX',
					method:'post',fit:true,pagination:true,toolbar:'',singleSelect:true,
					selectOnCheck:true,checkOnSelect: true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',align:'left',resizable:true,sortable:true" width="90%">名称</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<script type="text/javascript">  
		function selectLookups(){
			var type= $('#selectType_lookups').val();
			var row = $('#lookupref_selectdg').datagrid('getSelections');
			if(row!=null&&row.length==1){
				for(var i=0;i<row.length;i++){
					if(type=='YJZDHZGX'){
						$("#person_add_yhzgxhz").val(row[i].name);
						$("#person_edit_yhzgxhz").val(row[i].name);
					}else if(type=='YHJDHZGX'){
						$("#person_add_yzjzrgxhz").val(row[i].name);
						$("#person_edit_yzjzrgxhz").val(row[i].name);
					}
				    closeSearchDateWindow();
				}
			}else{
				 $.messager.alert('系统提示','请选择一条数据！','info');
			}
		}		 
		
		function querystdLookups(){
			$('#lookupref_selectdg').datagrid('load',{
				selectType:'${selectType}',
				name:$('#ref_lookupname').textbox("getValue")
			} ); 
		} 
	

	</script>
</body>
</html>


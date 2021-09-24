<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
	<script type="text/javascript">
		function editCategory(){
			var row = $('#category_dg').datagrid('getSelected');
			var selections = $('#category_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
			    var win=creatWin('修改-字典类型信息',650,330,'icon-edit','/category/edit/'+row.id);
			    win.window('open');
			}else{
				 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
			}
		}
		function addCategory(){
			var node=$('#CategoryTree').tree('getSelected');
			var win=creatWin('新增-字典类型信息',650,330,'icon-add','/category/add');
			if(null!=node){
				win=creatWin('新增-字典类型信息',650,330,'icon-add','/category/add?code='+node.code);
				win.window('open');
			}else{
				win.window('open');
			}
		}
		function deleteCategory(){
			var row = $('#category_dg').datagrid('getSelected');
			var selections = $('#category_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
				$.messager.confirm('系统提示','确认删除吗?',function(r){
					if(r){
						$.ajax({ 
							type: 'POST', 
							url: '${base}/category/delete/'+row.id,
							dataType: 'json',  
							success: function(data){ 
								if(data.success){
									$.messager.alert('系统提示',data.info,'info');
									$("#category_dg").datagrid('reload');
								}else{
									$.messager.alert('系统提示',data.info,'error');
								}
							} 
						});
					}
				});
			}else{
				 $.messager.alert('系统提示','请选择一条数据！','info');
			}
		}
		function queryCategory(){
			$('#category_dg').datagrid('load',{ 
				name:$('#categoryName').val()
			}); 
		}
	</script>

    <div class="easyui-layout" fit="true">
    <div data-options="region:'west',split:false"  style="width:200px;">
		<ul id="CategoryTree" class="easyui-tree" data-options="url:'${base}/category/tree',animate:true,lines:true"></ul>
	</div>
	<div data-options="region:'center'" style="background-color: #f0f5f7">
	
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">字典类型名称</td> 
					<td class="top-table-td2">
						<input id="categoryName" class="easyui-textbox" size="15" maxlength="10" style="width: 150px;height:25px;" />
					</td>
					
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="queryCategory();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
					<%-- <gwideal:perm url="/category/add"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="addCategory();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm>
					
					<gwideal:perm url="/category/edit/{id}"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="editCategory();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm>
					
					<gwideal:perm url="/lookup/delete/{id}"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="deleteCategory();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm> --%>
					
					
					<td align="right" style="padding-right: 10px"></td>
				</tr>
			</table>
		</div>
	
		<div class="list-table" style="height: 90%">
			<table id="category_dg" class="easyui-datagrid"
					data-options="singleSelect:true,collapsible:true,url:'${base}/category/jsonPagination',
					method:'post',fit:true,pagination:true,toolbar:'#category_tb',singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150]">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'code',align:'center',resizable:false,sortable:true" width="20%">字典类型代码</th>
						<th data-options="field:'name',align:'center',resizable:false" width="20%">字典类型名称</th>
						<th data-options="field:'parentName',align:'center',resizable:false" width="20%">父字典类型名称</th>
						<th data-options="field:'orderNo',align:'center',resizable:false" width="15%">排列顺序</th>
						<th data-options="field:'description',align:'left',resizable:false" width="23%">说明</th>
					</tr>
				</thead>
			</table>
		</div>
   </div>
</div>

<script type="text/javascript">
$('#CategoryTree').tree({
	onClick: function(node){
		$('#category_dg').datagrid('load',{ 
			code:node.code
		}); 
	}
});
</script>
</body>
</html>

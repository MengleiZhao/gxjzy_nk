<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'west',split:false"  style="width:250px;">
		<ul id="lookupsCategoryTree" class="easyui-tree" data-options="url:'${base}/category/tree',animate:true,lines:true"></ul>
	</div>
	<div data-options="region:'center'" style="background-color: #f0f5f7">
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">字典项名称</td> 
					<td class="top-table-td2">
						<input id="lookupName" class="easyui-textbox" size="15"  maxlength="10" style="width: 150px;height:25px;"/>
					</td>
					
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="queryLookup();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
					<%-- <gwideal:perm url="/lookup/add"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="addLookup();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm>
					
					<gwideal:perm url="/lookup/edit/{id}"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="editLookup();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm>
					
					<gwideal:perm url="/lookup/delete/{id}"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="deleteLookup();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm> --%>
					
					
					<td align="right" style="padding-right: 10px"></td>
					
				</tr>
			</table>
		</div>
		
		<div class="list-table" style="height: 90%">
			<table id="lookup_dg" border="0" class="easyui-datagrid"
					data-options="singleSelect:true,collapsible:true,url:'${base}/lookup/jsonPagination',
					method:'post',fit:true,pagination:true,toolbar:'#lookup_tb',singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150]">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'code',align:'left',resizable:false,sortable:true" width="15%">字典项代码</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="20%">字典项名称</th>
						<th data-options="field:'shortName',align:'center',resizable:false,sortable:true" width="15%">字典项简称</th>
						<th data-options="field:'categoryName',align:'center',resizable:false" width="20%">字典类型名称</th>
						<th data-options="field:'categoryCode',align:'center',resizable:false" width="10%">字典类型代码</th>
						<th data-options="field:'orderNo',align:'center',resizable:false" width="8%">排列顺序</th>
						<th data-options="field:'description',align:'center',resizable:false" width="10%">说明</th>
					</tr>
				</thead>
			</table>
		</div>
    </div>
</div>
<script type="text/javascript">
	function deleteLookup(){
		var row = $('#lookup_dg').datagrid('getSelected');
		var selections = $('#lookup_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			$.messager.confirm('系统提示','确认删除吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/lookup/delete/'+row.id,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#lookup_dg").datagrid('reload');
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
	function queryLookup(){
		$('#lookup_dg').datagrid('load',{ 
			name:$('#lookupName').val()
		}); 
	}
	function addLookup(){
		var node=$('#lookupsCategoryTree').tree('getSelected');
		var win=creatWin('新增-字典项信息',750,450,'icon-add','/lookup/add');
		if(null!=node){
			win=creatWin('新增-字典项信息',750,450,'icon-add','/lookup/add?categoryCode='+node.code);
			win.window('open');
		}else{
			$.messager.alert('系统提示','请先选择字典类型信息！','info');
			return;
		}
	}
	function editLookup(){
		var row = $('#lookup_dg').datagrid('getSelected');
		var selections = $('#lookup_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('修改-字典项信息',750,450,'icon-edit','/lookup/edit/'+row.id);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');
		}
	}
	$('#lookupsCategoryTree').tree({
		onClick: function(node){
			$('#lookup_dg').datagrid('load',{ 
				categoryCode:node.code
			}); 
		}
	});
</script>

</body>
</html>


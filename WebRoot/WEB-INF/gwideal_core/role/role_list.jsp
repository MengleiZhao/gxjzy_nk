<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
	<script type="text/javascript">
		function editRole(){
			var row = $('#role_dg').datagrid('getSelected');
			var selections = $('#role_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
			    var win=creatWin('修改-角色信息',540,500,'icon-edit','/role/edit/'+row.id);
			    win.window('open');
			}else{
				 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
			}
		}
		function addRole(){
			var win=creatWin('新增-角色信息',540,500,'icon-add','/role/add');
			win.window('open');
		}
		 //删除
		function deleteRole(id) {
			var row = $('#role_dg').datagrid('getSelected');
			var selections = $('#role_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
				if (confirm("确认删除吗？")) {
					$.ajax({
						type : 'POST',
						url : '${base}/role/delete?id='+row.id,
						dataType : 'json',
						success : function(data) {
							if (data.success) {
								$.messager.alert('系统提示', data.info, 'info');
								$('#role_dg').datagrid("reload");
							} else {
								$.messager.alert('系统提示', data.info, 'error');
							}
						}
					});
				}
			} 
		}
		function queryRole(){
			$('#role_dg').datagrid('load',{ 
				name:$('#roleName').val(),
				departid:$('#departid').val()
			}); 
		}
		function viewRole(){
			var row = $('#role_dg').datagrid('getSelected');
			var selections = $('#role_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
			    var win=creatWin('角色信息-查看',650,230,'icon-search','/role/view/'+row.id);
			    win.window('open');
			}else{
				 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
			}
		}
	</script>
	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">角色名称</td> 
				<td class="top-table-td2">
					<input id="roleName" class="easyui-textbox" size="15"  maxlength="10" style="width: 150px;height:25px;"/>
				</td>
				<td class="top-table-td1">归属部门: </td> 
				<td colspan="4">
					<input class="easyui-combobox" style="width: 200px;height: 30px; "  id="departid" name="departid"   data-options="editable:false,panelHeight:'auto',url:'${base}/apply/chooseDepart?selected=${bean.suggestDepId}',method:'POST',valueField:'code',textField:'text',editable:false"/>
				</td>
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryRole();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<%-- <gwideal:perm url="/role/add"> --%>
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="addRole();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<%-- </gwideal:perm> --%>
				
				<%-- <gwideal:perm url="/role/edit/{id}"> --%>
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="editRole();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="deleteRole();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shanchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<%-- </gwideal:perm> --%>
				
				<td align="right" style="padding-right: 5px"></td>
			</tr>
		</table>
	</div>

	<div class="list-table">
		<table id="role_dg" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/role/jsonPagination',
				method:'post',fit:true,pagination:true,toolbar:'#role_tb',singleSelect: true,scrollbarSize:0,
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<!-- <th data-options="field:'id',hidden:true"></th>
					<th data-options="field:'code',align:'left',resizable:false,sortable:true" width="13%">角色代码</th> -->
					<th data-options="field:'name',align:'center',resizable:false" width="15%">角色名称</th>
					<th data-options="field:'departname',align:'center',resizable:false" width="15%">归属部门</th>
					<th data-options="field:'orderNo',align:'center',resizable:false" width="10%">排列顺序</th>
					<th data-options="field:'description',align:'left',resizable:false" width="57%">说明</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
</body>

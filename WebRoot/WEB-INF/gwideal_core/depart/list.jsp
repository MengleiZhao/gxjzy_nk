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
		function editDepart(){
			var row = $('#depart_dg').datagrid('getSelected');
			var selections = $('#depart_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
			    var win=creatWin('修改-部门信息',700,300,'icon-edit','/depart/edit/'+row.id);
			    win.window('open');
			}else{
				 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
			}
		}
		function addDepart(){
			var node=$('#DepartTree').tree('getSelected');
			var win=creatWin('新增-部门信息',700,300,'icon-add','/depart/add');
			if(null!=node){
				win=creatWin('新增-部门信息',700,300,'icon-add','/depart/add?id='+node.id);
				win.window('open');
			}else{
				win.window('open');
			}
		}
		function deleteDepart(){
			var row = $('#depart_dg').datagrid('getSelected');
			var selections = $('#depart_dg').datagrid('getSelections');
			if(null!=row && selections.length==1){
				/* if(row.status=='10'){
					$.messager.alert('系统提示','离岗后才能删除!','info');
					return;
				} */
				$.messager.confirm('系统提示','确认删除用户吗?',function(r){
					if(r){
						$.ajax({ 
							type: 'POST', 
							url: '${base}/depart/delete/'+row.id,
							dataType: 'json',  
							success: function(data){ 
								if(data.success){
									$.messager.alert('系统提示',data.info,'info');
									$("#depart_dg").datagrid('reload');
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
		function queryDepart(){
			$('#depart_dg').datagrid('load',{ 
				name:$('#departName').val(),
				code:$('#departCode').val()
			}); 
		}
	</script>

    <div class="easyui-layout" fit="true">
        <div data-options="region:'west',split:false"  style="width:200px;">
		 	<ul id="DepartTree" class="easyui-tree" data-options="url:'${base}/depart/tree',animate:true,lines:true"></ul>
	    </div>
	<div data-options="region:'center'" style="background-color: #f0f5f7">   
	
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>	
					<td class="top-table-search" style="width:70%;">&nbsp;部门名称
						<input id="departName" class="easyui-textbox" size="15" maxlength="10" style="width: 150px;height:25px;"/>
						&nbsp;&nbsp;部门代码&nbsp;
						<input id="departName" class="easyui-textbox" size="15" maxlength="10" style="width: 150px;height:25px;"/>
						&nbsp;&nbsp;
						<a href="#" onclick="queryDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="addDepart();">
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="editDepart();">
							<img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="deleteDepart();">
							<img src="${base}/resource-modality/${themenurl}/button/shanchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
					<%-- <td class="top-table-td1">部门名称:</td> 
					<td class="top-table-td2">
						<input id="departName" class="easyui-textbox" size="15"maxlength="10" style="width: 150px;height:25px;"/>
					</td>
					
					<td style="width: 30px;"></td>
					
					<td class="top-table-td1">部门代码:</td> 
					<td class="top-table-td2">
						<input id="departCode" class="easyui-textbox" size="15" maxlength="10"  style="width: 150px;height:25px;"/>
					</td>
					
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="queryDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> --%>
					
			<%-- 		<gwideal:perm url="/depart/add">
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="addDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					</gwideal:perm>
					
					<gwideal:perm url="/depart/edit/{id}">
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="editDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					</gwideal:perm> --%>
				</tr>
	 		</table>
	 	</div>
	 		
		<div class="list-table" style="height: 90%">
			<table id="depart_dg" class="easyui-datagrid"
					data-options="singleSelect:true,collapsible:true,url:'${base}/depart/jsonPagination',
					method:'post',fit:true,pagination:true,toolbar:'#depart_tb',singleSelect: true,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<!-- <th data-options="field:'orderNo',align:'center',resizable:false" width="8%">排列顺序</th> -->
						<th data-options="field:'code',align:'center',resizable:false,sortable:true" width="20%">部门代码</th>
						<th data-options="field:'type',align:'center',resizable:false,formatter:getTypeName" width="10%">类型</th>
						<th data-options="field:'name',align:'center',resizable:false" width="20%">部门名称</th>
						<th data-options="field:'parentName',align:'center',resizable:false" width="20%">上级部门名称</th>
						<th data-options="field:'managerName',align:'center',resizable:false" width="10%">主管领导</th>
						<th data-options="field:'description',align:'left',resizable:false" width="20%">说明</th>
					</tr>
				</thead>
			</table>
		</div>
  </div>
</div>

<script type="text/javascript">
$('#DepartTree').tree({
	onClick: function(node){
		$('#depart_dg').datagrid('load',{ 
			id:node.id
		}); 
	}
});
function getTypeName(code){
	if (code=='COMPANY') {
		return "单位";
	} else if (code=='DEPART') {
		return "部门";
	}
}
</script>
</body>
</html>

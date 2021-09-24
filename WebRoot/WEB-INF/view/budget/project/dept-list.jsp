<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
   <!--  <div class="easyui-layout" fit="true"> -->
    <div class="list-div">
	<!-- <div data-options="region:'center'" style="background-color: #f0f5f7">    -->
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
						&nbsp;&nbsp;
						<%-- <a href="#" onclick="editDepart();">
							<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a> --%>
						<a href="#" onclick="editDepart();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
	 		</table>
	 	</div>
	 		
		<div class="list-table" style="height: 90%">
			<table id="depart_dgs" class="easyui-datagrid"
					data-options="singleSelect:true,collapsible:true,url:'${base}/project/deptJsonPagination?xmid=${xmid}',
					method:'post',fit:true,pagination:true,toolbar:'#depart_tb',singleSelect: false,scrollbarSize:0,
					selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true,onLoadSuccess:onLoadSuccessUserCheck">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'code',align:'center',resizable:false,sortable:true" width="40%">部门代码</th>
						<th data-options="field:'type',align:'center',resizable:false,formatter:getTypeName" width="20%">类型</th>
						<th data-options="field:'name',align:'center',resizable:false" width="40%">部门名称</th>
						<!-- <th data-options="field:'parentName',align:'center',resizable:false" width="20%">上级部门名称</th>
						<th data-options="field:'managerName',align:'center',resizable:false" width="10%">主管领导</th>
						<th data-options="field:'description',align:'left',resizable:false" width="20%">说明</th> -->
					</tr>
				</thead>
			</table>
		</div>
  </div>
</div>

<script type="text/javascript">
$('#DepartTree').tree({
	onClick: function(node){
		$('#depart_dgs').datagrid('load',{ 
			id:node.id
		}); 
	}
});

function onLoadSuccessUserCheck(){
	var dept = '${dept}';
	var deptids = dept.split(",");
	var rows = $('#depart_dgs').datagrid('getRows');
	for (var i = 0; i < deptids.length; i++) {
		for (var j = 0; j < rows.length; j++) {
			if(deptids[i]==rows[j].id){
				$('#depart_dgs').datagrid('selectRow',j);
			}
		}
	}
}

function getTypeName(code){
	if (code=='COMPANY') {
		return "单位";
	} else if (code=='DEPART') {
		return "部门";
	}
}

function editDepart(){
	var ids = '';
	//var row = $('#depart_dgs').datagrid('getSelected');
	var rows = $('#depart_dgs').datagrid('getSelections');
	//var selections = $('#depart_dgs').datagrid('getSelections');
	if(null!=rows || rows != ''){
		for (var i = 0 ; i < rows.length ; i++) {
			ids=ids + rows[i].id+',';
		}
		ids = ids.substr(0,ids.length-1);
		$('#depart_dgs').load('${base}/project/saveDept?id='+${xmid}+'&ids='+ids);
		closeWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条要保存的数据！','info');
	}
} 
function queryDepart(){
	$('#depart_dgs').datagrid('load',{ 
		name:$('#departName').val(),
		code:$('#departCode').val()
	}); 
}
</script>
</body>
</html>

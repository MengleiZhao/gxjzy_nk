
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
</style>
</head>
<!-- 绑定角色页面 -->
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'north'" border="false" style="width: 100%;font-size: 12px;height: 40px;">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th class="top-table-td1">姓名：</th> 
					<td class="top-table-td2">
						<input id="bindingRole_roleName" name="" style="width: 90px;height:25px;" class="easyui-textbox"></input>
						<input type="hidden" id="bindingRole_roleId" name="roleId"  value="${node.roleId}"/>
						<input type="hidden" id="bindingRole_departId" name="departId"  value="${node.departId}" />
						<input type="hidden" id="bindingRole_fill" name="fill"  value="${node.fill}" />
						<input type="hidden" id="bindingRole_stepType" name="stepType"  value="${node.stepType}" />
						<input type="hidden"   id="bindingRole_keyId" name="keyId" value="${node.key}"/>
						<input type="hidden"   id="bindingRole_category" name="keyId" value="${node.category}"/>
						<input type="hidden" id="bindingRole_loc" name="loc" value="${node.loc}"/>
						<input type="hidden" id="bindingRole_agree" name="agree" value="${node.agree}"/>
						<input type="hidden" id="bindingRole_refuse" name="refuse" value="${node.refuse}"/>
					</td>
					<th class="top-table-td1">部门名称：</th> 
					<td class="top-table-td2">
						<input id="bindingRole_departName" name=""  style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="save();"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
				</tr>
			</table>           
		</div>
		<div  region="center" border="false">
			<table id="M_nameAndDept_dg" 
			data-options="collapsible:true,url:'${base}/wflow/allUser',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'userId',hidden:true"></th>
						<!-- <th data-options="field:'roleName',align:'center',resizable:false,sortable:true" width="30%">角色</th>
						<th data-options="field:'departName',align:'center',resizable:false,sortable:true" width="35%">部门</th> -->
						<th data-options="field:'departName',align:'center'" width="50%">部门</th>
						<th data-options="field:'userName',align:'center'" width="50%">姓名</th>
					</tr>
				</thead>
			</table>
		</div>

	</div>
	

<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#M_nameAndDept_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
function save(){
	var row = $('#M_nameAndDept_dg').datagrid('getSelected');
	var selections = $('#M_nameAndDept_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		var name=row.userName;//姓名
		var userId=row.userId;//用户id
		var loc=$("#bindingRole_loc").val();//坐标
		var keyId=parseInt($("#bindingRole_keyId").val());//key
		var fill=$("#bindingRole_fill").val();//key
		var stepType=$("#bindingRole_stepType").val();//节点类型
		var category=$("#bindingRole_category").val();//节点模型
		var agree=$("#bindingRole_agree").val();//同意跳转节点
		var refuse=$("#bindingRole_refuse").val();//不同意跳转节点
		var nodeJson = {"category":category,"key":keyId,"keyId":keyId,"text":name,"loc":loc,"agree":agree,"refuse":refuse,"fill":"#"+fill,"stepType":stepType,"userId":userId};//
		myDesigner.updateNodeDataByKey(keyId,nodeJson);
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#M_nameAndDept_dg').datagrid('load',{ 
		roleName:$('#bindingRole_roleName').textbox('getValue'),
		departName:$('#bindingRole_departName').textbox('getValue')
		//accountNo:$('#M_nameAndDept_accountNo').textbox('getValue'),
	} ); 
}
</script>
</body>
</html>


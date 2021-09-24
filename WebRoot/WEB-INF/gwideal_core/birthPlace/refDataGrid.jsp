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
function bp_select_search(){
	$('#bp_select_dg').datagrid('reload',{
		name:$('#bp_select_name').val(),
		code:$('#bp_select_code').val()
	});	 
}

function select_bp_dg(row){
	var t = $('#selectType').val();
	if(row==undefined){
		row = $('#bp_select_dg').datagrid('getSelections');
	}
	if(row==""){
		$.messager.alert('系统提示',"请选择一条记录！",'info');
		return;
	}
	if(row.length>0){
		for(var i=0;i<row.length;i++){
			$("#birthPlaceName").textbox("setValue",row[i].name);
	 		$("#birthPlaceCode").val(row[i].code);
		}
	}
	closeSearchDateWindow();
}


//页面加载完成 控制单选或多选
$(function(){
	var t = $('#selectType').val();
	if(t=='multi'){
		$('#bp_select_dg').datagrid({
			singleSelect:false
		});
	}else if(t=='birthPlace'){
		$('#bp_select_dg').datagrid({
			singleSelect:true
		});
	}
});

</script>

<div class="main auto clearfix" style="width: 465px">
<input id="selectType" type="hidden" value="${selectType}">

	<div id="bp_select_tb" style="padding:8px 10px;">
		籍贯名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="bp_select_name"/>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="bp_select_search();">查询</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="select_bp_dg()" style="width: 70px;">选择</a>&nbsp;
	</div>


	<div>
	<table id="bp_select_dg" class="easyui-datagrid"
		data-options="
			url:'${base}/birthPlace/jsonDg',
			rownumbers:true, 
			border:false,
			singleSelect:false,
			method:'post',
			idField:'id',
			treeField:'text',
			pageSize:25,
			pagination:true,
			toolbar:'#bp_select_tb',
			pageList:[25,50,100]
			">
		<thead>
			<tr>
				<th field="id" width="15px" checkbox="true">籍贯id</th>
				<th field="name" width="300px">籍贯名称</th>
				<th field="code" width="100px">籍贯代码</th>
			</tr>
		</thead>
	</table>
	</div>
</div>
</body>

</html>

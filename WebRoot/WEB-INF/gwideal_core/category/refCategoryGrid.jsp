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
function queryCategoryTree(){
	$('#category_select_tree').treegrid('reload',{
		name:$('#category_name').val()
	});	 
}

function selecCategoryTree(row){
	//调用父窗口方法
	var t = $('#category_selectType').val();
	var num = $('#category_num').val();
	if(row==undefined){
		row = $('#category_select_tree').treegrid('getSelections');
	}
	if(row==""){
		$.messager.alert('系统提示',"请选择一条记录！",'info');
		return;
	}
	var ids = "";
	var names = "";
	var nameid = "";
	var id = "";
	var name = "";
	if(row.length>0){//复选框多选
		for(var i=0;i<row.length;i++){
			id = row[i].id;
			name = row[i].text;
			nameid+=id+":"+name+",";
			ids+=ids==""?id:","+id;
			names+=names==""?name:","+name;
		}
	}else{//双击选择单个
		//if(row.haveChild=='1'){
		//	$.messager.alert('系统提示',"请选择所属单位！",'info');
		//	return;
		//}
		id = row.id;
		name = row.name;
		nameid+=id+":"+name+",";
		ids+=ids==""?id:","+id;
		names+=names==""?name:","+name;
	}
	var rtnValue = ids + '&&' + names + '&&' +nameid;
	
	if(window.navigator.userAgent.indexOf("Chrome")>-1){
		window.opener.returnValue = rtnValue;
	}else{
		window.returnValue = rtnValue;
	}
	
	
	

	categoryReturnSelect(rtnValue);
	
	closeSearchDateWindow();
}




</script>


<div class="easyui-layout" fit="true">
<div region="center" border="false">

<div class="main auto clearfix"  style="width: 450px">
<input id="category_selectType" type="hidden" value="${selectType}">
<input id="category_num" type="hidden" value="${num}">



	<div id="category_tb" style="padding:8px 10px;">
		字典类型名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="category_name"/>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="queryCategoryTree();">查询</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="selecCategoryTree()" style="width: 70px;">新增</a>&nbsp;
	</div>


	<div>
	<table id="category_select_tree"  class="easyui-treegrid"
		data-options="
			url:'${base}/category/treeGrid?parentId=${selectType}',
			rownumbers:true, 
			border:false,
			method:'post',
			idField:'id',
			treeField:'text',
			fitColumns:true,
			scrollbarSize :0
			">
		<thead>
			<tr>
				<th field="id" width="100px" checkbox="true" name="rid">字典类型名称代码</th>
				<th field="text" width="100px">字典类型名称</th>
				<th field="code" data-options="hidden:true" width="450px"></th>
			</tr>
		</thead>
	</table>
	</div>
	
	
</div>
</div>
</div>
</body>

</html>

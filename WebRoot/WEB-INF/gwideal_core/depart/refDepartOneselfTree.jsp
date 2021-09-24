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
function queryDepartOneself(){
	$('#depart_oneself_select_tree').treegrid('reload',{
		name:$('#oneself_departName').val(),
		code:$('#user_departCode').val()
	});	 
}

function selectDepartOneselfTree(row){
	//调用父窗口方法
	var t = $('#depart_oneself_selectType').val();
	var num = $('#depart_oneself_num').val();
	var depart_id = $('#depart_oneself_id').val();
	if(row==undefined){
		row = $('#depart_oneself_select_tree').treegrid('getSelections');
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
	
	/* if(window.navigator.userAgent.indexOf("Chrome")>-1){
		window.opener.returnValue = rtnValue;
	}else{
		window.returnValue = rtnValue;
	} */
	if (window.opener != undefined) { //for chrome 
		window.opener.returnValue = rtnValue; 
	} else { 
		window.returnValue = rtnValue; 
		} 
	departOneselfReturnSelect(rtnValue);
	
	closeSearchDateWindow();
}




</script>


<div class="easyui-layout" fit="true">
<div region="center" border="false">
<div class="main auto clearfix"  style="width: 470px">
<input id="depart_oneself_selectType" type="hidden" value="${selectType}">
<input id="depart_oneself_num" type="hidden" value="${num}">
<input id="depart_oneself_id" type="hidden" value="${depart_id}">


	<div id="depart_oneself_tb" style="padding:8px 10px;">
		部门名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="oneself_departName"/>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="queryDepartOneself();">查询</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="selectDepartOneselfTree()" style="width: 70px;">确认</a>&nbsp;
	</div>


	<div>
	<table id="depart_oneself_select_tree"  class="easyui-treegrid"
		data-options="
			url:'${base}/depart/treeGrid',
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
				<th field="id" width="100px" checkbox="true" name="rid">部门id</th>
				<th field="text" width="450px">部门名称</th>
			</tr>
		</thead>
	</table>
	</div>
	
	
</div>
</div>
</div>
</body>

</html>

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
function queryUser(){
	$('#user_dg').datagrid('load',{ 
		name:$('#userName').val(),
		mobileNo:$('#mobileNo').val()
	}); 
}
function clearQuery(){
	$('#departName').textbox('setValue',"");
	$('#departCode').textbox('setValue',"");
}

function selectUser(row){
	if(row==undefined){
		row = $('#user_dg').datagrid('getSelections');
	}
	var ids = "";
	var names = "";
	var nameid = "";
	var id = "";
	var name = "";
	if(row.length>0){//复选框多选
		for(var i=0;i<row.length;i++){
			if(row[i].haveChild=="1"){
				alert("请选择所属单位！");
				return;
			}
			id = row[i].id;
			//var code=row[i].code;
			name = row[i].name;
			nameid+=id+":"+name+",";
			ids+=ids==""?id:","+id;
			names+=names==""?name:","+name;
		}
	}else{//双击选择单个
		if(row.haveChild=='1'){
			alert('请选择所属单位！');
			return;
		}
		id = row.id;
		name = row.name;
		nameid+=id+":"+name+",";
		ids+=ids==""?id:","+id;
		names+=names==""?name:","+name;
	}
	if(row==""){
		alert("请选择一条记录！");
		return;
	}
	var rtnValue = ids + '&&' + names + '&&' +nameid;
	//alert(rtnValue);
	if(window.navigator.userAgent.indexOf("Chrome")>-1){
		window.opener.returnValue = rtnValue;
	}else{
		window.returnValue = rtnValue;
	}
	//调用父窗口方法
	userSearch1(rtnValue);
	
	closeWindow();
	//parent.window.closeWind();  
	//window.close();
}

$(function(){
	var t = $('#selectType').val();
	if(t=='single'){
		$('#user_dg').datagrid({
			singleSelect:true
		});
	}else if(t=='multi'){
		$('#user_dg').datagrid({
			singleSelect:false
		});
	}
});

</script>



<div class="main auto clearfix" style="width: 700px">
<input id="selectType" type="hidden" value="${selectType}">
     <!--right start-->
    <div class=""  id="" style="height: 650px; width: 615px">
		<div id="depart_tb" style="padding:8px 10px;">
			姓名: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="userName"/>&nbsp;
			手机号码： <input type="text" size="15" class="easyui-textbox" maxlength="10" id="mobileNo"/>&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="queryUser();">查询</a>&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="selectUser()" style="width: 70px;">确认</a>&nbsp;
		</div>
	
		<table id="user_dg" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/user/jsonPaginationMsgReceiver',
				method:'post',fit:true,pagination:true,toolbar:'#depart_tb',
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:25,pageList:[25,50,100],rownumbers:true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'id',hidden:true"></th>
					<th data-options="field:'name',align:'center',resizable:false" width="25%">姓名</th>
					<th data-options="field:'mobileNo',align:'left',resizable:false,sortable:true" width="30%">手机号码</th>
					<th data-options="field:'departName',align:'left',resizable:false,sortable:true" width="45%">部门名称</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
</body>

<script type="text/javascript">

</script>

</html>

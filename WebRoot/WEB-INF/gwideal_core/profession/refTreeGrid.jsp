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
function professionDepart(){
	$('#profession_select_dg').treegrid('reload',{
		name:$('#professionName').val(),
		code:$('#professionCode').val()
	});	 
}

function selectProfessionTree(row){
	var t = $('#selectType').val();
	if(row==undefined){
		row = $('#profession_select_dg').treegrid('getSelections');
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
	}
	var rtnValue = ids + '&&' + names + '&&' +nameid;
	
	if(window.navigator.userAgent.indexOf("Chrome")>-1){
		window.opener.returnValue = rtnValue;
	}else{
		window.returnValue = rtnValue;
	}
	if(t=='single'){
		
	}else if(t=='profession'){
		professionSearch1(rtnValue);
	}
	closeWindow();
}


//页面加载完成 控制单选或多选
$(function(){
	var t = $('#selectType').val();
	if(t=='single'){
		$('#profession_select_dg').treegrid({
			singleSelect:true
		});
	}else if(t=='multi' || t=='profession' || t=='popuType'){
		$('#profession_select_dg').treegrid({
			singleSelect:false
		});
	}
});

</script>



<div class="main auto clearfix" style="width: 700px">
<input id="selectType" type="hidden" value="${selectType}">


	<div id="profession_select_tb" style="padding:8px 10px;">
		职业类别名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="professionName"/>&nbsp;
		职业类别代码: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="professionCode"/>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="professionDepart();">查询</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="selectProfessionTree()" style="width: 70px;">添加</a>&nbsp;
	</div>


	<div>
	<table id="profession_select_dg" class="easyui-datagrid" width="100%"
				data-options="collapsible:true,url:'${base}/profession/dataGrid',
				method:'post',fit:true,pagination:true,toolbar:'#profession_select_tb',
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:15,pageList:[15,50,100],rownumbers:true,onLoadSuccess:function(){
                        $('#profession_select_dg').datagrid('selectAll');
                        $('#profession_select_dg').datagrid('unselectAll');
                    }">
		<thead>
			<tr>
				<th field="id" width="15px" checkbox="true" name="rid">职业id</th>
				<th field="text" width="360px">职业类别名称</th>
				<th field="code" width="90px">职业类别代码</th>
			</tr>
		</thead>
	</table>
	</div>
	
	
</div>
</body>

</html>

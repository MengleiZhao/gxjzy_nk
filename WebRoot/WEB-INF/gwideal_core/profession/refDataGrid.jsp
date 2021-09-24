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
function prof_select_search(){
	$('#profession_select_dg').datagrid('load',{
		name:$('#prof_select_name').val(),
		code:$('#pro_select_code').val()
	});	 
}

function selectProfessionDg(row){
	var t = $('#selectType').val();
	if(row==undefined){
		row = $('#profession_select_dg').treegrid('getSelections');
	}
	if(row==""){
		$.messager.alert('系统提示',"请选择一条记录！",'info');
		return;
	}
	
	if(row.length>0){//复选框多选
		for(var i=0;i<row.length;i++){
			var professioninfo=document.getElementById("div"+row[i].code);
			if(professioninfo==null){	
				var div1 = $("#div_profession");
				div1.append("<div id='div"+row[i].code+"'  style='float:left;margin-left:8px;margin-top:8px;' > "+
							"<input type='hidden' name='zylbdm' value='"+row[i].code+"'/>"+
							"<input type='hidden' name='zylbhz' value='"+row[i].name+"'/>"+
							""+row[i].name+""+
							"<img src='${base}/resource/images/cancelSelected.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelSelected(this)' title='删除' id='"+row[i].code+"'/>"+
							"</div>")
			}
			
			
		}
	}
	closeSearchDateWindow();
}


//页面加载完成 控制单选或多选
$(function(){
	var t = $('#selectType').val();
	if(t=='single'){
		$('#profession_select_dg').datagrid({
			singleSelect:true
		});
	}else if(t=='multi' || t=='profession' || t=='popuType'){
		$('#profession_select_dg').datagrid({
			singleSelect:false
		});
	}
});

</script>



<div class="main auto clearfix" style="width: 595px">
<input id="selectType" type="hidden" value="${selectType}">


	<div id="prof_select_tb" style="padding:8px;">
		职业类别名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="prof_select_name"/>&nbsp;
		职业类别代码: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="pro_select_code"/>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width: 70px;" onclick="prof_select_search();">查询</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="selectProfessionDg()" style="width: 70px;">选择</a>&nbsp;
	</div>


	<div>
	<table id="profession_select_dg" class="easyui-datagrid"
		data-options="
			url:'${base}/profession/jsonDg',
			rownumbers:true, 
			border:false,
			singleSelect:false,
			method:'post',
			idField:'id',
			treeField:'text',
			pageSize:25,
			pagination:true,
			toolbar:'#prof_select_tb',
			pageList:[25,50,100]
			">
		<thead>
			<tr>
				<th field="id" width="15px" checkbox="true" name="rid">职业id</th>
				<th field="name" width="360px">职业类别名称</th>
				<th field="code" width="90px">职业类别代码</th>
			</tr>
		</thead>
	</table>
	</div>
	
	
</div>
</body>

</html>

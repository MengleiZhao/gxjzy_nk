/**
 * 人力资源管理
 * |--基本个人数据
 * 所有基本个人数据的JS操作都在此JS文件
 */
/******************************************/
/**
 * 查询
 */
function queryPersonInfo(){
	$('#personInfo_dg').datagrid('load',{ 
		name:$('#name').val()
	} ); 
} 

function resetQueryPersonInfo(){
	$('#query_personInfo_form').form('clear');
	$('#personInfo_dg').datagrid('load',{ 
		unitName:'',
		businessContact:''
	} ); 
}
/**
 * 添加
 */
function addPersonInfo(){
    var win=creatWin('添加-个人数据',750,300,'icon-add','/personInfo/add');
    win.window('open');
}

function savePersonInfo(){
	var flag=false;
	$('#personInfo_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/personInfo/save', 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data=eval("("+data+")");
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#personInfo_from').form('clear');
				$("#personInfo_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#personInfo_from').form('clear');
			}
		} 
	});
}

/**
 * 修改
 */
function editPersonInfo(){
	var row = $('#personInfo_dg').datagrid('getSelected');
	var selections = $('#personInfo_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('修改-单位信息',650,300,'icon-edit','/personInfo/edit/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}

function updatePersonInfo(){
	var flag=false;
	$('#personInfo_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/personInfo/save',
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data=eval("("+data+")");
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#personInfo_from').form('clear');
				$("#personInfo_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#personInfo_from').form('clear');
			}
		} 
	});
}

/**
 * 删除
 */
function deletePersonInfo(){
	var row = $('#personInfo_dg').datagrid('getSelected');
	var selections = $('#personInfo_dg').datagrid('getSelections');
	
	//if(row!=null&&selections.length>0){
	if(row!=null&&selections.length==1){
		$.messager.confirm('系统提示','确认删除么?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/personInfo/delete/'+row.id,
					dataType: 'json',  
					success: function(data){
						if(data.success){
							//刷新数据 
							$.messager.alert('系统提示', data.info, 'info');
							$("#personInfo_dg").datagrid('reload'); 
						}else{ 
							$.messager.alert('系统提示', data.info, 'info');
						} 
					} 
				}); 
			} 
		}); 
		/*var ids="";
		for (var i = 0; i < selections.length; i++) {
			ids=ids+selections[i].id+",";
		}
		$.messager.confirm('confirm','确认删除么?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/unitInfo/delete/'+ids,
					dataType: 'json',  
					success: function(data){ 
						if(data){ 
							//刷新数据 
							$.messager.alert('系统提示','数据删除成功！','info');
							$("#personInfo_dg").datagrid('reload'); 
						}else{ 
							$.messager.alert('系统提示', data.message, 'info'); 
						} 
					} 
				}); 
			} 
		});*/
	}else{
		$.messager.alert('系统提示','请选择一条要删除的数据！','info');
	}
}

/**
 * 查看详情
 */
function detailPersonInfo(){
	var row = $('#personInfo_dg').datagrid('getSelected');
	var selections = $('#personInfo_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('查看-单位信息',650,300,'icon-search','/personInfo/detail/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}



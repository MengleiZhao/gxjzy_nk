function queryUnit(){
	$('#unit_dg').datagrid('load',{ 
		unitName:$('#unitName').val(),
		businessContact:$("#businessContact").val(),
		mobile:$("#mobile").val()
	} ); 
} 

function resetQueryUnit(){
	$('#query_unit_form').form('clear');
	$('#unit_dg').datagrid('load',{ 
		unitName:'',
		businessContact:''
	} ); 
}



function addUnit(){
    var win=creatWin('添加-单位信息',750,400,'icon-add','/unitInfo/add');
    win.window('open');
}

function saveUnit(){
	var flag=false;
	$('#unit_add_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data=eval("("+data+")");
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#unit_add_from').form('clear');
				$("#unit_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#unit_add_from').form('clear');
			}
		} 
	});
}

function editUnit(){
	var row = $('#unit_dg').datagrid('getSelected');
	var selections = $('#unit_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('修改-单位信息',650,380,'icon-edit','/unitInfo/edit/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}

function updateUnit(){
	var flag=false;
	$('#unit_edit_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data=eval("("+data+")");
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#unit_edit_from').form('clear');
				$("#unit_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#unit_add_from').form('clear');
			}
		} 
	});
}

function deleteUnit(){
	var row = $('#unit_dg').datagrid('getSelected');
	var selections = $('#unit_dg').datagrid('getSelections');
	
	//if(row!=null&&selections.length>0){
	if(row!=null&&selections.length==1){
		$.messager.confirm('系统提示','确认删除么?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/unitInfo/delete/'+row.id,
					dataType: 'json',  
					success: function(data){
						if(data.success){
							//刷新数据 
							$.messager.alert('系统提示', data.info, 'info');
							$("#unit_dg").datagrid('reload'); 
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
							$("#unit_dg").datagrid('reload'); 
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

function detailUnit(){
	var row = $('#unit_dg').datagrid('getSelected');
	var selections = $('#unit_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('查看-单位信息',750,350,'icon-search','/unitInfo/detail/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}

function detailUnitTeamCrew(id){
    var win=creatFreeWindow('first_window','查看-团队人员信息',750,350,'icon-search','/unitInfo/teamCrewdetail/'+id);
    win.window('open');
}


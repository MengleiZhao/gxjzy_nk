/**
 * 入围单位
 */
/**
 * 查询
 */
function queryFinalistUnit(){
	$('#finalist_unit_dg').datagrid('load',{ 
		unitNameStr:$('#finalist_unit_name').val(),
		year:$('#finalist_unit_year').val(),
		packets:$('#finalist_unit_packets').combobox("getValue"),
		type:$('#finalist_unit_type').combobox("getValue")
	} ); 
}
/**
 * 弹出添加窗口
 */
function addFinalistUnit(){
	var win=creatWin('添加-入围单位',550,180,'icon-add','/finalistUnit/add');
    win.window('open');
}


//弹出单位选择框
function openSearchFinalistUnitWin(){
	var win=creatSearchDataWin('选择-单位',800,450,'icon-search','/finalistUnit/selectUnitList');
	win.window('open');
}

function querySearchFinalistUnit(){
	$('#finalist_unit_select_dg').datagrid('load',{ 
		unitName:$('#finalist_unit_select_name').val()
	} ); 
}

function selectFinalistUnit(){
	var row = $('#finalist_unit_select_dg').datagrid('getSelected');
	if(row!=null){
		var id=row.id;
		var unitName=row.unitName;
		$("#select_finalist_unit_id").val(id);
		$("#select_finalist_unit_name").textbox('setValue',unitName)
		closeSearchDateWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}
/**
 * 保存
 */
function saveFinalistUnit(){
	var flag=false;
	$('#finalist_unit_add_from').form('submit', {
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
				$('#finalist_unit_add_from').form('clear');
				$("#finalist_unit_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#finalist_unit_add_from').form('clear');
			}
		} 
	});
}



/**
 * 弹出修改窗口
 */
function editFinalistUnit(){
	var row = $('#finalist_unit_dg').datagrid('getSelected');
	var selections = $('#finalist_unit_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('修改-入围单位',550,180,'icon-edit','/finalistUnit/edit/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}

function updateFinalistUnit(){
	var flag=false;
	$('#finalist_unit_edit_from').form('submit', {
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
				$('#finalist_unit_add_from').form('clear');
				$("#finalist_unit_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#finalist_unit_add_from').form('clear');
			}
		} 
	});
}


/**
 * 删除
 */
function deleteFinalistUnit(){
	var row = $('#finalist_unit_dg').datagrid('getSelected');
	var selections = $('#finalist_unit_dg').datagrid('getSelections');
	//if(row!=null&&selections.length>0){
	if(row!=null&&selections.length==1){
		$.messager.confirm('系统提示','确认删除么?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/finalistUnit/delete/'+row.id,
					dataType: 'json',  
					success: function(data){
						if(data.success){ 
							//刷新数据 
							$.messager.alert('系统提示',data.info,'info');
							$("#finalist_unit_dg").datagrid('reload'); 
						}else{ 
							$.messager.alert('系统提示', data.info, 'info'); 
						} 
					} 
				}); 
			} 
		});
	}
}

/**
 * 弹出详情窗口
 */
function detailFinalistUnit(){
	var row = $('#finalist_unit_dg').datagrid('getSelected');
	var selections = $('#finalist_unit_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('查看-入围单位',550,180,'icon-edit','/finalistUnit/detail/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}

function detailFinalUnit(){
	var row = $('#finalist_unit_dg').datagrid('getSelected');
	var selections = $('#finalist_unit_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatFreeWindow('first_window','查看-单位信息',650,300,'icon-search','/finalistUnit/detailUnit/'+row.unit.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}

function detailUnitByFinalListUnit(id){
	var win=creatFreeWindow('first_window','查看-单位信息',650,300,'icon-search','/finalistUnit/detailUnit/'+id);
	win.window('open');
}

function detailTeamCrewByFinalListUnit(id){
	var win=creatFreeWindow('second_window','查看-单位信息',750,350,'icon-search','/finalistUnit/detailTeamCrew/'+id);
	win.window('open');
}
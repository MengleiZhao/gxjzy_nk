$(document).ready(
	function(){
		
	}
);
/**
 * 设置所属第三方单位显示
 */
function teamCrewUnitFormatter(value, rowData, rowIndex){
　　	if(rowData.unit!=null){
		return rowData.unit.unitName
	}
}
/**
 * 查询
 */
function queryTeamCrew(){
	$('#teamCrew_dg').datagrid('load',{ 
		name:$('#name').val(),
		unitName:$("#team_crew_unitName").val(),
		isNational:$("input:radio[name='isNational'][checked]").val(),
		sex:$("#sex").combobox("getValue"),
		startAge:$("#startAge").val(),
		endAge:$("#endAge").val(),
		education:$("#education").val()
	} ); 
}

function resetQueryTeamCrew(){
	$("#isNational_1").attr("checked",false);
	$("#isNational_2").attr("checked",false);
	$("#startAge").val("");
	$("#endAge").val("");
	$('#query_team_crew').form('clear');
	$('#teamCrew_dg').datagrid('load',{ 
		name:'',
		unitName:'',
		isNational:'',
		sex:'',
		startAge:'',
		endAge:'',
		education:''
	} ); 
}

/*添加时选择单位*/
function openSearchUnitWin(){
	var win=creatSearchDataWin('查询-所属单位',800,450,'icon-search','/teamCrew/unitList');
	win.window('open');
}

function querySearchUnit(){
	$('#unit_select_dg').datagrid('load',{ 
		unitName:$('#unit_select_name').val()
	} ); 
}

function selectUnit(){
	var row = $('#unit_select_dg').datagrid('getSelected');
	if(row!=null){
		var id=row.id;
		var unitName=row.unitName;
		$("#teamCrew_unitId").val(id);
		$("#teamCrew_unitName").textbox('setValue',unitName);
		closeSearchDateWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}

//弹出添加窗口
function addTeamCrew(){
    var win=creatWin('添加-团队人员',800,450,'icon-add','/teamCrew/add');
    win.window('open');
}


function saveTeamCrew(){
	var flag=false;
	$('#teamCrew_add_from').form('submit', {
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
				$('#teamCrew_add_from').form('clear');
				$("#teamCrew_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#teamCrew_add_from').form('clear');
			}
		} 
	});
}

function editTeamCrew(){
	var row = $('#teamCrew_dg').datagrid('getSelected');
	var selections = $('#teamCrew_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('修改-团队人员',800,450,'icon-edit','/teamCrew/edit/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}


function updateTeamCrew(){
	var flag=false;
	$('#teamCrew_edit_from').form('submit', {
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
				$('#teamCrew_edit_from').form('clear');
				$("#teamCrew_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#teamCrew_edit_from').form('clear');
			}
		} 
	});
}


function deleteTeamCrew(){
	var row = $('#teamCrew_dg').datagrid('getSelected');
	var selections = $('#teamCrew_dg').datagrid('getSelections');
	//if(row!=null&&selections.length>0){
	if(row!=null&&selections.length==1){
		$.messager.confirm('confirm','确认删除么?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/teamCrew/delete/'+row.id,
					dataType: 'json',  
					success: function(data){
						if(data.success){ 
							//刷新数据 
							$.messager.alert('系统提示', data.info, 'info'); 
							$("#teamCrew_dg").datagrid('reload'); 
						}else{ 
							$.messager.alert('系统提示', data.info, 'error'); 
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
					url: base+'/unit/delete/'+ids,
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


function detailTeamCrew(){
	var row = $('#teamCrew_dg').datagrid('getSelected');
	var selections = $('#teamCrew_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('查看-团队人员',800,380,'icon-edit','/teamCrew/detail/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}

function detailTeamCrewUnit(){
	var row = $('#teamCrew_dg').datagrid('getSelected');
	var selections = $('#teamCrew_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatFreeWindow('first_window','查看-单位信息',650,380,'icon-search','/teamCrew/detailUnit/'+row.gdUnitId);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}

function detailTeamCrewUnitDetail(id){
	var win=creatFreeWindow('first_window','查看-单位信息',650,300,'icon-search','/teamCrew/detailUnit/'+id);
	win.window('open');
}

function detailTeamCrewByUnit(id){
	var win=creatFreeWindow('second_window','查看-单位信息',750,350,'icon-search','/teamCrew/detailByUnit/'+id);
	win.window('open');
}
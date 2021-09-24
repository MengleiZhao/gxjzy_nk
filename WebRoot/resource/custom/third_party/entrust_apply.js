
function teamCrewUnitFormatter(value, rowData, rowIndex){
　　	if(rowData.unit!=null){
		return rowData.unit.unitName
	}
}
/**
 * 查询
 */
function queryEntrustApply(){
	$('#entrustApply_dg').datagrid('load',{ 
		projectName:$('#projectName').val(),
		unitNameStr:$('#unitName').val(),
		auditStatus:$('#auditStatus').combobox('getValue'),
		auditDate1:$('#auditDate1').val(),
		auditDate2:$('#auditDate2').val(),
		applyDate1:$('#applyDate1').val(),
		applyDate2:$('#applyDate2').val()
	} ); 
}
/**
 * 重置查询
 */
function resetQueryEntrustApply(){
	$('#query_apply_form').form('clear');
	$('#entrustApply_dg').datagrid('load',{ 
		projectName:'',
		unitName:'',
		auditStatus:'',
		auditDate1:'',
		auditDate2:'',
		applyDate1:'',
		applyDate2:''
	} ); 
}
/**
 * 操作
 * @param value
 * @param row
 * @param index
 * @returns
 */
function rowformater(value,row,index){
	var auditStatus = parseInt(row.auditStatus);
	var operate="<a href='javascript:void(0);' onclick=\"operateDetailEntrustApply('"+row.id+"')\">查看</a>";
	if(auditStatus==10){
		operate=operate+"&nbsp;<a href='javascript:void(0);' onclick=\"operateEditEntrustApply('"+row.id+"')\">修改</a>"
		operate=operate+"&nbsp;<a href='javascript:void(0);' onclick=\"commitApply('"+row.id+"')\">提交申请</a>"
		operate=operate+"&nbsp;<a href='javascript:void(0);' onclick=\"operateDeleteEntrustApply('"+row.id+"')\">删除</a>"
	}
	if(auditStatus==20){
		operate=operate+"&nbsp;<a href='javascript:void(0);' onclick=\"cancel('"+row.id+"')\">取消申请</a>"
	}
	if(auditStatus==30){
		operate=operate+"&nbsp;<a href='javascript:void(0);' onclick=\"auditMaterial('"+row.id+"')\">资料上传</a>"
		operate=operate+"&nbsp;<a href='javascript:void(0);' onclick=\"auditMark('"+row.id+"')\">评分</a>"
	}
 	return operate;
}

//选择审计项目
function openSelectProject(){
	var win=creatWin('选择需要委托审计的项目',350,130,'icon-add','/entrustApply/selectProject');
    win.window('open');
}

function opwnSearchProjectWin(){
	var win=creatSearchDataWin('项目查询',800,450,'icon-search','/entrustApply/selectProjectList');
	win.window('open');
}
/**
 * 选择委托项目查询
 */
function querySearchProject(){
	$('#project_select_dg').datagrid('load',{ 
		name:$('#project_select_name').val()
	} ); 
}
/**
 * 选择委托项目
 */
function selectProject(){
	var row = $('#project_select_dg').datagrid('getSelected');
	if(row!=null){
		var id=row.id;
		var name=row.name;
		$("#thridPartyApplyAddProjectId").val(id);
		$("#thridPartyApplyAddProjectName").textbox('setValue',name);
		$("#thridPartyApplyAddProjectAllName").textbox('setValue',name);
		$("#thridPartyApplyAddAuditName").val(name);
		closeSearchDateWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}

/*添加时选择单位*/
function opwnSearchApplyUnitWin(num){
	var win=creatSearchDataWin('查询-委托单位',800,450,'icon-search','/entrustApply/selectUnitList?num='+num);
	win.window('open');
}
/**
 * 选择审计单位-查询
 */
function querySearchApplyUnit(){
	$('#apply_unit_select_dg').datagrid('load',{ 
		unitNameStr:$('#apply_unit_select_name').val()
	} ); 
}
/**
 * 选择审计单位
 */
function selectApplyUnit(num){
	var row = $('#apply_unit_select_dg').datagrid('getSelected');
	if(row!=null){
		var id=row.id;
		var unitName=row.unitName;
		$("#apply_unit_id"+num).val(id);
		$("#select_apply_unit_name"+num).textbox('setValue',unitName)
		closeSearchDateWindow();
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}


/**
 * 选择团队人员
 */

function querySelectApplyTeamCrew(){
	$('#apply_teamCrew_dg').datagrid('load',{ 
		name:$('#name').val()
	} ); 
}
function openSelectApplyTeamCrew(num){
	var id=$("#apply_unit_id"+num).val();
	if(id==""){
		$.messager.alert('系统提示', "请先选择受托单位"+num+"！", 'info');
		return;
	}
	var win=creatSearchDataWin('查询-团队人员',800,450,'icon-search','/entrustApply/selectTeamCewList/'+id+'?num='+num);
	win.window('open');
}

function detailSelectApplyTeamCrew(){
	var row = $('#apply_teamCrew_dg').datagrid('getSelected');
	var selections = $('#apply_teamCrew_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		 var win=creatFreeWindow('first_window','查看-团队人员',650,300,'icon-search','/entrustApply/selectTeamCewDetail/'+row.id);
	    win.window('open');
	}
}

//弹出申请表单
function addEntrustApply(){
	var win=creatWin('委托审计申请',820,600,'icon-add','/entrustApply/add');
	win.window('open');
}

/**
 * 保存
 */
function saveEntrustApply(){
	var flag=false;
	$('#entrustApply_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/entrustApply/save', 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data= eval('(' + data + ')');
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#entrustApply_add_from').form('clear');
				$('#entrust_apply_select_project_from').form('clear');
				$("#entrustApply_dg").datagrid('reload');
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#entrustApply_add_from').form('clear');
			}
		} 
	});
}
/**
 *工具栏/右键-修改
 */
function editEntrustApply(){
	var row = $('#entrustApply_dg').datagrid('getSelected');
	var selections = $('#entrustApply_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('修改-委托审计申请',820,600,'icon-edit','/entrustApply/edit/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要修改的数据！','info');
	}
}
/**
 * 列表操作-修改
 * @param {} id
 */
function operateEditEntrustApply(id){
	var win=creatWin('修改-委托审计申请',820,600,'icon-edit','/entrustApply/edit/'+id);
	win.window('open');
}

//申请提交
function commitEntrustApply(){
    var flag=false;
    $('#entrustApply_from').form('submit',{  
        onSubmit:function(){  
        	flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
        },  
        url:base+'/entrustApply/commit',  
        success:function(data){
        	if(flag){
				$.messager.progress('close');
			}
            var data=eval("("+data+")");
            if(data.success){
            	$.messager.alert('系统提示', data.info, 'info');
            }else {
            	$.messager.alert('系统提示', data.info, 'error');
			}
            closeWindow();
			$('#entrustApply_from').form('clear');
			$("#entrustApply_dg").datagrid('reload'); 
        }  
    }); 
    $.messager.progress('close');
}

/**
 * 预览
 * @returns
 */
function previewEntrustApply(){
	$('#entrustApply_from').form('submit',{  
    	onSubmit:function(){  
        	return $(this).form('enableValidation').form('validate');
        },   
        url:base+'/entrustApply/preview',  
        success:function(data){
    		var win=$("#first_window").window({
    	        title: '预览',
    		    width: 850,
    		    height: 500,
    		    shadow: true,
    		    modal: true,
    		    iconCls: 'icon-search',
    		    closed: true,
    		    minimizable: false,
    		    maximizable: false,
    		    collapsible: false,
    		    resizable:false,
    		    draggable:true,
    		    cache : false,
    		    loadingMessage:'正在加载，请稍等...',
    		    href:'',
    		    content:"<body>"+data+"</body>"
    	    });
    		win.window('open');
        }  
    });
}
/**
 *保存修改
 */
function updateEntrustApply(){
	var flag=false;
	$('#entrustApply_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/entrustApply/save', 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			var data=eval("("+data+")");
            if(data.success){
            	$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#entrustApply_edit_from').form('clear');
				$("#entrustApply_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#entrustApply_edit_from').form('clear');
			}
		} 
	});
}
/**
 * 提交申请
 * @param {} id
 */
function commitApply(id){
	if(id==''){
		var row = $('#entrustApply_dg').datagrid('getSelected');
		var selections = $('#entrustApply_dg').datagrid('getSelections');
		//if(row!=null&&selections.length>0){
		if(row!=null&&selections.length==1){
			commitApplyById(row.id)
		}
	}else{
		commitApplyById(id)
	}
}

/**
 * 列表操作-提交申请
 * @param {} rowId
 */
function commitApplyById(rowId){
	$.messager.confirm('系统提示','确认提交?',function(id){ 
		if(id){
			var win=creatWin('提交-委托审计申请',820,480,'icon-search','/entrustApply/commitWin/'+rowId);
	   	 	win.window('open');
		} 
	});
}

function commitApplyByForm(){
	var flag=false;
	$('#entrustApply_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/entrustApply/commitApply',
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			var data=eval("("+data+")");
            if(data.success){
            	$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#entrustApply_edit_from').form('clear');
				$("#entrustApply_dg").datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#entrustApply_edit_from').form('clear');
			}
		} 
	});
}


/**
 * 工具栏/右键-删除
 */
function deleteEntrustApply(){
	var row = $('#entrustApply_dg').datagrid('getSelected');
	var selections = $('#entrustApply_dg').datagrid('getSelections');
	
	//if(row!=null&&selections.length>0){
	if(row!=null&&selections.length==1){
		$.messager.confirm('系统提示','确认删除么?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/entrustApply/delete/'+row.id,
					dataType: 'json',  
					success: function(data){ 
			            if(data.success){
			            	$.messager.alert('系统提示', data.info, 'info');
							$("#entrustApply_dg").datagrid('reload'); 
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

/**
 * 列表操作-取消申请
 */
function cancel(rowId){
	$.messager.confirm('系统提示','确认取消申请?',function(id){ 
		if(id){ 
			$.ajax({ 
				type: 'POST', 
				url: base+'/entrustApply/cancel/'+rowId,
				dataType: 'json',  
				success: function(data){ 
		            if(data.success){
		            	$.messager.alert('系统提示', data.info, 'info');
						$("#entrustApply_dg").datagrid('reload'); 
					}else{ 
						$.messager.alert('系统提示', data.info, 'error');
					} 
				}
			}); 
		} 
	});
}
/**
 * 右键-取消申请
 */
function cancelByContextMenu(){
	var row = $('#entrustApply_dg').datagrid('getSelected');
	var selections = $('#entrustApply_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		$.messager.confirm('系统提示','确认取消申请?',function(id){ 
			if(id){ 
				$.ajax({ 
					type: 'POST', 
					url: base+'/entrustApply/cancel/'+row.id,
					dataType: 'json',  
					success: function(data){ 
			            if(data.success){
			            	$.messager.alert('系统提示', data.info, 'info');
							$("#entrustApply_dg").datagrid('reload'); 
						}else{ 
							$.messager.alert('系统提示', data.info, 'error');
						} 
					}
				}); 
			} 
		});
	}
}
/**
 * 列表操作-删除
 * @param {} rowId
 */
function operateDeleteEntrustApply(rowId){
	
	$.messager.confirm('系统提示','确认删除么?',function(id){ 
		if(id){ 
			$.ajax({ 
				type: 'POST', 
				url: base+'/entrustApply/delete/'+rowId,
				dataType: 'json',  
				success: function(data){ 
		            if(data.success){
		            	$.messager.alert('系统提示', data.info, 'info');
						$("#entrustApply_dg").datagrid('reload'); 
					}else{ 
						$.messager.alert('系统提示', data.info, 'error');
					} 
				}
			}); 
		} 
	});
}
/**
 * 工具栏/右键-查看
 */
function detailEntrustApply(){
	var row = $('#entrustApply_dg').datagrid('getSelected');
	var selections = $('#entrustApply_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
	    var win=creatWin('查看-委托审计申请',850,450,'icon-search','/entrustApply/detail/'+row.id);
	    win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
	}
}
/**
 * 列表操作-查看
 * @param {} id
 */
function operateDetailEntrustApply(id){
	var win=creatWin('查看-委托审计申请',850,450,'icon-search','/entrustApply/detail/'+id);
	win.window('open');
}
/**
 * 删除附件
 * @param {} obj
 * @param {} serviceType
 * @param {} attId
 */
function deleteAtt(obj,serviceType,attId){
	$.messager.confirm('系统提示','确认删除么?',function(id){ 
		if(id){ 
			$.ajax({ 
				type: 'POST', 
				url: base+'/entrustApply/deleteAtt/'+attId,
				dataType: 'json',
				success: function(data){ 
					//data=eval("("+data+")");
					if(data.success){
						//刷新数据 
						$.messager.alert('系统提示', data.info, 'info'); 
						if(serviceType==1){
							$("#serviceType_1").html("");
							var type=$("<input type='hidden' name='apply.serviceTypes' value='1'/>");
							type.appendTo($("#serviceType_1"));
							var file=$("<input id='fb_1' name='apply.files' type='text' style='width:400px'>");
							file.appendTo($("#serviceType_1"));
							$('#fb_1').filebox({
							    buttonText: '浏览文件',
							    buttonAlign: 'right',
							    required:true
							});
						}else if(serviceType==2){
							$("#serviceType_2").html("");
							var type=$("<input type='hidden' name='apply.serviceTypes' value='2'/>");
							type.appendTo($("#serviceType_2"));
							var file=$("<input id='fb_2' name='apply.files' type='text' style='width:400px'>");
							file.appendTo($("#serviceType_2"));
							$('#fb_2').filebox({
							    buttonText: '浏览文件',
							    buttonAlign: 'right',
							    required:true
							});
						}else if(serviceType==3){
							$("#serviceType_3").html("");
							var type=$("<input type='hidden' name='apply.serviceTypes' value='3'/>");
							type.appendTo($("#serviceType_3"));
							var file=$("<input id='fb_3' name='apply.files' type='text' style='width:400px'>");
							file.appendTo($("#serviceType_3"));
							$('#fb_3').filebox({
							    buttonText: '浏览文件',
							    buttonAlign: 'right',
							    required:true
							});
						}else if(serviceType==4){
							$("#auditTypes_4").html("");
							var type=$("<input type='hidden' name='apply.auditTypes' value='4'/>");
							type.appendTo($("#auditTypes_4"));
							var file=$("<input id='fb_4' name='apply.auditFiles' type='text' style='width:370px'>");
							file.appendTo($("#auditTypes_4"));
							$('#fb_4').filebox({
							    buttonText: '浏览文件',
							    buttonAlign: 'right',
							    required:true
							});
						}else if(serviceType==5){
							$("#auditTypes_5").html("");
							var type=$("<input type='hidden' name='apply.auditTypes' value='5'/>");
							type.appendTo($("#auditTypes_5"));
							var file=$("<input id='fb_5' name='apply.auditFiles' type='text' style='width:370px'>");
							file.appendTo($("#auditTypes_5"));
							$('#fb_5').filebox({
							    buttonText: '浏览文件',
							    buttonAlign: 'right',
							    required:true
							});
						}
					}else{ 
						$.messager.alert('系统提示', data.info, 'error'); 
					} 
				} 
			}); 
		} 
	}); 
}

/**
 * 通过右键菜单或者操作打开资料上传窗口
 * @param {} id
 */
function auditMaterial(id){
	if(id==''){
		var row = $('#entrustApply_dg').datagrid('getSelected');
		var selections = $('#entrustApply_dg').datagrid('getSelections');
		//if(row!=null&&selections.length>0){
		if(row!=null&&selections.length==1){
			material(row.id)
		}
	}else{
		material(id)
	}
}
function material(id){
	var win=creatWin('资料上传-委托审计申请',600,450,'icon-search','/entrustApply/auditMaterial/'+id);
	win.window('open');
}
/**
 * 添加相关资料行
 */
function addMTr(){
	var tbd=$("#apply_material_tbd");//tbody
	var tr=$("<tr></tr>");			 //tr
	var td=$("<td class='b'></td>"); //td
	var length=tbd.find("tr").length;
	var num=$("<td class='b'>"+(length+1)+"、</td>");
	num.appendTo(tr);
	var file=$("<input id='m_files_"+(length+1)+"' name='relateFiles' type='text' style='width:400px'>");
	file.appendTo(td);
	var btnTd=$("<td class='b'></td>");
	var btn=$("<a id='a_files_"+(length+1)+"' href='javascript:void(0);' style='margin-left: 5px;' onclick='deleteMTr(this)'>移除</a>");
	btn.appendTo(btnTd);
	tr.append(td);
	tr.append(btnTd);
	tbd.append(tr);
	$("#m_files_"+(length+1)).filebox({
	    buttonText: '浏览文件',
	    buttonAlign: 'right',
	    width:'345'
	});
	$("#a_files_"+(length+1)).linkbutton({
		iconCls:'icon-remove'
	});
	$("#rowsTh").attr("rowspan",length+1);
	m_num();
}
/**
 * 移除相关资料行
 * @param {} obj
 */
function deleteMTr(obj){
	var tr=$(obj).parent().parent();
	tr.remove();
	$("#rowsTh").attr("rowspan",$("#apply_material_tbd").find("tr").length);
	m_num();
}
/**
 * 相关资料序号
 */
function m_num(){
	var length=$("#apply_material_tbd").find("tr").length;
	
	for (var i = 0; i < length; i++) {
		if(i==0){
			$("#apply_material_tbd").find("tr:eq("+i+")").find("td:eq(0)").html((i+1)+"、");	
		}else{
			$("#apply_material_tbd").find("tr:eq("+i+")").find("td:eq(0)").html((i+1)+"、");
		}
		
	}
}
/**
 * 保存资料
 */
function saveMaterial(){
	var flag=false;
	$('#entrustApply_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/entrustApply/saveMaterial', 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			var data=eval("("+data+")");
            if(data.success){
            	$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#entrustApply_from').form('clear');
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#entrustApply_from').form('clear');
			}
		} 
	});
}
/**
 * 删除相关资料附件
 * @param {} attId
 * @param {} obj
 */
function deleteRelateAtt(attId,obj){
	
	$.messager.confirm('系统提示','确认删除么?',function(id){ 
		if(id){ 
			$.ajax({ 
				type: 'POST', 
				url: base+'/entrustApply/deleteAtt/'+attId,
				dataType: 'json',
				success: function(data){ 
					if(data.success){
						var tbd=$(obj).parent().parent().parent().parent();
						var length=tbd.find("tr").length;
						if(length==1){
							var tr=$(obj).parent().parent().parent();
							tr.html("");
							var th=$("<th class='br' width='20%' id='rowsTh'>相关资料上传：</th>");
							th.appendTo(tr);
							var td=$("<td class='b'></td>"); //td
							var length=tbd.find("tr").length;
							var num=$("<td class='b'>"+(length)+"、</td>");
							num.appendTo(tr);
							var file=$("<input id='m_files_"+(length)+"' name='relateFiles' type='text' style='width:400px'>");
							file.appendTo(td);
							var btnTd=$("<td class='b'></td>");
							var btn=$("<a id='a_files_"+(length)+"' href='javascript:void(0);' style='margin-left: 5px;' onclick='addMTr(this)'>添加</a>");
							btn.appendTo(btnTd);
							tr.append(td);
							tr.append(btnTd);
							tbd.append(tr);
							$("#m_files_"+(length)).filebox({
							    buttonText: '浏览文件',
							    buttonAlign: 'right',
							    width:'345'
							});
							$("#a_files_"+(length)).linkbutton({
								iconCls:'icon-add'
							});
							$("#rowsTh").attr("rowspan",length);
							m_num();
						}else{
							var tr=$(obj).parent().parent().parent();
							tr.remove();
						}
						$("#rowsTh").attr("rowspan",length-1);
						$.messager.alert('系统提示', data.info, 'info'); 
					}else{ 
						$.messager.alert('系统提示', data.info, 'error'); 
					} 
				} 
			}); 
		} 
	});
}
/**
 * 通过右键菜单或者操作打开打分窗口
 * @param {} id
 */
function auditMark(id){
	if(id==''){
		var row = $('#entrustApply_dg').datagrid('getSelected');
		var selections = $('#entrustApply_dg').datagrid('getSelections');
		//if(row!=null&&selections.length>0){
		if(row!=null&&selections.length==1){
			mark(row.id);
		}
	}else{
		mark(id);
	}
}
function mark(id){
	var win=creatWin('评分',800,550,'icon-search','/entrustApply/mark/'+id);
	win.window('open');
}

function saveMark(){
	var flag=false;
	$('#entrustApplyMarkForm').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/entrustApply/saveMark', 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			var data=eval("("+data+")");
            if(data.success){
            	$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#entrustApplyMarkForm').form('clear');
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#entrustApplyMarkForm').form('clear');
			}
		} 
	});
}
function commitMark(){
	var flag=false;
	$('#entrustApply_from').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		url:base+'/entrustApply/commitMark', 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			var data=eval("("+data+")");
            if(data.success){
            	$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#entrustApply_from').form('clear');
			}else{
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#entrustApply_from').form('clear');
			}
		} 
	});
}

<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'north'" border="false" style="margin-bottom: 5px;">
			<table cellpadding="5" cellspacing="0" class="a_search_table" width="100%" border="0" >
				<tr>
					<th class="br" width="90px">
						姓名：
					</th> 
					<td class="br" width="100px">
						<input id="demo_name" name="" style="width: 90px;" class="easyui-textbox"></input>
					</td>
				<th class="br" width="90px">
						联系号码：
					</th> 
					<td class="br" width="140px">
						<input id="demo_phoneNumber" name=""  style="width: 150px;" class="easyui-numberbox"></input>
					</td>
				
				<th class="br" width="80px">
						修改日期：
					</th> 
					<td class="br" width="220px">
						<input id="demo_updatetime1" name="" class="Wdate" type="text" onClick="WdatePicker()" readonly="readonly" style="width: 95px;"></input>
							-
						<input id="demo_updatetime2" name="" class="Wdate" type="text" onClick="WdatePicker()" readonly="readonly" style="width: 95px;"></input>
					</td>
					<td  class="br">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryDemo();">查询</a>
					</td>
				</tr>
			</table>
		</div>
		<div  region="center" border="false">
				<div id="lawHelpTab" style="padding:2px 5px;">
				<gwideal:perm url="/demo/add">
					<a href="javascript:void(0)"  class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addDemo()" >新增</a>&nbsp;
				</gwideal:perm> 
			    <gwideal:perm url="/demo/edit/{id}">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editDemo()">修改</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/demo/delete/{id}">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteDemo()">删除</a>&nbsp;
				</gwideal:perm>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-view32',size:'large',iconAlign:'left'"  onclick="detailDemo()">查看</a>&nbsp;
				
				 <a href="javascript:void(0)"  class="easyui-linkbutton" data-options="iconCls:'icon-help',size:'large',iconAlign:'left'" onclick="helpDemo()">帮助</a> 
			</div>
			
			<table id="demo_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/demo/demoPageData',
			method:'post',fit:true,pagination:true,toolbar:'#lawHelpTab',singleSelect: true,
			selectOnCheck: true,checkOnSelect: true,remoteSort:true,nowrap:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,editor:'textbox'" width="200">姓名</th>
						<th data-options="field:'phoneNumber',align:'center',resizable:false,sortable:true" width="200">手机号码</th>
						<th data-options="field:'updateTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="200">更新时间</th>
						<th data-options="field:'custom',align:'center',resizable:false,sortable:true,formatter:formatPrice" width="200">操作</th>
						
					</tr>
				</thead>
			</table>
			
		</div>
	</div>
	

<script type="text/javascript">
$(function(){
	$('#demo_dg').datagrid().datagrid('enableCellEditing');
})

$.extend($.fn.datagrid.methods, {
			editCell: function(jq,param){
				return jq.each(function(){
					var opts = $(this).datagrid('options');
					var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor1 = col.editor;
						if (fields[i] != param.field){
							col.editor = null;
						}
					}
					$(this).datagrid('beginEdit', param.index);
                    var ed = $(this).datagrid('getEditor', param);
                    if (ed){
                        if ($(ed.target).hasClass('textbox-f')){
                            $(ed.target).textbox('textbox').focus();
                        } else {
                            $(ed.target).focus();
                        }
                    }
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor = col.editor1;
					}
				});
			},
            enableCellEditing: function(jq){
                return jq.each(function(){
                    var dg = $(this);
                    var opts = dg.datagrid('options');
                    opts.oldOnClickCell = opts.onClickCell;
                    opts.onClickCell = function(index, field){
                        if (opts.editIndex != undefined){
                            if (dg.datagrid('validateRow', opts.editIndex)){
                                dg.datagrid('endEdit', opts.editIndex);
                                opts.editIndex = undefined;
                            } else {
                                return;
                            }
                        }
                        dg.datagrid('selectRow', index).datagrid('editCell', {
                            index: index,
                            field: field
                        });
                        opts.editIndex = index;
                        opts.oldOnClickCell.call(this, index, field);
                    }
                });
            }
		});


$(function(){
	//定义双击事件
	$('#demo_dg').datagrid({
		onDblClickRow :function(rowIndex,rowData){
			detailDemo();
		}
	});
});
function queryDemo(){  
	$('#demo_dg').datagrid('load',{ 
		name:$('#demo_name').textbox('getValue'),
		phoneNumber:$('#demo_phoneNumber').numberbox('getValue'),
		updatetime1:$('#demo_updatetime1').val(),
		updatetime2:$('#demo_updatetime2').val()
	} ); 
}
function addDemo(){
	 var win=creatWin('新增-演示样本',600,600,'icon-search','/demo/add');
	  win.window('open');
}
function detailDemo(){
	var row = $('#demo_dg').datagrid('getSelected');
	var selections = $('#demo_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		var win=creatWin('查看-演示样本',600,600,'icon-search',"/demo/detail/"+row.id);
		win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
function editDemo(id){
	var row = $('#demo_dg').datagrid('getSelected');
	var selections = $('#demo_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		var win=creatWin('修改-演示样本',600,600,'icon-search',"/demo/edit/"+row.id);
		  win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
function deleteDemo(id){
	var row = $('#demo_dg').datagrid('getSelected');
	var selections = $('#demo_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/demo/delete/'+row.id,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#demo_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			}); 
		}
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
function expListlawHelp(){
	 //var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
	  //win.window('open');
	if(confirm("按当前查询条件导出？")){
	   var queryForm = document.getElementById("lawHelp_list_form");
		queryForm.setAttribute("action","${base}/demo/expList");
		queryForm.submit();
	}
}
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val)
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
}
//在线帮助
 function helpDemo(){
	window.open("./resource/onlinehelp/zzzx/demo/help.html");
} 
function test(val){
	alert('test')
}
function formatPrice(val,row,index){
	return row.id;
}

</script>
</body>
</html>


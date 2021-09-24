<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<div class="easyui-layout" fit="true" >
		<div data-options="region:'north'" border="false" 
			style="margin-bottom: 5px;height:100px;">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th width="90px">
						姓名：
					</th> 
					<td width="100px">
						<input id="demo_name" name="" style="width: 90px;" class="easyui-textbox"></input>
					</td>
				<th width="90px">
						联系号码：
					</th> 
					<td width="140px">
						<input id="demo_phoneNumber" name=""  style="width: 150px;" class="easyui-numberbox"></input>
					</td>
				
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="queryDemo();">查询</a>
					</td>
				</tr>
			</table>           
				<div style="margin-left: 5px;">  
                <div class="easyui-panel" style="vertical-align:center;height:45px;padding-top: 10px;">
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add32'">添加</a>
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit32'">修改</a>
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cut32'">删除</a>
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-view32'">查看</a>
				</div>
				</div>
		</div>
		
		
		
		<div  region="center" border="false">
			
			<table id="demo_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/project/projectPageData?proLibType=${proLibType }',
			method:'post',fit:true,pagination:false,toolbar:'#lawHelpTab',singleSelect: true,
			selectOnCheck: true,checkOnSelect: true,remoteSort:true,nowrap:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'FProCode',align:'center'" width="100">项目编号</th>
						<th data-options="field:'fproName',align:'center'" width="100">项目名称</th>
						<th data-options="field:'FProClass',align:'center'" width="100">项目类别</th>
						<th data-options="field:'FProHead',align:'center'" width="100">负责人</th>
						<th data-options="field:'FProAppliDepart',align:'center'" width="100">申报部门</th>
						<th data-options="field:'updateTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="100">申报时间</th>
						<th data-options="field:'FProcurementAmount',align:'center'" width="100">项目预算[万元]</th>
						<th data-options="field:'FFlowStauts',align:'center'" width="100">审批状态</th>
						<th data-options="field:'FProLibType',align:'center'" width="100">所属库</th>
						<th data-options="field:'name',align:'center'" width="100">操作</th>
						
					</tr>
				</thead>
			</table>
		</div>
		<div region="south" border="false">
		<div class="easyui-pagination" data-options="
					total:114,
					layout:['list','sep','first','prev','links','next','last','sep','refresh','info']
				"></div>
		</div>
	</div>
	


<script type="text/javascript">
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
function formatOper(value, row, index){
	return 'sfsdf';
	 //return '<a href="#" onclick="test('+index+')">修改</a>';  
//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
}
</script>
</body>
</html>


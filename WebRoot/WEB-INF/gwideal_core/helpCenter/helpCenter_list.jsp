<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  <body>
    <div class="easyui-layout" fit="true">	
		
		<div region="center" border="false">
			<div id="HelpCenterHelpTab" style="padding:2px 5px;">
				<p style="padding-bottom:5px;">
					文件名称：<input type="text"  size="15" class="easyui-textbox" maxlength="10" id="help_helpName"/>&nbsp;
					上传人：<input type="text"  size="15" class="easyui-textbox" maxlength="10" id="help_releaseUser"/>&nbsp;
				</p>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryNotice();">查询</a>
				<%-- <gwideal:perm url=""> --%>
					<a href="javascript:void(0)"  class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addNotice()" >新增</a>&nbsp;
				<%-- </gwideal:perm> 
			    <gwideal:perm url=""> --%>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editNotice()">修改</a>&nbsp;
				<%-- </gwideal:perm> --%>
				<%-- <gwideal:perm url=""> --%>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteNotice()">删除</a>&nbsp;
				<%-- </gwideal:perm> --%>
			</div>
			
			<table id="helpCenterTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/helpCenter/helpCenterPage',
			method:'post',fit:true,pagination:true,toolbar:'#helpCenterTab',singleSelect: true,
			selectOnCheck: true,checkOnSelect: true,remoteSort:true,nowrap:false,pageSize:5,pageList:[5]">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true" style="width: 5%"></th>
						<th data-options="field:'helpId',hidden:true"></th>
						<th data-options="field:'num',align:'center',resizable:false,sortable:true" style="width: 5%">序号</th>
						<th data-options="field:'helpName',align:'center',resizable:false,sortable:true" style="width: 30%">公告标题</th>
						<th data-options="field:'helpSize',align:'center',resizable:false,sortable:true" style="width: 40%">副标题</th>
						<th data-options="field:'releaseUser',align:'center',resizable:false,sortable:true" style="width: 10%">发布人</th>
						<th data-options="field:'releaseTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">发布时间</th>
					</tr>
				</thead>
			</table>	
    	</div>
    </div>
    
    
<script type="text/javascript">
//时间格式化
function ChangeDateFormat(val) {
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}

//新增窗口弹出
function addNotice(){
	//var win=creatWin('公告新增',900,700,'icon-search','/notice/add');
	//win.window('open');

	window.open("/nkgl/notice/add","新增公告","width=900,height=700");
}

//删除
function deleteNotice(){
	var row = $('#noticeTab').datagrid('getSelected');
	var selections = $('#noticeTab').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/notice/delete/'+row.noticeId,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$('#noticeTab').datagrid('reload');
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

//修改页面跳转
function editNotice(){
	var row = $('#noticeTab').datagrid('getSelected');
	var selections = $('#noticeTab').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		//var win=creatWin('公告修改',650,600,'icon-search',"/notice/edit/"+row.noticeId);
		//win.window('open');
		window.open("/nkgl/notice/edit/"+row.noticeId,"新增公告","width=900,height=700");
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}

//查询
function queryNotice(){ 
	$('#noticeTab').datagrid('load',{ 
		noticeTitle:$('#notice_noticeTitle').textbox('getValue'),
		releaseUser:$('#notice_releaseUser').textbox('getValue')
	} ); 
}
</script>
  </body>
</html>

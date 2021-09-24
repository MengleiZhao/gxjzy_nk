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
			style="margin-bottom: 5px">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th width="120px">
						指标名称：
					</th> 
					<td width="100px">
						<input id="quota_query_FBIndexName" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">
						指标类型：
					</th> 
					<td width="140px">
						<input id="quota_query_FIndexType" style="width: 150px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">
						使用部门：
					</th> 
					<td width="140px">
						<input id="quota_query_FDeptName" style="width: 150px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="queryQuota();">查询</a>
					</td>
				</tr>
			</table>           
				<div style="margin-left: 5px;">  
                <div class="easyui-panel" style="vertical-align:center;height:45px;padding-top: 10px;">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add32'" style="margin-left: 15px;" onclick="addQuota()">新增预算指标</a>
				</div>
				</div>
		</div>
		
		
		
		<div  region="center" border="false">
			
			<table id="quota_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/quota/dataList',
			method:'post',fit:true,pagination:false,singleSelect: true,rownumbers:true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'fbId',hidden:true"></th>
						<th data-options="field:'fbindexName',align:'center'" width="10%">指标名称</th>
						<th data-options="field:'fbindexCode',align:'center'" width="10%">指标编号</th>
						<th data-options="field:'findexTypeName',align:'center'" width="15%">指标类型</th>
						<th data-options="field:'fdeptName',align:'center'" width="10%">使用部门</th>
						<th data-options="field:'fyears',align:'center',resizable:false,sortable:true" width="10%">预算年度</th>
						<th data-options="field:'operation',align:'center',formatter:operformat_quotalist" width="10%">操作</th>
						
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

function queryQuota(){  
	$('#quota_dg').datagrid({
		url:'${base}/quota/dataList',
		queryParams:{
			FBIndexName:$('#quota_query_FBIndexName').textbox('getValue'),
			FIndexType:$('#quota_query_FIndexType').textbox('getValue'),
			qdeptName:$('#quota_query_FDeptName').textbox('getValue')
		}
	});
}
function addQuota(){
	 var win=creatWin('新增-预算指标',1100,700,'icon-search','/quota/add');
	  win.window('open');
}
function editQuota(id){
	var win=creatWin('修改-预算指标',1100,700,'icon-search','/quota/edit/'+id);
	win.window('open');
}
function deleteQuota(id){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/quota/delete/'+id,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#quota_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			}); 
		}
}
//时间格式化
function dateformat_quotalist(val) {
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}
function detailQuota(quotaId){
	var win=creatWin('查看-预算指标',1100,700,'icon-search','/quota/detail/'+quotaId);
	win.window('open');
}
function operformat_quotalist(value, row, index){
	var btn1 = "<a href='javascript:void(0)' style='color:blue' onclick='detailQuota("+row.fbid+")'>查看</a>";
	var btn2 = "<a href='javascript:void(0)' style='color:blue' onclick='editQuota("+row.fbid+")'>修改</a>";
	var btn3 = "<a href='javascript:void(0)' style='color:blue' onclick='deleteQuota("+row.fbid+")'>删除</a>";
	var btn3 = "";
	return btn1 + "    " + btn2 ;
}
</script>
</body>
</html>


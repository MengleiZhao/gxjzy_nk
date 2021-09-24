<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<div  class="easyui-layout" fit="true" >
		<div data-options="region:'north'" border="false" style="margin-bottom: 5px;height:45px;">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th width="90px">项目名称：</th> 
					<td width="100px">
						<input id="CF_add_PN_FProName" name="" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">项目编号：</th> 
					<td width="90px">
						<input id="CF_add_PN_FProCode" name=""  style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">预算金额：</th> 
					<td width="100px">
						<input id="CF_add_PN_FProBudgetAmount" name="" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="queryCF();">查询</a>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="PitchOn();">保存</a>
					</td>
				</tr>
			</table>           
		</div>
		<div  region="center" border="false">
			<table id="FProCode_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/Formulation/fProCodejsonPagination',
			method:'post',fit:true,pagination:false,singleSelect: true,rownumbers:true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'fproCode',align:'center'" width="25%">项目编号</th>
						<th data-options="field:'fproName',align:'center'" width="25%">项目名称</th>
						<th data-options="field:'fproClassName',align:'center'" width="25%">项目类别</th>
						<th data-options="field:'FProBudgetAmount',align:'center'" width="25%">项目预算金额</th>
						
					</tr>
				</thead>
			</table>
		</div>
		<div region="south" border="false">
			<div class="easyui-pagination" data-options="
						total:114,
						layout:['list','sep','first','prev','links','next','last','sep','refresh','info']">
			</div>
		</div>
	</div>
	


<script type="text/javascript">
function PitchOn(id){
	var row = $('#FProCode_dg').datagrid('getSelected');
	$("#F_fProCode").textbox('setValue',row.fproCode); 
	closeFirstWindow();
	//closeWindow();
}
function queryCF(){  
	$('#FProCode_dg').datagrid('load',{ 
		FProName:$('#CF_add_PN_FProName').val(),
		FProCode:$('#CF_add_FProCode').val(),
		FProBudgetAmount:$('#CF_add_FProBudgetAmount').val(),
	} ); 
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
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


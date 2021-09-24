<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
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
					<th width="90px">采购批次号：</th> 
					<td width="100px">
						<input id="CF_add_PN_fpCode" name="" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">采购方式：</th> 
					<td width="90px">
						<input id="CF_add_PN_fpMethod" name=""  style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<th width="90px">采购金额：</th> 
					<td width="100px">
						<input id="CF_add_PN_fpAmount" name="" style="width: 90px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="queryCF();">查询</a>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="PitchOn();">保存</a>
					</td>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" onclick="PitchOn();">保存</a>
					</td>
				</tr>
			</table>           
		</div>
		<div  region="center" border="false">
			<table id="FProCode_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/Archiving/fProCodejsonPagination',
			method:'post',fit:true,pagination:false,singleSelect: true,rownumbers:true,
			selectOnCheck: true">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fpId',hidden:true">
						</th>
						<th data-options="field:'number',align:'center'" width="15%">序号</th>
						<th data-options="field:'fcTitle',align:'center'" width="35%">合同名称</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="25%">申请人</th>
						<th data-options="field:'fpAmount',align:'center'" width="25%" >采购金额</th>
						<!-- <th data-options="field:'name',align:'center',resizable:false,sortable:true" width="20%">操作</th> -->
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
		fpCode:$('#CF_add_PN_fpCode').val(),
		fpMethod:$('#CF_add_PN_fpMethod').val(),
		fpAmount:$('#CF_add_PN_fpAmount').val(),
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


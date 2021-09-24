<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<div  class="easyui-layout" fit="true" >
		<div data-options="region:'north'" border="false" style="margin-bottom: 5px;height:40px;">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th width="90px">采购批次号：</th> 
					<td width="100px">
						<input id="CF_add_PN_fpCode" name="" style="width: 90px;" class="easyui-textbox"></input>
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
				</tr>
			</table>           
		</div>
		<div  region="center" border="false">
			<table id="CF_add_BI_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/BudgetIndexMgr/JsonPagination',
			method:'post',fit:true,pagination:false,toolbar:'#lawHelpTab',singleSelect: true,
			selectOnCheck: true,checkOnSelect: true,remoteSort:true,nowrap:false">
				<thead>
					<tr>
					
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fbId',hidden:true">
							
						</th>
						<th data-options="field:'fbIndexCode',align:'center'" width="10%">预算指标编码</th>
						<th data-options="field:'fbIndexName',align:'center'" width="45%">预算指标名称</th>
						<!-- <th data-options="field:'fpMethod',align:'center',resizable:false,sortable:true" width="25%">采购方式</th> -->
						<th data-options="field:'fpAmount',align:'center'" width="45%" >采购金额</th>
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
function formatPrice(val,row){
	if (val ==0){
		return '<span style="color:green;">'+"暂存"+'</span>';
	} else if(val ==1){
		return '<span style="color:red;">'+"待审核"+'</span>';
	}
}
function CZ(val,row){
	return '<a href="#" onclick="PitchOn('+row.fpId+')" class="easyui-linkbutton">'+"选取"+'</a>';
}
function PitchOn(id){
	var row = $('#CF_add_BI_dg').datagrid('getSelected');
	$("#F_fPurchNo").textbox('setValue',row.fpId); 
	closeFirstWindow();
	//closeWindow();
}
function queryCF(){  
	$('#CF_add_BI_dg').datagrid('load',{ 
		fpCode:$('#CF_add_PN_fpCode').val(),
		fpAmount:$('#CF_add_PN_fpAmount').val(),
	} ); 
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


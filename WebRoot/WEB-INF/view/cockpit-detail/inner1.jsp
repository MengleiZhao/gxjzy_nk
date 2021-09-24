<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/style-tabs.css">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">

<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
.datagrid-cell,
.datagrid-cell-group,
.datagrid-header-rownumber,
.datagrid-cell-rownumber {
  margin: 0;
  padding: 0 4px;
  white-space: nowrap;
  word-wrap: normal;
  overflow: hidden;
  height: 18px;
  line-height: 18px;
  font-size: 12px;
  text-overflow: ellipsis;		/* 焦广兴添加   文本超出单元格省略号显示 */
}
</style>

	<div class="easyui-layout" style="width:100%;height:100%; background: #fff; ">
  <!-- 查询区 -->
  <div data-options="region:'north'" style="height:50px; ">
		<div style="height:100%">
			<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
					<td style="width:20px">
					<td>
					<td id="quota_list_top1" style="text-align: left; padding-right: 10px; ">
						<span style="font-size: 12px; color: #182C4D;">指标名称</span>
						<input id="quota_list_query_indexName" style="width: 150px;height:22px;" class="easyui-textbox"/>
					</td>
					<td>
					&nbsp;&nbsp;
					<a href="#" onclick="searchData();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearSearchData();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>
	</div>	
	<div data-options="region:'center'">
  	<div style="height: 100%; width:98%; margin-left: 1%;">
		<table id="inner1_pro_dg"  class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cockDetail/departData?year=${year}&departName=${departName}',
				method:'post',pageSize:10,fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns:true" >
					<thead>
						<tr>
							<!--  操作时间 操作人 所属部门  支出金额 -->
							<th data-options="field:'bId',hidden:true"></th>
							<th data-options="field:'xdAmount',hidden:true"></th>
							<th data-options="field:'syAmount',hidden:true"></th>
							<th data-options="field:'djAmount',hidden:true"></th>
							<th data-options="field:'num',align:'center'" width="10%">序号</th>
							<th data-options="field:'indexCode',align:'center'" style="width: 25%">指标编码</th>
							<th data-options="field:'indexName',align:'center',formatter:formatCellTooltip" style="width: 20%">指标名称</th>
							<th data-options="field:'pfAmount',align:'center'" width="17%">批复金额（万元）</th>
							<th data-options="field:'amount',align:'center',formatter:zxjeFormat" width="18%">执行金额（万元）</th> 
							<th data-options="field:'name',align:'left',resizable:false,formatter:CZ" style="width: 10%">操作</th>
						</tr>
					</thead>
			</table>
		</div>	
	</div>
	<!-- 导航区 -->
  <div data-options="region:'south'" style="height:40px; ">
  		<div style="text-align: center;">
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
  </div>
 </div>
	
<script type="text/javascript">
//查询
function searchData() {
	$('#inner1_pro_dg').datagrid('load',{
		indexName:$("#quota_list_query_indexName").textbox('getValue').trim()
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_indexName").textbox('setValue','');
	$('#inner1_pro_dg').datagrid('load',{//清空以后，重新查一次
	});
}

//执行金额
function zxjeFormat(val,row){
	var s1=parseFloat(row.xdAmount);
	var s2=parseFloat(row.syAmount);
	var s3=parseFloat(row.djAmount);
	var s4=parseFloat(s1.toFixed(2)-s2.toFixed(2));
	var s5=parseFloat(s4.toFixed(2)-s3.toFixed(2));
	 return s5.toFixed(2);
}
//操作栏创建
function CZ(val, row) {
var code = "'"+row.indexCode+"'";
	return '<table><tr style="width: 75px;height:20px"><td style="width: 85px; ">'+
	   '<a href="#" onclick="detailLook(' + code + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td></tr></table>';
}
function detailLook(code){
	var win = creatFreeWindow('four_window','指标详情信息', 825, 630, 'icon-search', "/cockDetail/tIndexHistory?code="+ code+"&year="+${year}+'&departId='+${departId});
	win.window('open');
}
//鼠标悬浮单元格提示信息  
function formatCellTooltip(value,row,index){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  
</script>
	
</body>
</html>
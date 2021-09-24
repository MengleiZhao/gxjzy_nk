<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">

<script type="text/javascript">
var base='${base}';
var queryYear = '${year}';
var queryDepartId = '${departId}';
</script>

<!-- <style type="text/css">
.datagrid-body{
	height: 358px;
</style> -->


<div class="easyui-layout" style="width:100%;height:100%; 
  	background: #fff;
  ">
  <!-- 查询区 -->
  <div data-options="region:'north'" style="height:50px; ">
		<div style="height:100%">
			<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
					<td style="padding-left: 10px; width: 160px;">
						<span style="font-size: 12px; color: #182C4D;">指标类型：</span>
						<span style="font-size: 12px; color: #0053DC; font-weight: bold;">${indexName}</span>
					</td>
					<td id="quota_list_top1" style="text-align: right; padding-right: 10px; ">
						<span style="font-size: 12px; color: #182C4D;">指标名称</span>
						<input id="quota_list_query_indexName_1" style="width: 90px;height:22px;" class="easyui-textbox"/>
						<span style="font-size: 12px; color: #182C4D;">使用部门</span>
						<input id="quota_list_query_deptName_1" style="width: 90px;height:22px;" class="easyui-textbox"/>
					</td>
					<td>
						<a href="#" onclick="searchData();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
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
		<table id="pro_dg"  class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cockDetail/indexDataList?typeStr=residue&id=${departId}&indexName=${typeNum}&year=${year}',
					method:'post',pageSize:10,fit:true,pagination:true,singleSelect: true,selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,
					striped: true,fitColumns:true" >
					<thead>
						<tr>
							<th data-options="field:'bId',hidden:true"></th>
							<th data-options="field:'num',align:'center'" style="width: 6%">序号</th>
							<th data-options="field:'indexCode',align:'center'" style="width: 12%">指标编码</th>
							<th data-options="field:'indexName',align:'center',formatter:formatCellTooltip" style="width: 17%">指标名称</th>
							<th data-options="field:'deptName',align:'center',formatter:formatCellTooltip" style="width: 10%">使用部门</th>
							<th data-options="field:'pfAmount',align:'right',formatter:listToFixed" style="width: 15%">批复金额(万元)</th>
							<th data-options="field:'syAmount',align:'right',formatter:syAmount" style="width: 15%">剩余金额(万元)</th>
							<th data-options="field:'xdjd',align:'right',formatter: getUse" style="width: 9%">执行进度</th>
							<th data-options="field:'appDate',align:'center',formatter:zcsjFormat" style="width: 10%">批复日期</th>
							<th data-options="field:'operation',align:'center',formatter: CZ" style="width: 8%">操作</th>
						</tr>
					</thead>
			</table>
	</div>
 	</div>
	<!-- 导航区 -->
  <div data-options="region:'south'" style="height:40px; ">
  		<div style="text-align: center;">
			<a href="javascript:void(0)" onclick="goback()">
				<img src="${base}/resource-modality/${themenurl}/button/fanhui1.png"
					onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui2.png')"
					onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui1.png')"
				/>
			</a>
			&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
  </div>
 </div>
<script type="text/javascript">

//查询
function searchData() {
	$('#pro_dg').datagrid('load',{
		searchIndexName:$("#quota_list_query_indexName_1").textbox('getValue').trim(),
		searchDeptName:$("#quota_list_query_deptName_1").textbox('getValue').trim()
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_indexName_1").textbox('setValue','');
	$("#quota_list_query_deptName_1").textbox('setValue','');
	$('#pro_dg').datagrid('load',{//清空以后，重新查一次
	});
}
//时间格式化
function zcsjFormat(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "未填写";
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

//点击 返回 单位预算情况-剩余						
function goback(){						
	var win = parent.creatCockFirstWin('查看-单位剩余预算', 677,400, 'icon-search','/cockDetail/tLeast?year='+queryYear+'&departId='+queryDepartId);					
	win.window('open');					
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
	var win = creatFreeWindow('four_window','指标详情信息', 825, 630, 'icon-search', "/cockDetail/tIndexHistory?code="+ code+"&year="+queryYear);
	win.window('open');
}

//类型转换
function getNum(indexType){
	var indexName = "";
	if (indexType==0) {
		indexName = "基本支出";
	} else if (indexType==1) {
		indexName = "项目支出";
	}
	return indexName;
}
//指标使用进度
function getUse(val,row) {
	return parseFloat(((row.xdAmount-row.syAmount-row.djAmount)/row.pfAmount)*100).toFixed(2)+"%";
}
//剩余金额
function syAmount(val, row) {
	return parseFloat(row.pfAmount-(row.xdAmount-row.djAmount-row.syAmount)).toFixed(2);
}
//鼠标悬浮单元格提示信息  
function formatCellTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  
</script>
	
</body>
</html>


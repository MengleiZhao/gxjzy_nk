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

<style type="text/css">
</style>


	<div class="easyui-layout"
		style="width:100%;height:100%; 
  	background: #fff">
		<!-- 查询区 -->
		<div data-options="region:'north'" style="height:50px; ">
			<div style="height:100%">
				<table cellpadding="0" cellspacing="0"
					style="height: 100%; width:100%;">
					<tr>
						<td style="padding-left: 10px; width: 160px;"><span
							style="font-size: 12px; color: #182C4D;">当前部门：</span> <span
							style="font-size: 12px; color: #0053DC; font-weight: bold;">${departName}</span>
						</td>
						<td id="quota_list_top1"
							style="text-align: right; padding-right: 10px; "><span
							style="font-size: 12px; color: #182C4D;">培训名称</span> <input
							id="quota_list_query_searchName" style="width: 90px;height:22px;"
							class="easyui-textbox" /> </td>
						<td><a href="#" onclick="searchData();"> <img
								style="vertical-align:bottom"
								src="${base}/resource-modality/${themenurl}/button/detail1.png"
								onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a> <a href="#" onclick="clearSearchData();"> <img
								style="vertical-align:bottom"
								src="${base}/resource-modality/${themenurl}/button/qingchu1.png"
								onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a></td>
					</tr>
				</table>
			</div>
		</div>
		<div data-options="region:'center'">
			<div style="height: 100%; width:98%; margin-left: 1%;">
				<table id="pro_dg" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/cockDetail/chartDataList?type=train&id=${departNameId}&year=${year}',
				method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
				selectOnCheck: true,pageSize:10,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns:true">
					<caption></caption>
					<thead>
						<tr>
							<th data-options="field:'rId',hidden:true"></th>
							<th data-options="field:'num',align:'center'" style="width: 7%">序号</th>
							<th data-options="field:'gCode',align:'center'"
								style="width: 18%">报销单编号</th>
							<th
								data-options="field:'gName',align:'center',formatter:formatCellTooltip"
								style="width: 20%">培训名称</th>
							<th
								data-options="field:'reimburseReason',align:'center',formatter:formatCellTooltip"
								width="20%">报销事由</th>
							<th
								data-options="field:'amount',align:'right'"
								style="width: 15%">报销金额(元 )</th>
							<th
								data-options="field:'reimburseReqTime',align:'center',formatter:zcsjFormat"
								width="12%">报销时间</th>
							<th
								data-options="field:'name',align:'center',resizable:false,formatter:CZ"
								style="width: 8%">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<!-- 导航区 -->
		<div data-options="region:'south'" style="height:40px; ">
			<div style="text-align: center;">
				<a href="javascript:void(0)" onclick="goback()"> <img
					src="${base}/resource-modality/${themenurl}/button/fanhui1.png"
					onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui2.png')"
					onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui1.png')" />
				</a> &nbsp;&nbsp; <a href="javascript:void(0)"
					onclick="closeFirstWindow()"> <img
					src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
					onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>

	<script type="text/javascript">
//查询
function searchData() {
	$('#pro_dg').datagrid('load',{
		searchName:$("#quota_list_query_searchName").textbox('getValue').trim(),
		searchContent:$("#quota_list_query_searchContent").textbox('getValue').trim()
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_searchName").textbox('setValue','');
	$("#quota_list_query_searchContent").textbox('setValue','');
	$('#pro_dg').datagrid('load',{//清空以后，重新查一次
	});
}
//时间格式化
function zcsjFormat(val) {
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

//点击 返回(生成饼图)
function goback(){
	var win = parent.creatCockFirstWin('查看-培训支出统计', 677,400, 'icon-search','/cockDetail/inC3?type=train&year='+queryYear+'&departId='+queryDepartId);
	win.window('open');
}
//操作栏创建
function CZ(val, row) {
	
	return '<table style="margin:0 auto"><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editApply(' + row.rId + ',\'detail\')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
}
//鼠标悬浮单元格提示信息  
function formatCellTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  
//查看
function editApply(id,type) {
	var win = creatWin('查看', 970, 580, 'icon-search', "/reimburse/edit?id="+ id+"&editType=0");
	win.window('open');
}
function getMoney(money){
	if(money==null){
		money=0.00;
		return money.toFixed(2);
	}
	return money.toFixed(2);
}
</script>
	
</body>
</html>


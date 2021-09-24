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
  	background: #fff;">
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
							style="font-size: 12px; color: #182C4D;">报销单编号</span> <input
							id="quota_list_query_searchContent"
							style="width: 90px;height:22px;" class="easyui-textbox" /> <span
							style="font-size: 12px; color: #182C4D;">指标名称</span> <input
							id="quota_list_query_searchName" style="width: 90px;height:22px;"
							class="easyui-textbox" /></td>
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
		<!-- 列表区 -->
		<div data-options="region:'center'">
			<div style="height: 100%; width:98%; margin-left: 1%;">
				<table id="inner5-1-dg" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/cockDetail/chartDataList?type=inner5&indexType=inner5_1&itemName=${itemName}&year=${year}&id=${departNameId}&dates=${dates}&datee=${datee}',
				method:'post',pageSize:10,fit:true,pagination:true,singleSelect: true,selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,
			striped: true,fitColumns:true" >
					<thead>
						<tr>
							<th data-options="field:'rId',hidden:true"></th>
							<th data-options="field:'num',align:'center'" width="8%">序号</th>
							<th data-options="field:'gCode',align:'center',formatter:formatCellTooltip" width="18%">申请单编号</th>
							<th data-options="field:'rCode',align:'center',formatter:formatCellTooltip" width="18%">报销单编号</th>
							<th data-options="field:'indexName',align:'center',formatter:formatCellTooltip" width="20%">指标名称</th>
							<th data-options="field:'amount',align:'right'" width="15%">支出金额(元)</th>
							<th
								data-options="field:'reimburseReqTime',align:'center',formatter:zcsjFormat"
								width="15%">支出时间</th>
							<th
								data-options="field:'name',align:'left',resizable:false,formatter:CZ"
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
	$('#inner5-1-dg').datagrid('load',{
		searchName:$("#quota_list_query_searchName").textbox('getValue').trim(),	//指标名称
		searchContent:$("#quota_list_query_searchContent").textbox('getValue').trim()	//报销单编号
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_searchName").textbox('setValue','');
	$("#quota_list_query_searchContent").textbox('setValue','');
	$('#inner5-1-dg').datagrid('load',{//清空以后，重新查一次
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

//点击 返回
function goback(){
	var itemType="";
	if("7"==${itemName}){
		itemType="因公出国出境";
	}else if("5"==${itemName}){
		itemType="公务接待";
	}else if("6"==${itemName}){
		itemType="公务用车购置与运维";
	}
	var win = parent.creatCockFirstWin(itemType+' 经费使用情况', 677,400, 'icon-search',encodeURI('/cockDetail/inC5?itemName=${itemName}&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}
//操作栏创建
function CZ(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="editApply(\''+ row.gCode + '\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a></td></tr></table>';
}
function editApply(code){
	 $.ajax({
		url : base+"/cockDetail/chartApp?code="+code,
		type : "post",
		dataType : "text",
		success : function(data) {
				var win = creatWin('查看', 1075, 580, 'icon-search', "/apply/edit?id="+data+"&editType=detail");
				win.window('open');
		},
		error : function() {
			alert("出现异常啦...");
		}
	});
}
//鼠标悬浮单元格提示信息  
function formatCellTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  
</script>

</body>
</html>


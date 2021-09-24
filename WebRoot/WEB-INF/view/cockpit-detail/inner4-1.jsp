<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">

<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
</style>


<div class="easyui-layout" style="width:100%;height:100%; 
  	background:#fff;">
	<!-- 查询区域 -->
	<div data-options="region:'north'" style="height:50px; ">
		<div style="height:100%">
			<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
				<td style="width:20px">
				<td>
				<td id="quota_list_top1" style="text-align: left; padding-right: 10px; ">
						<span style="font-size: 12px; color: #182C4D;">申请单编号</span>
						<input id="quota_list_query_gCode_1" style="width: 160px;height:22px;" class="easyui-textbox"/>
						&nbsp;&nbsp;
						&nbsp;&nbsp;
						<span style="font-size: 12px; color: #182C4D;">申请摘要名称</span>
						<input id="quota_list_query_gName_1" style="width: 160px;height:22px;" class="easyui-textbox"/>
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
			</tr>
		</table>   
	</div>
	</div>
<!-- 列表区 -->
  <div data-options="region:'center'">
  	<div style="height: 100%; width:98%; margin-left: 1%;">
		<table id="inner4-1-dg"  class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cockDetail/chartDataList?type=inner4&month=${month}&id=${departNameId}',
				method:'post',pageSize:10,fit:true,pagination:true,singleSelect: true,scrollbarSize:0,selectOnCheck: true,checkOnSelect:true,
				remoteSort:true,nowrap:true,striped: true,fitColumns:true" >
					<thead>
						<tr>
							<th data-options="field:'gId',hidden:true"></th>
							<th data-options="field:'num',align:'center'" style="width: 7%">序号</th>
							<th data-options="field:'gCode',align:'center'" style="width: 18%">申请单编号</th>
							<th data-options="field:'gName',align:'center',formatter:formatCellTooltip"  style="width: 20%">申请摘要名称</th>
							<th data-options="field:'amount',align:'center',formatter:getMoney"  style="width: 15%">申请金额(元 )</th>
							<th data-options="field:'deptName',align:'center',formatter:formatCellTooltip" width="15%">申请部门</th>
							<th data-options="field:'reqTime',align:'center',formatter:zcsjFormat" width="15%">申请时间</th>
							<th data-options="field:'name',align:'left',resizable:false,formatter:CZ" style="width: 10%">操作</th>
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
	$('#inner4-1-dg').datagrid('load',{
		searchGCode:$("#quota_list_query_gCode_1").textbox('getValue').trim(),
		searchGName:$("#quota_list_query_gName_1").textbox('getValue').trim()
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_gCode_1").textbox('setValue','');
	$("#quota_list_query_gName_1").textbox('setValue','');
	$('#inner4-1-dg').datagrid('load',{//清空以后，重新查一次
	});
}
function getMoney(money){
	if(money==null){
		money=0.00;
		return money.toFixed(2);
	}
	return money.toFixed(2);
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
//点击 返回(生成柱形图)
function goback(){
	var win = parent.creatCockFirstWin('查看-'+'${dept}'+' 差旅费支出情况', 677,400, 'icon-search',encodeURI('/cockDetail/inC4?departName='+'${departName}'+'&year='+queryYear));
	win.window('open');
}
//操作栏创建
function CZ(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="editApply(\''+row.gCode+'\',0)" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td></tr></table>';
}

function editApply(code,type){
	//根据申请单号获取报销单id
	 $.ajax({
		url : base+"/cockDetail/obtainId?code="+code,
		type : "post",
		dataType : "text",
		success : function(data) {
			var win = creatWin(' ', 1070,580, 'icon-search', "/reimburse/edit?id="+ data+"&editType="+type);
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


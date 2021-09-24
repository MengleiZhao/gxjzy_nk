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



<div class="easyui-layout" style="width:100%;height:100%; background: #fff; ">
  <!-- 查询区 -->
  <div data-options="region:'north'" style="height:50px; ">
		<div style="height:100%">
			<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
					<td style="width:20px">
					<td>
					<td id="quota_list_top1" style="text-align: left; padding-right: 10px; ">
						<span style="font-size: 12px; color: #182C4D;">操作人</span>
						<input id="quota_list_query_userName_1" style="width: 150px;height:22px;left:50%" class="easyui-textbox"/>
						&nbsp;&nbsp;
						&nbsp;&nbsp;
						<span style="font-size: 12px; color: #182C4D;">所属部门</span>
						<input id="quota_list_query_deptName_1" style="width: 150px;height:22px;" class="easyui-textbox"/>
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
		<table id="inner2_pro_dg"  class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cockDetail/outLogData?indexCode=${indexCode}',
				method:'post',pageSize:10,fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
					<thead>
						<tr>
							<!--  操作时间 操作人 所属部门  支出金额 -->
							<th data-options="field:'id',hidden:true"></th>
							<th data-options="field:'pageOrder',align:'center'" width="15%">序号</th>
							<th data-options="field:'userName',align:'center'" style="width: 15%">操作人</th>
							<th data-options="field:'depart',align:'center'" style="width: 20%">所属部门</th>
							<th data-options="field:'date',align:'center',formatter:zcsjFormat" width="20%">变更时间</th>
							<th data-options="field:'amount',align:'center',formatter:zxjdpmJeFormat" width="20%">变更金额（元）</th>
							<th data-options="field:'name',align:'left',resizable:false,formatter:zcmxCZ" style="width: 10%">操作</th>
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
	$('#inner2_pro_dg').datagrid('load',{
		searchUserName:$("#quota_list_query_userName_1").textbox('getValue').trim(),
		searchDeptName:$("#quota_list_query_deptName_1").textbox('getValue').trim()
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_userName_1").textbox('setValue','');
	$("#quota_list_query_deptName_1").textbox('setValue','');
	$('#inner2_pro_dg').datagrid('load',{//清空以后，重新查一次
	});
}

//变更金额格式化 取绝对值
function zxjdpmJeFormat(num){
	return Math.abs(num);
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
//操作栏创建
function zcmxCZ(val, row) {
	var url = "'"+row.url+"'";
	
	return'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	   '<a href="#" onclick="editZCMX(' + url + ')" class="easyui-linkbutton">'+
	   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	   '</a></td></tr></table>';
}
function editZCMX(url) {
	var type = url.substring(1,8);
	//用来判断是不是通用事项
	url = url.toString();
	var lastfourtype = url.substring(url.length-4,url.length);
	var lasttype = url.substring(url.length-1,url.length);
	var types = url.substring(1,12);
	if(type=='ull' || type=='ndefine') {
		alert("没有传入地址");
	} else if(types=='projectknot') {
		var win = parent.creatWin('查看', 980, 580,'icon-search',url);
		win.window('open');
	}else if(type=='project'){
	var win = parent.creatWin('查看', 1230,630, 'icon-search',url);
	win.window('open');
}  else if(type=='Enforci') {
	var win = parent.creatFirstWin('查看', 970, 580,'icon-search',url);
	win.window('open');
} else if(type=='apply/e') {
	if(lasttype=='1') {
		//通用事项申请查看
		var win = parent.creatWin('查看',780, 580,'icon-search',url);
//		win.window('open');
	}else {
		var win = parent.creatWin('查看', 1080, 580,'icon-search',url);
	}
	win.window('open');
} else if(type=='Formula') {
	var win = parent.creatWin('查看', 970, 580,'icon-search',url);
	win.window('open');
} else if(type=='insideA') {
	var win = parent.creatWin('查看', 970, 580,'icon-search',url);
	win.window('open');
}  else if(type=='Storage') {
	var win = parent.creatWin('查看', 970, 580,'icon-search',url);
	win.window('open');
}  else if(type=='reimbur'&&lastfourtype=='tysx') {
	var win = parent.creatWin('查看', 720, 580,'icon-search',url);
	win.window('open');
}  else if(type=='payment') {
	var win = parent.creatWin('查看', 1075, 580,'icon-search',url);
	win.window('open');
}  else {
	var win = parent.creatWin('查看', 970, 580, 'icon-search',url);
	win.window('open');
}
		
		
		
		
		/* if(type=='project'){
		var win = creatWin('查看', 1300,630, 'icon-search',url);
		win.window('open');
	}  else if(type=='Enforci') {
		var win = creatCockFirstWin('查看', 970, 580,'icon-search',url);
		win.window('open');
	}  else {
		var win = creatWin('查看', 960, 580, 'icon-search',url);
		win.window('open');
	} */
}


</script>
	
</body>
</html>


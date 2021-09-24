<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/style-tabs.css">
<script type="text/javascript" src="${base}/resource-modality/js/index-tabs.js"></script>
<script type="text/javascript">
var base='${base}';
var queryYear = '${year}';
var queryDepartId = '${departId}';
var queryDepartName='${departName}';
</script>
<body>
<style type="text/css">
.list-table-tab{
background-color:rgba(1,1,1,0)}
.tab-menu li{
background-color:rgba(1,1,1,0)}
.tab-content>div {
background-color:rgba(1,1,1,0)}
</style>



<div class="easyui-layout" style="width:100%;height:100%; 
  	background:#fff;
  ">
  
   <!-- 查询区 -->
  <div data-options="region:'north'" style="height:50px; ">
  
		<div style="height:100%">
			<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
					<td style="padding-left: 10px; width: 50px;">
						<span style="font-size: 12px; color: #182C4D;">当前部门：</span>
						<span style="font-size: 12px; color: #0053DC; font-weight: bold;">${departName}</span>
					</td>	
					<td class="top-table-search" id="quota_list_top1" style="width: 73%">
					&nbsp;&nbsp;指标编码&nbsp;
					<input id="quota_list_query_indexCode_1" style="width: 90px;height:22px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;指标名称&nbsp;
					<input id="quota_list_query_indexName_1" style="width: 90px;height:22px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="searchData(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearQuotaList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td class="top-table-search" id="quota_list_top2" style="display: none;width: 73%">
					&nbsp;&nbsp;指标编码&nbsp;
					<input id="quota_list_query_indexCode_2" style="width: 90px;height:22px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;指标名称&nbsp;
					<input id="quota_list_query_indexName_2" style="width: 90px;height:22px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="searchData(2);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearQuotaList(2);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					
				</td>
				</tr>
			</table>   
		</div>
  
  </div>
  
   <!-- 列表区 -->
  <div data-options="region:'center'">
  <div class="list-table-tab" style="height: 100%; width:98%; margin-left: 1%; border: none;position: relative; ">
		<div class="tab-wrapper" id="quota-tab" >
			<ul class="tab-menu">
				<li class="active" onclick="reloadbasic()">基本支出</li>
		    	<li onclick="reloadpro()">项目支出</li>
			</ul>
		  
			<div class="tab-content">
				<div style="height: 355px; width:98%; margin-left: 1%;">
					<table id="basicIndex"
					data-options="collapsible:true,url:'${base}/cockDetail/indexDataList?typeStr=residue&id=${departNameId}&year=${year}&indexType=0',
					method:'post',pageSize:9,fit:true,pagination:true,singleSelect: true,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns:true" >
						<thead>
							<tr>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 7%">序号</th>
								<th data-options="field:'indexCode',align:'center'" style="width: 15%">指标编码</th>
								<th data-options="field:'indexName',align:'center',formatter:formatCellTooltip" style="width: 18%">指标名称</th>
								<th data-options="field:'pfAmount',align:'right',formatter:listToFixed" style="width: 16%">批复金额(万元)</th>
								<th data-options="field:'syAmount',align:'right',formatter:syAmount" style="width: 16%">剩余金额(万元)</th>
								<th data-options="field:'xdjd',align:'right',formatter: getUse" style="width: 10%">执行进度</th>
								<th data-options="field:'appDate',align:'center',formatter:zcsjFormat" style="width: 12%">批复日期</th>
								<th data-options="field:'operation',align:'center',formatter: CZ" style="width: 8%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
			   	<div style="height: 355px;width:749px; margin-left: 1%;">
				    <table id="proIndex"
					data-options="collapsible:true,url:'${base}/cockDetail/indexDataList?typeStr=residue&id=${departNameId}&year=${year}&indexType=1',
					method:'post',pageSize:9,fit:true,pagination:true,singleSelect: true,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
						<thead>
							<tr>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 7%">序号</th>
								<th data-options="field:'indexCode',align:'center'" style="width: 15%">指标编码</th>
								<th data-options="field:'indexName',align:'center',formatter:formatCellTooltip" style="width: 18%">指标名称</th>
								<th data-options="field:'pfAmount',align:'right',formatter:listToFixed" style="width: 16%">批复金额(万元)</th>
								<th data-options="field:'syAmount',align:'right',formatter:syAmount" style="width: 16%">剩余金额(万元)</th>
								<th data-options="field:'xdjd',align:'right',formatter: getUse" style="width: 10%">执行进度</th>
								<th data-options="field:'appDate',align:'center',formatter:zcsjFormat" style="width: 12%">批复日期</th>
								<th data-options="field:'operation',align:'center',formatter: CZ" style="width: 8%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		
		</div>
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
function searchData(type){
	if(type==1){
		$('#basicIndex').datagrid('load',{
			searchIndexName:$("#quota_list_query_indexName_1").textbox('getValue').trim(),
			searchIndexCode:$("#quota_list_query_indexCode_1").textbox('getValue').trim()
		});
	}
	if(type==2){
		$('#proIndex').datagrid('load',{
			searchIndexName:$("#quota_list_query_indexName_2").textbox('getValue').trim(),
			searchIndexCode:$("#quota_list_query_indexCode_2").textbox('getValue').trim()
		});
	}
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
	var win = creatFreeWindow('four_window','指标详情信息', 825, 630, 'icon-search', encodeURI("/cockDetail/tIndexHistory?code="+ code+"&year="+queryYear+"&departNameId="+'${departNameId}'));
	win.window('open');
}

function detailHistory(code){
	var win = creatFreeWindow('four_window','指标详情信息', 1000, 550, 'icon-search', "/transmit/zcmx?code="+ code);
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
//type为指标类型1位基本2为项目
var type=1;
function reloadbasic() {
	$('#basicIndex').datagrid('reload');
	type=1;
	
	$("#quota_list_top1").show();
	$("#quota_list_top2").hide();
}
function reloadpro() {
	$('#proIndex').datagrid('reload');
	type=2;
	
	$("#quota_list_top1").hide();
	$("#quota_list_top2").show();
}
flashtab("quota-tab");

//分页样式调整
$(function(){
	var pager = $('#basicIndex').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});	
	
	var pager2 = $('#proIndex').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager2.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});


//清除查询条件
function clearQuotaList(type) {
	if(type==1){
		/* $("#quota_list_query_indexCode_1").textbox('setValue',''); */
		$("#quota_list_query_indexName_1").textbox('setValue','');
		$("#quota_list_query_indexCode_1").textbox('setValue','');
		$("#basicIndex").datagrid('load',{});
	}
	if(type==2){
		/* $("#quota_list_query_indexCode_2").textbox('setValue',''); */
		$("#quota_list_query_indexName_2").textbox('setValue','');
		$("#quota_list_query_indexCode_2").textbox('setValue','');
		$("#proIndex").datagrid('load',{});
	}
}
//鼠标悬浮单元格提示信息  
function formatCellTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  
</script>
</body>


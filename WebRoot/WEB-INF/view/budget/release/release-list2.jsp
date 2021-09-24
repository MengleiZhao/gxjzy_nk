<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/style-tabs.css">
<script type="text/javascript" src="${base}/resource-modality/js/index-tabs.js"></script>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">预算指标名称：</td> 
				<td class="top-table-td2">
					<input id="" name=""  style="width: 150px;height:25px;" class="easyui-datebox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">使用部门：</td> 
				<td class="top-table-td2">
					<input id="" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
				</td>
			</tr>
		</table>   
	</div>


	
	<div class="list-table-tab">
		<div class="tab-wrapper" id="quota-tab2">
			<ul class="tab-menu">
				<li class="active" onclick="reloadbasic2()">基本指标</li>
		    	<li onclick="reloadpro2()">项目指标</li>
			</ul>
		  
			<div class="tab-content">
				<div style="height: 440px">
					<table id="basicIndex2"
					data-options="collapsible:true,url:'${base}/quota/indexPage?indexType=0',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:false" >
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'left'" style="width: 10%">预算指标编码</th>
								<th data-options="field:'indexName',align:'left'" style="width: 10%">预算指标名称</th>
								<th data-options="field:'ysAmount',align:'left'" style="width: 10%">指标批复总额[万元]</th>
								<th data-options="field:'deptName',align:'left'" style="width: 10%">使用部门</th>
								<th data-options="field:'umpfje',align:'left'" style="width: 10%">部门批复金额[万元]</th>
								<th data-options="field:'umpfssje',align:'left'" style="width: 10%">累计下达金额[万元]</th>
								<th data-options="field:'umpssje',align:'left'" style="width: 10%">指标剩余金额[万元]</th>
							<!-- 	<th data-options="field:'appDate',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">批复日期</th> -->
								<th data-options="field:'stauts',align:'left',formatter: indexStauts" style="width: 10%">指标下达状态</th>
								<th data-options="field:'xdjd',align:'left',formatter: zbxdjd" style="width: 10%">指标下达进度</th>
								<th data-options="field:'cz',align:'left',formatter: releaseCZ" style="width: 5%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
			   	<div style="height: 440px">
				    <table id="proIndex2"
					data-options="collapsible:true,url:'${base}/quota/indexPage?indexType=1',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:false" >
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'left'" style="width: 15%">预算指标编码</th>
								<th data-options="field:'indexName',align:'left'" style="width: 15%">预算指标名称</th>
								<th data-options="field:'ysAmount',align:'left'" style="width: 15%">指标批复金额[万元]</th>
								<th data-options="field:'umpfssje',align:'left'" style="width: 10%">累计下达金额[万元]</th>
								<th data-options="field:'umpssje',align:'left'" style="width: 10%">指标剩余金额[万元]</th>
<!-- 								<th data-options="field:'deptName',align:'left'" style="width: 15%">使用部门</th>-->								
								<!-- <th data-options="field:'appDate',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">批复日期</th> -->
								<th data-options="field:'stauts',align:'left',formatter: indexStauts" style="width: 10%">指标下达状态</th>
								<th data-options="field:'xdjd',align:'left',formatter: zbxdjd" style="width: 10%">指标下达进度</th>
								<th data-options="field:'cz',align:'left',formatter: releaseCZ" style="width: 10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		
		</div>
	</div>
</div>


<script type="text/javascript">
flashtab("quota-tab2");

//分页样式调整
$(function(){
	var pager = $('#basicIndex2').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});	
	
	var pager2 = $('#proIndex2').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager2.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});


//指标状态设置
function indexStauts(val, row) {
	if(val==0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未生成" + '</a>';
	} else if(val==1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已生成" + '</a>';
	} else {
		return null;
	}
}

function releaseCZ(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="yszbxd(' + row.bId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/xiada1.png">'+
		   '</a></td></tr></table>';
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/xiada1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/xiada2.png';
}


//type为指标类型1位基本2为项目
var type=1;
function reloadbasic2() {
	//显示导入按钮支持基本指标导入
	$('#imput').css('display','');
	
	$('#basicIndex2').datagrid('reload');
	type=1;
}
function reloadpro2() {
	//隐藏导入按钮
	$('#imput').css('display','none');
	
	$('#proIndex2').datagrid('reload');
	type=2;
}



//修改指标
function yszbxd(id) {
	var win = creatWin('预算指标下达', 540, 480, 'icon-search', '/release/xiada?bId='+id);
	win.window('open');
}

function zbxdjd(val, row) {
	if(row.indexName=="基本工资") {
		return '81%';
	} else {
		return '0%';
	}
}

/* 
function start2() {
	 var value1 = $('#zbxdp2').progressbar().progressbar('getValue');  
       if (value1 < 100){  
          value1 += Math.floor(Math.random() * 2);  
           $('#zbxdp2').progressbar('setValue', value1);  
               if(value1<=30){  
                   $(".progressbar-value .progressbar-text").css("background-color","#DF4134");  
               }else if (value1<=70){  
                   $(".progressbar-value .progressbar-text").css("background-color","#EABA0A");  
               }else if (value1>70){  
                   $(".progressbar-value .progressbar-text").css("background-color","#53CA22");  
               }
           setTimeout(arguments.callee, 30);  
       }  
} */


</script>
</body>


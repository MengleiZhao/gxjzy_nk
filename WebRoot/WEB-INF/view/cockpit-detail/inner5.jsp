<!-- 三公经费 -->

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
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
	<div data-options="region:'center'" >
<div id="div_chart6_inner" class="easyui-tabs" style="">
	<div title="各部门经费使用情况" style="padding:10px;" >
		
		<div id="div_chart6_inner1" style="height:275px; width:620px; margin: 0 auto;" >
		
		</div>
	</div>
	<div title="各月份经费使用情况" style="padding:10px">
		<div id="div_chart6_inner2" style="height:275px; width:660px; margin: 0 auto; " >
		
		</div>
	</div>
</div>
<div data-options="region:'south',split:true" style="height:35px; text-align: center; ">
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</div>
</div>

	
<script type="text/javascript">

var queryYear = '${year}';
var queryDepartId = '${departId}';

//按部门统计 bar
var option_1_1;
var div_chart6_inner1 = echarts.init(document.getElementById('div_chart6_inner1'));
//getdiv_chart6_inner1();
//按月份统计 bar
var option_1_2;
var div_chart6_inner2 = echarts.init(document.getElementById('div_chart6_inner2'));
//getdiv_chart6_inner2();

//-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#div_chart6_inner').tabs({
	onSelect:function(title){
		if("各部门经费使用情况"==title && isflag1==false){
			getdiv_chart6_inner1();
			isflag1=true;
		}
		if("各月份经费使用情况"==title && isflag1==true && isflag2==false){
			getdiv_chart6_inner2();
			isflag2=true;
		}
    }
});

function getdiv_chart6_inner1(dates,datee){
	div_chart6_inner1.clear();
	$.ajax({
		url : encodeURI(base + '/cockDetail/insideData1?chartName=chart6-inner1&itemName=${itemName}&dates='+dates+'&datee='+datee),
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
			var datax = [];
			var datay = [];
			if (map) {
				for (var key in map) {
					datax.push(key);
					var dataobj = {
						value:map[key],
						name:key
					};
					datay.push(dataobj);
				}
			}
			var option = {
					title : {
				        text: '${year}'.substring(0,4)+'年各部门经费使用情况',
				        x:'center'
				    },
				    xAxis: {
				    	name : '部门',
				        type: 'category',
				        data: datax
				    },
				    yAxis: {
				    	name : '金额(万元)',
				        type: 'value'
				    },
				    series: [{
				    	name: '支出金额（万元）',
				        data: datay,
				        type: 'bar',
				        barWidth: '20'
				    }],
				    legend: {
				        data: ['支出金额'],
					    orient: 'vertical',
				        right: '0',
				        top: 'center',
				        show:false
				    },
				    tooltip: {
				        trigger: 'axis'
				    }
				};
				var chart =  echarts.init(document.getElementById('div_chart6_inner1'));
				chart.setOption(option);
			    //单击下钻事件
			    chart.on('click',function(p){
			    	getdiv_chart6_inner5_1(p.name);
			    });
		}
	});
}   
//图一下钻数据列表
function getdiv_chart6_inner5_1(dept){
	var typeName='';
	var itemType='${itemName}';
	if(itemType=="7"){
		typeName="因公出国出境";
	}else if(itemType=="5"){
		typeName="公务接待";
	}else if(itemType=="6"){
		typeName="公务用车购置与运维";
	}
	var win = parent.creatDetailFirstWin('部门 '+typeName+' 经费使用情况',  'icon-search',encodeURI('/cockDetail/chartDetail?type=inner5_1&itemName=${itemName}&year=${year}&dept='+dept+'&departId='+queryDepartId));
	win.window('open');
}

//图二 
function getdiv_chart6_inner2(){
	$.ajax({
		url : encodeURI(base + '/cockDetail/insideData1?chartName=chart6-inner2&itemName=${itemName}'),
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
			var datax = [];
			var datay = [];
			if (map) {
				for (var key in map) {
					datax.push(key);
					var dataobj = {
						value:map[key],
						name:key
					};
					datay.push(dataobj);
				}
			}
			var option = {
					title : {
						text: '各月份经费使用情况',
				        x:'center'
				    },
				    grid:{
						right:70			    	
				    },
				    xAxis: {
				    	name : '时间(月份)',
				        type: 'category',
				        data: datax,
				        axisLabel: {  
				        	   interval:0,  
				        	   rotate:30  
				        	}  
				    },
				    yAxis: {
				    	name : '金额(万元)',
				        type: 'value'
				    },
				    series: [{
				    	name: '支出金额（万元）',
				        data: datay,
				        type: 'bar',
				        barWidth: '20'
				    }],
				    legend: {
				        data: ['支出金额'],
					    orient: 'vertical',
				        right: '0',
				        top: 'center',
				        show:false
				    },
				    tooltip: {
				        trigger: 'axis'
				    }
				};
				var chart =  echarts.init(document.getElementById('div_chart6_inner2'));
				chart.setOption(option);
			    //单击下钻事件
			    chart.on('click',function(p){
			    	getdiv_chart6_inner5_2(p.name);
			    });
		}
	});
}  

//图二下钻数据列表
function getdiv_chart6_inner5_2(month){
	var win = parent.creatDetailFirstWin('经费使用情况', 'icon-search',encodeURI('/cockDetail/chartDetail?type=inner5_2&itemName=${itemName}&year='+queryYear+'&month='+month+'&departId='+queryDepartId));
	win.window('open');
}

//点击查询按钮
function queryBmsgjf(){
	var dates = '';
	var datee = '';
	dates = $('#bmsgjf_datas').datebox('getValue');
	datee = $('#bmsgjf_datae').datebox('getValue');
	getdiv_chart6_inner1(dates,datee);
}

</script>
	
</body>
</html>


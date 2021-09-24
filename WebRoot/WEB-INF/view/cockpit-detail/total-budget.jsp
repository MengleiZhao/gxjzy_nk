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
		<div id="chart_chart1_budget" class="easyui-tabs" style="height:85%; width:100%; border:0;">
			<div title="指标金额占比" style="padding:10px;">
				<div id="chart_chart1_budget1" style="height:250px; width:600px; margin: 0 auto;" >
				
				</div>
			</div>
			<div title="部门指标金额占比" style="padding:10px">
				<div id="chart_chart1_budget2" style="height:250px; width:600px; margin: 0 auto; " >
				
				</div>
			</div>
		</div>
	<div data-options="region:'south',split:true" style="height:15%; text-align: center; ">
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
	</div>
</div>



	
<script type="text/javascript">

var queryYear = '${year}';
var queryDepartId = '${departId}';

//各类型指标统计
//getchart_chart1_budget1(queryYear,queryDepartId);
//各部门指标统计
//getchart_chart1_budget2(queryYear,queryDepartId);

//-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#chart_chart1_budget').tabs({
	onSelect:function(title){
		if("指标金额占比"==title && isflag1==false){
			getchart_chart1_budget1();
			isflag1=true;
		}
		if("部门指标金额占比"==title && isflag1==true && isflag2==false){
			getchart_chart1_budget2();
			isflag2=true;
		}
    }
});

function getchart_chart1_budget1(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart1-budget1',
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
				        text: '指标金额占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "指标类型：{b}<br/>金额：{c} 万元<br/>额度占比： {d} %"
				    },
				    legend: {
				        orient: 'vertical',
				        right: '0',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '指标额度',
				            type: 'pie',
				            radius : '62%',
				            center: ['50%', '60%'],
				            data:datay,
				            itemStyle: {
				            	emphasis: {
				                    shadowBlur: 5,
				                    shadowOffsetX: 0,
				                    shadowOffsetY: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				};
				var chart = echarts.init(document.getElementById('chart_chart1_budget1'));
				chart.clear();
				//设置自定义文字
				var _zr = chart.getZr();
				_zr.add(new echarts.graphic.Text({
					 style: {            
						  x: _zr.getWidth() / 10,
						  y: _zr.getHeight() / 6,
						  textFill:'#182C4D',
						  text: '单位：%',
						  textAlign: 'center', 
						  textFont : 'bold 12px verdana ',
					  }
				}  
				));
				//加载配置
				chart.setOption(option);
			    //单击下钻事件
			    chart.off('click');
			    chart.on('click',function(p){
			    	//generateChart_chart1_budget1_1(p.name);
			    	chartBudgetData1(p.name);
			    });
		}
	});
}   

//图一下钻数据列表
function chartBudgetData1(indexName) {		//indexName 是指标类型 基本支出/项目支出
	var win = parent.creatDetailFirstWin('指标管理信息', 'icon-search',encodeURI('/cockDetail/indexDataJsp?typeStr=budget&year='+queryYear+'&departId='+queryDepartId+'&indexName='+indexName));
	win.window('open');
}

//图二 各部门指标饼图
function getchart_chart1_budget2(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart1-budget2',
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
				        text: '部门指标金额占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "指标类型：{b}<br/>金额：{c} 万元<br/>额度占比： {d} %"
				    },
				    legend: {
				        orient: 'vertical',
				        right: '3%',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '金额(万元)',
				            type: 'pie',
				            radius : '55%',
				            center: ['40%', '60%'],
				            data:datay,
				            itemStyle: {
				            	emphasis: {
				                    shadowBlur: 5,
				                    shadowOffsetX: 0,
				                    shadowOffsetY: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				};
				var chart = echarts.init(document.getElementById('chart_chart1_budget2'));
				chart.clear();
				chart.setOption(option);
			  	//单击下钻事件
			  	chart.off('click');
			    chart.on('click',function(p){
			    	//generateChart_chart1_budget1_2(p.name);
			    	chartBudgetData2(p.name);
			    });
		}
	});
}    
//图二下钻
function chartBudgetData2(departName) {
	var win = parent.creatDetailFirstWin('指标管理信息', 'icon-search',encodeURI('/cockDetail/indexDataJsp?typeStr=budget&year='+queryYear+'&departName='+departName));
	win.window('open');
}


</script>
	
</body>
</html>


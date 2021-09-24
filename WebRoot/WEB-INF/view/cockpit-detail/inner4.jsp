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

<div class="easyui-layout"
		style="width:100%;height:100%; 
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
		<div data-options="region:'center'">
			<div style="margin:20px 0 10px 0;"></div>
			<div id="div_chart2_inner1"
				style="height:300px; width:625px; margin: 0 auto; "></div>
		<div data-options="region:'south',split:true"
			style="height:40px; text-align: center; ">

			<div style="text-align: center;">
				<a href="javascript:void(0)" onclick="closeFirstWindow()"> <img
					src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
					onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>

		</div>
		</div>

	</div>

	
<script type="text/javascript">

var queryYear = '${year}';

gc_chart1_outcome3();

function gc_chart1_outcome3(){
	$.ajax({
		url : encodeURI(base + '/cockDetail/insideData1?chartName=chart5-inner1&departName=${departName}'),
		data : {
			year : queryYear
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
			var option_chart1_outcome3 = {
					title : {
				        text: '${departName}' + ' 项目差旅费统计',
				        x:'center'
				    },
				    grid:{
						right:80			    	
				    },
				    xAxis: {
				    	name : '时间（月份）',
				        type: 'category',
				        data: datax,
				        axisLabel: {  
				        	   interval:0,  
				        	   rotate:30  
			            }
				    },
				    yAxis: {
				    	name : '金额(元)',
				        type: 'value'
				    },
				    series: [{
				    	name: '支出金额',
				        data: datay,
				        type: 'line',
					   

				    }],
				    legend: {
				        data: ['支出金额'],
					    orient: 'vertical',
				        right: '0',
				        top: 'center',
				        show:false
				    },
				    tooltip: {
				        trigger: 'axis',
				        formatter: function(params, ticket, callback){
				        	return params[0].axisValue.split('@')[0]
				        	+ '</br>'
				        	+ params[0].seriesName + "：" 
				        	+ params[0].value + "元";
				        }
				    }
				};
				var chart_chart1_outcome4 =  echarts.init(document.getElementById('div_chart2_inner1'));
				chart_chart1_outcome4.setOption(option_chart1_outcome3);
			    //单击下钻事件
			    chart_chart1_outcome4.on('click',function(p){
			    	getdiv_outcome4_1(p.name);
			    });
		}
	});
}   
//下钻数据列表
function getdiv_outcome4_1(nameCode){
	var month=nameCode;
	var array=nameCode.split('@');
	var win = parent.creatDetailFirstWin(array[0]+' 差旅费列表','icon-search',encodeURI('/cockDetail/chartDetail?type=inner4&month='+month+'&dept=${departName}'));
	win.window('open');
}
</script>
	
</body>
</html>


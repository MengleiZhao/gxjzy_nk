<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">
<!-- echarts  -->
<script type="text/javascript" src="${base}/resource-now/js/echarts.js"></script>

<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
</style>

<div class="easyui-layout"
		style="width:100%;height:100%;">
		<div data-options="region:'center'" style="margin: 0;padding: 0">
			<div style="margin:20px 0 0 0;"></div>
			<div id="trendAnalyze"
				style="height:460px; width:900px; margin: 0 auto; "></div>
			<div style="text-align: center;">
				<a href="javascript:void(0)" onclick="closeFirstWindow()"> <img
					src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
					onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>

	</div>

	
<script type="text/javascript">

var queryYear = '${year}';
var indexCode = '${indexCode}';
var indexName = '${indexName}';
var deptName = '${deptName}';

gc_chart1_outcome3();

function gc_chart1_outcome3(){
	$.ajax({
		url : encodeURI(base + '/bData/trendAnalyzeList?search=0'),
		data : {
			years : queryYear,
			indexCode:indexCode,
			indexName:indexName,
			deptName:deptName
		},
		type : 'post',
		dataType : 'json',
		success : function(obj){
			var data = [];
			var percentage=[];	//执行进度
			var list= [];	//年度
			var dataDept=[];	//部门
			if (obj) {
				 for(var i=0;i<obj.length;i++){
					 obj[i][1]=(obj[i][1]*100).toFixed(2);	//执行进度转换 
					data.push(obj[i]);
					var num=(obj[i][1]); //执行进度
					percentage.push(num);
					var dept=obj[i][5];	//部门
					dataDept.push(dept);
					var y=obj[i][6];	//年度
					list.push(y);
				 } 
			}
			option = {
					tooltip : {
						  trigger: 'axis',
  				        axisPointer :{
  				          type : 'none',
  				          lineStyle: {
  				              type : 'none'
  				          }

  				        },
  				        formatter:function(params){
      				    	return '执行年度' + ' : ' +params[0].seriesName + '<br/>'
      				    	 	+ '指标名称' + ' : ' +(params[0].value)[4] + '<br/>'
      		                   + '指标编码' + ' : ' +(params[0].value)[3] + '<br/>'
      		                 + '下达金额' + ' : ' +(params[0].value)[0]+ ' 万元<br/>'
      		               + '支出金额' + ' : ' +(params[0].value)[2]+ ' 万元<br/>'
      		               + '执行进度' + ' : ' +(params[0].value)[1]+ '%<br/>'
      		                   + '使用部门' + ' : ' +(params[0].value)[5] + '<br/>';
      				    }
				    },
					  title: {
					        text: '指标执行进度趋势分析',
					        left:'center'
					    },
					    legend: {
					    	 orient: 'vertical',
							 right: '3%',
							 top: 'center',
					    },
					    grid:{
					    	right:'12%',
					    	x:50,
					    	y2:50
					    },
					    xAxis: {
					        max: '1000',
					        min:0,
					        name:'下达金额(万元)',
					        splitLine: {
					            lineStyle: {
					                type: 'dashed'
					            }
					        }
					    },
					    yAxis: {
					    
				            name : '执行进度（%）',
				           max:100,
				           min:0,
				           splitLine: {
					            lineStyle: {
					                type: 'dashed'
					            }
					        }
					    },
					    series: [{
					        name: list[0],
					        data: data,
					        type: 'scatter',
					        symbolSize: function (data) {
	                            return data[2]/3;
	                         },
					            label: {
					            emphasis: {
					                show: false,
					                formatter: function (param) {
					                    return param.data[3];
					                },
					                position: 'top'
					            }
					        },
					        itemStyle: {
					            normal: {
					                shadowBlur: 10,
					                shadowColor: 'rgba(120, 36, 50, 0.5)',
					                shadowOffsetY: 5,
					                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
					                    offset: 0,
					                    color: 'rgb(251, 118, 123)'
					                }, {
					                    offset: 1,
					                    color: 'rgb(204, 46, 72)'
					                }])
					            }
					        }
					    }]
					};
			
				var chart_trendAnalyze =  echarts.init(document.getElementById('trendAnalyze'));
				chart_trendAnalyze.setOption(option);
			    //单击下钻事件
			   chart_trendAnalyze.on('click',function(p){
				   detailHistory((p.value)[3]);
			    }); 
		}
	});
}   
//下钻数据列表
function detailHistory(code){
	var win = creatFreeWindow('four_window','支出记录追踪', 970, 550, 'icon-search', "/transmit/zcmx?code="+ code);
	win.window('open');
}
</script>
	
</body>
</html>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>


<style type="text/css">
.td-border-row1{border:1px solid #E3E3E3; margin:25px; width: 425px; }
.td-noborder-row2{						 margin:25px; width: 380px; }
.td-border-row3{border:1px solid #E3E3E3; margin:25px; width: 858px; }

.tr-title1{height:20px; font-size: 16px; vertical-align: bottom;}
.tr-title2{height:20px; font-size: 22px;}
.tr-echart{height:120px;}
.tr-title3{height:35px; font-size: 16px; vertical-align: top;}
.tr5{height:35px; font-size: 16px; vertical-align: top; text-align: center;}
.div-chart-row1{margin: 0 10px 0 10px;height: 120px; width:400px; }
.div-chart-row2{margin: 0 10px 0 10px;height: 220px; width:750px; }
</style>




	<!-- 第1排 -->
	<table style="margin:0 auto;">
		<tr>
			<td class="td-border-row1">
				<table>	
					<tr class="tr-title1"><td>总收入</td></tr>
					<tr class="tr-title2"><td>￥65,548,541</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart11" class="div-chart-row1" >
				
							</div>
						</td>
					</tr>
					<tr class="tr-title3"><td>当月收入	￥2,956,330</td></tr>
				</table>
			</td>
			<td class="td-border-row1">
				<table>	
					<tr class="tr-title1"><td>总支出</td></tr>
					<tr class="tr-title2"><td>￥65,548,541</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart12" class="div-chart-row1" >
				
							</div>
						</td>
					</tr>
					<tr class="tr-title3"><td>当月支出	￥2,956,330	</td></tr>
				</table>
			</td>		
			<td class="td-border-row1">
				<table>	
					<tr class="tr-title1"><td>使用率</td></tr>
					<tr class="tr-title2"><td>￥65,548,541</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart13" class="div-chart-row1" >
								<br><br>
								<div class="easyui-progressbar" data-options="value:40" style="width:300px; height:45px; "></div>
							</div>
						</td>
					</tr>
					<tr class="tr-title3"><td>剩余可用	￥2,956,330	</td></tr>
				</table>
			</td>
			<td class="td-border-row1">
				<table>	
					<tr class="tr-title1"><td>合同数</td></tr>
					<tr class="tr-title2"><td>2,188,025</td></tr>
					<tr class="tr-echart">
						<td>
							<table style="font-size: 18px;">
								<tr><td>正常终止 500</td><td>&nbsp;&nbsp;&nbsp;&nbsp;异常解除 30</td></tr>
								<tr><td>完成归档 400</td><td></td></tr>
							</table>
						</td>
					</tr>
					<tr class="tr-title3"><td>
					</td></tr>
				</table>
			</td>
		</tr>
		
	</table>
	
	<!-- 第2排 -->
	<table style="margin:0 auto;border:1px solid #E3E3E3;">
		<tr>
			<td class="td-noborder-row2">
				<table>	
					<tr class="tr-echart">
						<td>
							<div id="chart21" class="div-chart-row1" >
				
							</div>
						</td>
					</tr>
					<tr class="tr5"><td>资金使用率</td></tr>
				</table>
			</td>
			<td class="td-noborder-row2">
				<table>	
					<tr class="tr-echart">
						<td>
							<div id="chart22" class="div-chart-row1" >
				
							</div>
						</td>
					</tr>
					<tr class="tr5"><td>合同结项率</td></tr>
				</table>
			</td>		
			<td class="td-noborder-row2">
				<table>	
					<tr class="tr-echart">
						<td>
							<div id="chart23" class="div-chart-row1" >
				
							</div>
						</td>
					</tr>
					<tr class="tr5"><td></td></tr>
				</table>
			</td>
			<td class="td-noborder-row2">
				<table>	
					<tr class="tr-echart">
						<td>
							<div id="chart24" class="div-chart-row1" >
				
							</div>
						</td>
					</tr>
					<tr class="tr5"><td></td></tr>
				</table>
			</td>
		</tr>
	</table>
	
	<!-- 第3排 -->
	<table style="margin:0 auto;">
		<tr>
			<td class="td-border-row3">
				<table>	
					<tr class="tr-title1"><td>年度分类支出分析</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart31" class="div-chart-row2" >
				
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td class="td-border-row3">
				<table>	
					<tr class="tr-title1"><td>年度科目支出分析</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart32" class="div-chart-row2" >
				
							</div>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
		
	</table>	
	
	<!-- 第4排 -->
	<table style="margin:0 auto;">
		<tr>
			<td class="td-border-row3">
				<table>	
					<tr class="tr-title1"><td>历年资金使用分析</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart41" class="div-chart-row2" >
				
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td class="td-border-row3">
				<table>	
					<tr class="tr-title1"><td>*分析</td></tr>
					<tr class="tr-echart">
						<td>
							<div id="chart42" class="div-chart-row2" >
				
							</div>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
		
	</table>	
	
	
	
	<script type="text/javascript">
	
	//echart统计图
	generateChart11();
	generateChart12();
	
	generateChart21();
	generateChart22();
	generateChart23();
	
	generateChart31(); 
	generateChart32(); 
	
	generateChart41(); 
	generateChart42(); 
	
	$(".progressbar-value .progressbar-text").css("background-color","black");
	
	//第1排
	function generateChart11(){
		var option = {
			    xAxis: {
			        type: 'category',
			        boundaryGap: false,
			        data: [ '5月', '6月', '7月', '8月', '9月', '10月']
			    },
			    yAxis: {
			        type: 'value',
			        minInterval:500
			    },
			    grid:{
			        x:40,   //左侧与y轴的距离
			        y:15,   //top部与x轴的距离
			        x2:20,   //右侧与y轴的距离
			        y2:30    //bottom部与x轴的距离
			    },
			    series: [{
			        data: [ 932, 901, 934, 1290, 1330, 1320],
			        type: 'line',
			        smooth:true,
			        symbol:'none',
			        areaStyle: {}
			    }]
			};
	        //初始化echarts实例
	        var myChart = echarts.init(document.getElementById('chart11'));
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	}
	function generateChart12(){
		var option = {
				/* title : {
			        text: '机关建设及日常保障经费',
			        subtext: '预算分配情况',
			        left:'center'
			    }, */
	            tooltip:{},
	            legend:{
	                data:['用户来源']
	            },
	            xAxis:{
	                data:["5月","6月","7月","8月","9月","10月"]
	            },
	            yAxis:{
	            	minInterval:3000
	            },
	            toolbox: {
			        show: true,
			        orient: 'vertical',
			        left: 'right',
			        top: 'center',
			        feature: {
			        }
			    },
			    grid:{
			        x:50,   //左侧与y轴的距离
			        y:15,   //top部与x轴的距离
			        x2:20,   //右侧与y轴的距离
			        y2:30    //bottom部与x轴的距离
			    },
	            series:[{
	                name:'预算额度',
	                barWidth:20,
	                type:'bar',
	                data:[12000.00,9000.00,10000.00,11000.00,8000.00,4000.00],
	                itemStyle:{
	                	normal:{
	                		color:'#83bff6'
	                	}
	                }
	            }]
	        };
	        //初始化echarts实例
	        var myChart = echarts.init(document.getElementById('chart12'));
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	} 
	
	//第2排
	function generateChart21(){
		var option = {
			    tooltip: {
			        trigger: 'item',
			        formatter: "{a} <br/>{b}: {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        x: 'left',
			        data:['已使用资金','未使用资金']
			    },
		        color:['#83bff6', '#FFA07A'],
			    series: [
			        {
			            name:'资金使用率',
			            /* itemStyle:{
		                	normal:{
		                		color:'#83bff6'
		                	}
		                }, */
			            type:'pie',
			            radius: ['60%', '90%'],
			            avoidLabelOverlap: false,
			            label: {
			                normal: {
			                    show: false,
			                    position: 'center'
			                },
			                emphasis: {
			                    show: true,
			                    textStyle: {
			                        fontSize: '14'
			                    }
			                }
			            },
			            labelLine: {
			                normal: {
			                    show: false
			                }
			            },
			            data:[
			                {value:335, name:'已使用资金'},
			                {value:310, name:'未使用资金'},
			            ]
			        }
			    ]
			};
        var myChart1 = echarts.init(document.getElementById('chart21'));
        myChart1.setOption(option);
	}
	
	function generateChart22(){
		var option = {
			    tooltip: {
			        trigger: 'item',
			        formatter: "{a} <br/>{b}: {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        x: 'left',
			        data:['已结项合同','未结项合同']
			    },
		        color:['#83bff6', '#FFA07A'],
			    series: [
			        {
			            name:'合同结项率',
			            /* itemStyle:{
		                	normal:{
		                		color:'#83bff6'
		                	}
		                }, */
			            type:'pie',
			            radius: ['60%', '90%'],
			            avoidLabelOverlap: false,
			            label: {
			                normal: {
			                    show: false,
			                    position: 'center'
			                },
			                emphasis: {
			                    show: true,
			                    textStyle: {
			                        fontSize: '14'
			                    }
			                }
			            },
			            labelLine: {
			                normal: {
			                    show: false
			                }
			            },
			            data:[
			                {value:305, name:'已结项合同'},
			                {value:110, name:'未结项合同'},
			            ]
			        }
			    ]
			};
        var myChart1 = echarts.init(document.getElementById('chart22'));
        myChart1.setOption(option);
	}
	
	function generateChart23(){
		var option = {
			    tooltip: {
			        trigger: 'item',
			        formatter: "{a} <br/>{b}: {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        x: 'left',
			        data:['数据1','数据2']
			    },
		        color:['#83bff6', '#FFA07A'],
			    series: [
			        {
			            name:'测试数据',
			            /* itemStyle:{
		                	normal:{
		                		color:'#83bff6'
		                	}
		                }, */
			            type:'pie',
			            radius: ['60%', '90%'],
			            avoidLabelOverlap: false,
			            label: {
			                normal: {
			                    show: false,
			                    position: 'center'
			                },
			                emphasis: {
			                    show: true,
			                    textStyle: {
			                        fontSize: '14'
			                    }
			                }
			            },
			            labelLine: {
			                normal: {
			                    show: false
			                }
			            },
			            data:[
			                {value:50, name:'数据1'},
			                {value:50, name:'数据2'},
			            ]
			        }
			    ]
			};
        var myChart3 = echarts.init(document.getElementById('chart23'));
        var myChart4 = echarts.init(document.getElementById('chart24'));
        myChart3.setOption(option);
        myChart4.setOption(option);
	}
	
	//第3排
	function generateChart31(){
		var option = {
			tooltip : {
			    trigger: 'axis'
			},
            xAxis:{
            	type: 'category',
                data:["人员支出","公共支出","项目支出"]
            },
            yAxis:{
            	minInterval:100
            },
		    grid:{
		        x:50,   //左侧与y轴的距离
		        y:15,   //top部与x轴的距离
		        x2:200,   //右侧与y轴的距离
		        y2:30    //bottom部与x轴的距离
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'right',
		        data:['目标使用','实际使用']
		    },
		    series: [
				        {
				            name: '目标使用',
				            type: 'bar',
				            data: [ 191, 234, 290]
				        },
				        {
				            name: '实际使用',
				            type: 'bar',
				            data: [ 201, 154, 190]
				        }
				    ]
        };
		var myChart = echarts.init(document.getElementById('chart31'));
		myChart.setOption(option);
	}
	
	function generateChart32(){
		var option = {
				/* title : {
			        text: '机关建设及日常保障经费',
			        subtext: '预算分配情况',
			        left:'center'
			    }, */
	            tooltip:{},
	            legend:{
	                data:['用户来源']
	            },
	            xAxis:{
	                data:["机关工资福利支出","对个人和家庭补助","对事业单位补助","债务利息支出","债务还本支出","基础建设支出"],
	                axisLabel: {
                        interval:0,
                        rotate:30
                     }
	            },
	            yAxis:{
	            	minInterval:3000
	            },
	            toolbox: {
			        show: true,
			        orient: 'vertical',
			        left: 'right',
			        top: 'center',
			        feature: {
			        }
			    },
			    grid:{
			        x:50,   //左侧与y轴的距离
			        y:15,   //top部与x轴的距离
			        x2:20,   //右侧与y轴的距离
			        y2:70    //bottom部与x轴的距离
			    },
	            series:[{
	                name:'预算额度',
	                barWidth:20,
	                type:'bar',
	                data:[12000.00,9000.00,10000.00,11000.00,8000.00,4000.00],
	                itemStyle:{
	                	normal:{
	                		color:'#83bff6'
	                	}
	                }
	            }]
	        };
	        //初始化echarts实例
	        var myChart = echarts.init(document.getElementById('chart32'));
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	}
	
	function generateChart41(){
		var option = {
	            tooltip:{},
	            legend:{
	            	orient: 'vertical',
			        left: 'right',
	                data:['收入','支出']
	            },
	            xAxis:{
	                data:["机关工资福利支出","对个人和家庭补助","对事业单位补助","债务利息支出","债务还本支出","基础建设支出"],
	                axisLabel: {
                        interval:0,
                        rotate:30
                     }
	            },
	            yAxis:{
	            	minInterval:3000
	            },
	            toolbox: {
			        show: true,
			        orient: 'vertical',
			        left: 'right',
			        top: 'center',
			        feature: {
			        }
			    },
			    grid:{
			    	x:50,   //左侧与y轴的距离
			        y:15,   //top部与x轴的距离
			        x2:200,   //右侧与y轴的距离
			        y2:30    //bottom部与x轴的距离
			    },
	            series:[{
	                name:'收入',
	                barWidth:20,
	                type:'line',
	                smooth:true,
			        areaStyle: {},
	                data:[6000.00,9000.00,7000.00,11000.00,10500.00,4000.00],
	                itemStyle:{
	                	normal:{
	                		color:'#83bff6'
	                	}
	                }
	            },
	            {
	                name:'支出',
	                barWidth:20,
	                type:'line',
	                smooth:true,
	                areaStyle: {},
	                data:[4500.00,10000.00,9500.00,8000.00,8000.00,10000.00,],
	                itemStyle:{
	                	normal:{
	                		color:'#FFA07A'
	                	}
	                }
	            }
	            ]
	        };
	        //初始化echarts实例
	        var myChart = echarts.init(document.getElementById('chart41'));
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	}
	
	function generateChart42(){
		var option = {
	            tooltip:{},
	            legend:{
	                data:['用户来源']
	            },
	            xAxis:{
	                data:["机关工资福利支出","对个人和家庭补助","对事业单位补助","债务利息支出","债务还本支出","基础建设支出"],
	                axisLabel: {
                        interval:0,
                        rotate:30
                     }
	            },
	            yAxis:{
	            	minInterval:3000
	            },
	            toolbox: {
			        show: true,
			        orient: 'vertical',
			        left: 'right',
			        top: 'center',
			        feature: {
			        }
			    },
			    grid:{
			        x:50,   //左侧与y轴的距离
			        y:15,   //top部与x轴的距离
			        x2:20,   //右侧与y轴的距离
			        y2:70    //bottom部与x轴的距离
			    },
	            series:[{
	                name:'预算额度',
	                barWidth:20,
	                type:'bar',
	                data:[12000.00,9000.00,10000.00,11000.00,8000.00,4000.00],
	                itemStyle:{
	                	normal:{
	                		color:'#83bff6'
	                	}
	                }
	            }]
	        };
	        //初始化echarts实例
	        var myChart = echarts.init(document.getElementById('chart42'));
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	}
	</script>
	
</body>
</html>


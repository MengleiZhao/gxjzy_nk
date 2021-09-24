<%@ page language="java" pageEncoding="UTF-8"%>


	<div id="chart5" style="height:350px; width:100%;" >
		
	</div>
				
							

	<script type="text/javascript">
	getchart5();
	function getchart5(){
		//传柱状图数据:已花金额（万元）
		var data1 =[];
		//x轴坐标：项目名称
		//var projectName=['朝晖小学项目','商标信息化项目','自行车充电桩项目','中央空调安装项目','地铁5号线施工项目'];
		var projectName=['地铁5号线施工项目','中央空调安装项目','自行车充电桩项目','商标信息化项目','朝晖小学项目'];
		//y轴数据:百分比
		var percentage=[];
		$.ajax({
    		//项目执行进去后五的地址
    		url : base + '/cockpit/projectProgressLastFive',
    		type : 'post',
    		dataType : 'json',
    		success : function(json){
    			for (var i = 0; i < json.length; i++) {
    				 //console.log(json[i].yhje);
    				 data1.push(json[i].yhje);
    				 //projectName.push(json[i].xmmc);
    				 percentage.push((json[i].bfb*100).toFixed(2));
				}
    			var option = {
    					title : {
    						text: '项目执行进度(后五)',
    						textStyle: {
    							color:'#666666'
    						}
    					},
    				    tooltip : {
    				        trigger: 'axis',
    				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    				            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
    				        }
    				    },
    				    calculable : true,
    				   	//x轴坐标
    				    xAxis : [
    				        {
    				            type : 'category',
    				            //data:data1,
    				           	data : projectName,
    				            axisLabel : {//坐标轴刻度标签的相关设置。
    				                interval:0,
    				                rotate:"15",
    				                color: '#666666'
    				            }
    				        }
    				    ],
    				    //y轴数据
    				    yAxis : [
    				        {
    				            type : 'value',
    				            data : data1,
    				            name : '已用金额(万元)',
    				           	axisLabel :{
    				            	formatter : '{value}',
    				            	color: '#666666'
    				            },
    				            nameTextStyle :{
    				            	color:'#666666'
    				            },
    				            splitLine: {
    				                show: false
    				            }
    				        },
    				        {
    				            type : 'value',
    				            data : percentage,
    				            name : '执行进度（%）',
    				            axisLabel : {
    				                formatter: '{value}%',
    				                color: '#666666'
    				            },
    				            nameTextStyle :{
    				            	color:'#666666'
    				            },
    				            splitLine: {
    				                show: false
    				            }
    				        }
    				    ],
    				    legend: {
    				        data:['已用金额(万元)','执行进度（%）'],
    				    	top:48
    				    },
    				    grid : {
    						top:100
    					},
    				    //传数据
    				    series : 
    				    	 [
    					        {
    					        	name: '执行进度（%）',
    					            type: 'line',
    					            data: percentage,
    					            color:'#364754',
    					            smooth :true,
    					            smoothness : true,
    					            yAxisIndex: 1,
    					        },
    					        {
    					            name:'已用金额(万元)',
    					            type:'bar',
    					            barWidth: '30',
    					            yAxisIndex: 0,
    					            smooth :true,
    					            smoothness : true,
    					            data:data1,
    					            color: '#b1423b'
    					        }
    					    ],
    				};
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart5'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    		}
    	});
	}                    
	</script>
	
</body>
</html>


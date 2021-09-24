<%@ page language="java" pageEncoding="UTF-8"%>


	<table style="width:95%">
		<tr>
			<td style="width: 80%">
				<div id="chart2" style="height:320px;width: 100%;" >
					
				</div>
			</td>
		</tr>
	</table>
				
							

	<script type="text/javascript">
	
	
	
	
	var option2;
	var chart2 = echarts.init(document.getElementById('chart2'));
	genechart2();
	function genechart2(){
		//数据:批复金额（万元）
		var data1 =[];
		//数据：已用金额（万元）
		var data2 = [];
		//数据：剩余金额（万元）
		var data3 = [];
		//x轴坐标：部门名称
		var departName=[];
		//y轴数据:百分比
		var percentage=[];
		$.ajax({
    		url : base + '/cockpit/departProgress',
    		type : 'post',
    		dataType : 'json',
    		success : function(map){
    			for (var key in map) {
    				departName.push(key);
    				data1.push(map[key][0]);
    				data2.push(map[key][1]);
    				data3.push(map[key][0]-map[key][1]);
    				percentage.push((map[key][2]*100).toFixed(2));
    			}
    			var pfNum=0;
    			var zcNum=0;
    			var syNum=0;
    			for (var key in map) {
    				pfNum += map[key][0];
    				zcNum += map[key][1];
    			}
    			syNum = pfNum - zcNum;
    			$('#cockpit_pfNum').html(pfNum.toFixed(2));
    			$('#cockpit_zcNum').html(zcNum.toFixed(2));
    			$('#cockpit_syNum').html(syNum.toFixed(2));
    			option2 = {
    					title : {
    						text: '各部门预算执行排名',
    						textStyle: {
    							color:'#666666'
    						},
    						top:-5
    					}, 
    					grid: {
    						top:100,
    						left:50
    					},
    				    tooltip : {
    				        trigger: 'axis',
    				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    				            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
    				        },
    				        formatter:function(params){
        				    	return params[0].name + '<br/>'
        		                   + '批复金额（万元）' + ' : ' + (params[1].value + params[0].value) + '<br/>'
        		                   + params[1].seriesName + ' : ' + params[1].value + '<br/>'
        		                   + params[0].seriesName + ' : ' + params[0].value + '<br/>';
        				    }
    				    },
    				    calculable : true,
    				   	//x轴坐标
    				    xAxis : [
    				        {
    				            type : 'category',
    				           	data : departName,
    				            axisLabel : {//坐标轴刻度标签的相关设置。
    				                interval:0,
    				                rotate:"20",
    				                color: '#666666'
    				            }
    				        },
    				    ],
    				    //y轴数据
    				    yAxis : [
    				        {
    				            type : 'value',
    				            data : data1,
    				            name : '金额(万元)',
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
    				    	selectedMode:false,
    				        data:['执行金额（万元）', '剩余金额（万元）','执行进度（%）'],
    				        top:30
    				    },
    				    series : 
    				    	 [
    					        {
    					        	name: '剩余金额（万元）',
    					            type: 'bar',
    					            barWidth: '30',
    					            data: data3,
    					            stack: '金额',
   					            	itemStyle: {
       					            	normal:{
       					            		color:'#6f9ea5',
       					            		barBorderColor: '#6f9ea5',
       					                    barBorderWidth: 3, 
       					            	}
       					            }
    					            
    					        },
    					        {
    					        	name:'执行金额（万元）',
    					            type: 'bar',
    					            data: data2,
    					            stack: '金额',
    					            itemStyle: {
    					            	normal:{
    					            		color:'#e5dfbf',
    					            		barBorderColor: '#6f9ea5',
    					                    barBorderWidth: 2,
    					            	}
    					            }
    					        },
    					        {
    					            name:'执行进度（%）',
    					            type:'line',
    					            yAxisIndex: 1,
    					            smooth :true,
    					            smoothness : true,
    					            data:percentage,
    					            color: '#5196d4'
    					        }
    					    ],
    				};
    			chart2.setOption(option2);
    		}
    	});
	}                    
	</script>
	
</body>
</html>


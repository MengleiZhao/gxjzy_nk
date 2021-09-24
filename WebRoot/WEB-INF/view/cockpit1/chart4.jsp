<%@ page language="java" pageEncoding="UTF-8"%>


	<div id="chart4" style="height:350px; width:100%;" >
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="text-align: center;">
					<img src="${base}/resource-modality/img/cockpit/loading.gif"/>
				</td>
			</tr>
		</table>
	</div>
				
							

	<script type="text/javascript">
	$(function(){
		getchart4('','${defaultDepartId}');
	});
	function getchart4(year,departId){
		//柱状图渐变色
		var color1 = gradualColor('#63aff6','#188df0');
		var color2 = gradualColor('#6bd9d8','#f69f0d');
		var color3 = gradualColor('#64dce2','#0f85dd');
		var color4 = gradualColor('#ffc58d','#fa3d14');
		var color5 = gradualColor('#148cf9','#a837e1');
		//传柱状图数据:已花金额（万元）
		var data1 =[];
		//x轴坐标：项目名称
		var projectName=[];
		//var projectName=['朝晖小学项目','商标信息化项目','自行车充电桩项目','中央空调安装项目','地铁5号线施工项目'];
		//y轴数据:百分比
		var percentage=[];
		//批复金额
		var pfAmount=[];
		$.ajax({
    		//项目执行进去前五的地址
    		url : base + '/cockpit/projectProgressTopFive?year='+year+'&departId='+departId,
    		type : 'post',
    		dataType : 'json',
    		success : function(json){   			
    			for (var i = 0; i < json.length && i < 5 ; i++) {
    				 //console.log(json[i].yhje);
    				 data1.push(json[i].yhje);
    				 projectName.push(json[i].xmmc);
    				 percentage.push((json[i].bfb*100).toFixed(2));
    				 pfAmount.push(json[i].pf);   				
				}
    			var option4 = {
    					title : {
    						//text: '项目执行进度(前五)',
    						textStyle: {
    							color:'#666666'
    						}
    					},
    					//提示框，鼠标悬浮交互时的信息提示
    				    tooltip : {
    				        trigger: 'axis',
    				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    				            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
    				        },
    				         formatter: function(params){
    				        	 return params[0].axisValue.split('@')[0]+ '<br/>'
    				        	 + '批复金额' +' : '+params[0].value+ '万元<br/>'
    				        	 + '执行金额' +' : '+params[1].value+ '万元<br/>' 
    				        	 + '执行进度' +' : '+params[2].value+ '%<br/>';
    				        },
    				      //调整提示框的位置
    		                position: function (p) { //其中p为当前鼠标的位置
    		                    return [p[0] + 10, p[1] - 10];
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
    				                color: '#7efff7',
    				                formatter: function(value,index){
    				                	var nameArr = value.split('@');
    				                	return nameArr[0];
    				                },
		    				      //多余的字自动隐藏为...
			                        formatter: function (value) {
			                            var res = value;
			                            if (res.length > 4) {
			                                res = res.substring(0, 4) + "...";
			                            }
			                            return res;
			                        }
    				            }
    				        }
    				    ],
    				    //y轴数据
    				    yAxis : [
    				        {
    				            type : 'value',
    				            data : data1,
    				            name : '金额(万元)',
    				           	axisLabel :{
    				            	formatter : '{value}',
    				            	color: '#7efff7'
    				            },
    				            nameTextStyle :{
    				            	color:'#7efff7'
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
							        color: '#7efff7'
							    },
							    nameTextStyle :{
							    	color:'#7efff7'
							    },
							    splitLine: {
							        show: false
							    }
							}
    				    ],
    				    legend: {	
    				    	selectedMode:true,/* 图例点击效果 */
    				        data:['批复金额(万元)',,'执行金额(万元)','执行进度（%）'],
    				        top:65,
    				        right:5,
    				        textStyle:{
    				        	color:'#7efff7'
    				        },
    				    },
    				    grid:{
    				    	left: '15%',
    				        right: '11%',
    				    	top:130,
    				    	bottom:50
    				    },
    				    //传柱状图数据
    				    series : 
    				    	 [
								{									
								    name:'批复金额(万元)',
								    type:'bar',
								    barWidth: '20',
								    data:pfAmount,
								    barGap:"-100%", /* 柱形重叠 */
								    color: '#9bc4ae',
								    itemStyle: {
       					            	normal:{
       					            		color:'#2cb6ec',
       					            		barBorderColor: '#2cb6ec',
       					                 	barBorderRadius:[10,10,0,0]
       					            	},
	   					       			 emphasis: {
	   					       				borderWidth: 1,
	  					       		        shadowBlur: 5,
	  					       		        shadowOffsetX:	0,
	  					       		        shadowOffsetY: 0,
	  					       		        shadowColor: 'rgba(255,255,255,0.5)'
  					       				}
       					            }
								},
    					        {									
								    name:'执行金额(万元)',
								    type:'bar',							    
								    barWidth: '20',
								    data:data1,
								    stack: '金额',
    					            itemStyle: {
    					            	normal:{
    					            		color:'#fdb628',
    					            		barBorderColor: '#2cb6ec',
    					                    barBorderRadius:[0,0,0,0]
    					            	},
	   					       			 emphasis: {
	  					       		        borderWidth: 1,
	  					       		        shadowBlur: 5,
	  					       		        shadowOffsetX: 0,
	  					       		        shadowOffsetY: 0,
	  					       		        shadowColor: 'rgba(0,0,0,0.5)'
	  					       		    
	  					       			}
    					            }
								},								
								{
    					        	name: '执行进度（%）',
    					            type: 'line',
    					            data: percentage,
    					            smooth :true,
    					            smoothness : true,
    					            yAxisIndex: 1,
    					            color:['#806d41'],
    					        },
    					    ],
    				};
    				var chart4 = echarts.init(document.getElementById('chart4'));
    			    chart4.setOption(option4);    			    
    			    //单击下钻事件
    			    chart4.on('click',function(p){
    			    	//drillChart2(p.name);
    			    	openInner2(p.name);
    			    });
    		}
    	});
	}                   
	//生成图标的渐变色
	function gradualColor(color1,color2){
		var color = new echarts.graphic.LinearGradient(
            0, 0, 0, 1,
            [
                {offset: 0, color: color1},
                {offset: 1, color: color2}
            ]
        );
		return color;
	}
	</script>
	


<%@ page language="java" pageEncoding="UTF-8"%>


	<table style="width:100%">
		<tr>
			<td>
				<div id="chart2" style="height:320px;width: 100%;" >
					<table style="width: 100%; height: 100%;">
						<tr>
							<td style="text-align: center;">
								<img src="${base}/resource-modality/img/cockpit/loading.gif"/>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
				
							

	<script type="text/javascript">
	
	$(function(){
		genechart2('','${defaultDepartId}');
	});
	
	
	
	function genechart2(year,departId){
		
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
    		url : base + '/cockpit/departProgress?year='+year+'&departId='+departId,
    		type : 'post',
    		dataType : 'json',
    		success : function(map){
    			var option2;
    			var chart2 = echarts.init(document.getElementById('chart2'));
    			for (var key in map) {
    				departName.push(key);
    				data1.push(map[key][0]);/* 批复金额 */
    				data2.push(map[key][1]);/* 执行金额 */
    				data3.push(map[key][0]-map[key][1]);/* 剩余金额 */
    				percentage.push((map[key][2]*100).toFixed(2));/* 执行进度 */
    			}
    			var pfNum=0;
    			var zcNum=0;
    			var syNum=0;
    			for (var key in map) {
    				pfNum += map[key][0];
    				zcNum += map[key][1];
    				syNum += map[key][3];
    			}
    			$('#cockpit_pfNum').html(pfNum.toFixed(2));
    			$('#cockpit_zcNum').html(zcNum.toFixed(2));
    			$('#cockpit_syNum').html(syNum.toFixed(2));
    			option2 = {
    					title : {
    						//text: '各部门预算执行排名',
    						textStyle: {
    							color:'#666666'
    						},
    						top:-5
    					}, 
    					grid: {
    						top:80,
    						left:100,
    						bottom:50
    					},
    				    tooltip : {
    				        trigger: 'axis',
    				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    				            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
    				        },
    				        formatter:function(params){
        				    	return params[0].name + '<br/>'
        		                   + params[0].seriesName + ' : ' + getMoney(params[0].value) + '<br/>'
        		                   + params[1].seriesName + ' : ' + getMoney(params[1].value) + '<br/>'
        		                   + '剩余金额（万元）' + ' : ' + getMoney((params[0].value - params[1].value)) + '<br/>'
        				    }
    				    },
    				    calculable : true,
    				   	//x轴坐标
    				    xAxis : [
    				        {
    				            type : 'category',
    				           	data : departName,  				            
    				            axisLabel: {
    		                        show: true,  
    		                        interval:0,
    				                rotate:"20",
    				                color: '#7efff7',
    		                        //多余的字自动隐藏为...
    		                        formatter: function (value) {
    		                            var res = value;
    		                            if (res.length > 3) {
    		                                res = res.substring(0, 3) + "...";
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
    				        data:[ '批复金额（万元）','执行金额（万元）','执行进度（%）'],
    				        top:30,
    				        textStyle:{
    				        	color:'#7efff7'
    				        }
    				    },
    				    /* 滚动轴 */
    				    dataZoom: 
    				    	[
								{
								    show: false,
								    start: 0,
								    end: 30,
								    top:"95%",
								    left:"12%",
								    showDetail: false,//滑轴的字是否显示
								    realtime: true,//是否实时更新
								    backgroundColor: "rgba(47,69,84,0)", //组件的背景颜色 
								    width: '78%', //指定宽度
								    height: 15, //指定高度    
								},
								{
								    type: 'inside',
								    start: 0,
								    end: 30,
								    zoomLock: true,//是否锁定选择区域（或叫做数据窗口）的大小   
		                            zoomOnMouseWheel: false,  //是否触发缩放
		                            moveOnMouseMove: true, //是否触发数据窗口平移
								}							
    				          ],
    				    series : 
    				    	 [
    					        {
    					        	name: '批复金额（万元）',
    					            type: 'bar',
    					            barGap: "-100%", 
    					            barWidth: '20',
    					            data: data1,
    					            /* stack: '金额', */
    					            /* 数据显示在柱形上 */
    					            /* label: {
    					                normal: {
    					                    show: true,
    					                    position: 'insideTop'
    					                }
    					            }, */
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
    					        	name:'执行金额（万元）',
    					            type: 'bar',
    					            data: data2,
    					            barWidth: '20',
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
    					            name:'执行进度（%）',
    					            type:'line',
    					            yAxisIndex: 1,
    					            smooth :true,
    					            smoothness : true,
    					            data:percentage,
    					            color: '#dc7528'
    					        }
    					    ],
    				};
    			chart2.setOption(option2);
    			/* 数据少于10条时 全部显示 */
    				 if(departName.length <= 10){
    					 chart2.setOption({
    	                        dataZoom: [
    	                            {  	      
    	                            	disabled:false,
    	                            	start:0,
    	                            	end:100,   	                            	
    	                            }
    	                        ],
    	                    })
    				 }   				   				  			
    			//数据多于10条时 鼠标放入 显示滚轮
    			if(departName.length > 10){
                $("#chart2").on('mouseover', function () {
                	chart2.setOption({
                        dataZoom: [
                            {
                                show: true,
                                animation: true
                            }
                        ],
                    })
                })   			
                //鼠标离开 隐藏滚轮
                $("#chart2").on('mouseout', function () {
                	chart2.setOption({
                        dataZoom: [
                            {
                                show: false
                            }
                        ],
                    })
                })
    			} 
    			 //单击下钻事件
			    chart2.on('click',function(p){
			    	openInner1(p.name);
			    });
    		}
    	});
	}             
	function getMoney(money){
		if(money==null){
			money=0.00;
		}
		return money.toFixed(2);
	}
	
	</script>
	
</body>
</html>


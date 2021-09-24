<%@ page language="java" pageEncoding="UTF-8"%>

	<style type="text/css">
		.tdNum{color:#7efff7;width:30%;height:26px; text-align: center; font-size: 12px; vertical-align: center; }
	</style>

	<table style="width:100%;height:100%">
		<tr>
			<!-- 仪表盘 -->
			<td style="width: 33%;" onclick="openInner5('7')">
				<div style="height:; width:100%; font-size: 18px; font-weight: bold; color: #666666; text-align: center; margin-top: 35px;">
					<!-- 因公出国出境费用 -->
				</div>
				<div id="chart61" style="height:210px; width:100%;" >
					
				</div>
				<div style="height:40%;" onmousemove="bigTextPfzc(61)" onmouseout="normalTextPfzc(61)">
					<table style="height: 100px; width: 90%; height:40px; margin: 0 auto;">
						<tr>
							<td class="tdNum pfzc61"><div id="pf61"></div></td>
						</tr>
						<tr>
							<td class="tdNum pfzc61"><div id="zc61"></div></td>
						</tr>
					</table>
				</div>			
			</td>
			
			<!-- 仪表盘 -->
			<td style="width: 33%;" onclick="openInner5('5')">
				<div style="height:; width:100%; font-size: 18px; font-weight: bold; color: #666666; text-align: center; margin-top: 35px;">
						<!-- 公务接待费 -->
				</div>
				<div id="chart62" style="height:210px; width:100%;" >
					<table style="width: 100%; height: 100%;">
						<tr>
							<td style="text-align: center;">
								<img src="${base}/resource-modality/img/cockpit/loading.gif"/>
							</td>
						</tr>
					</table>
				</div>
				<div style="height:40%;" onmousemove="bigTextPfzc(62)" onmouseout="normalTextPfzc(62)">
					<table style="height: 100px; width: 90%; height:40px; margin: 0 auto;">
						<tr >
							<td class="tdNum pfzc62"><div id="pf62"></div></td>
						</tr>
						<tr>
							<td class="tdNum pfzc62"><div id="zc62"></div></td>
						</tr>
					</table>
				</div>			
			</td>
			
			<!-- 仪表盘 -->
			<td style="width: 33%;" onclick="openInner5('6')">
				<div style="height:; width:100%; font-size: 18px; font-weight: bold; color: #666666; text-align: center; margin-top: 35px;">
						<!-- 公务用车购置与运维费 -->
				</div>
				<div id="chart63" style="height:210px; width:100%;" >
					
				</div>
				<div style="height:40%;" onmousemove="bigTextPfzc(63)" onmouseout="normalTextPfzc(63)">
					<table style="height: 100px; width: 90%; height:40px; margin: 0 auto;">
						<tr >
							<td class="tdNum pfzc63"><div id="pf63"></div></td>
						</tr>
						<tr>
							<td class="tdNum pfzc63"><div id="zc63"></div></td>
						</tr>
					</table>
				</div>			
			</td>
		</tr>
	</table>
							

	<script type="text/javascript">
	//鼠标悬浮样式
	function bigTextPfzc(num){
		if(num==61){
			$(".pfzc61").css("font-size","16px");
			$(".pfzc61").css("color","#fff");
		}else if(num==62){
			$(".pfzc62").css("font-size","16px");
			$(".pfzc62").css("color","#fff");
		}else if(num==63){
			$(".pfzc63").css("font-size","16px");
			$(".pfzc63").css("color","#fff");
		}
		
	}
	function normalTextPfzc(num){
		if(num==61){
			$(".pfzc61").css("font-size","14px");
			$(".pfzc61").css("color","#7efff7");
		}else if(num==62){
			$(".pfzc62").css("font-size","14px");
			$(".pfzc62").css("color","#7efff7");
		}else if(num==63){
			$(".pfzc63").css("font-size","14px");
			$(".pfzc63").css("color","#7efff7");
		}
	}
	
	
	
	
	
	
	
	
	
	/* //渐变色
	var color1 = gradualColor('#fdb42c','#0bfeff');
	var color2 = gradualColor('#fdb42c','#fdb42c');
	var color3 = gradualColor('#fdb42c','#b146ff'); */
	var myInterval1=null;
	var myInterval2=null;
	var myInterval3=null;
	$(function(){
		getchart61('','${defaultDepartId}');
		getchart62('','${defaultDepartId}');
		getchart63('','${defaultDepartId}');
	});
	function getchart61(year,departId){
		//百分比
		var data1 =null;
		//批复金额（万元）
		var pf='批复金额';
		//支出金额（万元）
		var zc='支出金额';
		$.ajax({
    		url : base + '/cockpit/dialData?year='+year+'&departId='+departId,
    		type : 'post',
    		dataType : 'json',
    		data : {indexName : '因公出国出境费用'},
    		success : function(json){
    			 data1=json.因公出国出境费用[2];
    			 $('#pf61').text(pf+=' '+((json.因公出国出境费用[0]).toFixed(2)+'万元'));
    			 $('#zc61').text(zc+=' '+((json.因公出国出境费用[1]).toFixed(2)+'万元'));
    			 var option = {
    						/* title :{
    							text: '因公出国出境费用(境)费用',
    							textStyle: {
        							color:'#666666'
        						},
        						left:'16%'
    						},
    						grid:{
    							bottom:0
    						}, */
    					    tooltip : {
    					        formatter: "{a} <br/>{b} : {c}%"
    					    },
    					    series : [
    					        {
    					            name:'业务指标',
    					            type:'gauge',
    					            detail : {
    					            	formatter:'{value}%',
    					            	offsetCenter:[0,'80%'],
    					            	fontSize: 20,
    					            	color: '#7efff7'
    					            },
    					            data:[{value: data1, name: ''}],
    					            axisLine:{
    					            	lineStyle:{
    					            		//color: [[0.3, color1], [0.7, color2], [1, color3]],
    					            		color:[[0.2, '#0bfeff'], [0.8, '#fdb42c'], [1, '#b146ff']],
    					            		width:15,
    					            	}
    					            },
    					            itemStyle: {			// 仪表盘指针样式。
    					            	color: "auto",			// 指针颜色，默认(auto)取数值所在的区间的颜色
    					            },
    					            
    					            emphasis: {				// 高亮的 仪表盘指针样式
    					            	itemStyle: {
    					            		shadowBlur: 10,			// (发光效果)图形阴影的模糊大小。该属性配合 shadowColor,shadowOffsetX, shadowOffsetY 一起设置图形的阴影效果。 
        							        shadowColor: "#fff",	// 阴影颜色。支持的格式同color
    					            	}
    					            },
    					            axisLabel: {
    					            	interval: 20,
    					            	distance:-5,
    					            	textStyle: {
    					            		color:'#7efff7'
    					            	}
    					            },
    					            axisTick: {
    					            	show:false
    					            },
    					            splitLine: {
    					            	show:false
    					            },
    					            pointer: {
    					            	width:5,
    					            	length:"65%"
    					            },
    					            splitNumber: 5
    					        },
    					        {
    					        	radius: '90%',
    				                splitNumber: 0,
    				                type:'gauge',
    				                axisLine: { // 坐标轴线
    				                    lineStyle: {
    				                        color: [[1, '#0095ff']], // 属性lineStyle控制线条样式
    				                        width: 2
    				                    }
    				                },
    				                splitLine: {
    				                    show: false
    				                }
    				            }
    					    ]
    					};
    			
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart61'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    			    //动画1
    			    option.series[1].axisTick = {show: false};
    		        option.series[1].axisLabel = {show: false};
    		        option.series[1].pointer = {show: false};
    		        option.series[1].detail = {show: false};
    		        var num1 = 0;
    		        //清除动画
					clearInterval(myInterval1);
    			      myInterval1 = setInterval(function () {
    			        num1 += Math.round(Math.random()) === 0 ? 0.011 : 0.005;
    			        if (num1 >= 1) num1 = 0;
    			       option.series[1].axisLine.lineStyle.color = [[num1, '#13FEFF'], [1, '#0584D7']];
    			        myChart.setOption(option);
    			    }, 50); 
    			   
    		}
    	}); 
	}    
	
	function getchart62(year,departId){
		//百分比
		var data1 =null;
		//批复金额（万元）
		var pf='批复金额';
		//支出金额（万元）
		var zc='支出金额';
		$.ajax({
    		//项目执行进去后五的地址
    		url : base + '/cockpit/dialData?year='+year+"&departId="+departId,
    		type : 'post',
    		dataType : 'json',
    		data : {indexName : '公务接待费'},
    		success : function(json){
    			 data1=json.公务接待费[2];
    			 $('#pf62').text(pf+=' '+((json.公务接待费[0]).toFixed(2)+'万元'));
    			 $('#zc62').text(zc+=' '+((json.公务接待费[1]).toFixed(2)+'万元'));
    			 var option = {
    						/* title :{
    							text: '公务接待费',
    							textStyle: {
        							color:'#666666'
        						},
        						left:'25%'
    						}, */
    					    tooltip : {
    					        formatter: "{a} <br/>{b} : {c}%"
    					    },
    					    series : [
    					        {
    					            name:'业务指标',
    					            type:'gauge',
    					            detail : {
    					            	formatter:'{value}%',
    					            	offsetCenter:[0,'80%'],
    					            	fontSize: 20,
    					            	color: '#7efff7'
    					            	
    					            },
    					            data:[{value: data1, name: ''}],
    					            axisLine:{
    					            	lineStyle:{
    					            		//color: [[0.3, color1], [0.7, color2], [1, color3]],
    					            		color:[[0.2, '#0bfeff'], [0.8, '#fdb42c'], [1, '#b146ff']],
    					            		width:15
    					            	}
    					            },
    					            axisLabel: {
    					            	distance:-5,
    					            	textStyle: {
    					            		color:'#7efff7'
    					            	}
    					            },
    					            axisTick: {
    					            	show:false
    					            },
    					            splitLine: {
    					            	show:false
    					            },
    					            pointer: {
    					            	width:5,
    					            	length:"65%"
    					            },
    					            splitNumber: 5
    					        },
    					        {
    					        	radius: '90%',
    				                splitNumber: 0,
    				                type:'gauge',
    				                axisLine: { // 坐标轴线
    				                    lineStyle: {
    				                        color: [[1, '#0095ff']], // 属性lineStyle控制线条样式
    				                        width: 2
    				                    }
    				                },
    				                splitLine: {
    				                    show: false
    				                }
    				            }
    					    ]
    					};
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart62'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    			    //动画2
    			    option.series[1].axisTick = {show: false};
    		        option.series[1].axisLabel = {show: false};
    		        option.series[1].pointer = {show: false};
    		        option.series[1].detail = {show: false};
    		        var num1 = 0;
    		        clearInterval(myInterval2);
					
    			      myInterval2 = setInterval(function () {
    			        num1 += Math.round(Math.random()) === 0 ? 0.011 : 0.005;
    			        if (num1 >= 1) num1 = 0;
    			       option.series[1].axisLine.lineStyle.color = [[num1, '#FB8A84'], [1, '#0584D7']];
    			        myChart.setOption(option);
    			    }, 52); 
    		}
    	}); 
	}
	
	function getchart63(year,departId){
		//百分比
		var data1 =null;
		//批复金额（万元）
		var pf='批复金额';
		//支出金额（万元）
		var zc='支出金额';
		$.ajax({
    		//项目执行进去后五的地址
    		url : base + '/cockpit/dialData?year='+year+'&departId='+departId,
    		type : 'post',
    		dataType : 'json',
    		data : {indexName : '公务用车购置与运维费'},
    		success : function(json){
    			 data1=json.公务用车购置与运维费[2];
    			 $('#pf63').text(pf+=' '+((json.公务用车购置与运维费[0]).toFixed(2)+'万元'));
    			 $('#zc63').text(zc+=' '+((json.公务用车购置与运维费[1]).toFixed(2)+'万元'));
    			 var option = {
    						/* title :{
    							text: '公务用车购置与运维费',
    							textStyle: {
        							color:'#666666'
        						},
        						left:'8%'
    						}, */
    						
    					    tooltip : {
    					        formatter: "{a} <br/>{b} : {c}%"
    					    },
    					    series : [
    					        {
    					            name:'业务指标',
    					            type:'gauge',
    					            detail : {
    					            	formatter:'{value}%',
    					            	offsetCenter:[0,'80%'],
    					            	fontSize: 20,
    					            	color: '#7efff7'
    					            },
    					            data:[{value: data1, name: ''}],
    					            axisLine:{
    					            	show:false,
    					            	lineStyle:{
    					            		//color: [[0.3, color1], [0.7, color2], [1, color3]],
    					            		color:[[0.2, '#0bfeff'], [0.8, '#fdb42c'], [1, '#b146ff']],
    					            		width:15
    					            	}
    					            },
    					            axisLabel: {
    					            	distance:-5,
    					            	textStyle: {
    					            		color:'#7efff7'
    					            	}
    					            },
    					            axisTick: {
    					            	show:false
    					            },
    					            splitLine: {
    					            	show:false
    					            },
    					            pointer: {
    					            	width:5,
    					            	length:"65%"
    					            },
    					            splitNumber: 5
    					        },
    					        {
    					        	radius: '90%',
    				                splitNumber: 0,
    				                type:'gauge',
    				                axisLine: { // 坐标轴线
    				                    lineStyle: {
    				                        color: [[1, '#0095ff']], // 属性lineStyle控制线条样式
    				                        width: 2
    				                    }
    				                },
    				                splitLine: {
    				                    show: false
    				                }
    				            }
    					    ]
    					};
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart63'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    			    //动画3
    			    option.series[1].axisTick = {show: false};
    		        option.series[1].axisLabel = {show: false};
    		        option.series[1].pointer = {show: false};
    		        option.series[1].detail = {show: false};
    		        var num1 = 0;
    		        clearInterval(myInterval3);
    			      myInterval3 = setInterval(function () {
    			        num1 += Math.round(Math.random()) === 0 ? 0.011 : 0.005;
    			        if (num1 >= 1) num1 = 0;
    			       option.series[1].axisLine.lineStyle.color = [[num1, '#EEEE00'], [1, '#0584D7']];
    			        myChart.setOption(option);
    			    }, 55); 
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


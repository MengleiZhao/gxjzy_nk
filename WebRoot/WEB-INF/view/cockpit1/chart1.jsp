<%@ page language="java" pageEncoding="UTF-8"%>

	
	<script type="text/javascript">
	//鼠标悬浮样式
	function bigText(x){
		//x.style.fontSize="13px";
		x.style.color="#fff";
	}
	function normalText(x){
		//x.style.fontSize="12px";
		x.style.color="#7efff7";
	}
	</script>
	<div style="margin-top: 2px;">
			<span style="text-align: left; color: #666666; font-weight: bold; font-size: 18px; ">
				<!-- 培训会议支出统计 -->
			</span>
	</div>
	
	<div style="height:28px">
	</div>

	<div><span style="cursor: pointer;color:#7efff7;font-size: 12px;"onclick="openInnerNumber3('培训')" onmousemove="bigText(this)" onmouseout="normalText(this)">培训计划执行情况（数量）</span></div>
	<div id="chart11" style="height:50px; width:90%; cursor: pointer;" onclick="openInnerNumber3('培训')";>
		 
	</div>
	<div><span style="cursor: pointer;color:#7efff7;font-size: 12px;"onclick="openInner3('培训')" onmousemove="bigText(this)" onmouseout="normalText(this)">培训计划执行情况（金额）</span></div>
	<div id="chart12" style="height:50px; width:90%; cursor: pointer;" onclick="openInner3('培训')";>
		 <table style="width: 100%; height: 100%;"><tr><td style="text-align: center;">
			<img src="${base}/resource-modality/img/cockpit/loading.gif"/>
		</td></tr></table>
	</div>
	<div><span style="cursor: pointer;color:#7efff7;font-size: 12px;"onclick="openInnerNumber3('会议')" onmousemove="bigText(this)" onmouseout="normalText(this)">会议计划执行情况（数量）</span></div>
	<div id="chart13" style="height:50px; width:90%; cursor: pointer;" onclick="openInnerNumber3('会议')";>
		 
	</div>
	<div><span style="cursor: pointer;color:#7efff7;font-size: 12px;"onclick="openInner3('会议')" onmousemove="bigText(this)" onmouseout="normalText(this)">会议计划执行情况（金额）</span></div>
	<div id="chart14" style="height:50px; width:90%; cursor: pointer;"onclick="openInner3('会议')"; >
		 
	</div>
				
							

	<script type="text/javascript">
	
	
	$(function(){
		generateChart1('','');
	});
	//setInterval(generateChart1,3000);  
	
	
	
	
	function generateChart1(year,departId){
		//获取数据
		var data = [];
		$.ajax({
			url : base + '/cockpit/data1?year='+year+'&departId='+departId,
			type : 'get',
			async : false,
			dataType : "json",
			success : function(json){
				
				//解决 echart Can't get dom width or height
				$("#chart11").width('280px');
				$("#chart12").width('280px');
				$("#chart13").width('280px');
				$("#chart14").width('280px');
				var option11;
				var chart11 = echarts.init(document.getElementById('chart11'));
				var option12;
				var chart12 = echarts.init(document.getElementById('chart12'));
				var option13;
				var chart13 = echarts.init(document.getElementById('chart13'));
				var option14;
				var chart14 = echarts.init(document.getElementById('chart14'));
				for(var i = 0; i < json.length; i++){
					data.push(json[i][1]);
				}
				generateChart11(chart11,option11,'培训计划执行情况（数量）',data[0],'200','次','#2791eb');
				generateChart11(chart12,option12,'培训计划执行情况（金额）',data[1],'100000','元','#fdb42c');
				generateChart11(chart13,option13,'会议计划执行情况（数量）',data[2],'200','次','#67dfe2');
				generateChart11(chart14,option14,'会议计划执行情况（金额）',data[3],'100000','元','#ea6e4a');
			}
		});
	}
	//参数：chart对象 option对象 表名
	function generateChart11(chart,option,name,data,max,dw,barColor){
			option = {
			    xAxis: {
			    	type: 'value',
			    	splitLine: {
		                show: false
		            },
		            max:max
			    },
			    yAxis: {
			        	show:false,
			        	 type: 'category',
					     data: [name]
			    },
			    grid: {
			    	left:'0%'
			    },
			    series: [{
			        data: [data],
			        type: 'bar',
			        color: barColor,
		            barWidth: '15',
		            itemStyle: {
		            	normal: {
		            		barBorderRadius: [0, 20, 20, 0]
		            	},
			       		emphasis: {
				       		 borderWidth: 1,
				       		 shadowBlur: 5,
				       		 shadowOffsetX: 0,
				       		 shadowOffsetY: 0,
				       		 shadowColor: 'rgba(255,255,255,0.9)'
				       	}
		            }
			    }],
			    tooltip:{
			    	name:[name],
			    	formatter: '{b0}:{c0}'+dw
			    }
			};	
		
	        chart.setOption(option);
	      	//单击下钻事件
		    chart.on('click',function(p){
		    	openInner3(p.name);
		    });
	}
	</script>
	
</body>
</html>


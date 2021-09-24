<%@ page language="java" pageEncoding="UTF-8"%>

	<style>
	div{
		font-size: 12px;
		color:#666666;
	}
	</style>
	
	<div style="margin-top: 2px;">
			<span style="text-align: left; color: #666666; font-weight: bold; font-size: 18px; ">
				培训会议支出统计
			</span>
	</div>
	
	<div style="height:28px">
	</div>

	<div>培训计划执行情况（数量）</div>
	<div id="chart11" style="height:50px; width:300px;" >
		 
	</div>
	<div>培训计划执行情况（金额）</div>
	<div id="chart12" style="height:50px; width:300px;" >
		 
	</div>
	<div>会议计划执行情况（数量）</div>
	<div id="chart13" style="height:50px; width:300px;" >
		 
	</div>
	<div>会议计划执行情况（金额）</div>
	<div id="chart14" style="height:50px; width:300px;" >
		 
	</div>
				
							

	<script type="text/javascript">
	
	var option11;
	var chart11 = echarts.init(document.getElementById('chart11'));
	var option12;
	var chart12 = echarts.init(document.getElementById('chart12'));
	var option13;
	var chart13 = echarts.init(document.getElementById('chart13'));
	var option14;
	var chart14 = echarts.init(document.getElementById('chart14'));
	
	generateChart1();
	//setInterval(generateChart1,3000);  
	
	
	
	
	function generateChart1(){
		//获取数据
		var data = [];
		$.ajax({
			url : base + '/cockpit/data1',
			type : 'get',
			async : false,
			dataType : "json",
			success : function(json){
				for(var i = 0; i < json.length; i++){
					data.push(json[i][1]);
				}
				/* generateChart11(chart11,option11,'培训计划执行情况（数量）',data[0],'100','次');
				generateChart11(chart12,option12,'培训计划执行情况（金额）',data[1],'100000','元');
				generateChart11(chart13,option13,'会议计划执行情况（数量）',data[2],'100','次');
				generateChart11(chart14,option14,'会议计划执行情况（金额）',data[3],'100000','元'); */
				generateChart11(chart11,option11,'培训计划执行情况（数量）',100,'100','次');
				generateChart11(chart12,option12,'培训计划执行情况（金额）',20000,'100000','元');
				generateChart11(chart13,option13,'会议计划执行情况（数量）',70,'100','次');
				generateChart11(chart14,option14,'会议计划执行情况（金额）',50000,'100000','元');
			}
		});
	}
	//参数：chart对象 option对象 表名
	function generateChart11(chart,option,name,data,max,dw){
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
			    series: [{
			        data: [data],
			        type: 'bar',
			        color: '#bf873d',
		            barWidth: '30'
			    }],
			    tooltip:{
			    	name:[name],
			    	formatter: '{b0}:{c0}'+dw
			    }
			};	
		
	        chart.setOption(option);
	}
	</script>
	
</body>
</html>


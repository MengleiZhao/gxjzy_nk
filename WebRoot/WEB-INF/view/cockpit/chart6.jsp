<%@ page language="java" pageEncoding="UTF-8"%>

	<style type="text/css">
		.tdNum{color:#fff;width:30%; text-align: center; font-size: 12px; vertical-align: center;  padding:10px;}
	</style>

	<table style="width:100%;height:100%">
		<tr>
			<!-- 仪表盘 -->
			<td style="width: 33%;">
				<div style="width:100%; font-size: 18px; font-weight: bold; color: #666666; text-align: center; margin-top: 35px;">
					因公出国（境）费用
				</div>
				<div id="chart61" style="height:210px; width:100%;" >
					
				</div>
				<div style="height:40%;">
					<table style="height: 100px; width: 90%; height:40px; margin: 0 auto;">
						<tr >
							<td class="tdNum" style="vertical-align: center; background-color: #6d9ca2;"><div id="pf61" style="color:white" ></div></td>
							<td class="tdNum" style="vertical-align: center; background-color: #7c9b83;"><div id="zc61" style="color:white"  ></div></td>
						</tr>
					</table>
				</div>			
			</td>
			
			<!-- 仪表盘 -->
			<td style="width: 33%;">
				<div style="width:100%; font-size: 18px; font-weight: bold; color: #666666; text-align: center; margin-top: 35px;">
						公务接待费
				</div>
				<div id="chart62" style="height:210px; width:100%;" >
					
				</div>
				<div style="height:40%;">
					<table style="height: 100px; width: 90%; height:40px; margin: 0 auto;">
						<tr >
							<td class="tdNum" style="vertical-align: center; background-color: #c5836b;"><div id="pf62" style="color:white" ></div></td>
							<td class="tdNum" style="vertical-align: center; background-color: #b69f99;"><div id="zc62" style="color:white" ></div></td>
						</tr>
					</table>
				</div>			
			</td>
			
			<!-- 仪表盘 -->
			<td style="width: 33%;">
				<div style="width:100%; font-size: 18px; font-weight: bold; color: #666666; text-align: center; margin-top: 35px;">
						公务用车购置与运维费
				</div>
				<div id="chart63" style="height:210px; width:100%;" >
					
				</div>
				<div style="height:40%;">
					<table style="height: 100px; width: 90%; height:40px; margin: 0 auto;">
						<tr >
							<td class="tdNum" style="vertical-align: center; background-color: #d7a560;"><div id="pf63" style="color:white"></div></td>
							<td class="tdNum" style="vertical-align: center; background-color: #bb873e;"><div id="zc63" style="color:white" ></div></td>
						</tr>
					</table>
				</div>			
			</td>
		</tr>
	</table>
							

	<script type="text/javascript">
	getchart61();
	function getchart61(){
		//百分比
		var data1 =null;
		//批复金额（万元）
		var pf='批复金额';
		//支出金额（万元）
		var zc='支出金额';
		$.ajax({
    		//项目执行进去后五的地址
    		url : base + '/cockpit/dialData',
    		type : 'post',
    		dataType : 'json',
    		data : {indexName : '奖金'},
    		success : function(json){
    			 data1=json.奖金[2];
    			 $('#pf61').text(pf+=' '+((json.奖金[0]).toFixed(2)+'万元'));
    			 $('#zc61').text(zc+=' '+((json.奖金[1]).toFixed(2)+'万元'));
    			 var option = {
    						/* title :{
    							text: '因公出国(境)费用',
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
    					            	fontSize: 20
    					            },
    					            data:[{value: data1, name: ''}],
    					            axisLine:{
    					            	lineStyle:{
    					            		color: [[0.2, '#9bc4ae'], [0.8, '#63859d'], [1, '#b1423b']],
    					            		width:20
    					            	}
    					            },
    					            axisLabel: {
    					            	distance:-5
    					            },
    					            pointer: {
    					            	width:5,
    					            	length:"65%"
    					            }
    					        }
    					    ]
    					};
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart61'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    		}
    	}); 
	}    
	getchart62();
	function getchart62(){
		//百分比
		var data1 =null;
		//批复金额（万元）
		var pf='批复金额';
		//支出金额（万元）
		var zc='支出金额';
		
		$.ajax({
    		//项目执行进去后五的地址
    		url : base + '/cockpit/dialData',
    		type : 'post',
    		dataType : 'json',
    		data : {indexName : '职业年金缴费'},
    		success : function(json){
    			
    			 data1=json.职业年金缴费[2];
    			 $('#pf62').text(pf+=' '+((json.职业年金缴费[0]).toFixed(2)+'万元'));
    			 $('#zc62').text(zc+=' '+((json.职业年金缴费[1]).toFixed(2)+'万元'));
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
    					            	fontSize: 20
    					            	
    					            },
    					            data:[{value: data1, name: ''}],
    					            axisLine:{
    					            	lineStyle:{
    					            		color: [[0.2, '#9bc4ae'], [0.8, '#63859d'], [1, '#b1423b']],
    					            		width:20
    					            	}
    					            },
    					            axisLabel: {
    					            	distance:-5
    					            },
    					            pointer: {
    					            	width:5,
    					            	length:"65%"
    					            }
    					        }
    					    ]
    					};
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart62'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    		}
    	}); 
	}
	getchart63();
	function getchart63(){
		//百分比
		var data1 =null;
		//批复金额（万元）
		var pf='批复金额';
		//支出金额（万元）
		var zc='支出金额';
		$.ajax({
    		//项目执行进去后五的地址
    		url : base + '/cockpit/dialData',
    		type : 'post',
    		dataType : 'json',
    		data : {indexName : '津贴补贴'},
    		success : function(json){
    			 data1=json.津贴补贴[2];
    			 $('#pf63').text(pf+=' '+((json.津贴补贴[0]).toFixed(2)+'万元'));
    			 $('#zc63').text(zc+=' '+((json.津贴补贴[1]).toFixed(2)+'万元'));
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
    					            	fontSize: 20
    					            },
    					            data:[{value: data1, name: ''}],
    					            axisLine:{
    					            	lineStyle:{
    					            		color: [[0.2, '#9bc4ae'], [0.8, '#63859d'], [1, '#b1423b']],
    					            		width:20
    					            	}
    					            },
    					            axisLabel: {
    					            	distance:-5
    					            },
    					            pointer: {
    					            	width:5,
    					            	length:"65%"
    					            }
    					        }
    					    ]
    					};
    			    //初始化echarts实例
    			    var myChart = echarts.init(document.getElementById('chart63'));
    			    //使用制定的配置项和数据显示图表
    			    myChart.setOption(option);
    		}
    	}); 
	}
	</script>


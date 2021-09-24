<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">


<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
</style>


<div class="easyui-layout" style="width:100%;height:100%; 
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
  	<div data-options="region:'center'" >
  	
  		<div id="div-chart1-outcome" class="easyui-tabs" style="">
			<div title="分项支出金额占比" style="padding:10px;" >
				<div id="div-chart1-outcome1" style="height:260px; width:600px; margin: 0 auto;" >
				
				</div>
			</div>
			
			<div title="年度预算支出趋势分析" style="padding:10px">
				<div id="div-chart1-outcome2" style="height:260px; width:600px; margin: 0 auto; " >
				
				</div>
			</div>
			
			<div title="月度预算支出趋势分析" style="padding:10px">
				<div id="div-chart1-outcome3" style="height:260px; width:600px; margin: 0 auto; " >
				
				</div>
			</div>
		</div>
  	<div data-options="region:'south',split:true" style="height:40px; text-align: center; ">
  		
  		<div style="text-align: center;">
			<a href="javascript:void(0)" onclick="gc_chart1_outcome1();$(this).css('display','none')" style="display: none;" id="anyc">
		<img src="${base}/resource-modality/${themenurl}/button/fanhui1.png"
			onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui2.png')"
			onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui1.png')"
		/>
	</a>
&nbsp;&nbsp;
	<a href="javascript:void(0)" onclick="closeFirstWindow()">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
		</div>
  		
  	</div>
  	</div>
</div>






<script type="text/javascript">

var queryYear = '${year}';
var queryDepartId = '${departId}';
/* //单位预算支出统计 / 柱状
gc_chart1_outcome1(queryYear,queryDepartId);
//单位预算支出同比分析/折线图
gc_chart1_outcome2(queryYear,queryDepartId);
//单位预算支出环比分析/折线图
gc_chart1_outcome3(queryYear,queryDepartId); 
*/
//-----延迟加载----
var isflag1=false;
var isflag2=false;
var isflag3=false;
$('#div-chart1-outcome').tabs({
    onSelect:function(title){
		if("分项支出金额占比"==title && isflag1==false){
			gc_chart1_outcome1(queryYear,queryDepartId);
			isflag1=true;
		}
		if("年度预算支出趋势分析"==title && isflag1==true && isflag2==false){
			gc_chart1_outcome2(queryYear,queryDepartId);
			isflag2=true;
		}
		if("月度预算支出趋势分析"==title && isflag1==true && isflag3==false){
			gc_chart1_outcome3(queryYear,queryDepartId); 
			isflag3=true;
		}
    }
});

//图一
function gc_chart1_outcome1(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart1-outcome1',
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
			var datax = [];
			var datay = [];
			if (map) {
				for (var key in map) {
					datax.push(key);
					var dataobj = {
						value:map[key],
						name:key
					};
					datay.push(dataobj);
				}
			}
			var option_chart1_outcome1 = {
				    title : {
				        text: '分项支出金额占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "报销类型：{b}<br/>金额：{c} 元<br/>额度占比： {d} %"
				    },
				    legend: {
				        orient: 'vertical',
				        right: '0',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '各类支出',
				            type: 'pie',
				            radius : '55%',
				            center: ['50%', '60%'],
				            data:datay,
				            itemStyle: {
				            	emphasis: {
				                    shadowBlur: 5,
				                    shadowOffsetX: 0,
				                    shadowOffsetY: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				};
				var chart_chart1_outcome1 =  echarts.init(document.getElementById('div-chart1-outcome1'));
				chart_chart1_outcome1.off('click');
				chart_chart1_outcome1.clear();
				chart_chart1_outcome1.setOption(option_chart1_outcome1);
			 	//单击下钻事件
			    chart_chart1_outcome1.on('click',function(p){
			    	gc_chart1_outcome1_1(p.name);
			    	$("#anyc").css("display","");
			    });
		}
	});
}  

//生成图一下钻图
function gc_chart1_outcome1_1(indexName){
	var indexType = 0;	
	if (indexName=='直接报销') {
		indexType = 3;
	} else if (indexName=='申请报销') {
		indexType = 4;
	}else if (indexName=='借款') {
		indexType = 5;
		}else if (indexName=='采购支付') {
		indexType = 6;
	}else if (indexName=='合同报销') {
		indexType = 7;
	}
	$.ajax({
		url :  base + '/cockDetail/insideData2?chartName=chart1-outcome1_outcome1&indexType='+indexType,
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
			var datax = [];
			var datay1 = [];
			var datay2 = [];
			if (map) {
				for (var key in map) {
					var data=map[key];//取得里面的map
					if("map1"==key){	//map1:当前年份
						for (var k in data) {
							datax.push(k);	//存的年份
							var dataobj = {
								value:data[k],//取得金额
								name:k	//取得年份
							};
							datay1.push(dataobj);
						}
					}else{	//map2 同期
						for (var k in data) {
							var dataobj = {
								value:data[k],//取得金额
								name:k	//取得年份
							};
							datay2.push(dataobj);
						}
					}
				}
			}
		//绘制图表
		var chart = echarts.getInstanceByDom(document.getElementById("div-chart1-outcome1"));
		chart.clear();
		var option= {
			color: [ '#e5323e','#003366'],
			toolbox: {
			    show : true,
			    top:20,
			    itemSize:16,
			},		
			title : {
				text: '同期报销情况分析',
				x:'center'
			},
			 grid:{
					left:70			    	
			    },
			xAxis: {
				name : '日期',
				type: 'category',
				data: datax,
				 axisLabel: {  
		        	   interval:0,  
		        	   rotate:30  
		        	}  
			},
			yAxis: {
				name : '金额(元)',
				type: 'value'
			},
			series: [{
				name: '当年报销金额',
				data: datay1,
				type: 'bar',
		        barWidth:15,
		        itemStyle: {
		       			 emphasis: {
		       				borderWidth: 1,
		       		        shadowBlur: 5,
		       		        shadowOffsetX:	0,
		       		        shadowOffsetY: 0,
		       		        shadowColor: 'rgba(0,0,0,0.5)'
	       				}
		            }
			},
			{
				name: '同期报销金额',
				data: datay2,
				type: 'bar',
				barWidth:15,
		        itemStyle: {
		       			 emphasis: {
		       				borderWidth: 1,
		       		        shadowBlur: 5,
		       		        shadowOffsetX:	0,
		       		        shadowOffsetY: 0,
		       		        shadowColor: 'rgba(0,0,0,0.5)'
	       				}
		            }
			}
			],
			legend: {
				data: ['报销金额(元)','同期报销金额(元)'],
				orient: 'vertical',
				right: '0',
				top: 'center',
				show:false
			},
			tooltip: {
		        axisPointer: {
		            type: 'shadow'
		        }
		    }
		};
		chart.setOption(option);
		chart.on('click',function(p){
			outComeData1(p.name,indexName);
	    });
		}
	});
} 
//图一三级下钻
function outComeData1(year,indexName) {
	//year是需要查询的年月
	//queryYear是生成图一饼图的时间
		var indexType = 0;	
	if (indexName=='直接报销') {
		indexType = 3;
	} else if (indexName=='申请报销') {
		indexType = 4;
	}else if (indexName=='借款') {
		indexType = 5;
		}else if (indexName=='采购支付') {
		indexType = 6;
	}else if (indexName=='合同报销') {
		indexType = 7;
	}
	//时间格式化
	 var t, y, m;
	 t = new Date(year);
	 y = t.getFullYear();
	 m = t.getMonth() + 1;
	// 可根据需要在这里定义时间格式  
	 if(year.length>4){
	     years=y + '年' + (m < 10 ? '0' + m : m)+'月';
	 }else{
		 years=y + '年';
	 }
	var win = parent.creatDetailFirstWin('指标管理信息', 'icon-search','/cockDetail/indexDataJsp?typeStr=detail&year='+year+'&queryYear='+queryYear+'&departId='+queryDepartId+'&indexType='+indexType);
	win.window('open');
}

//图二
function gc_chart1_outcome2(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart1-outcome2',
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
			var datax = [];
			var datay = [];
			if (map) {
				for (var key in map) {
					datax.push(key);
					var dataobj = {
						value:map[key],
						name:key
					};
					datay.push(dataobj);
				}
			}
			var option_chart1_outcome2 = {
					title : {
				        text: '年度预算支出趋势分析',
				        x:'center'
				    },
				    grid:{
						right:70			    	
				    },
				    xAxis: {
				    	name : '时间(年度)',
				        type: 'category',
				        data: datax,
				    },
				    yAxis: {
				    	name : '金额(万元)',
				        type: 'value'
				    },
				    series: [{
				    	name: '支出金额（万元）',
				        data: datay,
				        type: 'bar',
				        barWidth:20
				    }],
				    legend: {
				        data: ['支出金额'],
					    orient: 'vertical',
				        right: '0',
				        top: 'center',
				        show:false
				    },
				    tooltip : {
				        trigger: 'axis',
				        formatter: "年度：{b}<br/>金额：{c} 万元"
				    }
				};
				var chart_chart1_outcome2 =  echarts.init(document.getElementById('div-chart1-outcome2'));
				chart_chart1_outcome2.setOption(option_chart1_outcome2);
			    //单击下钻事件
			    chart_chart1_outcome2.on('click',function(p){
			    	outComeData2(p.name);
			    });
		}
	});
}  

//图二和图三  三级下钻（打开同比、环比下钻列表）
function outComeData2(year) {
	//时间格式化
	 var t, y, m;
	 t = new Date(year);
	 y = t.getFullYear();
	 m = t.getMonth() + 1;
	// 可根据需要在这里定义时间格式  
	 if(year.length>4){
	     years=y + '年' + (m < 10 ? '0' + m : m)+'月';
	 }else{
		 years=y + '年';
	 }
	var win = parent.creatDetailFirstWin('指标管理信息', 'icon-search','/cockDetail/indexDataJsp?typeStr=detail&year='+year+'&departId='+queryDepartId);
	win.window('open');
}
//图三
function gc_chart1_outcome3(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart1-outcome3',
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
			var datax = [];
			var datay = [];
			if (map) {
				for (var key in map) {
					datax.push(key);
					var dataobj = {
						value:map[key],
						name:key
					};
					datay.push(dataobj);
				}
			}
			var option_chart1_outcome3 = {
					title : {
				        text: '月度预算支出趋势分析',
				        x:'center'
				    },
				    grid:{
				    	left:70,
						right:70				    	
				    },
				    xAxis: {
				    	name : '时间(月份)',
				        type: 'category',
				        data: datax,
				        axisLabel: {  
				        	   interval:0,  
				        	   rotate:30  
				        	}  
				    },
				    yAxis: {
				    	name : '金额(元)',
				        type: 'value'
				    },
				    series: [{
				    	name: '支出金额（元）',
				        data: datay,
				        type: 'line'
				    }],
				    legend: {
				        data: ['支出金额'],
					    orient: 'vertical',
				        right: '0',
				        top: 'center',
				        show:false
				    },
				    tooltip : {
				        trigger: 'axis',
				        formatter: "年度：{b}<br/>金额：{c} 元"
				    }
				};
				var chart_chart1_outcome3 =  echarts.init(document.getElementById('div-chart1-outcome3'));
				chart_chart1_outcome3.setOption(option_chart1_outcome3);
			    //单击下钻事件
			    chart_chart1_outcome3.on('click',function(p){
			    	outComeData2(p.name);;
			    });
		}
	});
}   

//打开同比下钻列表
function gl_dwystb_list(queryYear,queryDepartId ){
	var win = parent.creatDetailFirstWin('查看-单位支出明细', 'icon-search',encodeURI('/cockDetail/chartDetail?type=unitOutList&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}

//打开环比下钻列表
function gl_dwyshb_list(queryYear,queryDepartId ){
	var win = parent.creatDetailFirstWin('查看-单位支出明细', 'icon-search',encodeURI('/cockDetail/chartDetail?type=unitOutList&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}
</script>
	
</body>
</html>


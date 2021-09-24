<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">
<%-- <script type="text/javascript" src="${base}/resource-now/js/echarts.js"></script>  --%>

<%-- <script type="text/javascript" src="${base}/resource/ui/jquery.easyui.min.js"></script> --%>
<%-- <script type="text/javascript" src="${base}/resource/ui/locale/easyui-lang-zh_CN.js"></script>

<link rel="stylesheet" id="easyuiTheme" type="text/css" href="${base}/resource/ui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/icon.css"> --%>

<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
</style>

	<div class="easyui-layout"
		style="width:100%;height:100%; 
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
		<div data-options="region:'center'">
			<div id="div_chart4_inner" class="easyui-tabs" style="">
				<div title="各类型培训支出统计" style="padding:10px;">
					<div id="div_chart4_inner1"
						style="height:250px; width:550px; margin: 0 auto;"></div>
				</div>
				<div title="各部门培训支出统计" style="padding:10px">
					<div id="div_chart4_inner2"
						style="height:250px; width:550px; margin: 0 auto; "></div>
				</div>
			</div>
		<div data-options="region:'south',split:true"
			style="height:40px; text-align: center; ">
			<a href="javascript:void(0)" onclick="closeFirstWindow()"> <img
				src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
				onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
		</div>
	</div>



	<script type="text/javascript">

var queryYear = '${year}';
var queryDepartId = '${departId}';

//各类型
var option_chart1_train1;
var div_chart4_inner1 = echarts.init(document.getElementById('div_chart4_inner1'));
//getdiv_chart4_inner1();
//各部门
var option_chart1_train2;
var div_chart4_inner2 = echarts.init(document.getElementById('div_chart4_inner2'));
//getdiv_chart4_inner2();

//-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#div_chart4_inner').tabs({
	onSelect:function(title){
		if("各类型培训支出统计"==title && isflag1==false){
			getdiv_chart4_inner1();
			isflag1=true;
		}
		if("各部门培训支出统计"==title && isflag1==true && isflag2==false){
			getdiv_chart4_inner2();
			isflag2=true;
		}
    }
});


function getdiv_chart4_inner1(){
	$.ajax({
		//项目执行进度前五的地址
		url : base + '/cockDetail/insideData1?chartName=chart4-inner1',
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
			option_chart1_train1 = {
				    title : {
				        text: '各类型培训支出占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: function(params){
				        	 return params.seriesName+ '<br/>'
				        	 + '类型' +' : '+params.data.name+ '<br/>'
				        	 + '支出金额' +' : '+(params.data.value).toFixed(2)+ '元<br/>'
				        	 + '支出占比' +' : '+params.percent+ '%<br/>'; 
				        }  
				    },
				    legend: {
				        orient: 'vertical',
				        right: '0',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '培训支出统计',
				            type: 'pie',
				            radius : '60%',
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
			    div_chart4_inner1.setOption(option_chart1_train1);
			    //单击下钻事件
			    div_chart4_inner1.on('click',function(p){
			    	//generatediv_chart4_inner1_1();
			    	//生成下钻数据列表
			    	getdiv_chart4_inner1_1(p.name);
			    });
		}
	});
}   
//各类型培训下钻数据列表
function getdiv_chart4_inner1_1(typeNum){
	var win = parent.creatDetailFirstWin('培训列表','icon-search',encodeURI('/cockDetail/chartDetail?type=train&typeNum='+typeNum+'&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}

//图二 各部门指标饼图
function getdiv_chart4_inner2(){
	$.ajax({
		//项目执行进去前五的地址
		url : base + '/cockDetail/insideData1?chartName=chart4-inner2',
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
			
			option_chart1_train2 = {
				    title : {
				        text: '各部门培训支出占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: function(params){
				        	 return params.seriesName+ '<br/>'
				        	 + '部门' +' : '+params.data.name+ '<br/>'
				        	 + '支出金额' +' : '+(params.data.value).toFixed(2)+ '元<br/>'
				        	 + '支出占比' +' : '+params.percent+ '%<br/>'; 
				        }  
				    },
				    legend: {
				        orient: 'vertical',
				        right: '0',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '培训支出统计',
				            type: 'pie',
				            radius : '60%',
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
			    div_chart4_inner2.setOption(option_chart1_train2);
			  	//单击下钻事件
			    div_chart4_inner2.on('click',function(p){
			    	//generatediv_chart4_inner1_2();
			    	getdiv_chart4_inner1_2(p.name);
			    });
		}
	});
}
//各部门培训下钻数据列表
function getdiv_chart4_inner1_2(dept){
	var win = parent.creatDetailFirstWin('培训列表','icon-search',encodeURI('/cockDetail/chartDetail?type=train&year='+queryYear+'&dept='+dept+'&departId='+queryDepartId));
	win.window('open');
}
</script>
	
</body>
</html>


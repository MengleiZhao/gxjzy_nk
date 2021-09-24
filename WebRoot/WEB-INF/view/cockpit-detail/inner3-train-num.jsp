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

<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/default/easyui.css">
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
				<div title="各类型培训次数统计" style="padding:10px;">
					<div id="div_option_train_num"
						style="height:250px; width:550px; margin: 0 auto;"></div>
				</div>
				<div title="各部门培训次数统计" style="padding:10px">
					<div id="div_option_train_dept"
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

//各类型培训次数统计
var option_train_num;
var div_option_train_num = echarts.init(document.getElementById('div_option_train_num'));
//各部门培训次数统计
var option_train_dept;
var div_option_train_dept = echarts.init(document.getElementById('div_option_train_dept'));

//-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#div_chart4_inner').tabs({
	onSelect:function(title){
		if("各类型培训次数统计"==title && isflag1==false){
			getdiv_option_train_num();
			isflag1=true;
		}
		if("各部门培训次数统计"==title && isflag1==true && isflag2==false){
			getdiv_option_train_dept();
			isflag2=true;
		}
    }
});


function getdiv_option_train_num(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart4-inner1-num',
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
			option_train_num = {
				    title : {
				        text: '各类型培训次数统计',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: function(params){
				        	 return params.seriesName+ '<br/>'
				        	 + '类型' +' : '+params.data.name+ '<br/>'
				        	 + '培训次数' +' : '+params.data.value+ '次<br/>'
				        	 + '次数占比' +' : '+params.percent+ '%<br/>'; 
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
				            name: '培训次数统计',
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
			    div_option_train_num.setOption(option_train_num);
			    //单击下钻事件
			    div_option_train_num.on('click',function(p){
			    	//生成下钻数据列表
			    	getdiv_train_num(p.name);
			    });
		}
	});
}   
//各类型培训下钻数据列表
function getdiv_train_num(typeNum){
	var win = parent.creatDetailFirstWin('培训列表','icon-search',encodeURI('/cockDetail/chartDetail?type=train&typeNum='+typeNum+'&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}

//图二 各部门指标饼图
function getdiv_option_train_dept(){
	$.ajax({
		url : base + '/cockDetail/insideData1?chartName=chart4-inner2-num',
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
			
			option_train_dept = {
				    title : {
				        text: '各部门培训次数统计',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: function(params){
				        	 return params.seriesName+ '<br/>'
				        	 + '部门' +' : '+params.data.name+ '<br/>'
				        	 + '培训次数' +' : '+params.data.value+ '次<br/>'
							 + '次数占比' +' : '+params.percent+ '%<br/>';  
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
				            name: '培训次数统计',
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
			    div_option_train_dept.setOption(option_train_dept);
			  	//单击下钻事件
			    div_option_train_dept.on('click',function(p){
			    	getdiv_train_dept(p.name);
			    });
		}
	});
}
//各部门培训下钻数据列表
function getdiv_train_dept(dept){
	var win = parent.creatDetailFirstWin('培训列表','icon-search',encodeURI('/cockDetail/chartDetail?type=train&year='+queryYear+'&dept='+dept+'&departId='+queryDepartId));
	win.window('open');
}
</script>
	
</body>
</html>


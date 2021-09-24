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
var queryYear = '${year}';
var queryDepartId = '${departId}';
</script>

<style type="text/css">
</style>

	<div class="easyui-layout"
		style="width:100%;height:100%; 
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
		<div data-options="region:'center'">
			<div id="div_chart1_least" class="easyui-tabs" style="">
				<div title="指标金额占比" style="padding:10px;">
					<div id="div_chart1_least1"
						style="height:260px; width:550px; margin: 0 auto;"></div>
				</div>
				<div title="部门指标金额占比" style="padding:10px">
					<div id="div_chart1_least2"
						style="height:260px; width:600px; margin: 0 auto; "></div>
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
//各类型指标统计
var option_chart1_budget1;
var div_chart1_least1 = echarts.init(document.getElementById('div_chart1_least1'));
//getdiv_chart1_least1();
//各部门指标统计
var option_chart1_budget2;
var div_chart1_least2 = echarts.init(document.getElementById('div_chart1_least2'));
//getdiv_chart1_least2();

//-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#div_chart1_least').tabs({
    onSelect:function(title){
		if("指标金额占比"==title && isflag1==false){
			getdiv_chart1_least1();
			isflag1=true;
		}
		if("部门指标金额占比"==title && isflag1==true && isflag2==false){
			getdiv_chart1_least2();
			isflag2=true;
		}
    }
});


function getdiv_chart1_least1(){
	$.ajax({
		//项目执行进去前五的地址
		url : base + '/cockDetail/insideData1?chartName=chart1-least1',
		type : 'post',
		dataType : 'json',
		data : {
			year : queryYear,
			departId : queryDepartId
		},
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
			option_chart1_budget1 = {
				    title : {
				        text: '指标金额占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient: 'vertical',
				        right: '0',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '指标额度',
				            type: 'pie',
				            radius : '62%',
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
				div_chart1_least1.clear();
			    div_chart1_least1.setOption(option_chart1_budget1);
			    
			    //单击下钻事件
			    div_chart1_least1.on('click',function(p){
			    	chartLeastData1(p.name);
			    });
		}
	});
}   
//图一下钻数据列表
function chartLeastData1(indexName) {		//indexName 是指标类型 基本支出/项目支出
	var indexType = 0;
	if (indexName=='基本支出') {
		indexType = 0;
	} else if (indexName=='项目支出') {
		indexType = 1;
	}
	var win = parent.creatDetailFirstWin('指标管理信息', 'icon-search',encodeURI('/cockDetail/indexDataJsp?typeStr=residue&year='+queryYear+'&departId='+queryDepartId+'&indexName='+indexName));
	win.window('open');
}

//图二 各部门指标饼图
function getdiv_chart1_least2(){
	$.ajax({
		//项目执行进去前五的地址
		url : base + '/cockDetail/insideData1?chartName=chart1-least2',
		type : 'post',
		data : {
			year : queryYear,
			departId : queryDepartId
		},
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
			
			option_chart1_budget2 = {
				    title : {
				        text: '部门指标金额占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient: 'vertical',
				        right: '0',
				        top: 'center',
				        data: datax
				    },
				    series : [
				        {
				            name: '访问来源',
				            type: 'pie',
				            radius : '55%',
				            center: ['40%', '60%'],
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
				div_chart1_least2.off('click');
				div_chart1_least2.clear();
			    div_chart1_least2.setOption(option_chart1_budget2);
			  	div_chart1_least2.on('click',function(p){
			  		chartLeastData2(p.name);
			    	$("#anhide").css("display","");
			    });
		}
	});
}
//图二下钻
function chartLeastData2(departName) {
	var win = parent.creatDetailFirstWin('指标管理信息', 'icon-search',encodeURI('/cockDetail/indexDataJsp?typeStr=residue&year='+queryYear+'&departName='+departName));
	win.window('open');
}


</script>
</body>
</html>


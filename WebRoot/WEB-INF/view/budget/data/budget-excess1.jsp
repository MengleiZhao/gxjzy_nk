<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">
<!-- echarts  -->
<%-- <script type="text/javascript" src="${base}/resource-now/js/echarts.js"></script> --%>
<!-- echarts  -->

<%-- <!-- highcharts  -->
<script type="text/javascript" src="${base}/resource/highcharts/highcharts.js"></script> 
<!-- highcharts  -->  --%>

<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
</style>



  	<div data-options="region:'center'" >
  	
  		
			<div title="分项支出金额占比" style="padding:40px;" >
				<div id="outcomeAmount" style="height:330px; width:600px; margin: 0 auto;" >
				
				</div>
			</div>
		
  	</div>
  <div data-options="region:'south',split:true" style="height:40px; text-align: center; ">
  	<div style="height:30px; margin-top:10px;" align="center">
	<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
	</div>
  </div>


	<input id="indexCode" value="${code }" type="hidden"/>
	



<script type="text/javascript">
var queryYear = '${year}';
var queryDepartId = '${departId}';
var code = '${indexCode}';

gc_outcomeAmount();

//图一

var arr = [];
function gc_outcomeAmount(){
	$.ajax({
		url : base + '/bExcess/insideData1?code=${code}',
		data : {
			year : queryYear,
			departId : queryDepartId
		},
		type : 'post',
		dataType : 'json',
		success : function(map){
				for (var key in map) {
					arr.push([key, map[key]]);
				}
				var chart = Highcharts.chart('outcomeAmount', {
					chart: {
						type: 'pie',
						options3d: {
							enabled: true,
							alpha: 30,
							beta: 0
						}
					},
					credits: {
					     enabled: false
					},
					    title : {
					        text: '<b>分项支出金额占比</b>',
					        style: {
				                fontSize: '20px', 
				            }
					    },
					    tooltip : {
					    	headerFormat: '{series.name}：',
							pointFormat: '<b>{point.name}<br> 金额：<b>{point.y}元<br> </b>额度占比:<b>{point.percentage:.1f} %</b>' 	
					    },
					    legend: {
					    	  itemStyle : {
					    	        'fontSize' : '15px'
					    	    },
			                layout: 'vertical',
			                align:'right',
			                verticalAlign: 'middle' 
					    },
					    plotOptions: {
							pie: {
								allowPointSelect: true,
								cursor: 'pointer',
								 events: {
							            click: function(p) {
									    window.open = indexDetailHistory(p.point.name);
							        }
								 },
								depth: 35,
								dataLabels: {
									enabled: false,
									 //format: '<b>{point.name}</b>: {point.percentage:.1f} %',
								},
					    showInLegend: true
							}
						},
					    series : [
					        {
					            name: '报销类型',
					            type: 'pie',
					            data:arr
					        
					        }
					    ]
					});	
		}
	});
}	





	function indexDetailHistory(indexName) {
		var fType = 0;
		if (indexName=='直接报销') {
			fType = 3;
		} else if (indexName=='申请报销') {
			fType = 4;
		}else if (indexName=='借款') {
			fType = 5;
			}else if (indexName=='采购支付') {
			fType = 6;
		}else if (indexName=='合同报销') {
			fType = 7;
		}
	var code = $('#indexCode').val();
		var win = creatFreeWindow('four_window', '支出明细', 970, 550,
				'icon-search', "/bExcess/zcmx?code=" + code+'&fType='+fType);
		win.window('open');
	}



</script>
	
</body>
</html>


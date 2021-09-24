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


	<div class="easyui-layout"
		style="width:100%;height:100%; 
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
		<div data-options="region:'center'">
			<div id="option_div_meeting" class="easyui-tabs" style="">
				<div title="各类型会议次数统计" style="padding:10px;">
					<div id="div_meeting_num"
						style="height:250px; width:550px; margin: 0 auto;"></div>
				</div>
				<div title="各部门会议次数统计" style="padding:10px">
					<div id="div_meeting_dept"
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

//各类型会议次数统计
var option_meeting_num;
var div_meeting_num = echarts.init(document.getElementById('div_meeting_num'));
//各部门会议次数统计
var option_meeting_dept;
var div_meeting_dept = echarts.init(document.getElementById('div_meeting_dept'));

//-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#option_div_meeting').tabs({
	onSelect:function(title){
		if("各类型会议次数统计"==title && isflag1==false){
			getMeetingNum();
			isflag1=true;
		}
		if("各部门会议次数统计"==title && isflag1==true && isflag2==false){
			getMeetingDept();
			isflag2=true;
		}
    }
});

function getMeetingNum(){
	$.ajax({
		//项目执行进去前五的地址
		url : base + '/cockDetail/insideData1?chartName=chart4-inner3-num',
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
			option_meeting_num = {
				    title : {
				        text: '各类型会议支出占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: function(params){
				        	 return params.seriesName+ '<br/>'
				        	 + '类型' +' : '+params.data.name+ '<br/>'
				        	 + '会议次数' +' : '+params.data.value+ '次<br/>'
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
				            name: '会议次数统计',
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
			    div_meeting_num.setOption(option_meeting_num);
			    //单击下钻事件
			    div_meeting_num.on('click',function(p){
			    	getdiv_meeting_num(p.name);
			    });
		}
	});
}   
//各类型会议下钻数据列表
function getdiv_meeting_num(typeNum){
	var win = parent.creatDetailFirstWin('会议列表', 'icon-search',encodeURI('/cockDetail/chartDetail?type=meeting&typeNum='+typeNum+'&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}


//图二 各部门指标饼图
function getMeetingDept(){
	$.ajax({
		//项目执行进去前五的地址
		url : base + '/cockDetail/insideData1?chartName=chart4-inner4-num',
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
			
			option_meeting_dept = {
				    title : {
				        text: '各部门会议支出占比',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: function(params){
				        	 return params.seriesName+ '<br/>'
				        	 + '部门' +' : '+params.data.name+ '<br/>'
				        	 + '会议次数' +' : '+params.data.value+ '次<br/>'
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
				            name: '会议次数统计',
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
			    div_meeting_dept.setOption(option_meeting_dept);
			  	//单击下钻事件
			    div_meeting_dept.on('click',function(p){
			    	getdiv_meeting_dept(p.name);
			    });
		}
	});
}  
//图二各部门会议下钻数据列表
function getdiv_meeting_dept(dept){
	var win = parent.creatDetailFirstWin('部门会议列表',  'icon-search',encodeURI('/cockDetail/chartDetail?type=meeting&dept='+dept+'&year='+queryYear+'&departId='+queryDepartId));
	win.window('open');
}

</script>
	
</body>
</html>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body id="cockpit_body">

<!-- echarts  -->
<script type="text/javascript" src="${base}/resource-now/js/echarts.js"></script>
<!-- echarts  -->
	
<!-- <body style="background-color: #eff5f7"> -->
<div style="background-image:url(${base}/resource-modality/img/cockpit/bg-main1.png);  
	background-size:100% 100%;
	background-position: center center;">
<!-- <style type="text/css">
.chart_td {/* border: #d8e2e6 solid 1px; */ padding: 15px; font-family: 微软雅黑;} 

/*---滚动条默认显示样式--*/
::-webkit-scrollbar-thumb {
background-color: #2cb6ec;
height: 50px;
outline-offset: -2px;
outline: 2px solid #2cb6ec;
-webkit-border-radius: 15px;
border: 2px solid #2cb6ec;
}
	
/*---鼠标点击滚动条显示样式--*/
::-webkit-scrollbar-thumb:hover {
background-color: #7dfff7;
height: 50px;
-webkit-border-radius: 15px;
}
	
/*---滚动条大小--*/
::-webkit-scrollbar {
width: 16px;
height: 12px;
}
	
/*---滚动框背景样式--*/
::-webkit-scrollbar-track-piece {
background-color: #0370a4;
-webkit-border-radius: 0;
}
/* 清除下拉框默认样式 */
select::-ms-expand { display: none; }
/*---搜索条件下拉框样式---*/
.select_cockpit{
	border:none;
	height: 25px;
	appearance:none;
	-moz-appearance:none;
	-webkit-appearance:none;
	/* background: url("http://ourjs.github.io/static/2015/arrow.png") no-repeat scroll right center transparent; */
	padding-right: 14px;
	color:#fff;
	border-radius:4px;
	background-color: #24A3D7;
	outline: none;
}

/* 单位查询框样式 */
.textbox-text[readonly="readonly"]{
	background-color: #24A3D7;
	border: none;
	color: white;
}
.combo-arrow {
    background-color: #E0ECFF;
}
.textbox-text{
	border: none;
}
</style> -->

<style>
.combo-arrow {
    background-color: #E0ECFF;
}
</style>
<div id="div_cockpit_query" style="text-align: right; width:99%;height:30px;">
<div style="height:5px"></div>
	<span style="color:white;">年度：</span>
	<select id="select_cockpit_year" class="select_cockpit" style="width:60px">
		<c:forEach items="${yearList }" var="ye">
			<option value="${ye }" <c:if test="${ye == currentYear }">selected="selected"</c:if>>&nbsp;${ye }</option>
		</c:forEach>
	</select>
	
	<span style="color:white; margin-left: 15px;">单位：</span>
	<%-- <select id="select_cockpit_departCode" class="select_cockpit" style="min-width: 100px;">
		<option value="" selected="selected">-请选择-</option>
		<c:forEach items="${departList }" var="de">
			<option value="${de[1] }" <c:if test="${de[1]==defaultDepartId}">selected="selected"</c:if> >&nbsp;${de[0] }</option>
		</c:forEach>
	</select> --%>
	
	<input class="easyui-combotree" id="select_cockpit_departCode" data-options="url:'${base}/cockpit/departTree',method:'get'" style="width:300px;height:25px;"/>
	<!-- <input class="easyui-textbox"/> #24A3D7-->
	
	<a href="javascript:void(0)" onclick="queryCockpit();" style="margin-left: 15px;">
		<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png"
			onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
			onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"
		/>
	</a>
	
</div>
<div id="div_cockpit_charts">

	<table style="width: 100%; height: 100%; margin: 0 auto; 
	
	<%-- background-image:url(${base}/resource-modality/img/cockpit/bg-table.png);  
	 background-repeat:no-repeat; 
	background-position: center top; --%>
	"  
	cellspacing="5px"  >
		<tr style="height: 380px;">
			<td style="width:100%;">
				<table style="width:100%; height:100%; border: 0;"><!--  -->
					<tr>
						<td class="chart_td" 
							style="width:30%; vertical-align: top; padding:0px;
							background-image:url(${base}/resource-modality/img/cockpit/bg1.png);
							background-repeat:no-repeat;
							background-position: left top;
							background-size:98% 100%;
						">
							<!-- 单位预算 -->
							<%@ include file="chart7.jsp" %> 
						</td>
						<td class="chart_td" style="width:70%; 
							background-image:url(${base}/resource-modality/img/cockpit/bg2.png);
							background-repeat:no-repeat;
							background-position: left top;
							background-size:100% 100%;
						">
							<!-- 各部门预算项目执行排名 -->
							<%@ include file="chart2.jsp" %>			
						</td>
					</tr>	
				</table>
			</td>
		</tr>
		
		<tr>
			<td>
				<table style="width: 100%;">
					<tr style="height:400px;">
						<td style="width:35%; vertical-align: top;
							background-image:url(${base}/resource-modality/img/cockpit/bg3.png);
							background-repeat:no-repeat;
							background-position: left top;
							background-size:98% 100%;
							" 
							class="chart_td" >
							<!-- 项目执行进度 前五 -->
							<%@ include file="chart4.jsp" %>
						</td>
						<td style="width:31%;vertical-align: center;
							background-image:url(${base}/resource-modality/img/cockpit/bg4.png);
							background-repeat:no-repeat;
							background-position: left top;
							background-size:98% 100%;
							" 
							class="chart_td" >
							<!-- 培训/会议 计划执行情况 -->
							<%@ include file="chart1.jsp" %>
						</td>
						<td style="width:33%; vertical-align: top;
							background-image:url(${base}/resource-modality/img/cockpit/bg5.png);
							background-repeat:no-repeat;
							background-position: left top;
							background-size:100% 100%;
							" 
							class="chart_td" >
							<!-- 各部门差旅费支出情况 -->
							<div style="height: 65px;">

							</div>
							<div style="height:260px;overflow-y:auto;">
								<%@ include file="chart3.jsp" %>
							</div>
						</td>
					</tr>
					<tr style="height: 6px;"></tr>
					<tr style="height:400px; ">
						<td style="vertical-align: top; padding-bottom: 0;
							background-image:url(${base}/resource-modality/img/cockpit/bg6.png);
							background-repeat:no-repeat;
							background-position: left center;
							background-size:98% 100%;
							"  
							class="chart_td">
							<!-- 项目执行进度 后五 -->
							<%@ include file="chart5.jsp" %>
						</td>
						<td colspan="2" 
							style="cursor: pointer;
							padding-bottom: 0; 
							background-image:url(${base}/resource-modality/img/cockpit/bg7.png);
							background-repeat:no-repeat;
							background-position: left center;
							background-size:100% 100%;
							"  
							class="chart_td">
							<!-- 三公经费 -->
							<%@ include file="chart6.jsp" %>
						</td>
					</tr>
				</table>
			</td>
	</table>
</div>

<div id="div_cockpit_loading" style="height: 700px; width: 100%;  text-align: center;">
	<div style="height: 40%"></div>
	<img src="${base}/resource-modality/img/cockpit/loading.gif"/>
</div>

	<script type="text/javascript">
	//更改select选中时边框样式
		  $(".select_cockpit").focus(function(){
		    $(this).css("outline","none");
		    $(this).css("border","none");
		  });
	
	var queryYear = '${defaultYear}';
	var queryDepartId = '${defaultDepartId}';
	
	$(function(){
		$('#div_cockpit_loading').hide();
		$('#div_cockpit_charts').show();
	});
	
	function queryCockpit(){
		var year = $('#select_cockpit_year').val();
		var departId = $('#select_cockpit_departCode').combotree('getValue');
		queryYear = year;
		queryDepartId = departId;
		if(departId.length==0){
			departId=queryDepartId ;
		}
		
		$('#cockpit_chart7_year').html(year);
		genechart2(year,departId);
		getchart4(year,departId);
		generateChart1(year,departId);
		loadTravel(year,departId);
		getchart5(year,departId);
		getchart61(year,departId);
		getchart62(year,departId);
		getchart63(year,departId);
		//清除动画
		clearInterval(myInterval1);
		clearInterval(myInterval2);
		clearInterval(myInterval3);
	}
	
	//列表页面级子页面图片替换
	function mouseOver(tr){
		var src = $(tr).attr("src");
		src = src.replace(/1/, "2");
		$(tr).attr("src",src);
	}
		
	function mouseOut(img) {
		var src = $(img).attr("src");
		src = src.replace(/2/, "1");
		$(img).attr("src",src);
	}
	
	//点击 单位预算情况-总预算
	function openZys(){
		var win = parent.creatCockFirstWin('单位总预算', 677,400, 'icon-search','/cockDetail/tBudget?year='+queryYear+'&departId='+queryDepartId);
		win.window('open');
	}
	//点击 单位预算情况-总支出
	function openZzc(){
		var win = parent.creatCockFirstWin('单位总支出', 677,400, 'icon-search','/cockDetail/tOutcome?year='+queryYear+'&departId='+queryDepartId);
		win.window('open');
	}
	//点击 单位预算情况-剩余
	function openSy(){
		var win = parent.creatCockFirstWin('单位剩余预算', 677,400, 'icon-search','/cockDetail/tLeast?year='+queryYear+'&departId='+queryDepartId);
		win.window('open');
	}
	//点击 各部门预算执行排名(生成饼图)
	function openInner1(departName){
		var win = parent.creatCockFirstWin(''+departName+'&nbsp;项目预算执行情况', 677,508, 'icon-search',encodeURI('/cockDetail/inC1?departName='+departName+'&year='+queryYear));
		win.window('open');
	}
	
	//点击 项目执行进度（前五/后五）
	function openInner2(indexName){
		var array=indexName.split('@');
		var win = parent.creatDetailFirstWin(''+array[0]+' 支出明细','icon-search',encodeURI('/cockDetail/inC2?indexCode='+array[1]));
		win.window('open');
	}
	//点击 培训会议支出统计(数量)
	function openInnerNumber3(type){
		
		if (type.indexOf('培训')>-1) {
			var win = parent.creatCockFirstWin('培训次数统计', 677,400, 'icon-search','/cockDetail/inC3?type=trainNum&year='+queryYear+'&departId='+queryDepartId);
			win.window('open');
		} else if (type.indexOf('会议')>-1) {
			var win = parent.creatCockFirstWin('会议次数统计', 677,400, 'icon-search','/cockDetail/inC3?type=meetingNum&year='+queryYear+'&departId='+queryDepartId);
			win.window('open');
		}
	}
	//点击 培训会议支出统计(金额)
	function openInner3(type){
		if (type.indexOf('培训')>-1) {
			var win = parent.creatCockFirstWin('培训支出统计', 677,400, 'icon-search','/cockDetail/inC3?type=train&year='+queryYear+'&departId='+queryDepartId);
			win.window('open');
		} else if (type.indexOf('会议')>-1) {
			var win = parent.creatCockFirstWin('会议支出统计', 677,400, 'icon-search','/cockDetail/inC3?type=meeting&year='+queryYear+'&departId='+queryDepartId);
			win.window('open');
		}
	}
	//点击 各部门差旅费支出情况
	function openInner4(deName){
		var win = parent.creatCockFirstWin(''+deName+' 差旅费支出情况', 677,400, 'icon-search',encodeURI('/cockDetail/inC4?departName='+deName+'&year='+queryYear));
		win.window('open');
	}
	//点击 三公经费
	function openInner5(itemName){
		if(7==itemName){
			itemNameNum="因公出国出境";
		}else if(5==itemName){
			itemNameNum="公务接待";
		}else if(6==itemName){
			itemNameNum="公务用车购置与运维";
		}
		var win = parent.creatCockFirstWin(''+itemNameNum+' 经费使用情况', 677,400, 'icon-search',encodeURI('/cockDetail/inC5?itemName='+itemName+'&year='+queryYear+'&departId='+queryDepartId));
		win.window('open');
	}
	//鼠标悬浮单元格提示信息  
	function formatCellTooltip(value){  
	    return "<span title='" + value + "'>" + value + "</span>";  
	}  
	</script>
</div>
</body>


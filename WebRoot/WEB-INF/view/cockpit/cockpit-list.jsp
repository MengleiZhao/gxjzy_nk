<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #eff5f7">
<script type="text/javascript" src="${base}/resource-now/js/echarts.js"></script>
<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
<script type="text/javascript">
var base='${base}';
</script>

<style type="text/css">
.chart_td {border: #d8e2e6 solid 1px; padding: 15px; font-family: 微软雅黑;} 

/*---滚动条默认显示样式--*/
::-webkit-scrollbar-thumb {
background-color: #e5f0f6;
height: 50px;
outline-offset: -2px;
outline: 2px solid #fff;
-webkit-border-radius: 15px;
border: 2px solid #fff;
}
	
/*---鼠标点击滚动条显示样式--*/
::-webkit-scrollbar-thumb:hover {
background-color: #cfdde4;
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
background-color: #fff;
-webkit-border-radius: 0;
}
</style>




	<table style="width: 100%; height: 100%; margin: 0 auto; "  cellspacing="5px" >
		<tr>
			<td colspan="3" style="background: #ffffff">
				<%-- <div style="width:30%;">
					<!-- 单位预算 -->
							<%@ include file="chart7.jsp" %>
				</div>
				<div style="width:50%;">
					<!-- 各单位预算项目执行排名 -->
							<%@ include file="chart2.jsp" %>
				</div> --%>
				<table style="width:100%; border: 0;"><!--  -->
					<tr>
						<td class="chart_td" style="width:30%;vertical-align: top; padding-top: 8px;">
							<!-- 单位预算 -->
							<%@ include file="chart7.jsp" %>
						</td>
						<td class="chart_td" style="width:70%">
							<!-- 各单位预算项目执行排名 -->
							<%@ include file="chart2.jsp" %>						
						</td>
					</tr>	
				</table>
			</td>
		</tr>
		<tr>
			<td style="width:30%; background: #ffffff; vertical-align: top;" class="chart_td" >
				<!-- 项目执行进度 前五 -->
				<%@ include file="chart4.jsp" %>
			</td>
			<td style="width:30%;background: #ffffff;vertical-align: top;" class="chart_td" >
				<!-- 培训/会议 计划执行情况 -->
				<%@ include file="chart1.jsp" %>
			</td>
			<td style="width:30%; background: #ffffff; vertical-align: top;" class="chart_td" >
				<!-- 各部门差旅费支出情况 -->
				<%@ include file="chart3.jsp" %>
			</td>
		</tr>
		<tr>
			<td style="background: #ffffff; vertical-align: top; padding-bottom: 0;"  class="chart_td">
				<!-- 项目执行进度 后五 -->
				<%@ include file="chart5.jsp" %>
			</td>
			<td colspan="2" style="background: #ffffff;  padding-bottom: 0;"  class="chart_td">
				<!-- 三公经费 -->
				<%@ include file="chart6.jsp" %>
			</td>
		</tr>
	</table>

	
	<script type="text/javascript">
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
	</script>
	
</body>
</html>


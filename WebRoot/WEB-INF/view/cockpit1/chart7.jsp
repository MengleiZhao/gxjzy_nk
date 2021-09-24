<%@ page language="java" pageEncoding="UTF-8"%>
<style type="text/css">
.hoverStyle{
	line-height:40px;
	width:100%;
	height: 40px;
}

.tdStyle{
	text-align:right;
	color:#7efff7;
	font-size: 20px;
	font-weight: bold;
	margin:0px;
	padding:0px;
	cursor: pointer;
}
.tdStyle + td{
	width:60%;
}
#cockpit_pfNum,#cockpit_syNum,#cockpit_zcNum{
	text-align:right;
	font-size:21px;
	font-weight:bold;
	cursor:pointer;
	letter-spacing:5px;
}

</style>

<script type="text/javascript">
 //-----鼠标悬浮样式----
	//总预算
	function bigTextZys(){
		//$("#tdTextZys").css("font-size","22px");
		//$("#tdTextZys").css("color","#fff");
		$("#cockpit_pfNum").css("font-size","24px");
		//$("#cockpit_pfNum").css("color","#fff");
	}
	function normalTextZys(){
		//$("#tdTextZys").css("font-size","20px");
		//$("#tdTextZys").css("color","#7efff7");
		$("#cockpit_pfNum").css("font-size","21px");
		//$("#cockpit_pfNum").css("color","#00df89"); 
	}
	
	//总支出
	function bigTextZzc(){
		//$("#tdTextZzc").css("font-size","22px");
		//$("#tdTextZzc").css("color","#fff");
		$("#cockpit_zcNum").css("font-size","24px");
		//$("#cockpit_zcNum").css("color","#fff");
	}
	function normalTextZzc(){
		//$("#tdTextZzc").css("font-size","20px");
		//$("#tdTextZzc").css("color","#7efff7");
		$("#cockpit_zcNum").css("font-size","21px");
		//$("#cockpit_zcNum").css("color","#dc7528"); 
	}
	
	//剩余
	function bigTextSy(){
		//$("#tdTextSy").css("font-size","22px");
		//$("#tdTextSy").css("color","#fff");
		$("#cockpit_syNum").css("font-size","24px");
		//$("#cockpit_syNum").css("color","#fff");
	}
	function normalTextSy(){
		//$("#tdTextSy").css("font-size","20px");
		//$("#tdTextSy").css("color","#7efff7");
		$("#cockpit_syNum").css("font-size","21px");
		//$("#cockpit_syNum").css("color","#cab651"); 
	} 
</script>
	<table style="width:100%; height:100%; ">
		<tr>
			<!-- 单位预算概况 -->
			<td style="width: 20%;  vertical-align: top">
				<table style="height: 70%; width: 100%; ">
					<tr style="height:20px; vertical-align: top;">
						<td colspan="2" >
							<table style="color: #7efff7; text-align: right; font-size: 12px; padding-right: 10px; padding-top: 5px; width:100%;">
								<tr><td>年度：<span id="cockpit_chart7_year">${currentYear }</span></td></tr>
								<tr><td>单位：&nbsp;万元</td></tr>
							</table>
						</td>
					</tr>
					<tr style="height: 25px;">
					</tr>
					<tr style="height:20px;">
						<td class="tdStyle" onclick="openZys()">
							<span id="tdTextZys">总&nbsp;预&nbsp;算</span>
							&nbsp;&nbsp;
						</td>
						<td>
						<div class="hoverStyle">
							<span style="color:#00df89;" id="cockpit_pfNum" onclick="openZys()" onmousemove="bigTextZys()" onmouseout="normalTextZys()">
							</span>
							<!-- &nbsp;万元 -->
						</div>
						</td>
					</tr>
					<tr style="height:12px;">
						<td class="tdStyle" onclick="openZzc()">
							<span id="tdTextZzc">总&nbsp;支&nbsp;出</span>
							&nbsp;&nbsp;
						</td>
						<td>
						<div class="hoverStyle">
							<span style="color:#dc7528;" id="cockpit_zcNum"onclick="openZzc()" onmousemove="bigTextZzc()" onmouseout="normalTextZzc()">
							
							</span>
						</div>
						</td>
					</tr>
					<tr style="height:12px;">
						<td class="tdStyle" onclick="openSy()">
							<span id="tdTextSy">剩&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;余</span>
							&nbsp;&nbsp;
						</td>
						<td>
						<div class="hoverStyle">
							<span style="color:#cab651;" id="cockpit_syNum"onclick="openSy()" onmousemove="bigTextSy()" onmouseout="normalTextSy()">
							
							</span>
						</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<%@ page language="java" pageEncoding="UTF-8"%>


	<table style="width:100%; height:100%; ">
		<tr>
			<!-- 单位预算概况 -->
			<td style="width: 20%;  vertical-align: top">
				<table style="height: 100%; width: 100%; ">
					<tr>
						<td style="text-align: left; color: #666666; font-weight: bold; font-size: 18px; margin-top: 16px;">
							单位预算概况
							<br>
							<div style="height:10px;"></div>
							<span style="font-size: 12px; color: #666666; font-weight: normal; ">预算年度：2018</span>
						</td>
					</tr>

					<tr style="height:30px;">
						<td>&nbsp;</td>
					</tr>
					<tr style=" background-image:url(${base}/resource-now/images/cockpit-g1.png); background-repeat:no-repeat;background-position:center;
					"
					>
						<td style="text-align: center; color:white; height: 60px; width: 210px; font-size: 12px; cursor: pointer;" onclick="openZys()" >
							<span style="text-align: left;">总预算</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span style="text-align: right;font-size: 16px; font-weight: bold;" id="cockpit_pfNum"></span>
							&nbsp;万元
						</td>
					</tr>
					<tr style="background-image:url(${base}/resource-now/images/cockpit-r1.png); background-repeat:no-repeat;background-position:center;">
						<td style="text-align: center; color:white; height: 60px; width: 210px; font-size: 12px; cursor: pointer;" onclick="openZzc()">
							<span style="text-align: left;">总支出</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span style="text-align: right;font-size: 16px;font-weight: bold;" id="cockpit_zcNum"></span>
							&nbsp;万元
						</td>
					</tr>
					<tr style="background-image:url(${base}/resource-now/images/cockpit-y1.png); background-repeat:no-repeat;background-position:center;">
						<td style="text-align: center; color:white; height: 60px; width: 210px; font-size: 12px; cursor: pointer;" onclick="openSy()">
							<span style="text-align: left;">剩&nbsp;&nbsp;&nbsp;&nbsp;余</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span style="text-align: right;font-size: 16px;font-weight: bold;" id="cockpit_syNum"></span>
							&nbsp;万元
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<script type="text/javascript">
//点击总预算
function openZys(){
	var win = parent.creatFirstWin('单位总预算', 700,550, 'icon-search','/cockpit/tBudget');
	win.window('open');
}
//点击总支出
function openZzc(){
	var win = parent.creatWin('单位总支出', 1300,630, 'icon-search','/cockpit/tOutcome');
	win.window('open');
}
//点击剩余
function openSy(){
	var win = parent.creatWin('单位剩余预算', 1300,630, 'icon-search','/cockpit/tLeast');
	win.window('open');
}
</script>

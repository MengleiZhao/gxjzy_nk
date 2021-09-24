<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!--今日工作 start-->
<div class="jrgz">
	<!-- g_tit start-->
	<div class="g_tit clearfix">
		<span class="l"><img
			src="${base}/resource/images/index/hhzl-t-01.png"></span><span
			class="ts l">正在办理 / 待办</span><a href="##" class="rt"></a>
	</div>
	<!--g_tit end-->
	<!--jrgz-cont start-->
	<div class="jrgz-cont">
		<a href="javascript:void(0);" class="a3"><b>安全检查：</b><i><font
				style="padding-right: 2px;" title="正在办理"><span><strong
						onclick="todayJobLink('安全检查记录(上报)','${base}/inspect/report/list?todayJobType=running')">${todayJob.dzxcRunningTask}</strong></span></font></i>/<i><font
				color="green" style="padding-left: 2px;" title="待办"><span
					id="dzxcNotStartTask"><strong
						onclick="todayJobLink('安全检查记录(上报)','${base}/inspect/report/list?todayJobType=notStart')">${todayJob.dzxcNotStartTask}</strong></span></font></i>(条)</a>
		<a href="javascript:void(0);" class="a2"> <b>社区走访：</b><i><font
				style="padding-right: 2px;" title="正在办理"><span><strong
						onclick="todayJobLink('社区走访情况(上报)','${base}/rwcx/list?todayJobType=running')">${todayJob.dzzfRunningTask}</strong></span></font></i>/<i><font
				color="green" style="padding-left: 2px;" title="待办"><span
					id="dzzfNotStartTask"><strong
						onclick="todayJobLink('社区走访情况(上报)','${base}/rwcx/list?todayJobType=notStart')">${todayJob.dzzfNotStartTask}</strong></span></font></i>(条)
		</a> <a href="javascript:void(0);" class="a2"> <b>社情民意：</b><i><font
				style="padding-right: 2px;" title="正在办理"><span><strong
						onclick="todayJobLink('社情民意上报','${base}/opinionsReport/list?todayJobType=running')">${todayJob.sqmysbRunningTask}</strong></span></font></i>/<i><font
				color="green" style="padding-left: 2px;" title="待办"><span
					id="dzzfNotStartTask"><strong
						onclick="todayJobLink('社情民意上报','${base}/opinionsReport/list?todayJobType=notStart')">${todayJob.sqmysbNotStartTask}</strong></span></font></i>(条)
		</a> <a href="##" class="a1"><b>今日接待：</b><i><font
				style="padding-right: 2px;" title="正在办理"><span><strong>0</strong></span></font></i>/<i><font
				color="green" style="padding-left: 2px;" title="待办"><span><strong>0</strong></span></font></i>(条)</a>
	</div>
	<!--jrgz-cont end-->
</div>
<!--今日工作 end-->
<script type="text/javascript">
	function todayJobLink(title, url) {
		addTabs(title, url);
	}
</script>
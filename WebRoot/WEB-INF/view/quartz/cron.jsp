<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript" src="${base}/resource-modality/js/index-tabs.js"></script>

<div class="tab-wrapper" id="">
	<ul class="tab-menu">
		<li>表达式书写</li>
	</ul>
	
	<div class="tab-content" >
		<div>
			<div class="check-system">
				
				<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 220px;vertical-align:text-top">
			
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td>
										<div class="htmledit_views" id="content_views">
                <p>SpringQuartz定时任务的使用，要配置这个定时任务什么时候执行，周期是多少，周期内执行多少次，这个都是cron表达式来控制的，下面详解一下这个cron表达式。</p>

<h3>一、表达式例子</h3>

<p>【1】0 0 10,14,16  *  *  ? 每天上午10点，下午2点，4点<br />
【2】0 0/30 9-17 * * ? 朝九晚五工作时间内每半小时<br />
【3】0 0 12 ? * WED  表示每个星期三中午12点<br />
【4】0 0 12 * * ? 每天12点触发 <br />
【5】0 15 10 ? * * 每天10点15分触发 <br />
【6】0 15 10 * * ? 每天10点15分触发 <br />
【7】0 15 10 * * ? * 每天10点15分触发 <br />
【8】0 15 10 * * ? 2005 2005年每天10点15分触发 <br />
【9】0 * 14 * * ? 每天下午的 2点到2点59分每分触发 <br />
【10】0 0/5 14 * * ? 每天下午的 2点到2点59分(整点开始，每隔5分触发) <br />
【11】0 0/5 14,18 * * ? 每天下午的 2点到2点59分、18点到18点59分(整点开始，每隔5分触发) <br />
【12】0 0-5 14 * * ? 每天下午的 2点到2点05分每分触发 <br />
【13】0 10,44 14 ? 3 WED 3月每周三下午的 2点10分和2点44分触发 <br />
【14】0 15 10 ? * MON-FRI 从周一到周五每天上午的10点15分触发 <br />
【15】0 15 10 15 * ? 每月15号上午10点15分触发 <br />
【16】0 15 10 L * ? 每月最后一天的10点15分触发 <br />
【17】0 15 10 ? * 6L 每月最后一周的星期五的10点15分触发 <br />
【18】0 15 10 ? * 6L 2002-2005 从2002年到2005年每月最后一周的星期五的10点15分触发 <br />
【19】0 15 10 ? * 6#3 每月的第三周的星期五开始触发 <br />
【20】0 0 12 1/5 * ? 每月的第一个中午开始每隔5天触发一次 <br />
【21】0 11 11 11 11 ? 每年的11月11号 11点11分触发(光棍节)</p>

<h3>二、cron表达式格式</h3>

<p>corn表达式格式为七个域，如：<br /><span style="color:#f33b45;">秒 分 时 日 月 周 年</span><br />
每一个域之间空格隔开，不指定“年”域时，年域可省略不写，如：<br /><span style="color:#f33b45;">秒 分 时 日 月 周</span></p>


<h3>三、符号使用说明</h3>

<p>1、所有域均可用“,”，“-”，“*”，“/”<br />
【1】<strong><span style="color:#f33b45;">,  </span></strong><span style="color:#f33b45;"> </span> x,y表示x和y<br />
【2】<strong><span style="color:#f33b45;">-  </span></strong>  x-y表示x到y<br />
【3】<strong><span style="color:#f33b45;">* </span></strong>   表示每TIME<br />
【4】<strong><span style="color:#f33b45;">/  </span></strong>  x/y表示从x起，每隔y</p>

<p>2、“日”域另有“?”，“L”，“W”，“C”<br />
【1】<strong><span style="color:#f33b45;">?   </span></strong> 表示不指定“日”域的值。规则是指定“周”域，则“日”域必须为“?”。反之，指定“日”域，则“周”域必须为“?”。如0 0 12 ? * MON 或 0 0 12 1 * ?<br />
【2】<strong><span style="color:#f33b45;">L  </span></strong>  2种写法。一，表示月末几天，如2L， 表示月末的2天。二，表示月末倒数第几天，如L-3，表示月末倒数第3天。<br />
【3】<strong><span style="color:#f33b45;">W </span></strong>   表示临近某日的工作日，如15W，表示最接近15号的工作日，可能是15号（刚好是工作日）、15号前（刚好周六）或15号后（刚好周日）。<br />
【4】<strong><span style="color:#f33b45;">C </span></strong>   表示和Calendar计划关联的值，如1C表示，1日或1日后包括Carlendar的第一天。<br />
【5】<strong><span style="color:#f33b45;">LW </span></strong>   L和W的组合，只能出现在"日"域中。表示某月最后一个工作日，不一定是周五（详细见结尾PS）。</p>

<p>3、“周”域另有“?”，“L”，“#”，“C”<br />
【1】<strong><span style="color:#f33b45;">?</span></strong>    表示不指定“周”域。规则是指定“日”域值，则“周”域值必须为“?”。反之，指定“周”域值，则“日”域值必须为“?”。如0 0 12 1 * ? 或 0 0 12 ？ * MON<br />
【2】<strong><span style="color:#f33b45;">L</span></strong>    表示某月的最后一个周几，如1L， 表示某月的最后一个周日（1表示周日），7L，表示某月的最后一个周六（7表示周六）。<br />
【3】<strong><span style="color:#f33b45;"># </span></strong>   只能出现在"周"域中，表示第几个周几，x#y，y表示第几个，x表示周的值，如6#2，表示第2个周五（6表示周五）。<br />
【4】<strong><span style="color:#f33b45;">C  </span></strong>  表示和Calendar计划关联的值，如1C表示，周日或周日后包括Carlendar的第一天。</p>

<p><strong><span style="color:#f33b45;">####注意####</span></strong><br />
“日域”域中，L和W组合为“LW”时，网上有很多种定义，比如：<br />
说法一：LW表示某月的最后一个工作日<br />
说法二：LW某月最后一周的最后一个工作日，即周五 </p>

						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
		  
</div>

<style>
	.tete
	{
	width:5px;
	height:78px;
	font-size:12px;
	text-align:center;
	color:#ffffff;
	transition: width 0.5s;
	-moz-transition: width 0.5s; /* Firefox 4 */
	-webkit-transition: width 0.5s; /* Safari 和 Chrome */
	-o-transition: width 0.5s; /* Opera */
	background-color:#0eaf7c;
	float: right;
	}
</style>

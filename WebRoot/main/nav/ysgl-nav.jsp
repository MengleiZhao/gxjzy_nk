<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<gwideal:perm url="/project/list"> 
<li><a href="#" class="inactive" onclick="erji(this,'xmkgl')"> 项目库管理</a>
		<ul style="display: none" class="subnav">
		<gwideal:perm url="/project/sbk"> 
			<li>
				<a href="#" class="inactive" id="siji2" onclick="siji(this)">申报库</a>
				<ul>
					<gwideal:perm url="/project/xmsb"> 
						<li class="subnav-li" data-id="100" href="${base}/project/list?proLibType=1&sbkLx=xmsb">
							<a class="siji" href="#" onclick="changeColor(this)">
							<img src="${base}/resource-modality/${themenurl}/dian1.png"> 项目申报</a>
						</li>
					</gwideal:perm>
					<gwideal:perm url="/project/xmsp"> 
						<li class="subnav-li" data-id="101" href="${base}/project/list?proLibType=1&sbkLx=xmsp">
							<a class="siji" href="#" onclick="changeColor(this)">
							<img src="${base}/resource-modality/${themenurl}/dian1.png"> 项目审批</a>
						</li>
					</gwideal:perm>
					<gwideal:perm url="/project/xmtz"> 
						<li class="subnav-li" data-id="102" href="${base}/project/list?sbkLx=xmtz">
							<a class="siji" href="#" onclick="changeColor(this)">
							<img src="${base}/resource-modality/${themenurl}/dian1.png"> 项目台账</a>
						</li>
					</gwideal:perm>
				</ul>
			</li>
		</gwideal:perm>
		<gwideal:perm url="/project/bxk"> 
			<li class="subnav-li" data-id="103" href="${base}/project/list?proLibType=2"><a class="sanji" href="#" onclick="changeColor(this)"> 备选库</a></li>
		</gwideal:perm>
		<gwideal:perm url="/project/zxk"> 
			<li class="subnav-li" data-id="104" href="${base}/project/list?proLibType=3"><a class="sanji" href="#" onclick="changeColor(this)"> 执行库</a></li>
		</gwideal:perm>
		<gwideal:perm url="/project/jzk"> 
			<li class="subnav-li" data-id="105" href="${base}/project/list?proLibType=4"><a class="sanji" href="#" onclick="changeColor(this)"> 结转库</a></li>
		</gwideal:perm>
		<gwideal:perm url="/project/xmjxgl"> 
			<li class="subnav">
				<a href="#" class="inactive" id="siji3" onclick="siji(this)">项目结项管理</a>
				<ul>
					<gwideal:perm url="/project/bmxmjx"> 
						<li class="subnav-li" data-id="106" href="${base}/project/list?sbkLx=bmxmjx">
							<a class="siji" href="#" onclick="changeColor(this)">
							<img src="${base}/resource-modality/${themenurl}/dian1.png"> 部门项目结项</a>
						</li>
					</gwideal:perm>
					<gwideal:perm url="/project/dwxmjx"> 
						<li class="subnav-li" data-id="107" href="${base}/project/list?sbkLx=dwxmjx">
							<a class="siji" href="#" onclick="changeColor(this)">
							<img src="${base}/resource-modality/${themenurl}/dian1.png"> 单位项目结项</a>
						</li>
					</gwideal:perm>
				</ul>
			</li>
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/control"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算控制数<span style="color: #4797d4"> 一下</span></a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/control/list">
		<li class="subnav-li" data-id="108" href="${base}/control/list"><a class="sanji" href="#" onclick="changeColor(this)"> 预算控制数分解</a></li>
		</gwideal:perm> 
		
		<gwideal:perm url="/control/tzList">
		<li class="subnav-li" data-id="109" href="${base}/control/tzList"><a class="sanji" href="#" onclick="changeColor(this)"> 预算控制数台账</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/ysbz"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算编制<span style="color: #4797d4"> 二上</span></a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/bmysbz">
		<li class="subnav-li" data-id="110" href="${base}/arrange/list/1"><a class="sanji" href="#" onclick="changeColor(this)"> 部门预算编制</a></li>
		</gwideal:perm> 
		
		<gwideal:perm url="/ysbzsp">
		<li class="subnav-li" data-id="111" href="${base}/arrange/list/2"><a class="sanji" href="#" onclick="changeColor(this)"> 预算编制审批</a></li>
		</gwideal:perm> 
		
		<gwideal:perm url="/ysbztz">
		<li class="subnav-li" data-id="1111" href="${base}/arrange/list/3"><a class="sanji" href="#" onclick="changeColor(this)"> 预算编制台账</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/yszbxd"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算指标下达<span style="color: #4797d4"> 二下</span></a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/yszbxd">
			<li class="subnav-li" data-id="1130" href="${base}/release/list"><a class="sanji" href="#" onclick="changeColor(this)"> 预算指标下达</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/jbzczbxd">
			<li class="subnav-li" data-id="1130" href="${base}/basicRelease/list"><a class="sanji" href="#" onclick="changeColor(this)"> 基本支出指标下达</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/xmzczbxd">
			<li class="subnav-li" data-id="1131" href="${base}/proRelease/list"><a class="sanji" href="#" onclick="changeColor(this)"> 项目支出指标下达</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/quota"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算指标管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/quota/list">
		<li class="subnav-li" data-id="113" href=""><a class="sanji" href="#" onclick="changeColor(this)"> 预算指标管理</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/adjust"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算指标调整</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/insideAdjust/list">
		<li class="subnav-li" data-id="114" href="${base}/insideAdjust/list"><a class="sanji" href="#" onclick="changeColor(this)"> 指标内部调整</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/outsideAdjust/list">
		<li class="subnav-li" data-id="115" href="${base}/outsideAdjust/list"><a class="sanji" href="#" onclick="changeColor(this)"> 指标外部调整申报</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/outsideCheck/list">
		<li class="subnav-li" data-id="116" href="${base}/outsideCheck/list"><a class="sanji" href="#" onclick="changeColor(this)"> 指标外部调整审批</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/outsideLedger/list">
		<li class="subnav-li" data-id="160" href="${base}/outsideLedger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 指标外部调整台账</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/htgl"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算指标查询</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/htgl">
		<li class="subnav-li" data-id="117" href=""><a class="sanji" href="#" onclick="changeColor(this)"> 指标执行情况报表</a></li>
		</gwideal:perm> 
		
		<gwideal:perm url="/htgl">
		<li class="subnav-li" data-id="118" href=""><a class="sanji" href="#" onclick="changeColor(this)"> 指标执行进度总表</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/pfmgl"> 
<li><a href="#" class="inactive" onclick="erji(this)">预算绩效</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/selfevaluationrule/list">
		<li class="subnav-li" data-id="119" href="${base}/selfevaluationrule/list"><a class="sanji" href="#" onclick="changeColor(this)">自评规则配置</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/selfevaluation/list">
		<li class="subnav-li" data-id="120" href="${base}/selfevaluation/list"><a class="sanji" href="#" onclick="changeColor(this)">绩效自评</a></li>
		</gwideal:perm> 
		<gwideal:perm url="/pfmlendgergl/list">
		<li class="subnav-li" data-id="121" href="${base}/pfmlendgergl/list"><a class="sanji" href="#" onclick="changeColor(this)">绩效监控 </a></li>
		</gwideal:perm> 
		<gwideal:perm url="/pfmlendgergl/list">
		<li class="subnav-li" data-id="122" href="${base}/pfmlendgergl/list"><a class="sanji" href="#" onclick="changeColor(this)">绩效目标台账</a></li>
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>




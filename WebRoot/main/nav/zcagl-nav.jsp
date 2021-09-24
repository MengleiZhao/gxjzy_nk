<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<gwideal:perm url="/zcagl"> 
		<gwideal:perm url="/zcagl/zcrkdj">
		<li><a href="#" class="inactive" onclick="erji(this)"> 资产入库登记</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Storage/lowlist">
					<li class="subnav-li" data-id="300" href="${base}/Storage/lowlist"><a class="sanji" href="#" onclick="changeColor(this)"> 低值易耗品</a>
				</gwideal:perm> 
				<gwideal:perm url="/Storage/fixedlist">
				<li class="subnav-li" data-id="301" href="${base}/Storage/fixedlist"><a class="sanji" href="#" onclick="changeColor(this)"> 固定资产</a>
				</gwideal:perm>
				<gwideal:perm url="/Storage/intangiblelist">
				<li class="subnav-li" data-id="302" href="${base}/Storage/intangiblelist"><a class="sanji" href="#" onclick="changeColor(this)"> 无形资产</a>
				</gwideal:perm>
			</ul>
		</li>
		</gwideal:perm> 
		<gwideal:perm url="/zcagl/zcly">
		<li><a href="#" class="inactive"onclick="erji(this)">资产领用</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Rece/lowlist">
					<li class="subnav-li" data-id="303" href="${base}/Rece/lowlist"><a class="sanji" href="#" onclick="changeColor(this)"> 低值易耗品申请</a>
				</gwideal:perm> 
				<gwideal:perm url="/Rece/fixedlist">
					<li class="subnav-li" data-id="304" href="${base}/Rece/fixedlist"><a class="sanji" href="#" onclick="changeColor(this)"> 固定资产</a>
				</gwideal:perm>
				<gwideal:perm url="/Rece/approvalList">
				<li class="subnav-li" data-id="305" href="${base}/Rece/approvalList"><a class="sanji" href="#" onclick="changeColor(this)"> 低值易耗品审批</a>
				</gwideal:perm>
			</ul>
		</li>
		</gwideal:perm> 
		<gwideal:perm url="/zcagl/zcdb">
		<li><a href="#" class="inactive"onclick="erji(this)">资产调拨</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Alloca/AppList">
					<li class="subnav-li" data-id="306" href="${base}/Alloca/AppList"><a class="sanji" href="#" onclick="changeColor(this)"> 资产调拨申请</a>
				</gwideal:perm> 
				<gwideal:perm url="/Alloca/approvalList">
				<li class="subnav-li" data-id="307" href="${base}/Alloca/approvalList"><a class="sanji" href="#" onclick="changeColor(this)"> 资产调拨审批</a>
				</gwideal:perm>
			</ul>
		</li>
		</gwideal:perm> 
		<gwideal:perm url="/zcagl/zccz">
		<li><a href="#" class="inactive"onclick="erji(this)">资产处置</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Handle/applicationList">
					<li class="subnav-li" data-id="308" href="${base}/Handle/applicationList"><a class="sanji" href="#" onclick="changeColor(this)"> 资产处置申请</a>
				</gwideal:perm> 
				<gwideal:perm url="/Handle/approvalList">
				<li class="subnav-li" data-id="309" href="${base}/Handle/approvalList"><a class="sanji" href="#" onclick="changeColor(this)"> 资产处置审批</a>
				</gwideal:perm>
				<gwideal:perm url="/Handle/registrationList">
				<li class="subnav-li" data-id="310" href="${base}/Handle/registrationList"><a class="sanji" href="#" onclick="changeColor(this)"> 资产处置登记</a>
				</gwideal:perm>
			</ul>
		</li>
		</gwideal:perm> 
</gwideal:perm> 

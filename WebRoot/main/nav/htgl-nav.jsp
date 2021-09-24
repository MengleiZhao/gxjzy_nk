<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<gwideal:perm url="/htgl"> 
	<gwideal:perm url="/htnd"> 
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同拟定</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Formulation/list">
				<li class="subnav-li" data-id="200" href="${base}/Formulation/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同拟定</a>
				</gwideal:perm> 
				
				<gwideal:perm url="/Approval/list">
				<li class="subnav-li" data-id="201" href="${base}/Approval/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同拟定审批</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/htba">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同备案</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Filing/list">
				<li class="subnav-li" data-id="202" href="${base}/Filing/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同备案</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/htlx">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同履行</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Enforcing/list">
				<li class="subnav-li" data-id="203" href="${base}/Enforcing/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同执行</a>
				</gwideal:perm> 
				<gwideal:perm url="/Change/List">
				<li class="subnav-li" data-id="204" href="${base}/Change/List"><a class="sanji" href="#" onclick="changeColor(this)"> 合同变更</a>
				</gwideal:perm> 
				<gwideal:perm url="/Conclusion/list">
				<li class="subnav-li" data-id="205" href="${base}/Conclusion/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同结项</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/htjf">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同纠纷</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Dispute/list">
				<li class="subnav-li" data-id="206" href="${base}/Dispute/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同纠纷</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/htgd">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同归档</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Archiving/list">
				<li class="subnav-li" data-id="207" href="${base}/Archiving/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同归档</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/httz">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同台账</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Ledger/list">
				<li class="subnav-li" data-id="208" href="${base}/Ledger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同台账</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/htdqtx">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同到期提醒</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/Expiration/list">
				<li class="subnav-li" data-id="209" href="${base}/Expiration/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同到期提醒</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
	<gwideal:perm url="/htzbjgl">
		<li><a href="#" class="inactive" onclick="erji(this)"> 合同质保金管理</a>
			<ul style="display: none" class="subnav">
				<gwideal:perm url="/GoldPay/list">
				<li class="subnav-li" data-id="210" href="${base}/GoldPay/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同质保金管理</a>
				</gwideal:perm> 
			</ul>
		</li>
	</gwideal:perm> 
</gwideal:perm> 

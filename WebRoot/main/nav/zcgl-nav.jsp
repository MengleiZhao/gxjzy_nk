<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<gwideal:perm url="/zcgl/sqsq"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 事前申请</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/zcgl/sqsq/sq"> 
		<li>
			<a href="#" class="inactive" id="siji1" onclick="siji(this)"> 申请</a>
			<ul>
				<li class="subnav-li">
					<a class="siji" href="#" onclick="addTabs('通用事项申请','${base}/apply/list?applyType=1');changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 通用事项申请</a>
				</li>
				<li class="subnav-li" data-id="502" href="${base}/apply/list?applyType=2">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 会议申请</a>
				</li>
				<li class="subnav-li" data-id="503" href="${base}/apply/list?applyType=3">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 培训申请</a>
				</li>
				<li class="subnav-li" data-id="504" href="${base}/apply/list?applyType=4">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 差旅申请</a>
				</li>
				<li class="subnav-li" data-id="505" href="${base}/apply/list?applyType=5">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 接待申请</a>
				</li>
			</ul>
		</li>
		</gwideal:perm>
		
		<gwideal:perm url="/applyCheck/list">
		<li class="subnav-li" data-id="506" href="${base}/applyCheck/list"><a class="sanji" href="#" onclick="changeColor(this)"> 审批</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/applyLedger/list">
		<li class="subnav-li" data-id="507" href="${base}/applyLedger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 台账</a></li> 
		</gwideal:perm> 
		
	</ul>
</li>
</gwideal:perm> 

<gwideal:perm url="/zcgl/jksq"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 借款申请</a>
	<ul class="subnav">
		<gwideal:perm url="/loan/list">
		<li class="subnav-li" data-id="508" href="${base}/loan/list"><a class="sanji" href="#" onclick="changeColor(this)"> 借款申请</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/loanCheck/list">
		<li class="subnav-li" data-id="509" href="${base}/loanCheck/list"><a class="sanji" href="#" onclick="changeColor(this)"> 借款审批</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/loanLedger/list">
		<li class="subnav-li" data-id="510" href="${base}/loanLedger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 借款台账</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/zcgl/bxsq"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 报销申请</a>
	<ul class="subnav">
		<gwideal:perm url="/directlyReimburse/list">
		<li class="subnav-li" data-id="511" href="${base}/directlyReimburse/list"><a class="sanji" href="#" onclick="changeColor(this)"> 直接报销</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/zcgl/bxsq/sqbx"> 
		<li>
			<a href="#" class="inactive" id="siji1" onclick="siji(this)"> 申请报销</a>
			<ul>
				<li class="subnav-li" data-id="512" href="${base}/reimburse/list?reimburseType=1">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 通用事项报销</a>
				</li>
				<li class="subnav-li" data-id="513" href="${base}/reimburse/list?reimburseType=2">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 会议报销</a>
				</li>
				<li class="subnav-li" data-id="514" href="${base}/reimburse/list?reimburseType=3">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 培训报销</a>
				</li>
				<li class="subnav-li" data-id="515" href="${base}/reimburse/list?reimburseType=4">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 差旅报销</a>
				</li>
				<li class="subnav-li" data-id="516" href="${base}/reimburse/list?reimburseType=5">
					<a class="siji" href="#" onclick="changeColor(this)"><img src="${base}/resource-modality/${themenurl}/dian1.png"> 接待报销</a>
				</li>
			</ul>
		</li>
		</gwideal:perm>
		
		<gwideal:perm url="/Enforcing/list">
		<li class="subnav-li" data-id="517" href="${base}/Enforcing/list"><a class="sanji" href="#" onclick="changeColor(this)"> 合同报销</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/reimburseCheck/list">
		<li class="subnav-li" data-id="518" href="${base}/reimburseCheck/list"><a class="sanji" href="#" onclick="changeColor(this)"> 报销审批</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/reimburseLedger/list">
		<li class="subnav-li" data-id="519" href="${base}/reimburseLedger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 报销台账</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/zcgl/cwsd">
<li><a href="#" class="inactive" onclick="erji(this)"> 财务审定</a>
	<ul class="subnav">
		<gwideal:perm url="/audit/list">
		<li class="subnav-li" data-id="520" href="${base}/audit/list"><a class="sanji" href="#" onclick="changeColor(this)"> 财务审定</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm>

<gwideal:perm url="/zcgl/cnsl">
<li><a href="#" class="inactive" onclick="erji(this)"> 出纳受理</a>
	<ul class="subnav">
		<gwideal:perm url="/cashier/list">
		<li class="subnav-li" data-id="521" href="${base}/cashier/list"><a class="sanji" href="#" onclick="changeColor(this)"> 出纳受理</a></li> 
		</gwideal:perm> 
	</ul>
	<ul class="subnav">
		<gwideal:perm url="/cashierCollect/list">
		<li class="subnav-li" data-id="522" href="${base}/cashierCollect/list"><a class="sanji" href="#" onclick="changeColor(this)"> 出纳机器人</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm>  


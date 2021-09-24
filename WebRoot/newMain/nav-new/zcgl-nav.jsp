<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">

	<h1>事前申请</h1>
	<div class="opened-for-codepen">
		<h2>申请</h2>
		<div class="opened-for-codepen">
			
			<gwideal:perm url="/apply/list?applyType=2">
			<h3 onclick="addTabs('会议申请','${base}/apply/list?applyType=2');">举办会议申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/apply/list?applyType=3">
			<h3 onclick="addTabs('举办培训申请','${base}/apply/list?applyType=3');">举办培训申请</h3>
			<div></div>
			</gwideal:perm>
			<gwideal:perm url="/apply/list?applyType=12">
			<h3 onclick="addTabs('参加培训申请','${base}/apply/list?applyType=12');">参加培训申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/apply/list?applyType=4">
			<h3 onclick="addTabs('差旅申请','${base}/apply/list?applyType=4');">差旅申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/apply/list?applyType=5">
			<h3 onclick="addTabs('公务接待申请','${base}/apply/list?applyType=5');">公务接待申请</h3>
			<div></div>
			</gwideal:perm>
			
			<%-- <gwideal:perm url="/apply/list?applyType=6">
			<h3 onclick="addTabs('公车运维申请','${base}/apply/list?applyType=6');">公车运维申请</h3>
			<div></div>
			</gwideal:perm> --%>
			
			<%--  <gwideal:perm url="/apply/list?applyType=7">
			<h3 onclick="addTabs('公务出国申请','${base}/apply/list?applyType=7');">公务出国申请</h3>
			<div></div>
			</gwideal:perm>  --%>
			
			<gwideal:perm url="/apply/list?applyType=1">
			<h3 onclick="addTabs('通用事项申请','${base}/apply/list?applyType=1');">通用事项申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/apply/list?applyType=13">
			<h3 onclick="addTabs('市内公务非公共交通申请','${base}/apply/list?applyType=13');">市内公务非公共交通申请</h3>
			<div></div>
			</gwideal:perm>
		</div>
		
		<gwideal:perm url="/applyCheck/list">
		<h2 onclick="addTabs('审批','${base}/applyCheck/list');">审批</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/applyLedger/list">
		<h2 onclick="addTabs('台账','${base}/applyLedger/list');">台账</h2>
		<div></div>
		</gwideal:perm>
	</div>
	
	<h1>借款申请</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/loan/list">
		<h2 onclick="addTabs('借款申请','${base}/loan/list');">借款申请</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/loanCheck/list">
		<h2 onclick="addTabs('借款审批','${base}/loanCheck/list');">借款审批</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/loanLedger/list">
		<h2 onclick="addTabs('借款台账','${base}/loanLedger/list');">借款台账</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/payment/list?menuType=1">
		<h2 onclick="addTabs('还款登记','${base}/payment/list?menuType=1');">还款登记</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/payment/list?menuType=2">
		<h2 onclick="addTabs('还款确认','${base}/payment/list?menuType=2');">还款确认</h2>
		<div></div>
		</gwideal:perm>
	</div>
	
	<h1>报销申请</h1>
	<div class="opened-for-codepen">
		
		<h2>申请报销</h2>
		<div class="opened-for-codepen">
			
			<gwideal:perm url="/reimburse/list?reimburseType=2">
			<h3 onclick="addTabs('会议报销','${base}/reimburse/list?reimburseType=2');">举办会议报销</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/reimburse/list?reimburseType=3">
			<h3 onclick="addTabs('举办培训报销','${base}/reimburse/list?reimburseType=3');">举办培训报销</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/reimburse/list?reimburseType=12">
			<h3 onclick="addTabs('参加培训报销','${base}/reimburse/list?reimburseType=12');">参加培训报销</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/reimburse/list?reimburseType=4">
			<h3 onclick="addTabs('差旅报销','${base}/reimburse/list?reimburseType=4');">差旅报销</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/reimburse/list?reimburseType=5">
			<h3 onclick="addTabs('公务接待报销','${base}/reimburse/list?reimburseType=5');">公务接待报销</h3>
			<div></div>
			</gwideal:perm>
			
			<%-- <gwideal:perm url="/reimburse/list?reimburseType=6">
			<h3 onclick="addTabs('公车运维报销','${base}/reimburse/list?reimburseType=6');">公车运维报销</h3>
			<div></div>
			</gwideal:perm> --%>
			
			<gwideal:perm url="/reimburse/list?reimburseType=7">
			<h3 onclick="addTabs('公务出国报销','${base}/reimburse/list?reimburseType=7');">公务出国报销</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/reimburse/list?reimburseType=1">
			<h3 onclick="addTabs('通用事项报销','${base}/reimburse/list?reimburseType=1');">通用事项报销</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/reimburse/list?reimburseType=13">
			<h3 onclick="addTabs('市内公务非公共交通报销','${base}/reimburse/list?reimburseType=13');">市内公务非公共交通报销</h3>
			<div></div>
			</gwideal:perm>
		</div>
		
		<gwideal:perm url="/directlyReimburse/list">
		<h2 onclick="addTabs('直接报销','${base}/directlyReimburse/list');">直接报销</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/reimburse/list?reimburseType=9">
		<h2 onclick="addTabs('往来款报销','${base}/reimburse/list?reimburseType=9');">往来款报销</h2>
		<div></div>
		</gwideal:perm>
		
		<%-- <gwideal:perm url="/cgsqsp/reimbList">
		<h2 onclick="addTabs('采购报销','${base}/cgsqsp/reimbList');">采购报销</h2>
		<div></div>
		</gwideal:perm> --%>
		
		<gwideal:perm url="/Enforcing/list">
		<h2 onclick="addTabs('合同报销','${base}/Enforcing/list');">合同报销</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/reimburseCheck/list">
		<h2 onclick="addTabs('报销审批','${base}/reimburseCheck/list');">报销审批</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/reimburseLedger/list">
		<h2 onclick="addTabs('报销台账','${base}/reimburseLedger/list');">报销台账</h2>
		<div></div>
		</gwideal:perm>
	</div>
	
	<%-- <h1>退费管理</h1>
	<div class="opened-for-codepen">
		<h2>新生退费</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/refund/list?fNewOrOld=0">
			<h3 onclick="addTabs('退费申请','${base}/refunde/list?fNewOrOld=0');">退费申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/refunde/checklist?fNewOrOld=0">
			<h3 onclick="addTabs('退费审批','${base}/refunde/checklist?fNewOrOld=0');">退费审批</h3>
			<div></div>
			</gwideal:perm>
		</div>
		
		<h2>老生退费</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/refunde/list?fNewOrOld=1">
			<h3 onclick="addTabs('退费申请','${base}/refunde/list?fNewOrOld=1');">申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/refunde/checklist?fNewOrOld=1">
			<h3 onclick="addTabs('退费审批','${base}/refunde/checklist?fNewOrOld=1');">审批</h3>
			<div></div>
			</gwideal:perm>
		</div>
		
		<gwideal:perm url="/refund/list?fNewOrOld=0">
		<h2 onclick="addTabs('新生退费申请','${base}/refund/list?fNewOrOld=0');">新生退费申请</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/refund/list?fNewOrOld=1">
		<h2 onclick="addTabs('老生退费申请','${base}/refund/list?fNewOrOld=1');">老生退费申请</h2>
		<div></div>
		</gwideal:perm>
			
		<gwideal:perm url="/refund/checkList">
		<h2 onclick="addTabs('退费审批','${base}/refund/checkList');">退费审批</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/refund/ledgerList">
		<h2 onclick="addTabs('退费台账','${base}/refund/ledgerList');">退费台账</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	
<%-- 	<gwideal:perm url="/zcgl/cwsd">
	<h1>财务审定</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/audit/list">
		<h2 onclick="addTabs('财务审定','${base}/audit/list');">财务审定</h2>
		<div></div>
		</gwideal:perm>
	</div>
	</gwideal:perm> --%>
	
	<gwideal:perm url="/cashier/list">
	<h1 onclick="addTabs('出纳受理','${base}/cashier/list');">出纳受理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/pzkglnav">
		<h2 onclick="addTabs('凭证库管理','${base}/cashier/list');">凭证库管理</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/Voucher/list">
		<h2 onclick="addTabs('凭证库管理','${base}/Voucher/list');">凭证库管理</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/cashierCollect/list">
		<h2 onclick="addTabs('出纳机器人','${base}/cashierCollect/list');">出纳机器人</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
</aside>


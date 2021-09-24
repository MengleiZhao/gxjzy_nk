<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">

	<h1>合同拟定</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/Formulation/list">
		<h2 onclick="addTabs('合同拟定','${base}/Formulation/list');">合同拟定</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/Approval/list">
		<h2 onclick="addTabs('合同拟定审批','${base}/Approval/list');">合同拟定审批</h2>
		<div></div>
		</gwideal:perm> 
	</div>
	
	<%--<gwideal:perm url="/Filing/list">
	<h1 onclick="addTabs('合同备案','${base}/Filing/list');">合同备案</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/htbanav">
		<h2 onclick="addTabs('合同备案','${base}/Filing/list');">合同备案</h2>
		<div></div>
		</gwideal:perm> 
	</div>
	<div></div>
	</gwideal:perm> --%>
	
	
	 <h1>合同变更</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/Change/List">
		<h2 onclick="addTabs('合同变更申请','${base}/Change/List');">合同变更申请</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/Change/approvalList">
		<h2 onclick="addTabs('合同变更审批','${base}/Change/approvalList');">合同变更审批</h2>
		<div></div>
		</gwideal:perm> 
	</div>
	<%--
	<gwideal:perm url="/sealInfo/list">
	<h1 onclick="addTabs('合同用印','${base}/sealInfo/list');">合同用印</h1>
	<div></div>
	</gwideal:perm>
	
	
	
	<gwideal:perm url="/Dispute/list">
	<h1 onclick="addTabs('合同纠纷','${base}/Dispute/list');">合同纠纷</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/htjfnav">
		<h2 onclick="addTabs('合同纠纷','${base}/Dispute/list');">合同纠纷</h2>
		<div></div>
		</gwideal:perm>
	</div>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/Formulation/overList"> 
	<h1 onclick="addTabs('合同完结','${base}/Formulation/overList');">合同完结</h1>
	<div></div>
	</gwideal:perm> --%>
	
	<h1>合同归档</h1>
	<div class="opened-for-codepen">
	<gwideal:perm url="/Archiving/list">
		<h2 onclick="addTabs('合同归档申请','${base}/Archiving/list');">合同归档申请</h2>
		
	</gwideal:perm> 
	
	<gwideal:perm url="/Archiving/htgdsp">
		<h2 onclick="addTabs('合同归档审批','${base}/Archiving/htgdsp');">合同归档审批</h2>
	</gwideal:perm> 
	<div></div>
	</div> 
	<gwideal:perm url="/Ledger/list">
	<h1 onclick="addTabs('合同台账','${base}/Ledger/list');">合同台账</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/httznav">
		<h2 onclick="addTabs('合同台账','${base}/Ledger/list');">合同台账</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	
	</gwideal:perm>
	<gwideal:perm url="/Ledger/statisticsList">
	<h1 onclick="addTabs('合同情况统计表','${base}/Ledger/statisticsList');">合同情况统计表</h1>
	<div></div>
	</gwideal:perm>
	
	<%-- <gwideal:perm url="/Expiration/list">
	<h1 onclick="addTabs('合同付款申请','${base}/Expiration/list');">合同付款申请</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/htdqtxnav">
		<h2 onclick="addTabs('合同到期提醒','${base}/Expiration/list');">合同到期提醒</h2>
		<div></div>
		</gwideal:perm> 
	</div>
	<div></div>
	</gwideal:perm> --%>
	
	<%-- <gwideal:perm url="/GoldPay/list">
	<h1 onclick="addTabs('合同质保金管理','${base}/GoldPay/list');">合同质保金管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/htzbjglnav">
		<h2 onclick="addTabs('合同质保金管理','${base}/GoldPay/list');">合同质保金管理</h2>
		<div></div>
		</gwideal:perm>
	</div>
	<div></div>
	</gwideal:perm> --%>
</aside>


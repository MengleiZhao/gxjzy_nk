<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">
	
	<h1>合同收入管理</h1>
	<div class="opened-for-codepen">
	
		<gwideal:perm url="/proceedsPlan/list"> 
		<h2 onclick="addTabs('合同收入确认','${base}/proceedsPlan/list');">合同收入确认</h2>
		<div></div>
		</gwideal:perm>
		<gwideal:perm url="/proceedsPlan/listcheck"> 
		<h2 onclick="addTabs('合同收入确认审批','${base}/proceedsPlan/listcheck');">合同收入确认审批</h2>
		<div></div>
		</gwideal:perm>
	
	</div>
	
	<h1>非合同收入管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/business/list">
		<h2 onclick="addTabs('收入立项申请','${base}/business/list');">收入立项申请</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/business/checkList">
		<h2 onclick="addTabs('收入立项审批','${base}/business/checkList');">收入立项审批</h2>
		<div></div>
		</gwideal:perm>

		<gwideal:perm url="/srregister/list">
		<h2 onclick="addTabs('应收款项登记','${base}/srregister/list');">应收款项登记</h2>
		<div></div>
		</gwideal:perm>
		
		<%-- <gwideal:perm url="/srregister/checklist">
		<h2 onclick="addTabs('应收款项登记审批','${base}/srregister/checklist');">应收款项登记审批</h2>
		<div></div>
		</gwideal:perm> --%>
		
		<gwideal:perm url="/incomeConfirm/confirmList">
		<h2 onclick="addTabs('非合同收入确认','${base}/incomeConfirm/confirmList');">非合同收入确认</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/incomeConfirm/confirmCheckList">
		<h2 onclick="addTabs('非合同收入确认审批','${base}/incomeConfirm/confirmCheckList');">非合同收入确认审批</h2>
		<div></div>
		</gwideal:perm>
		
		<%-- <gwideal:perm url="/incomeManagerledger/listBusiness">
		<h2 onclick="addTabs('培训类台账','${base}/incomeManagerledger/listBusiness');">培训类台账</h2>
		<div></div>
		</gwideal:perm> --%>
	</div>
	
	 <h1>往来款登记</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/accountsCurrent/list">
		<h2 onclick="addTabs('来款立项','${base}/accountsCurrent/list');">来款立项</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/accountsCurrentCheck/list">
		<h2 onclick="addTabs('立项审批','${base}/accountsCurrentCheck/list');">立项审批</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/accountsRegister/registerList">
		<h2 onclick="addTabs('来款登记','${base}/accountsRegister/registerList');">来款登记</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/accountsRegisterCheck/registerList">
		<h2 onclick="addTabs('登记审批','${base}/accountsRegisterCheck/registerList');">登记审批</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/registerAffirm/listAffirm">
		<h2 onclick="addTabs('来款确认','${base}/registerAffirm/listAffirm');">来款确认</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/incomeManagerledger/listAccounts">
		<h2 onclick="addTabs('往来款台账','${base}/incomeManagerledger/listAccounts');">往来款台账</h2>
		<div></div>
		</gwideal:perm> 
	</div> 
	
	<%-- <h1>拨款类收入</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/appropriation/list">
		<h2 onclick="addTabs('来款登记','${base}/appropriation/list');">来款登记</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/appropriation/checkList">
		<h2 onclick="addTabs('登记审批','${base}/appropriation/checkList');">登记审批</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/appropriation/confirmList">
		<h2 onclick="addTabs('来款确认','${base}/appropriation/confirmList');">来款确认</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
</aside>


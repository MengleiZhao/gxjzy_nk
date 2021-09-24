<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">

	<%-- <h1>年度计划</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/cgconfplan/list?freportStage=1&sblx=yssb">
		<h3 onclick="addTabs('一上申报','${base}/cgconfplan/list?freportStage=1&sblx=yssb');">一上申报</h3>
		<div></div>
		</gwideal:perm> 
			
		<gwideal:perm url="/cgconfplan/list?freportStage=1&sblx=yssp">
		<h3 onclick="addTabs('一上审批','${base}/cgconfplan/list?freportStage=1&sblx=yssp');">一上审批</h3>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/cgconfplan/list?freportStage=1&sblx=yxxd"> 
		<h3 onclick="addTabs('一下下达','${base}/cgconfplan/list?freportStage=1&sblx=yxxd');">一下下达</h3>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/cgconfplan/list?freportStage=2&sblx=essb">
		<h3 onclick="addTabs('二上申报','${base}/cgconfplan/list?freportStage=2&sblx=essb');">二上申报</h3>
		<div></div>
		</gwideal:perm>
			
		<gwideal:perm url="/cgconfplan/list?freportStage=2&sblx=essp">
		<h3 onclick="addTabs('二上审批','${base}/cgconfplan/list?freportStage=2&sblx=essp');">二上审批</h3>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/cgconfplan/list?freportStage=2&sblx=exxd"> 
		<h3 onclick="addTabs('二下下达','${base}/cgconfplan/list?freportStage=2&sblx=exxd');">二下下达</h3>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/cgconfplan/list?freportStage=2&sblx=ndtz"> 
		<h3 onclick="addTabs('年度计划台账','${base}/cgconfplan/list?freportStage=2&sblx=ndtz');">年度计划台账</h3>
		<div></div>
		</gwideal:perm>
	</div> --%>
	
	<h1>采购申请管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/cgsqsp/list">
		<h2 onclick="addTabs('采购计划申请','${base}/cgsqsp/list');">采购计划申请</h2>
		<div></div>
		</gwideal:perm> 

		<gwideal:perm url="/cgcheck/list">
		<h2 onclick="addTabs('采购计划审批','${base}/cgcheck/list');">采购计划审批</h2>
		<div></div>
		</gwideal:perm> 	
	
		<%-- <gwideal:perm url="/cgsqLedger/list">
		<h2 onclick="addTabs('月度执行台账','${base}/cgsqLedger/list');">月度执行台账</h2>
		<div></div> 
		</gwideal:perm>  --%>
	</div>
	
	<gwideal:perm url="/cgprocess/list"> 
	<h1 onclick="addTabs('采购过程登记','${base}/cgprocess/list');">采购过程登记</h1>
	<div></div>
	</gwideal:perm>
	
	<h1>采购验收管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/cgreceive/list">
		<h2 onclick="addTabs('采购验收申请','${base}/cgreceive/list');">采购验收申请</h2>
		<div></div>
		</gwideal:perm> 

		<gwideal:perm url="/cgreceive/checkList">
		<h2 onclick="addTabs('采购验收审批','${base}/cgreceive/checkList');">采购验收审批</h2>
		<div></div>
		</gwideal:perm> 	
	
		<%-- <gwideal:perm url="/cgtznav">
		<h2 onclick="addTabs('验收台账','${base}/cgreceiveLedger/list');">验收台账</h2>
		<div></div>
		</gwideal:perm> --%>
	</div>
	
	
	
	<%-- <gwideal:perm url="/cgreceive/list">
		<h2 onclick="addTabs('采购台账','${base}/cgsqLedger/list');">采购台账</h2>
		<div></div>
	</gwideal:perm>  --%>
	
	<gwideal:perm url="/cgsqLedger/list"> 
	<h1 onclick="addTabs('采购台账','${base}/cgsqLedger/list');">采购台账</h1>
	<div></div>
	</gwideal:perm>
	<%-- <h1>供应商管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/suppliergl/list">
		<h2 onclick="addTabs('供应商申请','${base}/suppliergl/list');">供应商申请</h2>
		<div></div> 
		</gwideal:perm> 
		
		<gwideal:perm url="/suppliergl/list2">
		<h2 onclick="addTabs('供应商出库申请','${base}/supplierglOut/list');">供应商出库申请</h2>
		<div></div>  
		</gwideal:perm> 
		
		<gwideal:perm url="/whitesuppliergl/blackAddList">
			<h2 onclick="addTabs('移入黑名单申请','${base}/whitesuppliergl/blackAddList');">移入黑名单申请</h2>
			<div></div>  
		</gwideal:perm> 
		
		<gwideal:perm url="/suppliercheck/list">
		<h2 onclick="addTabs('供应商审批','${base}/suppliercheck/list');">供应商审批</h2>
		<div></div> 
		</gwideal:perm> 
		
		<gwideal:perm url="/suppliercheck/list2">
		<h2 onclick="addTabs('供应商出库审核','${base}/suppliercheck/list2');">供应商出库审核</h2>
		<div></div>  
		</gwideal:perm> 
		
		<gwideal:perm url="/whitesuppliergl/list">
		<h2 onclick="addTabs('供应商查询','${base}/whitesuppliergl/list');">供应商查询</h2>
		<div></div>  
		</gwideal:perm>
		
	
		
		<gwideal:perm url="/suppliercheck/list3">
		<h2 onclick="addTabs('黑名单审核','${base}/suppliercheck/list3');">黑名单审核</h2>
		<div></div>  
		</gwideal:perm> 
		
		<gwideal:perm url="/blacksuppliergl/list">
		<h2 onclick="addTabs('供应商黑名单','${base}/blacksuppliergl/list');">供应商黑名单</h2>
		<div></div>  
		</gwideal:perm>
	</div>
	
	<h1>专家库管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/expertgl/list">
		<h2 onclick="addTabs('专家库申请','${base}/expertgl/list');">专家库申请</h2>
		<div></div> 
		</gwideal:perm> 
		
		<gwideal:perm url="/expertcheck/list">
		<h2 onclick="addTabs('专家库审批','${base}/expertcheck/list');">专家库审批</h2>
		<div></div> 
		</gwideal:perm>
		 
		<gwideal:perm url="/expertgl/recordJsp">
		<h2 onclick="addTabs('专家库抽取','${base}/expertgl/recordJsp');">专家库抽取</h2>
		<div></div> 
		</gwideal:perm>
		
		<gwideal:perm url="/whiteexpertgl/list">
		<h2 onclick="addTabs('专家库查看','${base}/whiteexpertgl/list');">专家库查看</h2>
		<div></div> 
		</gwideal:perm> 
		
		<gwideal:perm url="/blackexpertgl/list">
		<h2 onclick="addTabs('黑名单','${base}/blackexpertgl/list');">黑名单</h2>
		<div></div> 
		</gwideal:perm> 
	</div> --%>
</aside>
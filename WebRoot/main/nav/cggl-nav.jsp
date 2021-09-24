<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<%-- <gwideal:perm url="/cggl/cgsqsp"> 
 --%>

<gwideal:perm url="/cggl/cgsqsp"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 采购申请审批</a>
	<ul class="subnav">	
		<gwideal:perm url="/cgsqsp/list">
		<li class="subnav-li" data-id="400" href="${base}/cgsqsp/list"><a class="sanji" href="#" onclick="changeColor(this)"> 采购申请</a></li> 
		</gwideal:perm> 

		<gwideal:perm url="/cgcheck/list">
		<li class="subnav-li" data-id="401" href="${base}/cgcheck/list"><a class="sanji" href="#" onclick="changeColor(this)"> 采购审批</a></li> 
		</gwideal:perm> 	
	
		<gwideal:perm url="/cgsqLedger/list">
		<li class="subnav-li" data-id="402" href="${base}/cgsqLedger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 审批台账</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm> 

<gwideal:perm url="/cggl/cgprocess"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 采购过程登记</a>
	<ul class="subnav">	
		<gwideal:perm url="/cgprocess/list">
		<li class="subnav-li" data-id="405" href="${base}/cgprocess/list"><a class="sanji" href="#" onclick="changeColor(this)"> 招标登记</a></li> 
		</gwideal:perm> 
		<gwideal:perm url="/cgbid/list">
		<li class="subnav-li" data-id="406" href="${base}/cgbid/list"><a class="sanji" href="#" onclick="changeColor(this)"> 中标登记</a></li> 
		</gwideal:perm>
		<gwideal:perm url="/cginquiries/list">
		<li class="subnav-li" data-id="407" href="${base}/cginquiries/list"><a class="sanji" href="#" onclick="changeColor(this)"> 询比价登记</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm> 

<gwideal:perm url="/cggl/cgreceive"> 
<li><a href="#" class="inactive"onclick="erji(this)"> 采购验收</a>
	<ul class="subnav">	
		<gwideal:perm url="/cgreceive/list">
		<li class="subnav-li" data-id="403" href="${base}/cgreceive/list"><a class="sanji" href="#" onclick="changeColor(this)"> 采购验收</a></li> 
		</gwideal:perm> 
		
		<gwideal:perm url="/cgreceiveLedger/list">
		<li class="subnav-li" data-id="404" href="${base}/cgreceiveLedger/list"><a class="sanji" href="#" onclick="changeColor(this)"> 验收台账</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm> 
<gwideal:perm url="/cggl/cgpayfor"> 
<li><a href="#" class="inactive"onclick="erji(this)"> 采购付款</a>
	<ul class="subnav">	
		<gwideal:perm url="/cgpayfor/list">
		<li class="subnav-li" data-id="408" href="${base}/cgpayfor/list"><a class="sanji" href="#" onclick="changeColor(this)"> 付款申请</a></li> 
		</gwideal:perm> 
		<gwideal:perm url="/cgpayforcheck/list">
		<li class="subnav-li" data-id="409" href="${base}/cgpayforcheck/list"><a class="sanji" href="#" onclick="changeColor(this)"> 付款审批</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm> 


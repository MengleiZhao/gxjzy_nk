<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<%-- <gwideal:perm url="/cggl/cgsqsp"> 
 --%>

<gwideal:perm url="/srgl/srregister"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 收入登记</a>
	<ul class="subnav">	
		<gwideal:perm url="/srregister/list">
		<li class="subnav-li" data-id="600" href="${base}/srregister/list"><a class="sanji" href="#" onclick="changeColor(this)"> 收入登记</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm> 

<gwideal:perm url="/srgl/srcapital"> 
<li><a href="#" class="inactive"onclick="erji(this)"> 资金垫支</a>
	<ul class="subnav">	
		<gwideal:perm url="/srcapital/list">
		<li class="subnav-li" data-id="601" href="${base}/srcapital/list"><a class="sanji" href="#" onclick="changeColor(this)"> 资金垫支</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm> 



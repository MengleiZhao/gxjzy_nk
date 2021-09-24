<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">

	<h1>费用开支标准管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/YearsBsaic/mainList"> 
		<h2 onclick="addTabs('年度科目模板管理','${base}/YearsBsaic/mainList');">年度科目模板管理</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/yearsUnionBasic/list">
		<h2 onclick="addTabs('年度科目树管理','${base}/yearsUnionBasic/list');">年度科目树管理</h2>
		<div></div>
		</gwideal:perm> 
	</div>
	
	<gwideal:perm url="/log/list">
	<h1 onclick="addTabs('操作日志','${base}/log/list');">操作日志</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/czrznav">
		<h2 onclick="addTabs('操作日志','${base}/log/list');">操作日志</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/category/list">
	<h1 onclick="addTabs('字典类型管理','${base}/category/list');">字典类型管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/zdlxglnav">
		<h2 onclick="addTabs('字典类型管理','${base}/category/list');">字典类型管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/lookup/list">
	<h1 onclick="addTabs('字典项管理','${base}/lookup/list');">字典项管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/zdxglnav">
		<h2 onclick="addTabs('字典项管理','${base}/lookup/list');">字典项管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/user/list">
	<h1 onclick="addTabs('用户管理','${base}/user/list');">用户管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/yhglnav">
		<h2 onclick="addTabs('用户管理','${base}/user/list');">用户管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/depart/list">
	<h1 onclick="addTabs('部门管理','${base}/depart/list');">部门管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/bmglnav">
		<h2 onclick="addTabs('部门管理','${base}/depart/list');">部门管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/role/list">
	<h1 onclick="addTabs('角色管理','${base}/role/list');">角色管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/jsglnav">
		<h2 onclick="addTabs('角色管理','${base}/role/list');">角色管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/function/main">
	<h1 onclick="addTabs('功能菜单','${base}/function/main');">功能菜单</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/gncdnav">
		<h2 onclick="addTabs('功能菜单','${base}/function/main');">功能菜单</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/quartzController/list">
	<h1 onclick="addTabs('定时器管理','${base}/quartzController/list');">定时器管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/dsqglnav">
		<h2 onclick="addTabs('定时器管理','${base}/quartzController/list');">定时器管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
</aside>




<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">
	<h1><img src="${base}/resource-modality/${themenurl}/left/kjcd.png" style="margin:0 auto;transform: translateY(15%);"/>&nbsp;快捷菜单</h1>
	<div class="opened-for-codepen" id="ksrk">
		<c:forEach items="${ksrk}" var="li" varStatus="i">
			<h2 onclick="parent.addTabs('${li.menuName}','${base}${li.menuUrl}')">${li.menuName}</h2>
			<div></div>
		</c:forEach>
	</div>
	
	<h1 onclick="ksrkadd()"><img src="${base}/resource-modality/${themenurl}/left/sz.png" style="margin:0 auto;transform: translateY(15%);"/>&nbsp;添加快捷菜单</h1>
	<div></div>
	
</aside>

<script type="text/javascript">
//用户添加快速入口
function ksrkadd() {
	var win = creatWin('设置', 840, 475, 'icon-search', "/index/indexShortcut");
	win.window('open');
}

</script>
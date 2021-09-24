<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">
	<gwideal:perm url="/index/indexStreetPart">
	<h1 onclick="addTabs('系统首页','${base}/index/indexStreetPart');">系统首页</h1>
	<div></div>
	</gwideal:perm>
	
	<h1>我的工作台</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/index/taskList?listType=0">
		<h2 onclick="addTabs('待办事项','${base}/index/taskList?listType=0');">待办事项</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/index/taskList?listType=1">
		<h2 onclick="addTabs('已办事项','${base}/index/taskList?listType=1');">已办事项</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/index/taskList?listType=2">
		<h2 onclick="addTabs('办结事项','${base}/index/taskList?listType=2');">办结事项</h2>
		<div></div>
		</gwideal:perm>
	</div>
	
	<gwideal:perm url="/PrivateInfor/List">
	<h1 onclick="addTabs('消息中心','${base}/PrivateInfor/List');">消息中心</h1>
	<%-- <div class="opened-for-codepen">
		<h2 onclick="addTabs('消息中心','${base}/PrivateInfor/List');">消息中心</h2>
		<div></div>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<!-- <h1>效能分析</h1>
	<div class="opened-for-codepen">
		<h2>效能分析</h2>
		<div></div>
	</div> -->
	
</aside>

<script>
	//消息推送 更新待办事项数字 更新待办菜单列表
	var url1 = window.location.host;//localhost:8080
	var url2 = base;//nkgl
	var websocket;
	if ('WebSocket' in window) {
        //websocket = new WebSocket("ws://localhost:8080/nkgl/socket");
        websocket = new WebSocket("ws://" + url1 + url2 + "/socket");
    }
    else if ('MozWebSocket' in window) {
        //websocket = new MozWebSocket("ws://localhost:8080/nkgl/socket");
        websocket = new MozWebSocket("ws://" + url1 + url2 + "/socket");
    }
    else {
        //websocket = new SockJS("http://localhost:8080/nkgl/socket");
        websocket = new SockJS("ws://" + url1 + url2 + "/socket");
    }
	websocket.onopen = function(event) {
		/* console.log("WebSocket:已连接");
		console.log(event); */
	};
	websocket.onmessage = function(event) {
		var data = JSON.parse(event.data);
		console.log("WebSocket:收到一条消息-norm", data);
		alert("WebSocket:收到一条消息" + data);
		
		//重新变更待办数字
		$('#symenu_dbsx').html(data);
		//更新待办菜单列表
		$('#task_dg0').datagrid('reload');
	};
	websocket.onerror = function(event) {
		console.log("WebSocket:发生错误 ");
		console.log(event);
	};
	websocket.onclose = function(event) {
		console.log("WebSocket:已关闭");
		console.log(event);
	}
	
</script>


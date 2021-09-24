<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="easyui-layout" style="background-color: #f0f5f7;height: 100%; overflow: hidden">
	<div id="ksrk" style="background-color: #ffffff;border:1px #d9e3e7 solid;height: 44px;margin: 10px">
	
		
		<div class="ksrk0" style="background: url('${base}/resource-modality/${themenurl}/index/ksrk0.png');"></div>
		
		<c:if test="${ksrk.size()==0}">
			<div class="ksrk" style="background: url('${base}/resource-modality/${themenurl}/index/qtjkjfs.png;"></div>
		</c:if>
		
			
		<c:forEach items="${ksrk}" var="li" varStatus="i">
			<a href="#" onclick="parent.addTabs('${li.menuName}','${base}${li.menuUrl}')">
				<div class="ksrk" style="background: url('${base}/resource-modality/${themenurl}/index/ksrk${i.index+1}.png;">
					<p class="ksrkf">${li.menuName}</p>
				</div>
			</a>
		</c:forEach>
		
		<div class="ksrkjj"><a href="#"><img src="${base}/resource-modality/${themenurl}/index/ksrk9.png"></a></div>
		<%-- <div class="ksrkjj"><a href="#" onclick="ksrkdel()"><img src="${base}/resource-modality/${themenurl}/index/ksrk10.png"></a></div> --%>

	</div>
	
	<div style="margin: 0px 10px 10px 10px">
		<div id="tzgg" class="tzzd" style="float: left;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td style="padding-left:20px;font-size: 14px;color: #0170a4" colspan="2">通知公告</td>
					<td align="right" style="padding-right: 20px">
						<a href="#" onclick="tzggList()">
							<img src="${base}/resource-modality/${themenurl}/index/sygd.png">
						</a>
					</td>
				</tr>
			
				<c:forEach items="${notice}" var="ni">
					<tr>
						<td style="padding-left:20px;width: 60%"><a href="#" onclick="openNotice(${ni.noticeId})" style="color: #666666">${ni.noticeTitle}</a></td>
						<td><img src="${base}/resource-modality/${themenurl}/index/new.png"></td>
						<td align="right" style="padding-right: 20px">${ni.releaseTime.toString().substring(0,10)}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	
		<div id="zdzx" class="tzzd" style="float: right;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td style="padding-left:20px;font-size: 14px;color: #0170a4" colspan="2">制度中心</td>
					<td align="right" style="padding-right: 20px">
						<a href="#" onclick="zdzxList()">
							<img src="${base}/resource-modality/${themenurl}/index/sygd.png">
						</a>
					</td>
				</tr>
			
				<c:forEach items="${cheter}" var="ci">
					<tr>
						<td style="padding-left:20px;width: 60%"><a href="#" onclick="openCheter(${ci.systemId})" style="color: #666666">${ci.fileName}</a></td>
						<td><img src="${base}/resource-modality/${themenurl}/index/new.png"></td>
						<td align="right" style="padding-right: 20px">${ci.releseTime.toString().substring(0,10)}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
	</div>
	<div style="clear:both;"></div>
	<div class="db" style="margin:10px 10px 10px 10px;height: 300px;">
		<div class="tab-wrapper" id="sytab">
			<ul class="tab-menu"><!-- style="background-color: #f0f5f7" -->
		  		<li class="active" onclick="reloaddb()">待办事项</li>
		    	<li onclick="reloadyb()">已办事项</li>
		    	<li onclick="reloadbj()">办结事项</li>
		  	</ul>
		  
			<div class="tab-content">
			    <div style="height: 269px">
			    	<jsp:include page="index-tabs/dbsx.jsp" />
			    </div>
			    <div style="height: 269px">
			    	<jsp:include page="index-tabs/ybsx.jsp" />
			    </div>
			    <div style="height: 269px">
			    	<jsp:include page="index-tabs/bjsx.jsp" />
			    </div>
			</div>
		  
		</div>
	</div>

</div>


<script type="text/javascript">
//加载tab页
flashtab('sytab');

//用户添加快速入口
function ksrkadd() {
	var win = parent.creatWin('设置', 840, 475, 'icon-search', "/index/indexShortcut");
	win.window('open');
}
//用户删除快速入口
function ksrkdek() {
	
}

//加载待办信息
function reloaddb() {
	$('#indexdb').datagrid('reload');
}
function reloadyb() {
	$('#indexyb').datagrid('reload');
}
function reloadbj() {
	$('#indexbj').datagrid('reload');
}


//查看通知公告
function openNotice(noticeId) {
	//window.open(base + "/notice/detail/"+noticeId);
	 var win=parent.creatWin('通知公告-查看',1300,630,'icon-search',"/notice/detail/"+noticeId);
	 win.window('open');
}
//查看制度
function openCheter(cheterId) {
	//window.open(base + "/systemcentergl/detail?id="+cheterId+"&fromSy=true");
	var win=parent.creatWin('制度中心-查看',650,500,'icon-search',"/systemcentergl/detail?id="+cheterId+"&fromSy=true");
	win.window('open');
}
//通知公告列表
function tzggList(){
	window.open(base + "/notice/list?menuMark=fromIndex");
}
//制度列表
function zdzxList(){
	window.open(base + "/systemcentergl/list?menuMark=fromIndex");
}
</script>

<script>
	//消息推送 更新待办事项数字
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
		/* console.log("WebSocket:收到一条消息-norm", data);
		alert("WebSocket:收到一条消息" + data); */
		
		//重新刷新首页任务列表
		reloaddb();
		reloadyb();
		reloadbj();
	};
	websocket.onerror = function(event) {
		console.log("WebSocket:发生错误 ");
		console.log(event);
	};
	websocket.onclose = function(event) {
		/* console.log("WebSocket:已关闭");
		console.log(event); */
	}
	
</script>



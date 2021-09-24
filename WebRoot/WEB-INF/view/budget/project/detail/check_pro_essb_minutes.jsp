<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<style type="text/css">
.under{
	outline: none;
	width:75px;
    border-bottom: 1px solid #000;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
    text-align:center;
    color:#0000CD;
}
</style>
<table class="window-table">
<tr>
	<c:if test="${!empty checkPeople}">
		<td class="td1" style="">会议纪要
			<input type="file" multiple="multiple" id="hyjy"
			onchange="upladFileMoreParams(this,'hyjy','zcgl01','hyjyprogressNumber','hyjypercent','hyjytdf','hyjyfile','hyjyprogid','hyjyfileUrl')" hidden="hidden"> </td>
		<td colspan="3" id="hyjytdf">&nbsp;&nbsp; <a onclick="$('#hyjy').click()"
			style="font-weight: bold;  " href="#"> <img
				style="vertical-align:bottom;margin-bottom: 5px;"
				src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
				onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
			<div id="hyjyprogid"
				style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
				<div id="hyjyprogressNumber"
					style="background:#3AF960;width:0px;height:10px"></div>
				文件上传中...&nbsp;&nbsp;<font id="hyjypercent">0%</font>
			</div> <c:forEach items="${attaList}" var="att">
			<c:if test="${att.serviceType=='hyjy' }">
				<div style="margin-top: 5px;">
					<a href='${base}/attachment/download/${att.id}'
						style="color: #666666;font-weight: bold;">${att.originalName}</a>
					&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
						src="${base}/resource-modality/${themenurl}/sccg.png">
					&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="hyjyfileUrl" href="#"
						style="color:red" onclick="deleteAttac(this)">删除</a>
				</div>
			</c:if>
			</c:forEach>
		</td>
		</c:if>
		<c:if test="${empty checkPeople}">
			<td class="td1" style="">会议纪要</td>
			<td colspan="4">
				<c:if test="${!empty attaList}">
					<c:forEach items="${attaList}" var="att">
						<c:if test="${att.serviceType=='hyjy'}">
							<a href='${base}/attachment/download/${att.id}'
								style="color: #666666;font-weight: bold;">${att.originalName}</a>
							<br>
						</c:if>
					</c:forEach>
				</c:if>
			</td>	
		</c:if>
	</tr>
</table>
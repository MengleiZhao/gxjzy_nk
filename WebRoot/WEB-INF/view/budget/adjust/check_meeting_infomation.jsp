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
<!-- 校长办公会会议纪要 -->
<c:if test="${!empty xzbgsFile}">
 <div class="window-table" style="margin-bottom:10px;margin-left: 10px;">
	<div style="width:600px;margin-top:10px">
		<div >
			<%-- <label>附</label> <input type="text" name="meetingSummaryYear1"
				class="under" id="meetingSummaryYear1" autocomplete="off" <c:if test="${empty xzbgsFile}"> readonly="readonly" </c:if>
				value="${bean.meetingSummaryYear1}" />
				<label>年第 </label> <input type="text" autocomplete="off" id="meetingSummaryTime1" name="meetingSummaryTime1" <c:if test="${empty xzbgsFile}"> readonly="readonly" </c:if>
				class="under" required="required"
				value="${bean.meetingSummaryTime1}"/> --%>
				<label>校长办公会会议纪要&nbsp;</label> 
		</div>
	</div>
</div> 
</c:if>
<c:if test="${empty xzbgsFile}">
 <div class="window-table" style="margin-bottom:10px;margin-left: 10px;">
	<div style="width:600px;margin-top:10px">
		<div >
			<%-- <label>附</label> <input type="text" name="meetingSummaryYear1"
				class="under" id="meetingSummaryYear1" autocomplete="off" <c:if test="${empty xzbgsFile}"> readonly="readonly" </c:if>
				value="${bean.meetingSummaryYear1}" />
				<label>年第 </label> <input type="text" autocomplete="off" id="meetingSummaryTime1" name="meetingSummaryTime1" <c:if test="${empty xzbgsFile}"> readonly="readonly" </c:if>
				class="under" required="required"
				value="${bean.meetingSummaryTime1}"/> --%>
				<label>校长办公会会议纪要&nbsp;</label> 
		</div>
	</div>
</div> 
</c:if>
<table class="window-table">
<tr>
	<c:if test="${!empty xzbgsFile}">
		<td class="td1" style="width:0.1px;">
			<input type="file" multiple="multiple" id="xzbgs"
			onchange="upladFileMoreParams(this,'xzbgs','zcgl01','jdghprogressNumber','xzbgspercent','xzbgstdf','xzbgsfiles','xzbgsprogid','xzbgsfileUrl')" hidden="hidden"> <input
			type="text" id="xzbgsfiles" name="xzbgsfiles" hidden="hidden"></td>
		<td colspan="3" id="xzbgstdf">&nbsp;&nbsp; <a onclick="$('#xzbgs').click()"
			style="font-weight: bold;  " href="#"> <img
				style="vertical-align:bottom;margin-bottom: 5px;"
				src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
				onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
			<div id="xzbgsprogid"
				style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
				<div id="xzbgsprogressNumber"
					style="background:#3AF960;width:0px;height:10px"></div>
				文件上传中...&nbsp;&nbsp;<font id="xzbgspercent">0%</font>
			</div> <c:forEach items="${attaList}" var="att">
			<c:if test="${att.serviceType=='xzbgs' }">
				<div style="margin-top: 5px;">
					<a href='${base}/attachment/download/${att.id}'
						style="color: #666666;font-weight: bold;">${att.originalName}</a>
					&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
						src="${base}/resource-modality/${themenurl}/sccg.png">
					&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="xzbgsfileUrl" href="#"
						style="color:red" onclick="deleteAttac(this)">删除</a>
				</div>
			</c:if>
			</c:forEach>
		</td>
		</c:if>
		<c:if test="${empty xzbgsFile}">
			<td class="td1" style="width:0.1px;"></td>
			<td colspan="4">
				<c:if test="${!empty attaList}">
					<c:forEach items="${attaList}" var="att">
						<c:if test="${att.serviceType=='xzbgs'}">
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
<!-- 党委会会议纪要 -->
<c:if test="${!empty dwhFile}">
 <div class="window-table" style="margin-bottom:10px;margin-left: 10px;">
	<div style="width:600px;margin-top:10px">
		<div >
			<%-- <label>附</label> <input type="text" id="meetingSummaryYear2" name="meetingSummaryYear2" autocomplete="off"
				class="under" <c:if test="${empty dwhFile}"> readonly="readonly" </c:if>
				value="${bean.meetingSummaryYear2}" />
				<label>年第 </label> <input type="text" id="meetingSummaryTime2" name="meetingSummaryTime2" autocomplete="off"
				class="under" <c:if test="${empty dwhFile}"> readonly="readonly" </c:if>
				value="${bean.meetingSummaryTime2}"/> --%>
				<label>党委会会议纪要&nbsp;</label> 
		</div>
	</div>
</div> 
</c:if>
<c:if test="${empty dwhFile}">
 <div class="window-table" style="margin-bottom:10px;margin-left: 10px;">
	<div style="width:600px;margin-top:10px">
		<div >
			<%-- <label>附</label> <input type="text" id="meetingSummaryYear2" name="meetingSummaryYear2" autocomplete="off"
				class="under" <c:if test="${empty dwhFile}"> readonly="readonly" </c:if>
				value="${bean.meetingSummaryYear2}" />
				<label>年第 </label> <input type="text" id="meetingSummaryTime2" name="meetingSummaryTime2" autocomplete="off"
				class="under" <c:if test="${empty dwhFile}"> readonly="readonly" </c:if>
				value="${bean.meetingSummaryTime2}"/> --%>
				<label>党委会会议纪要&nbsp;</label> 
		</div>
	</div>
</div> 
</c:if>
<table class="window-table">
<tr>
	<c:if test="${!empty dwhFile}">
		<td class="td1" style="width:0.1px;">
			<input type="file" multiple="multiple" id="dwh"
			onchange="upladFileMoreParams(this,'dwh','zcgl01','dwhprogressNumber','dwhpercent','dwhtdf','dwhfiles','dwhprogid','dwhfileUrl')" hidden="hidden"> <input
			type="text" id="dwhfiles" name="dwhfiles" hidden="hidden"></td>
		<td colspan="3" id="dwhtdf">&nbsp;&nbsp; <a onclick="$('#dwh').click()"
			style="font-weight: bold;  " href="#"> <img
				style="vertical-align:bottom;margin-bottom: 5px;"
				src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
				onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
			<div id="dwhprogid"
				style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
				<div id="dwhprogressNumber"
					style="background:#3AF960;width:0px;height:10px"></div>
				文件上传中...&nbsp;&nbsp;<font id="dwhpercent">0%</font>
			</div> <c:forEach items="${attaList}" var="att">
			<c:if test="${att.serviceType=='dwh' }">
				<div style="margin-top: 5px;">
					<a href='${base}/attachment/download/${att.id}'
						style="color: #666666;font-weight: bold;">${att.originalName}</a>
					&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
						src="${base}/resource-modality/${themenurl}/sccg.png">
					&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="dwhfileUrl" href="#"
						style="color:red" onclick="deleteAttac(this)">删除</a>
				</div>
			</c:if>
			</c:forEach>
		</td>
		</c:if>
		
		<c:if test="${empty dwhFile}">
		<td class="td1" style="width:0.1px;"></td>
		<td colspan="4">
			<c:if test="${!empty attaList}">
				<c:forEach items="${attaList}" var="att">
					<c:if test="${att.serviceType=='dwh'}">
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
<script type="text/javascript">
</script>
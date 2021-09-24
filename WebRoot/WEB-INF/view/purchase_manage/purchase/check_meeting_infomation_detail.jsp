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
<div class="window-table" style="margin-bottom:10px;margin-left: 10px;">
	<div style="width:600px;margin-top:10px">
		<div >
			<label>附</label> <input type="text" name="meetingSummaryYear1" class="under" readonly="readonly" value="${bean.meetingSummaryYear1}" />
			<label>年第 </label> <input type="text" name="meetingSummaryTime1" class="under" required="required" readonly="readonly" value="${bean.meetingSummaryTime1}"/>
			<label>次校长办公会会议纪要&nbsp;</label> 
		</div>
	</div>
</div>
<%-- <table class="window-table">
	<tr>
		<td class="td1" style="width:0.1px;"></td>
		<td colspan="4">
			<c:if test="${!empty businessAttaList}">
				<c:forEach items="${businessAttaList}" var="att">
					<c:if test="${att.serviceType=='xzbgs'}">
						<a href='${base}/attachment/download/${att.id}'
							style="color: #666666;font-weight: bold;">${att.originalName}</a>
						<br>
					</c:if>
				</c:forEach>
			</c:if>
		</td>	
	</tr>
</table> --%>
<!-- 党委会会议纪要 -->
<c:if test="${!empty bean.meetingSummaryYear2}">
<div class="window-table" style="margin-bottom:10px;margin-left: 10px;">
	<div style="width:600px;margin-top:10px">
		<div>
			<label>附</label> <input type="text" name="meetingSummaryYear2" class="under" readonly="readonly" value="${bean.meetingSummaryYear2}" />
			<label>年第 </label> <input type="text" name="meetingSummaryTime2" class="under" readonly="readonly" value="${bean.meetingSummaryTime2}"/>
			<label>次党委会会议纪要&nbsp;</label> 
		</div>
	</div>
</div>

<%-- <table class="window-table">
	<tr>
		<td class="td1" style="width:0.1px;"></td>
		<td colspan="4">
			<c:if test="${!empty businessAttaList}">
				<c:forEach items="${businessAttaList}" var="att">
					<c:if test="${att.serviceType=='dwh'}">
						<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
						<br>
					</c:if>
				</c:forEach>
			</c:if>
		</td>	
	</tr>
</table> --%>
</c:if>
<script type="text/javascript">
</script>
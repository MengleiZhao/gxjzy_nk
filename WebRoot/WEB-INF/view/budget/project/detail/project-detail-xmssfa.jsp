<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.style_must{
	color:red;
}
.pro_inner_title{
	font-weight: bold;
	font-size: 14px;
}
</style>
<table cellpadding="0" cellspacing="0" style="margin-left: 20px">
	<tr class="trbody" style="height: 320px;">
		<td class="td1">&nbsp;&nbsp;项目实施方案</td>
		<td class="td2" colspan="4"> 
			<textarea name="FExplain"  id="fExplainId"  class="textbox-text" readonly="readonly" autocomplete="off"   style="width:750px;height:300px;resize:none">${bean.FExplain }</textarea> 
		</td>
	</tr>
	  			
	<tr class="trbody">
		<td class="td1">
			&nbsp;&nbsp;附件
			<input type="file" multiple="multiple" id="fSsfa" onchange="upladFileParams(this,'ssfa','ysgl01','ssfzprogressNumber','ssfzpercent','ssfztdf','ssfzfiles','ssfzprogid')" hidden="hidden">
			<input type="text" id="ssfzfiles" name="files" hidden="hidden">
		</td>
		
		<td colspan="2">
		<c:if test="${!empty attaList}">
			<c:forEach items="${attaList}" var="att">
				<c:if test="${att.serviceType=='ssfa' }">
					<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;margin-left: 8px">${att.originalName}</a><br>
				</c:if>
			</c:forEach>
			</c:if>
			<c:if test="${empty attaList}">
				<span style="color:#999999">暂未上传附件</span>
			</c:if>
		</td>
	</tr>
</table>

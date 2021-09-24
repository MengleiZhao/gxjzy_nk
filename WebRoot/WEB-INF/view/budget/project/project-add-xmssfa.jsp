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
<table cellpadding="0" cellspacing="0"  style="margin-left: 20px;">
				
	  			<tr class="trbody" style="height: 320px;">
	  				<td class="td1">&nbsp;&nbsp;项目实施方案</td>
	  				<td class="td2" colspan="4">
	  					<%-- <input id="fExplainId" class="easyui-textbox" style="width:750px;height:300px"
	  					 data-options="multiline:true,validType:'length[0,1000]'" name="FExplain" value="${bean.FExplain }"/> --%>
	  					 
	  					 <textarea name="FExplain"  id="fExplainId"  class="textbox-text" <c:if test="${!empty bean.zxmId}"> readonly="readonly"</c:if> oninput="textareaNum(this,'textareaNum2')" autocomplete="off"   style="width:750px;height:300px;resize:none">${bean.FExplain }</textarea> 
     					
	  				</td>
	  			</tr>
	  			<tr>
     				<td></td>
					<td align="right">
						可输入剩余数：<span id="textareaNum2" class="1000">
							<c:if test="${empty bean.FExplain}">1000</c:if>
							<c:if test="${!empty bean.FExplain}">${1000-bean.FExplain.length()}</c:if>
						</span>
					</td>
				</tr>
	  			<tr class="trbody">
					<td class="td1">
						&nbsp;&nbsp;附件
						<input type="file" multiple="multiple" id="fSsfa" onchange="upladFileParams(this,'ssfa','ysgl01','ssfzprogressNumber','ssfzpercent','ssfztdf','ssfzfiles','ssfzprogid')" hidden="hidden">
						<input type="text" id="ssfzfiles" name="ssfaFiles" hidden="hidden">
					</td>
					
					<c:if test="${operation!='detail'&& empty bean.zxmId}">
					<td colspan="3" id="ssfztdf">
						<a onclick="$('#fSsfa').click()" style="font-weight: bold;" href="#">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
						</a>
						<div id="ssfzprogid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
							 <div id="ssfzprogressNumber" style="background:#3AF960;width:0px;height:10px" >
							 </div>文件上传中...&nbsp;&nbsp;<font id="ssfzpercent">0%</font> 
						 </div>
						<c:forEach items="${attaList}" var="att">
							<c:if test="${att.serviceType=='ssfa' }">
								<div style="margin-top: 10px;">
								<a href='#' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
								</div>
							</c:if>
						</c:forEach>
					</td>
					</c:if>
					
					<c:if test="${operation=='detail'||!empty bean.zxmId}">
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
					</c:if>
				</tr>
</table>

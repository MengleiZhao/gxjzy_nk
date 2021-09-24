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
     				<td class="td1"><span class="style_must">*</span>&nbsp;立项依据</td>
     				<td style="width: 750px;height: 300px" colspan="4">
     					<textarea name="FProAccording"  id="fProAccordingId" <c:if test="${!empty bean.zxmId}"> readonly="readonly"</c:if>class="textbox-text" oninput="textareaNum(this,'textareaNum1')" autocomplete="off"  style="width:750px;height:300px;resize:none">${bean.FProAccording }</textarea> 
     					<%-- <input id="fProAccordingId" class="easyui-textbox" style="width:750px; height:300px;" required="true" onclick="alert(this.id)"
     					 data-options="multiline:true,required:true,validType:'length[0,1000]'" name="FProAccording" value="${bean.FProAccording }">
     				 --%>
     				</td>
     			</tr>
     			<tr>
     				<td></td>
	     			<td align="right">
						可输入剩余数：<span id="textareaNum1" class="1000">
							<c:if test="${empty bean.FProAccording}">1000</c:if>
							<c:if test="${!empty bean.FProAccording}">${1000-bean.FProAccording.length()}</c:if>
						</span>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1">
						&nbsp;&nbsp;附件
						<input type="file" multiple="multiple" id="fLxyj" onchange="upladFile(this,'lxyj','ysgl01')" hidden="hidden">
						<input type="text" id="files" name="lxyjFiles" hidden="hidden">
					</td>
					
					<c:if test="${operation!='detail'&&empty bean.zxmId}">
					<td colspan="3" id="tdf">
						<a onclick="$('#fLxyj').click()" style="font-weight: bold;" href="#">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
						</a>
						<c:forEach items="${attaList}" var="att">
							<c:if test="${att.serviceType=='lxyj' }">
								<div style="margin-top: 10px;">
								<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
								</div>
							</c:if>
						</c:forEach>
						<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
							 <div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
							 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
						</div>
					</td>
					</c:if>
					
					<c:if test="${operation=='detail'||!empty bean.zxmId}">
					<td colspan="2">
						<c:if test="${!empty attaList}">
							<c:forEach items="${attaList}" var="att">
							<c:if test="${att.serviceType=='lxyj' }">
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

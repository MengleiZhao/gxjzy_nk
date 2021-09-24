<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<table class="ourtable">  	<!-- 表单样式参考 -->
		<tr class="trbody">
			<td class="td1">
				&nbsp;&nbsp;合同文本
				<!-- <input type="file" multiple="multiple" id="f" onchange="upFile()" hidden="hidden">
				<input type="text" id="files1" name="files1" hidden="hidden"> -->
			</td>
			<td colspan="4" id="tdf1">
				<%-- <c:if test="${filingattac==null}">
					<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</c:if> --%>
				<c:forEach items="${filingattac}" var="att">
					<div style="margin-top: 10px;">
						<a href='#' style="color: #666666;font-weight: bold;">${att.fAttacName}</a>
						<c:if test="${filingattac==null}">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a id="${att.fAttacName}" class="fileUrl1" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						</c:if>
					</div>
				</c:forEach>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1">
				&nbsp;&nbsp;其他附件
				<input type="file" multiple="multiple" id="f1" onchange="upFile1()" hidden="hidden">
				<input type="text" id="files2" name="files2" hidden="hidden">
			</td>
			<td colspan="4" id="tdf2">
				<c:if test="${filinOthergattac==null}">
					<%-- <a onclick="$('#f1').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a> --%>
				</c:if>
				<c:forEach items="${filinOthergattac}" var="otheratt">
					<div style="margin-top: 10px;">
						<a href='#' style="color: #666666;font-weight: bold;">${otheratt.fAttacName}</a>
						<c:if test="${filinOthergattac==null}">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a id="${otheratt.fAttacName}" class="fileUrl2" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						</c:if>
					</div>
				</c:forEach>
			</td>
		</tr>
	</table>
<script type="text/javascript">
</script>

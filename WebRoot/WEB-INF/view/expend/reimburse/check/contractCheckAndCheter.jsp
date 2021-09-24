<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.tete
	{
	width:5px;
	height:60px;
	font-size:10px;
	text-align:center;
	color:#ffffff;
	transition: width 0.5s;
	-moz-transition: width 0.5s; /* Firefox 4 */
	-webkit-transition: width 0.5s; /* Safari 和 Chrome */
	-o-transition: width 0.5s; /* Opera */
	}
</style>

<div class="easyui-tabs">
	<div title="审批流程">
		<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="margin: 0px 0px 11px 15px;width: 160px">
		<table cellpadding="0" cellspacing="0" border="0">
		<c:forEach items="${nodeConf}" var="li" varStatus="i">
			<!-- 财务审定不为空 -->
			<c:if test="${li.auditInfo!=null}">
			<table style="background-color: #f0f5f7;width: 175px;font-size: 12px;color: #666666"
				cellpadding="0" cellspacing="0" 
				onMouseOver="spOver(this,'${li.auditInfo.auditResult}a',${li.FNType})"
				onMouseOut="spOut(this)" title="${li.auditInfo.auditRemake}">
				<tr>
					<td rowspan="4" align="center" style="width: 35px;background-color: #ffffff">
						<c:if test="${li.auditInfo.auditResult=='0'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxwtg.png">
						</c:if>
						<c:if test="${li.auditInfo.auditResult=='1'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
						</c:if>
						<c:if test="${li.auditInfo.auditResult!='1'&&li.auditInfo.auditResult!='0'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxwsp.png">
						</c:if>
					</td>
					<td colspan="2" style="padding-top: 6px;height: 18px">&nbsp;&nbsp;${li.user.name}</td>
					<td rowspan="4">
						<div class="tete" style="float: right;background-color: 
							<c:if test="${li.auditInfo.auditResult=='0'}">#bb1b34</c:if>
							<c:if test="${li.auditInfo.auditResult=='1'}">#0eaf7c</c:if>
							<c:if test="${li.auditInfo.auditResult!='1'&&li.auditInfo.auditResult!='0'}">#999999</c:if>
						">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="font-weight: bold;height: 18px">&nbsp;&nbsp;${li.user.depart.name}</td>
				</tr>
				<tr>
					<td colspan="2" style="height: 18px;padding-bottom: 6px;">
						&nbsp;&nbsp;${li.auditInfo.auditTime.toString().substring(0,16)}
					</td>
				</tr>
			</table>
			</c:if>
			
			<!-- 没有财务审定 -->
			<c:if test="${li.auditInfo==null}">
			<tr><td>
			<table style="background-color: #f0f5f7;width: 175px;font-size: 12px;color: #666666"
				cellpadding="0" cellspacing="0" 
				onMouseOver="spOver(this,'${li.checkInfo.checkResult}a',${li.FNType})"
				onMouseOut="spOut(this)" title="${li.checkInfo.checkRemake}">
				<tr>
					<td rowspan="4" align="center" style="width: 35px;background-color: #ffffff">
						<c:if test="${li.checkInfo.checkResult=='0'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxwtg.png">
						</c:if>
						<c:if test="${li.checkInfo.checkResult=='1'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
						</c:if>
						<c:if test="${li.checkInfo.checkResult!='1'&&li.checkInfo.checkResult!='0'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxwsp.png">
						</c:if>
					</td>
					<td colspan="2" style="padding-top: 6px;height: 18px">&nbsp;&nbsp;${li.user.name}</td>
					<td rowspan="4">
						<div class="tete" style="float: right;background-color: 
							<c:if test="${li.checkInfo.checkResult=='0'}">#bb1b34</c:if>
							<c:if test="${li.checkInfo.checkResult=='1'}">#0eaf7c</c:if>
							<c:if test="${li.checkInfo.checkResult!='1'&&li.checkInfo.checkResult!='0'}">#999999</c:if>
						">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="font-weight: bold;height: 18px">&nbsp;&nbsp;${li.user.depart.name}</td>
				</tr>
				<tr>
					<td colspan="2" style="height: 18px;padding-bottom: 6px;">
						&nbsp;&nbsp;${li.checkInfo.checkTime.toString().substring(0,16)}
					</td>
				</tr>
			</table>
			</td></tr>
			</c:if>
			<tr><td style="height: 10px"><img src="${base}/resource-modality/${themenurl}/skin_/spds.png" style="margin-left: 8px;"></td></tr>
		</c:forEach>
		<tr><td>
		<table style="background-color: #f0f5f7;width: 175px;font-size: 12px;color: #666666"
			cellpadding="0" cellspacing="0" onMouseOver="spOver(this,'-1a')" onMouseOut="spOut(this,'-1','0')">
			<tr>
				<td rowspan="4" align="center" style="width: 35px;background-color: #ffffff">
					<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
				</td>
				<td colspan="2" style="padding-top: 6px;height: 18px">&nbsp;&nbsp;${bean.fOperator}</td>
				<td rowspan="4">
					<div class="tete" style="background-color:#0eaf7c;float: right;"></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-weight: bold;height: 18px">&nbsp;&nbsp;${bean.fDeptName}</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 18px;padding-bottom: 6px">
					&nbsp;&nbsp;${bean.fReqtIME.toString().substring(0,16)}
				</td>
			</tr>

		</table>
		</td></tr>
		</table>
	</div>



	<div title="相关制度">
		<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="margin: 0px 0px 10px 15px;width: 160px">
		<table class="ourtable2" style="width: 150px;margin-left: 14px;" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 25px;"><input class="easyui-textbox"
					style="width:162px;"
					data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(e){}}]">
				</td>
			</tr>
			<c:forEach items="${cheterInfo}" var="li">
				<tr style="height: 30px;">
					<td><a style="color: #666666;margin-left: 5px;"
						id="file${li.systemId}" href="#"
						onclick="findSystemFile(${li.systemId})">${li.fileName}</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<script type="text/javascript">
	function spOut(t) {
		$(t).find('.tete').empty();
		$(t).find('.tete').css('width','5px');
	}
	function spOver(t,result,FNType) {
		$(t).find('.tete').css('width','15px');
		if(result=="-1a"){
			$(t).find('.tete').css('line-height','15px');
			$(t).find('.tete').append("发起流程");
		}
		if(result=="0a"){
			$(t).find('.tete').css('line-height','20px');
			$(t).find('.tete').append("未通过");
		}
		if(result=="1a"){
			$(t).find('.tete').css('line-height','30px');
			$(t).find('.tete').append("通过");
		}
		if(result=="a"){
			$(t).find('.tete').css('line-height','20px');
			$(t).find('.tete').append("待审批");
		}
		if(result!="0a"&&FNType=="3"&&result!="a"){
			$(t).find('.tete').css('line-height','20px');
			$(t).find('.tete').empty();
			$(t).find('.tete').append("已办结");
		};
			
	};
</script>


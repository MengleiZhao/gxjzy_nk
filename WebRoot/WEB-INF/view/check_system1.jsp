<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript" src="${base}/resource-modality/js/index-tabs.js"></script>
<div class="tab-wrapper" id="check_system">
	<ul class="tab-menu">
		<c:if test="${empty splc}">
			<li class="active">流程审批</li>
		</c:if>
		<!-- <li>相关制度</li> -->
	</ul>
	
	<div class="tab-content" >
		<c:if test="${empty splc}">
		<div>
			<div class="check-system">
			
			<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 220px;vertical-align:text-top">	 
			
			<table cellpadding="0" cellspacing="0" border="0">
				<c:forEach items="${nodeConf}" var="li" varStatus="i">
					<c:if test="${li.auditInfo!=null}">
					<tr><td>
						<table class="check-system-table" border="0" cellpadding="0" cellspacing="0" onMouseOver="spOver(this,'-1a')" onMouseOut="spOut(this,'-1','0')" title="${li.auditInfo.auditRemake}">
							<tr>
								<td rowspan="4" class="cstd1">
									<div style="height: 78px">
									<c:if test="${li.auditInfo.auditResult=='0'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxwtg.png">
									</c:if>
									<c:if test="${li.auditInfo.auditResult=='1'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
									</c:if>
									<c:if test="${li.auditInfo.auditResult!='1'&&li.auditInfo.auditResult!='0'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxwsp.png">
									</c:if>
									</div>
								</td>
								<td colspan="2" class="cstd2">${li.user.name}&nbsp;</td>
								<td rowspan="4" style="width: 15px">
									<div class="tete" style="float: right;background-color: 
										<c:if test="${li.auditInfo.auditResult=='0'}">#bb1b34</c:if>
										<c:if test="${li.auditInfo.auditResult=='1'}">#0eaf7c</c:if>
										<c:if test="${li.auditInfo.auditResult!='1'&&li.auditInfo.auditResult!='0'}">#999999</c:if>
									">
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="cstd3">${li.user.depart.name}&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2" class="cstd4">
									${li.auditInfo.auditTime.toString().substring(0,16)}&nbsp;
								</td>
							</tr>
						</table>
					</td></tr>
					<tr><td style="height: 10px"><div style="height: 10px"><img src="${base}/resource-modality/${themenurl}/skin_/spds.png"></div></td></tr>
					</c:if>
					
					<c:if test="${li.auditInfo==null}">
						<tr><td>
						
						<table class="check-system-table easyui-tooltip"  border="0" cellpadding="0" cellspacing="0" onMouseOver="spOver(this,'${li.checkInfo.checkResult}a',${li.FNType})" onMouseOut="spOut(this)" 
						
							data-options="position: 'left'"
							<c:if test="${empty (li.checkInfo.checkRemake)}">title="无审批意见"</c:if>
							<c:if test="${!empty (li.checkInfo.checkRemake)}">title="审批意见：${li.checkInfo.checkRemake}"</c:if> 
						>
							<tr>
								<td rowspan="4" class="cstd1">
									<div style="height: 78px">
									<c:if test="${li.checkInfo.checkResult=='0'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxwtg.png">
									</c:if>
									<c:if test="${li.checkInfo.checkResult=='1'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
									</c:if>
									<c:if test="${li.checkInfo.checkResult!='1'&&li.checkInfo.checkResult!='0'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxwsp.png">
									</c:if>
									</div>
								</td>
								<td colspan="2" class="cstd2">${li.user.name}&nbsp;</td>
								<td rowspan="4" style="width: 15px">
									<div class="tete" style="float: right;background-color: 
										<c:if test="${li.checkInfo.checkResult=='0'}">#bb1b34</c:if>
										<c:if test="${li.checkInfo.checkResult=='1'}">#0eaf7c</c:if>
										<c:if test="${li.checkInfo.checkResult!='1'&&li.checkInfo.checkResult!='0'}">#999999</c:if>
									">
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="cstd3">${li.user.depart.name}&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2" class="cstd4">
									${li.checkInfo.checkTime.toString().substring(0,16)}&nbsp;
								</td>
							</tr>
						</table>
						</td></tr>
						<tr><td style="height: 10px"><div style="height: 10px"><img src="${base}/resource-modality/${themenurl}/skin_/spds.png"></div></td></tr>
					</c:if>
				</c:forEach>
				
				
				<tr><td>
					<table class="check-system-table" border="0" cellpadding="0" cellspacing="0" onMouseOver="spOver(this,'-1a')" onMouseOut="spOut(this,'-1','0')">
						<tr>
							<td rowspan="4" class="cstd1">
								<div style="height: 78px">
								<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
								</div>
							</td>
							<td colspan="2" class="cstd2">${proposer.userName}</td>
							<td rowspan="4" style="width: 15px">
								<div class="tete"></div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="cstd3">${proposer.departName}</td>
						</tr>
						<tr>
							<td colspan="2" class="cstd4">
								${proposer.upTime.toString().substring(0,16)}&nbsp;
							</td>
						</tr>
			
					</table>
				</td></tr>
			</table>
			</div>
		</div>
		</c:if>
		
		<%-- <!-- 相关制度 -->
		<div>
			<div class="check-system">
				
				<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 220px;vertical-align:text-top">
			
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input class="easyui-textbox"
							style="width:200px;"
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
		</div> --%>
	</div>
		  
</div>

<style>
	.tete
	{
	width:5px;
	height:78px;
	font-size:12px;
	text-align:center;
	color:#ffffff;
	transition: width 0.5s;
	-moz-transition: width 0.5s; /* Firefox 4 */
	-webkit-transition: width 0.5s; /* Safari 和 Chrome */
	-o-transition: width 0.5s; /* Opera */
	background-color:#0eaf7c;
	float: right;
	}
</style>

<script type="text/javascript">
//加载tab页
flashtab('check_system');


function spOut(t) {
	$(t).find('.tete').empty();
	$(t).find('.tete').css('width','5px');
}
function spOver(t,result,FNType) {
	$(t).find('.tete').css('width','15px');
	if(result=="-1a"){
		$(t).find('.tete').css('line-height','19.5px');
		$(t).find('.tete').append("发起流程");
	}
	if(result=="0a"){
		$(t).find('.tete').css('line-height','26px');
		$(t).find('.tete').append("未通过");
	}
	if(result=="1a"){
		$(t).find('.tete').css('line-height','39px');
		$(t).find('.tete').append("通过");
	}
	if(result=="a"){
		$(t).find('.tete').css('line-height','26px');
		$(t).find('.tete').append("待审批");
	}
	if(result!="0a"&&FNType=="3"&&result!="a"){
		$(t).find('.tete').css('line-height','26px');
		$(t).find('.tete').empty();
		$(t).find('.tete').append("已办结");
	};
};
//寻找相关制度
function findSystemFile(id) {
	$.ajax({ 
		url: base+"/systemcentergl/attacFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
}
</script>
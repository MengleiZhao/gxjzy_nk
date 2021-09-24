<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript" src="${base}/resource-modality/js/index-tabs.js"></script>

<div class="tab-wrapper"  id="check_system">
	<ul class="tab-menu">
		<c:if test="${empty splc}">
			<li class="active">流程审批</li>
		</c:if>
		<!-- <li>相关制度</li> -->
	</ul>
	
	<div class="tab-content" >
	<!-- 是否显示审批流程，如果是空就不需要显示 -->
		<c:if test="${empty splc}">
		<div>
			<div class="check-system">
			
			<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 220px;vertical-align:text-top">	 
			
			<table cellpadding="0" cellspacing="0" border="0">
				<!-- 循环流程节点表 -->
				<c:forEach items="${nodeConf}" var="li" varStatus="i">
						<tr><td>
						<table class="check-system-table easyui-tooltip"  border="0" cellpadding="0" cellspacing="0" onMouseOver="spOver(this,'${li.checkInfo.fcheckResult}a')" onMouseOut="spOut(this)" 
						
							data-options="position: 'left'"
							<c:if test="${empty (li.checkInfo.fcheckRemake)}">title="无审批意见"</c:if>
							<c:if test="${!empty (li.checkInfo.fcheckRemake)}">title="审批意见：${li.checkInfo.fcheckRemake}"</c:if> 
						>
							<tr>
								<td rowspan="4" class="cstd1">
									<div style="height: 78px">
									<c:if test="${li.checkInfo.fcheckResult=='0'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxwtg.png">
									</c:if>
									<c:if test="${li.checkInfo.fcheckResult=='1'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
									</c:if>
									<c:if test="${li.checkInfo.fcheckResult!='1'&&li.checkInfo.fcheckResult!='0'}">
										<img src="${base}/resource-modality/${themenurl}/skin_/sptxwsp.png">
									</c:if>
									</div>
								</td>
								<td colspan="2" class="cstd2">${li.user.name}&nbsp;</td>
								<td rowspan="4" style="width: 15px">
									<div class="tete" style="float: right;background-color: 
										<c:if test="${li.checkInfo.fcheckResult=='0'}">#bb1b34</c:if>
										<c:if test="${li.checkInfo.fcheckResult=='1'}">#0eaf7c</c:if>
										<c:if test="${li.checkInfo.fcheckResult!='1'&&li.checkInfo.fcheckResult!='0'}">#999999</c:if>
									">
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="cstd3">${li.user.depart.name}&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2" class="cstd4">
									${li.checkInfo.fcheckTime.toString().substring(0,16)}&nbsp;
								</td>
							</tr>
						</table>
						</td></tr>
						<tr><td style="height: 10px"><div style="height: 10px"><img src="${base}/resource-modality/${themenurl}/skin_/spds.png"></div></td></tr>
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
function spOver(t,result) {
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
	/* if(result!="0a"&&result!="a"){
		$(t).find('.tete').css('line-height','26px');
		$(t).find('.tete').empty();
		$(t).find('.tete').append("已办结");
	}; */
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
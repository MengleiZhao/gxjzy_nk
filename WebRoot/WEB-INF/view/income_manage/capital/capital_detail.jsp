<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="re_capital_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
						<div title="借款单信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
								<tr>
									<td class="td1"><span class="style1">*</span>借款单号</td>
									<td class="td2">
										<input id="F_lCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="lCode"  style="width: 200px" value="${loanbean.lCode}"/>
										<!-- 隐藏域 --> 
									    <input type="hidden" name="lId" id="F_lId" value="${loanbean.lId}"/><!--借款单id -->
									</td>
									<td class="td4"></td>
									<td class="td1"><span class="style1">*</span>借款金额</td>
									<td class="td2">
										<input id="F_lAmount" name="lAmount"  class="easyui-textbox" readonly="readonly" data-options="iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${loanbean.lAmount}" />
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>借款指标</td>
									<td class="td2">
										<input id="F_indexName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="indexName"  style="width: 200px" value="${loanbean.indexName}"/>
									</td>
									<td style="width: 0px"></td>
									<td class="td1"><span class="style1">*</span>借款类型</td>
									<td class="td2">
										<c:if test="${loanbean.indexType=='0'}">
											<input id="F_indexType" name="indexType" class="easyui-textbox" readonly="readonly"  style="width: 200px" value="基本支出指标" />
										</c:if>
										<c:if test="${loanbean.indexType=='1'}">
											<input id="F_indexType" name="indexType" class="easyui-textbox" readonly="readonly"  style="width: 200px" value="项目支出指标" />
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>借款人</td>
									<td class="td2">
										<input id="F_userName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="userName" style="width: 200px" value="${loanbean.userName}"/>
									</td>
									<td style="width: 0px"></td>
									<td class="td1"><span class="style1">*</span>借款时间</td>
									<td class="td2">
										<input id="F_reqTime" name="reqTime"  class="easyui-datebox" readonly="readonly"  style="width: 200px" value="${loanbean.reqTime}" />
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>借款用途</td>
									<td colspan="4">
										<input class="easyui-textbox" id="F_loanPurpose" readonly="readonly" name="loanPurpose"  style="width: 555px" value="${loanbean.loanPurpose}"/>
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>预计冲账时间</td>
									<td class="td2" colspan="4">
										<input id="F_estChargeTime" class="easyui-datebox" type="text" readonly="readonly" required="required" name="estChargeTime" style="width: 200px" value="${loanbean.estChargeTime}"/>
									</td>
								</tr>
							</table>
						</div>							
						<div title="借款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
							<jsp:include page="../../expend/payee-info-detail.jsp" />
						</div>							
						<div title="还款信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
								<tr>
									<td class="td1"><span class="style1">*</span>登记人</td>
									<td class="td2">
										<input id="F_foperateUser" class="easyui-textbox" type="text" readonly="readonly" required="required" name="foperateUser"  style="width: 200px" value="${repaybean.foperateUser}"/>
									</td>
									<td class="td4"></td>
									<td class="td1"><span class="style1">*</span>还款时间</td>
									<td class="td2">
										<input id="F_foperateTime" name="foperateTime"  class="easyui-datebox" readonly="readonly"  style="width: 200px" value="${repaybean.foperateTime}" />
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>借款单号</td>
									<td class="td2">
										<input id="F_fcoCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fcoCode"  style="width: 200px" value="${repaybean.fcoCode}"/>
									</td>
									<td style="width: 0px"></td>
									<td class="td1"><span class="style1">*</span>还款金额</td>
									<td class="td2">
										<input id="F_famount" name="famount"  class="easyui-textbox" readonly="readonly" data-options="iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${repaybean.famount}" />
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">附件</td>
									<td colspan="4">
									<c:if test="${!empty attac}">
									<c:forEach items="${attac}" var="att">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
									</c:forEach>
									</c:if>
									<c:if test="${empty attac}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</tr>
							</table>
						</div>							
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>
	<script type="text/javascript">
	//查看附件
	function findAttacFile(id) {
		$.ajax({ 
			url: base+"/srcapital/attacFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	}
	</script>
</body>
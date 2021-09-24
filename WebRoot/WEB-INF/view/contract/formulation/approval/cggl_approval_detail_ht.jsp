<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div id="cgsq_apply_detail_form_ht">
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="预算信息" data-options="collapsible:false" style="overflow:auto;height: 150px;margin-left: 0px;">				
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span class="style1">*</span> 支出项目</td>
								<td colspan="3" style="padding-right: 5px;">
									<input class="easyui-textbox" style="width: 642px;height: 30px;"
									name="indexName" value="${cggl.indexName}" id="F_fBudgetIndexName"
								 readonly="readonly"/>
								</td>
							</tr>
						</table>	
						<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
								<tr>
									<td class="window-table-td1"><p>批复金额：</p></td>
									<td class="window-table-td2"><p id="p_pfAmount">${cggl.pfAmount}万元</p></td>
									
									<td class="window-table-td1"><p>预算年度：</p></td>
									<td class="window-table-td2"><p id="p_pfDate">${cggl.pfDate}</p></td>
								</tr>
								
								<tr>
									<td class="window-table-td1"><p>可用额度：</p></td>
									<td class="window-table-td2"><p id="p_syAmount">${cggl.syAmount}</p></td>
								</tr>
						</table>				
					</div>
				</div>	
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="采购信息" data-options=" collapsible:false" style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody" hidden="hidden">
								<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;采购批次编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fpCode" readonly="readonly" name="fpCode" readonly="readonly" style="width:220px;height: 30px" value="${cggl.fpCode}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请时间</td>
								<td class="td2">
									<input class="easyui-datebox" class="dfinput" id="F_fReqTime" name="fReqTime" readonly="readonly"  data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${cggl.fReqTime}"/>
								</td>			
								
							</tr>
	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly"  name="fDeptName" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${cggl.fDeptName}"/>
								</td>
								
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly"  name="fUserName" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${cggl.fUserName}"/>
								</td>
								
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:70px;"><span class="style1">*</span>&nbsp;是否政府采购</td>
								<td class="td2">
         							<input type="radio" name="fIsGovern" disabled="disabled" readonly="readonly" <c:if test="${cggl.fIsGovern=='1'}">checked="checked"</c:if> value="1" onclick="governYes()">是
         							<input type="radio" name="fIsGovern" disabled="disabled" readonly="readonly" <c:if test="${cggl.fIsGovern!='1'}">checked="checked"</c:if> value="0" onclick="governNo()">否
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:70px;"><span class="style1">*</span>&nbsp;是否进口</td>
								<td class="td2">
         							<input type="radio" name="fIsImp" disabled="disabled" readonly="readonly" <c:if test="${cggl.fIsImp=='1'}">checked="checked"</c:if> value="1">是</input>
         							<input type="radio" name="fIsImp" disabled="disabled" readonly="readonly" <c:if test="${cggl.fIsImp!='1'}">checked="checked"</c:if> value="0">否</input>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" ><span class="style1">*</span>&nbsp;是否订立合同</td>
								<td class="td2">
									<input type="radio" name="fIsContract" disabled="disabled" readonly="readonly" <c:if test="${cggl.fIsContract=='1'}">checked="checked"</c:if> value="1">是</input>
         							<input type="radio" name="fIsContract" disabled="disabled" readonly="readonly" <c:if test="${cggl.fIsContract!='1'}">checked="checked"</c:if> value="0">否</input>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购名称</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fpName"  name="fpName"  readonly="readonly" data-options="validType:'length[1,20]'" style="width: 576px;height: 30px" value="${cggl.fpName}"/>
								</td>
							</tr>
							<tr class="trbody">
								
								<td class="td1"><span class="style1">*</span>&nbsp;采购金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_fpAmount"  name="fpAmount"  readonly="readonly" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan'}]" style="width: 220px;height: 30px" value="${cggl.fpAmount}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
								<td class="td2">
									<select class="easyui-combobox" id="F_fpMethod"  name="fpMethod"  readonly="readonly" data-options="editable:false,validType:'length[1,20]'" style="width: 220px;height: 30px">
										<option value="">--请选择--</option>
										<option value="GKZB" <c:if test="${cggl.fpMethod=='GKZB'}">selected="selected"</c:if>>公开招标</option>
										<option value="YQZB" <c:if test="${cggl.fpMethod=='YQZB'}">selected="selected"</c:if>>邀请招标</option>
										<option value="JZXCS" <c:if test="${cggl.fpMethod=='JZXCS'}">selected="selected"</c:if>>竞争性磋商</option>
										<option value="JZXTP" <c:if test="${cggl.fpMethod=='JZXTP'}">selected="selected"</c:if>>竞争性谈判</option>
										<option value="DYLYCG" <c:if test="${cggl.fpMethod=='DYLYCG'}">selected="selected"</c:if>>单一来源采购</option>
										<option value="WSCS" <c:if test="${cggl.fpMethod=='WSCS'}">selected="selected"</c:if>>网上超市</option>
										<option value="XYDDCG" <c:if test="${cggl.fpMethod=='XYDDCG'}">selected="selected"</c:if>>协议定点采购</option>
									</select>
								</td>
							</tr> 
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购组织形式</td>
									 <c:if test="${cggl.fIsGovern == '1'}"> 
										<td class="td2" id="org1">
											<select class="easyui-combobox" id="orgType1"  style="width: 220px;height: 30px" readonly="readonly" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
												<option value="">--请选择--</option>
												<option value="JZCG" <c:if test="${cggl.orgType=='JZCG'}">selected="selected"</c:if>>集中采购</option>
												<option value="FSCG" <c:if test="${cggl.orgType=='FSCG'}">selected="selected"</c:if>>分散采购</option>
											</select>	
										</td>
									 </c:if> 
									 <c:if test="${cggl.fIsGovern == '0'}"> 
										<td class="td2" id="org2">
											<select class="easyui-combobox" id="orgType2"  style="width: 220px;height: 30px" readonly="readonly" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
												<option value="ZXCG" <c:if test="${cggl.orgType=='ZXCG'}">selected="selected"</c:if>>自行采购</option>
											</select>
										</td>
									 </c:if> 
								<td class="td1"><span class="style1">*</span>&nbsp;采购品目目录</td>
								<td class="td2">
										<select class="easyui-combobox" id="fItems" name="fItems"  readonly="readonly" style="width: 220px;height: 30px" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']"> 
											<option value="">--请选择--</option>
											<option value="A" <c:if test="${cggl.fItems=='A'}">selected="selected"</c:if>>货物</option>
											<option value="B" <c:if test="${cggl.fItems=='B'}">selected="selected"</c:if>>工程</option>
											<option value="C" <c:if test="${cggl.fItems=='C'}">selected="selected"</c:if>>服务</option>
										</select>												
								</td>
							</tr>
	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购品目细目</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="fItemsDetail"   name="fItemsDetail"  readonly="readonly" data-options="prompt: '选择细目' ,icons: [{iconCls:'icon-sousuo'}]"  style="width: 576px;height: 30px" value="${cggl.fItemsDetail}"/>
								</td>
								<input type="hidden" name="fItemsDetailIds" id="fItemsDetailIds" value="${cggl.fItemsDetailIds}"/>
							</tr>
	
							
							<tr>
								<td class="td1" valign="top"><span class="style1">*</span>&nbsp;申请理由</td>
								<td colspan="4">
									<textarea name="fRemark"  id="F_fRemark"  readonly="readonly" class="textbox-text"   style="width:570px;height:70px;resize:none;border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${cggl.fRemark}</textarea>
								</td>
							</tr>
							
							
							
							<tr class="trbody">
								<td class="td1">&nbsp;采购清单</td>
								<td colspan="4">
									<c:if test="${!empty attac}">
										<c:forEach items="${attac}" var="att">
											<c:if test="${att.serviceType=='cgqd' }">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											</c:if>
										</c:forEach>
									</c:if>
									
									<c:if test="${empty attac}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;需求文件</td>
								<td colspan="4">
									<c:if test="${!empty attac}">
										<c:forEach items="${attac}" var="att">
											<c:if test="${att.serviceType=='xqwj' }">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											</c:if>
										</c:forEach>
									</c:if>
									
									<c:if test="${empty attac}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;论证报告</td>
								<td colspan="4">
									<c:if test="${!empty attac}">
										<c:forEach items="${attac}" var="att">
											<c:if test="${att.serviceType=='lzbg' }">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											</c:if>
										</c:forEach>
									</c:if>
									
									<c:if test="${empty attac}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">&nbsp;工程量清单</td>
								<td colspan="4">
									<c:if test="${!empty attac}">
										<c:forEach items="${attac}" var="att">
											<c:if test="${att.serviceType=='gclqd' }">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											</c:if>
										</c:forEach>
									</c:if>
									
									<c:if test="${empty attac}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</td>
							</tr>
							
						</table>
					</div>
				</div>
				
			<!-- 审批记录 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;">
							<jsp:include page="../../../check_history.jsp" />
					</div>
				</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$.parser.parse("#cgsq_apply_detail_form_ht");
	//批复金额
	var pfAmount = $("#pfAmount").val();
	//pfAmount = parseFloat(pfAmount);
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
	//可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	}
	//批复时间
	var pfDate = $("#pfDate").val();
	if(pfDate !=""){
		$('#p_pfDate').html(getYear(pfDate));
	}
	
});



//是否论证	是-显示采购论证结论按钮
function isInquiry(){
	var isInquiry = $("input[name='fIsInquiry']:checked").val();
	if(isInquiry == "1"){
		$("#cglzjl").show();
	}else {
		$("#cglzjl").hide();
	}
}

//采购类型为货物类，采购单价大于等于10万，显示大型仪器设备前期调研报告
function dxyqdybg(){
	var totalFsumMoney = $("#F_fpAmount").val();
	var fpPype = $("#F_fpPype").val(); 
	if(totalFsumMoney>=100000 && fpPype=='A10'){
		$("#dxyqdybg").show();
	}else{
		$("#dxyqdybg").hide();
	}
}

//采购总金额大于等于10万，要上传三重一大党委会纪要
function scyddwhjy(){
	var totalFsumMoney = $("#F_fpAmount").val();
	if(totalFsumMoney>=100000){
		$("#scyddwhjy").show();
	}else{
		$("#scyddwhjy").hide();
	}
}
//加载完以后自动计算金额
</script>
</body>
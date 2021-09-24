<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 693px">
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span> 摘要</td>
							<td colspan="3" class="td2" >
									<input class="easyui-textbox" style="width: 635px;height: 30px; margin-left: 10px" readonly="readonly" value="${applyBean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span>申请事由</td>
							<td  class="td2" colspan="3" style="    line-height: 16px;">
								<textarea name="reason" id="reason" class="textbox-text" readonly="readonly"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:630px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7;margin-top:5px;margin-bottom:0px;">${applyBean.reason }</textarea>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
							<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;text-align: right;padding-right: 5px"><span class="style1">*</span> 部门名称</td>
							<td class="td2" >
							<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 267px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
					</table>
				</div>				
				</div>
				
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
					<div title="费用明细"
						data-options=" collapsed:false,collapsible:false" style="overflow:auto;width: 695px">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="apply_mingxi_car_detail.jsp" />
							<div >
									<a style="float: right;margin-right: 30px;">申请总额：<span style="color: #D7414E"  id="rapplyTotalAmount"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px;width: 695px">
				<div title="预算信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-left: 0px;height: 150px">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width: 693px">
						<tr class="trbody">
							<td style="width: 60px;text-align: right;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3" >
								<input class="easyui-textbox" style="width: 590px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
							 readonly="readonly" required="required"/>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:693px;height: 50px;">
							<tr>
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
							</tr>
							
							<tr>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}</p></td>
								
								<%-- <td class="window-table-td1"><p>累计支出:</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td> --%>
							</tr>
					</table>				
				</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
				<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px; ">
						<tr class="trbody">
								<td style="width: 60px">附件</td>
								<td colspan="4">
									<c:if test="${!empty attaList}">
									<c:forEach items="${attaList}" var="att">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
									</c:forEach>
								</c:if>
								<c:if test="${empty attaList}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
								</td>
							</tr>
						
						
					</table>
					
				</div>
				</div>
				<!-- 审批记录 事前申请 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
					<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../../check_history_reim_apply.jsp" />
					</div>
				</div>
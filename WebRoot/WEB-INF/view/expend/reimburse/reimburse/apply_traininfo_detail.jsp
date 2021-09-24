<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
				<!-- 预算信息 -->
				<div class="easyui-accordion"
					style="margin-left: 20px;margin-right: 20px;margin-top: 0px;width: 695px">
					<div title="预算信息" data-options="collapsible:false"
						style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0"
							style="margin-top: 3px;margin-left: 0px;width:692px;">
							<tr class="trbody">
								<td class="td2" ><span
									style="text-align: left;color: red">*</span> 支出项目:</td>
								<td colspan="3"><input class="easyui-textbox"
									readonly="readonly" style="width: 625px;height: 30px;"
									name="indexName" value="${bean.indexName}" 
									data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]"
									readonly="readonly" required="required" /></td>
							</tr>
						</table>
						<table class="window-table-readonly-zc" cellspacing="0"
							cellpadding="0" style="margin-left: 0px;width: 693px;height: 50px;">
							<tr>
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${fn:substring(bean.pfDate, 0, 4)}</p></td>
							</tr>
							<tr>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount"><fmt:formatNumber groupingUsed="true" value="${bean.indexAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
					<div title="基本信息" data-options="collapsible:false,collapsible:false">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 693px;margin-left: 3px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 事项摘要</td>
								<td colspan="3"><input class="easyui-textbox"
									style="width: 580px;height: 30px;" value="${applyBean.gName}"
									name="gName" readonly="readonly" /></td>
							</tr>
							<jsp:include page="apply_train_detail.jsp" />
						</table>
					</div>
				</div>
				<!-- 讲师信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:695px">
				<div title="讲师信息" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="apply_train_lecturer.jsp" />
					</div>
				</div>
				</div>
				
				<!-- 培训日程 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
				<div title="培训日程" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="apply_train_plan.jsp" />
					</div>
				</div>
				</div>
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 20px;width: 699px">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto">
							<!--  综合预算  明细 -->
						<div style="margin-top: 20px">
							<jsp:include page="apply_mingxi-train-zongheys.jsp" />
						</div>
						<div style="height:10px;"></div>
						<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
								<tr>
									<td class="window-table-td1" style="width:20%">综合预算总计</td>
									<td class="window-table-td2" style="width:27%">
										<input class="under" value="${trainingBean.zongheMoney}" readonly="readonly" type="text">元
									</td>
									<td class="window-table-td1"><p>定额标准总计：</p></td>
									<td class="td2">
										<input class="under" value="${trainingBean.zongheMoneyStd}" readonly="readonly" type="text">元
									</td>
								</tr>
						</table>
							<!--  师资费-讲课费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="apply_mingxi-train-lessons.jsp" />
						</div>	
							<!--  师资费-住宿费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="apply_mingxi-train-hotel.jsp" />
						</div>	
							<!--  师资费-伙食费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="apply_mingxi-train-food.jsp" />
						</div>	
							<!--  师资费-城市间交通费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="apply_mingxi-train-trafficCityToCity.jsp" />
						</div>
						<div style="margin-top: 20px">
							<div style="color: red;"><a style="color: red;">${applyBean.fTrafficHint}</a></div>
						</div>
							<div style="margin-top: 20px">
							<a style="float: right;">申请总额：<span style="color: #D7414E"  ><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/></span>[元]</a>
							</div>
					</div>
				</div>

				
				<!-- 附件信息 -->
				<div class="easyui-accordion"
					style="margin-left: 20px;margin-right: 20px;width: 693px">
					<div title="附件信息" data-options="collapsible:false"
						style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0"
							style="margin-top: 3px;width:690px;">
							<tr>
								<td class="td1" style="width:55px;text-align: left"><span
									class="style1">*</span> 附件:</td>
								<td colspan="3" id="tdf">
									<c:forEach items="${attaList}" var="att">
										<c:if test="${att.serviceType=='null'}">
											<div style="margin-top: 5px;">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
												&nbsp;&nbsp;&nbsp;&nbsp;
											</div>
										</c:if>
									</c:forEach>
								</td>
							</tr>
						</table>
				
					</div>
				</div>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
					<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../../check_history_reim_apply.jsp" />
					</div>
				</div>	
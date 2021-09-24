<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="confplan_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
					<div title="下达信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;审核人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fapproveUserName" name="fapproveUserName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fapproveUserName}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;审核时间</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fapproveTime" name="fapproveTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fapproveTime}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;审核意见</td>
								<td colspan="4">
									<textarea class="textbox-text" id="F_fapproveIdea" name="fapproveIdea" readonly="readonly" required="required" oninput="textareaNum(this,'textareaNum3')" autocomplete="off" style="width:555px;height:70px;resize:none">${bean.fapproveIdea }</textarea>
								</td>
							</tr>
						</table>
					</div>
					<!-- 第一个div -->
					<div title="配置计划信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购计划编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_flistNum"  name="flistNum"  style="width:200px;" readonly="readonly" required="required" data-options="validType:'length[1,50]'" value="${bean.flistNum}"/>
								</td>
								<td class="td4">
									<!-- 隐藏域 -->
									<!-- 上报阶段  1：一上   2：二上 -->
									<input type="hidden" id="cgconfplan_list_freportStage" name="freportStage" value="${bean.freportStage }" /> 
									
									<!-- 主键 -->					<input type="hidden" name="fplId" id="F_fplId" value="${bean.fplId}"/>
									<!-- 当前申报人id -->			<input type="hidden" name="freqUserId" value="${bean.freqUserId}" />
									<!-- 当前申报部门id -->		<input type="hidden" name="freqDeptId" value="${bean.freqDeptId}" />
									
									<!-- 采购的选择状态  -->			<input type="hidden" name="fisChecked" id="F_fisChecked" value="${bean.fisChecked}" />
									<!-- 数据状态  -->				<input type="hidden" name="fstauts" id="F_fstauts" value="${bean.fstauts}" />
									<!-- 配置申请的审批状态  -->		<input type="hidden" name="fcheckStauts" id="F_fcheckStauts" value="${bean.fcheckStauts}"/>
									
									<!-- 项目支出明细id -->		<input type="hidden" name="pid" id="F_pid" value="${bean.pid}" />
									<!-- 项目支出明细编码  -->		<input type="hidden" name="expCode" id="F_expCode" value="${bean.expCode}" />
									<!-- 项目支出明细科目编码  -->		<input type="hidden" name="subCode" id="F_subCode" value="${bean.subCode}" />
									
									<!-- 指标id -->				<input type="hidden" name="indexId" id="F_indexId" value="${bean.indexId}" />
									<!-- 指标编码 -->				<input type="hidden" name="indexName" id="F_indexCode value="${bean.indexCode}" />
												
									<!-- 当前审批人id -->			<input type="hidden" name="fuserId" value="${bean.userId}" />
	    							<!-- 当前审批人姓名  -->			<input type="hidden" name=fuserName value="${bean.userName2}" />
									<!-- 当前审批节点  -->			<input type="hidden" name="nCode" value="${bean.nCode}" />
												
									<!-- 审批结果 -->				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
									<!-- 审批意见 -->				<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
									<!-- 审批附件 -->				<input type="hidden" name="spjlFile" id="spjlFile" value=""/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_freqDept"  name="freqDept" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.freqDept}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
								<td class="td2">
									<input class="easyui-datebox" type="text" id="F_freqTime"  name="freqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.freqTime}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;配置采购类型</td>
								<td class="td2">
									<select class="easyui-combobox" id="F_fprocurType" name="fprocurType" readonly="readonly" required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
										<option value="A10" <c:if test="${bean.fprocurType=='A10'}">selected="selected"</c:if>>货物</option>
										<option value="A20" <c:if test="${bean.fprocurType=='A20'}">selected="selected"</c:if>>工程采购</option>
										<option value="A30" <c:if test="${bean.fprocurType=='A30'}">selected="selected"</c:if>>服务</option>
										<option value="A40" <c:if test="${bean.fprocurType=='A40'}">selected="selected"</c:if>>办公用品及耗材</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_freqLinkMen" readonly="readonly"  name="freqLinkMen"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.freqLinkMen}"/>
								</td>
								<td class="td4"></td>
								<td class="td1">&nbsp;&nbsp;联系人电话</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_flinkTel" readonly="readonly"  name="flinkTel" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.flinkTel}"/>
								</td>
							</tr>
							<tr >
								<td class="td1"><span class="style1">*</span>&nbsp;预算明细</td>
								<td colspan="4">
									<input id="F_subName" class="easyui-textbox" name="subName" readonly="readonly" data-options="prompt:'单击选择预算支出明细',validType:'length[1,32]'" value="${bean.subName}" style="width: 555px"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;预算金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_outAmount"  name="outAmount"   readonly="readonly"  data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.outAmount}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;一上申报金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_purFirstAmount"  name="purFirstAmount" readonly="readonly" required="required" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.purFirstAmount}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;支出项目</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_indexName" name="indexName" readonly="readonly" required="required" data-options="icons: [{iconCls:'icon-sousuo'}]" style="width: 555px;" value="${bean.indexName}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;指标可用金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_syAmount" name="syAmount" readonly="readonly" required="required" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.syAmount}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;二上申报金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_purSecondAmount" name="purSecondAmount" readonly="readonly" required="required" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.purSecondAmount}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;配置申请内容</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_freqContent" readonly="readonly"  name="freqContent"  data-options="validType:'length[1,200]',multiline:true"   style="width:555px;height:70px;" value="${bean.freqContent}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;备注</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fremark"  readonly="readonly" name="fremark"  data-options="validType:'length[1,200]',multiline:true"   style="width:555px;height:70px;" value="${bean.fremark}"/>
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
					<!-- 第2个div -->
					<div title="配置采购商品清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
					  	<jsp:include page="../mingxi/cgconf_plan_mingxi.jsp" />												
					</div>
					<!-- 第3个div -->
					<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow-x:hidden;margin-top: 10px;">
					  	<jsp:include page="../../../check_history.jsp" />												
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
		
	</div>
</form>
</div>
<script type="text/javascript">
	//审核
	function check(checkResult) {
	 	$('#confplan_check_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/cgconfplan/secondSaveCheck',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#confplan_check_tab').datagrid('reload'); 
					$('#indexdb').datagrid('reload');
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});	 
	}
</script>
</body>
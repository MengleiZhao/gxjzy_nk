<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>

<script type="text/javascript">

</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="width:1090px;height:500px;">
		<div style="height:1500px;"	data-options="region:'center'">
			<div class="easyui-accordion" style="width:800px;height:800px;">
				<div title="基本信息" data-options="collapsible:false"style="overflow:auto;padding:10px;">
					
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr>
							<td class="td1">单据编号</td>
							<td>
								<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gCode}" name="gCode" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr>
							<td class="td1"><span class="style1">*</span> 摘要名称</td>
							<td colspan="4">
								<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr>
							<td class="td1">申请事由</td>
							<td>
								<textarea name="reason" id="reason" class="textbox-text"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:590px;height:70px;resize:none">${bean.reason }</textarea>
							</td>
						</tr>
						<tr>
							<td class="td1">
								&nbsp;&nbsp;附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="4" id="tdf">
								<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
								</a>
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
									<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
									 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
								</div>
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
					
						
				</div>
				<div title="费用明细" data-options=""
					style="overflow:auto;padding:10px;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr>
							<td class="td1"><span class="style1">*</span> 费用名称</td>
							<td>
								<input class="easyui-textbox" style="width: 200px; height: 30px;" required="required" data-options="validType:'length[1,50]'"/>
							</td>
							<td>申请金额</td>
							<td>
								<input class="easyui-textbox" style="width: 200px; height: 30px;" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr>
							<td class="td1">备注</td>
							<td colspan="3">
								<textarea name="reason" id="reason" class="textbox-text"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:590px;height:70px;resize:none"></textarea>
							</td>
						</tr>
					</table>	
					<a>添加费用</a>
				</div>
				<div title="预算信息" data-options=""
					style="overflow:auto;padding:10px;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<a onclick="openIndex()" href="#">
								<input class="easyui-textbox" style="width: 590px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly" cellspacing="0" cellpadding="0">
						<tr>
							<td class="window-table-td1"><p>批复金额:</p></td>
							<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
							
							<td class="window-table-td1"><p>批复时间:</p></td>
							<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
						</tr>
						
						<tr>
							<td class="window-table-td1"><p>使用部门:</p></td>
							<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
							
							<td class="window-table-td1"><p>可用余额:</p></td>
							<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td>
						</tr>
					</table>
				</div>
				<div title="审批流转" data-options=""
					style="overflow:auto;padding:10px;">
					<div id="xjspr" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="nextrole.jsp" />
					</div>
				</div>
			</div>
		</div>
		<div
			data-options="region:'east',title:'流程审批'" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../../check_system.jsp" />
		</div>
		<div
			data-options="region:'south'"
			style="width:500px;height:300px;">
			<a href="javascript:void(0)" onclick="closeWindow()"> <img
				src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
				onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	</div>
	
	<!-- 隐藏域 --> 
	<!-- 主键ID --><input type="hidden" name="gId" value="${bean.gId}" />
	<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
	<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
	<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
	<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
	<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
	<!-- 申请类型 --><input type="hidden" id="applyTypeHi" value="${bean.type}" />
	<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
	<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="F_proDetailId"/>
	<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
	<!-- 申请时间  --><input type="hidden" id="applyReqTime" name="reqTime" value="${bean.reqTime}"/>
	<!-- 申请事项  --><input type="hidden" id="applyType" name="type" value="${bean.type}"/>
	<!-- 申请总额  --><input type="hidden" id="applyAmount" name="amount" value="${bean.amount}"/>
	<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
	<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
	<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
	<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
	<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
	<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
	</form>

</body>

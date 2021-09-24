<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<style type="text/css">
/*---滚动条默认显示样式--*/
::-webkit-scrollbar-thumb {
background-color: #e5f0f6;
height: 50px;
outline-offset: -2px;
outline: 2px solid #fff;
-webkit-border-radius: 15px;
border: 2px solid #fff;
}
	
/*---鼠标点击滚动条显示样式--*/
::-webkit-scrollbar-thumb:hover {
background-color: #cfdde4;
height: 50px;
-webkit-border-radius: 15px;
}
	
/*---滚动条大小--*/
::-webkit-scrollbar {
width: 16px;
height: 12px;
}
	
/*---滚动框背景样式--*/
::-webkit-scrollbar-track-piece {
background-color: #fff;
-webkit-border-radius: 0;
}
</style>
<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div" >
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="基本信息" data-options="collapsed:false,collapsible:false" style="margin-left: 20px;margin-right: 20px">
						<table class="ourtable" cellpadding="0" cellspacing="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款单号</td>
								<td colspan="4">
									<input style="width: 558px;height: 30px;" name="gCode" class="easyui-textbox"
									value="${bean.lCode}" data-options="required:true" readonly="readonly"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款单摘要</td>
								<td colspan="4">
									<input style="width: 558px;"
									id="" name="loanPurpose" class="easyui-textbox"
									value="${bean.loanPurpose}" readonly="readonly"/>
								</td>
							</tr>
							

							<tr class="trbody">
							
								<td class="td1"><span class="style1">*</span> 借款金额</td>
								<td class="td2">
									<input style="width: 200px;" id="lAmount" name="lAmount" class="easyui-numberbox" 
									value="${bean.lAmount}" precision="2" data-options="icons: [{iconCls:'icon-yuan'}],formatter:function(value,row,index){return fomatMoney(value,2);}" readonly="readonly"/>
								</td>

								<td class="td4"></td>

								<td class="td1"><span class="style1">*</span> 计划还款时间</td>

								<td class="td2">
									<input style="width: 200px;"
									name="estChargeTime" class="easyui-datebox"
									value="${bean.estChargeTime}" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款人</td>
								<td class="td2">
									<input style="width: 200px;" name="userName" class="easyui-textbox"
									value="${bean.userName}" readonly="readonly"/>
								<td class="td4">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="lId" value="${bean.lId}" />
									<!-- 借款单编号 --><input type="hidden" name="lCode" value="${bean.lCode}" />
									<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="loanflowStauts"/> 
									<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="loanStauts" />
									<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}"/>
									<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
									<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
									<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
								</td>

								<td class="td1"><span class="style1">*</span> 所属部门</td>
								<td class="td2">
									<input style="width: 200px;"
									value="${bean.deptName}" readonly="readonly"
									name="deptName" class="easyui-textbox" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款时间</td>
								<td class="td2">
									<input style="width: 200px;"
									id="loanReqTime" name="reqTime" class="easyui-datebox"
									value="${bean.reqTime}" readonly="readonly"/>
								</td>
							</tr>
							
							
							<tr style="height:5px;"></tr>

							<tr style="height: 70px;">
								<td class="td1" valign="top"><span class="style1">*</span>借款事由</td>
								<td colspan="4">
									<input class="easyui-textbox"
									data-options="multiline:true" name="loanReason"
									style="width:555px;height:70px" value="${bean.loanReason}" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="margin-left: 20px;margin-right: 20px">
						<jsp:include page="../payee-info-detail-loan.jsp" />
					</div>
					
					<div title="审批记录" data-options="collapsed:false,collapsible:false" style="margin-left: 20px;margin-right: 20px">
						<jsp:include page="../../check_history.jsp" />												
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div>
</div>
</body>
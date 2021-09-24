<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="allocaAPPAddEditForm" action="${base}/Alloca/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_A" id="A_fId_A" value="${bean.fId_A}"/>
		    	<input type="hidden" name="fFlowStauts" id="A_fFlowStauts" value="${bean.fFlowStauts}"/>
		    	<input type="hidden" name="fAllocaStauts" id="A_fAllocaStauts" value="${bean.fAllocaStauts}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="调拨单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产调拨单号</td>
										<td  colspan="4">
											<input id="A_fAssAllcoaCode" required="required" class="easyui-textbox" type="text" readonly="readonly" name="fAssAllcoaCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fAssAllcoaCode}" style="width: 555px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>调入部门</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput"  id="A_fInDept" name="fInDept" readonly="readonly" data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" value="${bean.fInDept }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>调出部门</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput"  id="A_fOutDept" name="fOutDept" readonly="readonly" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fOutDept}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>调入日期</td>
										<td class="td2">
											<input class="easyui-datebox" required="required" class="dfinput"  id="A_fInTime" name="fInTime" readonly="readonly" data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" value="${bean.fInTime }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>调出日期</td>
										<td class="td2">
											<input class="easyui-datebox" required="required" class="dfinput"  id="A_fOutTime" name="fOutTime" readonly="readonly" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fOutTime}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>调入经办人</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput"  id="A_fInUser" name="fInUser" readonly="readonly" data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" value="${bean.fInUser }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>调出经办人</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput"  id="A_fOutUser" name="fOutUser" readonly="readonly" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fOutUser}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>合计数量</td>
										<td class="td2">
											<input class="easyui-numberbox" required="required" class="dfinput" readonly="readonly" id="A_fSumNumber" name="fSumNumber"  data-options="prompt:'',validType:'length[1,25]',precision:0" style="width: 200px" value="${bean.fSumNumber }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>合计总值(元)</td>
										<td class="td2">
											<input class="easyui-numberbox" required="required" class="dfinput" readonly="readonly" id="A_fSumAmount" name="fSumAmount"  data-options="icons: [{iconCls:'icon-yuan'}],validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fSumAmount}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;申请部门</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput" readonly="readonly" id="A_fRecDept" name="fRecDept"  data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" value="${bean.fRecDept }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;申请人</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput" readonly="readonly" id="A_fRecUser" name="fRecUser"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fRecUser}"/>
										</td>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>资产内部转移原因</p></td>
										<td  colspan="4">
											<%-- <input class="easyui-textbox" data-options="validType:'length[1,200]',multiline:true" id="A_fAllocaRemark"
											 name="fAllocaRemark" style="width: 555px;height:70px" value="${bean.fAllocaRemark}">  --%> 
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
											
											
											<textarea name="fAllocaRemark"  id="A_fAllocaRemark"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 555px;height:70px;resize:none">${bean.fAllocaRemark }</textarea>
										</td>
									</tr>	
									<c:if test="${openType=='add'||openType=='edit'}">
										<tr>
											<td align="right" colspan="5" style="padding-right: 0px;">
											可输入剩余数：<span id="textareaNum1" class="200">
												<c:if test="${empty bean.fAllocaRemark}">200</c:if>
												<c:if test="${!empty bean.fAllocaRemark}">${200-bean.fAllocaRemark.length()}</c:if>
											</span>
											</td>
										</tr>
									</c:if>	
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fzcdb" onchange="upladFile(this,'allocaFlies','zcagl01')" hidden="hidden">
											<input type="text" id="files" name="allocaFlies" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fzcdb').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
											 </div>
											<c:forEach items="${allocaListFiles}" var="att">
												<c:if test="${att.serviceType=='allocaFlies' }">
													<div style="margin-top: 10px;">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<c:if test="${openType=='add'||openType=='edit'}">
													<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if>
													</div>
												</c:if>
											</c:forEach>
										</td>
									</tr>
								</table>	
							</div>
							<div title="调拨清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="alloca_base_approval_plan.jsp" />												
							</div>
							<c:if test="${checkinfo==1}">
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../../check_history.jsp" />												
							</div>
							</c:if>
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='app'}">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='detail'}">
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='ledger'}">
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
function check(stauts){
	var r=$('#A_fRemark').val();
	$('#allocaAPPAddEditForm').form('submit', {
			onSubmit: function(){ 
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:'${base}/Alloca/approvel/'+stauts,
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#allocaAPPAddEditForm').form('clear');
					$("#allcoa_approval_dg").datagrid('reload'); 
					$("#indexdb").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});		
}
function fReceCode(){
	var win=creatFirstWin('原配置单号',840,450,'icon-search','/Alloca/receCodeList');
	win.window('open');
}
//弹出选择资产的页面
function chooseAss(){
	var win=creatFirstWin('选择调拨资产',970,560,'icon-search','/Alloca/choose');
	win.window('open');
}
function fTransUser(){
	var win=creatFirstWin('姓名部门',840,450,'icon-search','/Alloca/nameAndDept');
	win.window('open');
}
function quota_DC(){
	//var node=$('#allcoa_dg').datagrid('getSelected');
	var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
	win.window('open');
}
$("#A_fInTime").datebox({
    onSelect : function(beginDate){
        $('#A_fOutTime').datebox().datebox('calendar').calendar({
            validator: function(date){
            	return beginDate <= date;
            }
        });
    }
});
</script>
</body>
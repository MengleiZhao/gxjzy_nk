<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="cgapply_receive_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
							<!-- 第一个div -->
								<div title="采购信息" data-options="iconCls:'icon-xxlb'"
									style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable">
										<!-- 表单样式参考 -->
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>采购批次编号</td>
											<td class="td2">
												<input id="F_fpCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fpCode" data-options="validType:'length[1,30]'" style="width: 200px" value="${bean.fpCode}"/>
											</td>
											<td class="td4">												
												<!-- 隐藏域 --> 
												<input type="hidden" name="fplId" id="F_fplId" value="${bean.fplId}"/><!--配置计划的主键id  -->
												<input type="hidden" name="ftendingStauts" id="F_ftendingStauts" value="${bean.ftendingStauts}"/><!--招标状态  -->
												<input type="hidden" name="fpId" id="F_fcId" value="${bean.fpId}"/>
	    										<input type="hidden" name="fCheckStauts" id="F_fCheckStauts" value="${bean.fCheckStauts}"/><!--当前审批状态  -->
	    										<input type="hidden" name="fbidStauts" id="F_fbidStauts" value="${bean.fbidStauts}"/><!--中标状态  --> 
	    										<input type="hidden" name="fStauts" id="F_fStauts" value="${bean.fStauts}"/><!--数据的删除状态  --> 
	    										<input type="hidden" name="fIsReceive" id="F_fIsReceive" value="${bean.fIsReceive}"/><!--验收状态  -->
	    										<input type="hidden" name="fpayStauts" id="F_fpayStauts" value="${bean.fpayStauts}"/><!--付款申请的审批状态  -->
							    				<input type="hidden" name="fevalStauts" id="F_fevalStauts" value="${bean.fevalStauts}"/><!--供应商的评价状态  -->
	    										<input type="hidden" name=fuserName value="${bean.userName2}" /><!--当前审批人姓名  -->
												<input type="hidden" name="fuserId" value="${bean.userId}" /><!--当前审批人id  -->
												<input type="hidden" name="nCode" value="${bean.nCode}" /><!--当前审批节点  -->
												<input type="hidden" name="fIsImp" value="${bean.fIsImp}" /><!--进出口货物服务 -->
												<!-- 支出科目类型 --><input type="hidden" name="indexType" value="${bean.indexType}"/>
												<!-- 支出科目编号--><input type="hidden" name="indexCode" value="${bean.indexCode}"/>
												<!-- 支出科目名称--><input type="hidden" name="indexName" value="${bean.indexName}"/>
												<!-- 采购名称名称--><input type="hidden" name="fpName" value="${bean.fpName}"/>
												<!-- 审批结果 -->
									    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
									    		<!-- 审批意见 -->
											    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
											    <!-- 审批附件 -->
											    <input type="hidden" name="spjlFile" id="spjlFile" value=""/>
											</td>

											<td class="td1"><span class="style1">*</span>申请人</td>
											<td class="td2">
												<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fUserName}"/>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>申报部门</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly"  name="fDeptName"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fDeptName}"/>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>采购金额</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpAmount" readonly="readonly"  name="fpAmount" required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${bean.fpAmount}"/>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>组织形式</td>
											<td class="td2">
												<input id="F_fOrgType" name="fOrgType.code" readonly="readonly"   class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE&selected=${bean.fOrgType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>申请时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_fReqTime" readonly="readonly"  name="fReqTime" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${bean.fReqTime}"/>
											</td>
										</tr>

										<%-- <tr class="trbody">
											<td class="td1"><span class="style1">*</span>评价方法</td>
											<td class="td2">
												<input id="F_fEvaMethod" name="fEvaMethod.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=BID_METHOD&selected=${bean.fEvaMethod.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>采购方式</td>
											<td class="td2">
												<input id="F_fpMethod" name="fpMethod.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=PURCHASE_METHOD&selected=${bean.fpMethod.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td>
										</tr> --%>

										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">采购说明</p></td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fRemark"  readonly="readonly" name="fRemark" data-options="validType:'length[1,500]',multiline:true"   style="width:555px;height:70px;" value="${bean.fRemark}"/>
											</td>
										</tr>
										
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>进口货物服务</td>
											<td colspan="4">
												<span>
               										<input type="radio"  name="IsImp" disabled="disabled" <c:if test="${bean.fIsImp=='0'}">checked="checked"</c:if> value="0">否</input>
                									<input type="radio" name="IsImp" disabled="disabled" <c:if test="${bean.fIsImp=='1'}">checked="checked"</c:if> value="1">是</input>
           										 </span>										
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

																<!--第二个div  -->
								<div title="采购需求" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">其他需求</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fOtherRemark" readonly="readonly"  name="fOtherRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fOtherRemark}"/>
											</td>
										</tr>
									</table>
								</div>
														<!-- 第三个div -->
								<div title="采购清单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							  		<jsp:include page="../purchase/select_cgconf_plan_mingxi.jsp" /> 												
								</div>
														<!-- 第四个div -->
								<%-- <div title="采购审批记录(只读)" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							  		<jsp:include page="../check/check_history.jsp" />												
								</div> --%>
								<div title="验收记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							  		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>验收人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_facpUser" readonly="readonly"  name="facpUser"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${historybean.facpUser}"/>
											</td>
											
											<td class="td4"></td>
											
											<td class="td1"><span class="style1">*</span>验收时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_facpTime"  name="facpTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${historybean.facpTime}"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>质量</td>
											<td class="td2">
												<select class="easyui-combobox" id="F_fqualityIsOk" name="fqualityIsOk" readonly="readonly" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
													<option value="">--请选择--</option>
													<option value="1" <c:if test="${historybean.fqualityIsOk=='1'}">selected="selected"</c:if>>合格</option>
													<option value="2" <c:if test="${historybean.fqualityIsOk=='0'}">selected="selected"</c:if>>不合格</option>
												</select>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>验收结果</td>
											<td class="td2">
												<select class="easyui-combobox" id="F_fisMatch" name="fisMatch" readonly="readonly" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
													<option value="">--请选择--</option>
													<option value="1" <c:if test="${historybean.fisMatch=='1'}">selected="selected"</c:if>>通过</option>
													<option value="2" <c:if test="${historybean.fisMatch=='0'}">selected="selected"</c:if>>不通过</option>
												</select>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>验收地点</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_facpAddr"  name="facpAddr" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 555px" value="${historybean.facpAddr}"/>
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">质量说明</p></td>
											<td class="td2" colspan="4">
												<input class="easyui-textbox" type="text" id="F_fqualityRemark" readonly="readonly"  name="fqualityRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${historybean.fqualityRemark}"/>
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">验收说明</p></td>
											<td class="td2" colspan="4">
												<input class="easyui-textbox" type="text" id="F_fmatchRemark" readonly="readonly"  name="fmatchRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${historybean.fmatchRemark}"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1">附件</td>
											<td colspan="4">
											<c:if test="${!empty hisattac}">
											<c:forEach items="${hisattac}" var="att">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
											</c:forEach>
											</c:if>
											<c:if test="${empty hisattac}">
												<span style="color:#999999">暂未上传附件</span>
											</c:if>
										</tr>
									</table>												
								</div>
								
														<!--第五个div  -->
								<div title="供应商信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>供应商名称</td>
											<td colspan="4">
												<input class="easyui-textbox" id="F_fwName"  name="fwName"  readonly="readonly"  style="width:555px;height:30px;" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkSel()}}]" value="${fwbean.fwName}"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>办公地址</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fwAddr"  name="fwAddr" readonly="readonly" required="required" data-options="validType:'length[1,200]'" style="width:555px;height:30px;" value="${fwbean.fwAddr}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>联系人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwuserName"  name="fwuserName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwuserName}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>联系人电话</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwTel"  name="fwTel" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwTel}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>收款人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeName"  name="fpayeeName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeName}"/>
											</td>
											<td style="width: 0px"></td>
											<td class="td1"><span class="style1">*</span>收款人身份证</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeIdCard"  name="fpayeeIdCard" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeIdCard}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>开户行</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeBank"  name="fpayeeBank" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeBank}"/>
											</td>
											<td style="width: 0px"></td>
											<td class="td1"><span class="style1">*</span>收款账号</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeAccount"  name="fpayeeAccount" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeAccount}"/>
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>备注</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fwRemark"  name="fwRemark" readonly="readonly" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${fwbean.fwRemark}"/>
											</td>
										</tr>
									</table>
								</div>
														<!-- 第六个div -->
								<div title="验收记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							  		<jsp:include page="../receive/receive_history.jsp" />												
								</div>
														<!-- 第七个div -->
								<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../../check_history.jsp" />												
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
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
	<script type="text/javascript">
	
	//审核
	function check(checkResult) {
	 	$('#cgapply_receive_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/cgpayforcheck/checkResult',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$('#cgapply_receive_form').form('clear');
					$('#check_payfor_receive_tab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#cgapply_receive_form').form('clear');
				}
			}
		});
	}
	
	//查看附件
	function findAttacFile(id) {
		$.ajax({ 
			url: base+"/cgsqsp/attacFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	}
	
	
	 //寻找相关制度
	function findSystemFile(id) {
		$.ajax({ 
			url: base+"/cheter/systemFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	} 
	 
	
	</script>
</body>
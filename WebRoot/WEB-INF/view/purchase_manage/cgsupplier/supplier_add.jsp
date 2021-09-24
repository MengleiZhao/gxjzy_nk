<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="supplier_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
																	<!-- 第一个div -->
								<div title="供应商信息"   id="gjsxxdiv" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span> 供应商名称</td>
											<td colspan="4">
												<input class="easyui-textbox" id="F_fwName"  name="fwName"  style="width:555px;" required="required" data-options="validType:'length[1,100]'" value="${fwbean.fwName}"/>
												<input type="hidden" name="fwId" id="F_fwId" value="${fwbean.fwId}"/><!--隐藏域  -->
												<input type="hidden" name="fcheckStauts" id="F_fcheckStauts" value="${fwbean.fcheckStauts}"/><!--供应商申请的审批状态  -->
												<input type="hidden" name="fisBlack" value="${fwbean.fisBlack}" /><!--是否黑名单  -->
												<input type="hidden" name="fstauts" value="${fwbean.fstauts}" /><!--数据的删除状态  -->
												<input type="hidden" name="faccFreq" value="${fwbean.faccFreq}" /><!--拉黑次数 -->
												<input type="hidden" name="fRecUserId" value="${fwbean.fRecUserId}" />
												<input type="hidden" name="fcheckType" value="in" /><!-- 审批类型 入库 -->
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span> 办公地址</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fwAddr"  name="fwAddr"  required="required" data-options="validType:'length[1,100]'" style="width:555px;" value="${fwbean.fwAddr}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 供应商编码</td>
											<td class="td2">
												<c:if test="${empty fwbean.fwId}">
													<input class="easyui-textbox" type="text" id="F_fwCode"  name="fwCode" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwcode}"/>
												</c:if>
												<c:if test="${!empty fwbean.fwId}">
													<input class="easyui-textbox" type="text" id="F_fwCode"  name="fwCode" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwCode}"/>
												</c:if>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span> 供应商简称</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwNameShort"  name="fwNameShort"  required="required" data-options="validType:'length[1,16]'" style="width: 200px" value="${fwbean.fwNameShort}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 行业</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_findustry"  name="findustry"  required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${fwbean.findustry}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span> 法人代表</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fLegalRep"  name="fLegalRep"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fLegalRep}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 公司规模</td>
											<td class="td2">
												<c:if test="${empty fwbean.fwId}">
													<input id="F_fcompanySize" name="fcompanySize.code" required="required"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=COMPANY_SIZE',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'" />
												</c:if>
												<c:if test="${!empty fwbean.fwId}">
													<input id="F_fcompanySize" name="fcompanySize.code" required="required"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=COMPANY_SIZE&selected=${fwbean.fcompanySize.code}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
												</c:if>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span> 公司性质</td>
											<td class="td2">
												<c:if test="${empty fwbean.fwId}">
													<input id="F_fcompanyNature" name="fcompanyNature.code" required="required" class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=COMPANY_NATURE',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'" />
												</c:if>
												<c:if test="${!empty fwbean.fwId}">
													<input id="F_fcompanyNature" name="fcompanyNature.code"  required="required" class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=COMPANY_NATURE&selected=${fwbean.fcompanyNature.code}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 成立日期</td>
											<td class="td2">
												<input class="easyui-datebox" type="text" id="F_festablistDate"  name="festablistDate"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" editable="false" value="${fwbean.festablistDate}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span> 注册资本</td>
											<td class="td2">
												<input class="easyui-numberbox" type="text" id="F_fregistCapital"  name="fregistCapital"  required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${fwbean.fregistCapital}"/>
											</td>
										</tr>
										
										<tr>
											<td class="td1"><span class="style1">*</span> 联系人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwuserName"  name="fwuserName"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwuserName}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span> 联系人电话</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwTel"  name="fwTel"  required="required" data-options="validType:'tel'" style="width: 200px" value="${fwbean.fwTel}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 收款人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeName"  name="fpayeeName"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeName}"/>
											</td>
											<td style="width: 0px"></td>
											<td class="td1"><span class="style1">*</span> 收款人身份证</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeIdCard"  name="fpayeeIdCard"  required="required" data-options="validType:'idCode'" style="width: 200px" value="${fwbean.fpayeeIdCard}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 开户行</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeBank"  name="fpayeeBank"  required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${fwbean.fpayeeBank}"/>
											</td>
											<td style="width: 0px"></td>
											<td class="td1"><span class="style1">*</span> 收款账号</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpayeeAccount"  name="fpayeeAccount"  required="required" data-options="validType:'BankCardID'" style="width: 200px" value="${fwbean.fpayeeAccount}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span> 工商登记号</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fregistNumber"  name="fregistNumber"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fregistNumber}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"></td>
											<td class="td2">
											</td>
										</tr>
										<tr style="height: 78px;">
											<td class="td1"  valign="top"><span class="style1">*</span> 经营范围</td>
											<td class="td2" colspan="4">
												<textarea name="fbusinessScope"  id="F_fbusinessScope"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${fwbean.fbusinessScope }</textarea> 
												<%-- <input class="easyui-textbox" type="text" id="F_fbusinessScope"  name="fbusinessScope"  required="required"  style="width:555px;height:70px;" value="${fwbean.fbusinessScope}"
												data-options="multiline:true,required:false,validType:'length[0,200]'"
												/> --%>
											</td>
										</tr>
										<c:if test="${operType=='add'||operType=='edit' }">
											<tr>
												<td align="right" colspan="6" style="padding-right: 0px;">
												可输入剩余数：<span id="textareaNum1" class="200">
													<c:if test="${empty fwbean.fbusinessScope}">200</c:if>
													<c:if test="${!empty fwbean.fbusinessScope}">${200-fwbean.fbusinessScope.length()}</c:if>
												</span>
												</td>
											</tr>
										</c:if>
										<tr>
											<td class="td1" valign="top">备注</td>
											<td colspan="4">
												<textarea name="fwRemark"  id="F_fwRemark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum2')" autocomplete="off"   style="width:555px;height:70px;resize:none">${fwbean.fwRemark }</textarea> 
												<%-- 
												<input class="easyui-textbox" type="text" id="F_fwRemark"  name="fwRemark"    style="width:555px;height:70px;" value="${fwbean.fwRemark}"
												data-options="multiline:true,required:false,validType:'length[0,200]'"
												/> --%>
											</td>
										</tr>
										<c:if test="${operType=='add'||operType=='edit' }">
											<tr>
												<td align="right" colspan="6" style="padding-right: 0px;">
												可输入剩余数：<span id="textareaNum2" class="200">
													<c:if test="${empty fwbean.fwRemark}">200</c:if>
													<c:if test="${!empty fwbean.fwRemark}">${200-fwbean.fwRemark.length()}</c:if>
												</span>
												</td>
											</tr>
										</c:if>
									</table>
								</div>
								<c:if test="${!empty fwbean.fwId}">
									<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
										<jsp:include page="../../check_history.jsp" />												
									</div>
								</c:if>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveSupplier(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveSupplier(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=采购管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
	//保存
	function saveSupplier(fcheckStauts) {
		//设置审批状态
		$('#F_fcheckStauts').val(fcheckStauts);
		//验证成立日期
		var F_festablistDate=$('#F_festablistDate').val();
		if(F_festablistDate!="" && !isdate(F_festablistDate)){
			alert("成立日期格式不正确");
			return false;
		}
		
		 //提交
		$('#supplier_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
			},
			url : base + '/suppliergl/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#supplier_save_form").form("clear");
					 $("#supplier_data_tb").datagrid("reload");
					 $("#indexdb").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#supplier_save_form').form('clear');
				}
			}
		}); 	
	}
		
	</script>
</body>
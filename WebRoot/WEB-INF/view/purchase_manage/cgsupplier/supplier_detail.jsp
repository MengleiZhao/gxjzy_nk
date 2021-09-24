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
					<div title="供应商信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>供应商名称</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fwName"  name="fwName" readonly="readonly" style="width:555px;" data-options="validType:'length[1,50]'" value="${fwbean.fwName}"/>
									<input type="hidden" name="fwId" id="F_fwId" value="${fwbean.fwId}"/><!--隐藏域  -->
									<input type="hidden" name="fcheckStauts" id="F_fcheckStauts" value="${fwbean.fcheckStauts}"/><!--供应商申请的审批状态  -->
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>办公地址</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fwAddr" readonly="readonly" name="fwAddr"  required="required" data-options="validType:'length[1,50]'" style="width:555px;" value="${fwbean.fwAddr}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>供应商编码</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fwCode"  name="fwCode" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwCode}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>供应商简称</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fwNameShort"  name="fwNameShort" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwNameShort}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>行业</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_findustry"  name="findustry" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.findustry}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>法人代表</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fLegalRep"  name="fLegalRep" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fLegalRep}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>公司规模</td>
								<td class="td2">
									<input id="F_fcompanySize" name="fcompanySize.code" readonly="readonly"   class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=COMPANY_SIZE&selected=${fwbean.fcompanySize.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>公司性质</td>
								<td class="td2">
									<input id="F_fcompanyNature" name="fcompanyNature.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=COMPANY_NATURE&selected=${fwbean.fcompanyNature.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>成立日期</td>
								<td class="td2">
									<input class="easyui-datebox" type="text" id="F_festablistDate" readonly="readonly"  name="festablistDate"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.festablistDate}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>注册资本</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fregistCapital"  name="fregistCapital" readonly="readonly"  required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${fwbean.fregistCapital}"/>
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
									<input class="easyui-textbox" type="text" id="F_fpayeeName"  name="fpayeeName" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeName}"/>
								</td>
								<td style="width: 0px"></td>
								<td class="td1"><span class="style1">*</span>收款人身份证</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fpayeeIdCard"  name="fpayeeIdCard" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeIdCard}"/>
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
									<input class="easyui-textbox" type="text" id="F_fpayeeAccount"  name="fpayeeAccount" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fpayeeAccount}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>工商登记号</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fregistNumber"  name="fregistNumber" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fregistNumber}"/>
								</td>
							</tr>
							<tr style="height:78px;">
								<td class="td1" valign="top"><span class="style1">*</span>经营范围</td>
								<td class="td2" colspan="4">
									<input class="easyui-textbox" type="text" id="F_fbusinessScope"  name="fbusinessScope" readonly="readonly" required="required"  style="width:555px;height:70px;" value="${fwbean.fbusinessScope}"
									data-options="multiline:true,required:false,validType:'length[0,200]'"
									/>
								</td>
							</tr>
							<c:if test="${fwbean.fcheckType=='out'}">	<!-- 出庫 -->
								<tr style="height:78px;">
									<c:if test="${bean.fflag==1}">
										<td class="td1" valign="top"><span class="style1">*</span>出库原因</td>
									</c:if>
									<c:if test="${bean.fflag==2}">
									<td class="td1" valign="top"><span class="style1">*</span>入库原因</td>
									</c:if>
									<td colspan="4">
										<input class="easyui-textbox" type="text" id="F_foutMsg"  name="foutMsg" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${fwbean.foutMsg}"/>
									</td>
								</tr>
							</c:if>
							<c:if test="${fwbean.fcheckType=='black'}">	<!-- 黑名单 -->
								<tr style="height:78px;">
									<c:if test="${bean.fFlag==1}">
										<td class="td1"valign="top"><span class="style1">*</span>移入黑名单原因</td>
									</c:if>
									<c:if test="${bean.fFlag==2}">
										<td class="td1"valign="top"><span class="style1">*</span>移出黑名单原因</td>
									</c:if>
									<td class="td2" colspan="4">
										<input class="easyui-textbox" type="text" id="F_fblackDesc"  name="fblackDesc" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${fwbean.fblackDesc}"/>
									</td>
								</tr>
							</c:if>
							<c:if test="${fwbean.fcheckType=='in'}">
								<c:if test="${fwbean.fisBlackStatus==1||fwbean.fisBlackStatus==-1}">
									<c:if test="${bean.fFlag==1}">
										<td class="td1"valign="top"><span class="style1">*</span>移入黑名单原因</td>
									</c:if>
									<c:if test="${bean.fFlag==2}">
										<td class="td1"valign="top"><span class="style1">*</span>移出黑名单原因</td>
									</c:if>
									<td class="td2" colspan="4">
										<input class="easyui-textbox" type="text" id="F_fblackDesc"  name="fblackDesc" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${fwbean.fblackDesc}"/>
									</td>
								</c:if>
								<c:if test="${fwbean.fisOutStatus==1 || fwbean.fisOutStatus==9}">
									<tr style="height:78px;">
										<td class="td1" valign="top"><span class="style1">*</span>入库原因</td>
										<td colspan="4">
											<input class="easyui-textbox" type="text" id="F_foutMsg"  name="foutMsg" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${fwbean.foutMsg}"/>
										</td>
									</tr>
								</c:if>
							</c:if>
							<tr style="height: 80px;">
								<td class="td1" valign="top">备注</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fwRemark"  name="fwRemark" readonly="readonly" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${fwbean.fwRemark}"/>
								</td>
							</tr>
						</table>
					</div>
					<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../check_history.jsp" />												
					</div>
					<div title="黑名单记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					  	<jsp:include page="supplier_black_history.jsp" />												
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
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

	</script>
</body>
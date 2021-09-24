<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="cgsq_apply_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
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
												<input type="hidden" name="fpId" id="F_fcId" value="${bean.fpId}"/>
							    				<input type="hidden" name="fCheckStauts" id="F_fCheckStauts" value="${bean.fCheckStauts}"/><!--采购审批状态  -->
							    				<input type="hidden" name="fStauts" id="F_fStauts" value="${bean.fStauts}"/><!--采购数据的删除状态  -->
							    				<input type="hidden" name="fIsReceive" id="F_fIsReceive" value="${bean.fIsReceive}"/><!--验收状态  -->
							    				<input type="hidden" name="fbidStauts" id="F_fbidStauts" value="${bean.fbidStauts}"/><!--中标状态  -->
							    				<input type="hidden" name="fpayStauts" id="F_fpayStauts" value="${bean.fpayStauts}"/><!--付款申请的审批状态  -->
							    				<input type="hidden" name="fevalStauts" id="F_fevalStauts" value="${bean.fevalStauts}"/><!--供应商的评价状态  -->
											</td>

											<td class="td1"><span class="style1">*</span>采购名称</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpName" readonly="readonly"  name="fpName" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fpName}"/>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>申请人</td>
											<td class="td2">
												<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fUserName}"/>
											</td>
											
											<td style="width: 0px"></td>
										
											<td class="td1"><span class="style1">*</span>申报部门</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly"  name="fDeptName"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fDeptName}"/>
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
												<input class="easyui-datebox" class="dfinput" id="F_fReqTime"  name="fReqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${bean.fReqTime}"/>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>评价方法</td>
											<td class="td2">
												<input id="F_fEvaMethod" name="fEvaMethod.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=BID_METHOD&selected=${bean.fEvaMethod.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td>

											<td style="width: 0px"></td>

											<%-- <td class="td1"><span class="style1">*</span>采购方式</td>
											<td class="td2">
												<input id="F_fpMethod" name="fpMethod.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=PURCHASE_METHOD&selected=${bean.fpMethod.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td> --%>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>资金来源</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_indexName"  name="indexName" readonly="readonly" required="required"  style="width: 200px" value="${bean.indexName}"/>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>采购金额</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpAmount"  name="fpAmount" readonly="readonly" required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${bean.fpAmount}"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>进口货物服务</td>
											<td colspan="4">
												<span>
               										<input type="radio"  name="fIsImp" disabled="disabled" <c:if test="${bean.fIsImp=='0'}">checked="checked"</c:if> value="0">否</input>
                									<input type="radio" name="fIsImp" disabled="disabled" <c:if test="${bean.fIsImp=='1'}">checked="checked"</c:if> value="1">是</input>
           										 </span>										
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">采购说明</p></td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fRemark"  name="fRemark" readonly="readonly" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fRemark}"/>
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
 							  		<jsp:include page="../../purchase_manage/purchase/select_cgconf_plan_mingxi.jsp" />												
								</div>
														<!-- 第四个div -->
								<div title="采购审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							  		<jsp:include page="../../purchase_manage/check/check_history.jsp" />		
								</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeSecondWindow()">
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
/* 	$(document).ready(function () {  //设置类型只能选择一次
	$("#F_fprocurType").combobox({
		onChange: function (newVal,oldVal) {
			if(newVal=="0"){//请选择不做处理
				return false;
			}else{//其他类型进行提示
				if (confirm("选择后将不可更改，请确认！")) {
					 $("#F_fprocurType").combobox('setValue',newVal);
					 //$('#F_fprocurType').combobox('disable');
					 $("#F_fprocurType").combobox('readonly',true);
				}else{
					return false;
				}
			}
		}
	});
}); */ 
	
	
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
	
	</script>
</body>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table cellpadding="0" cellspacing="0" class="ourtable" style="width:700px;height:auto">
	<!-- 表单样式参考 -->
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;采购批次编号</td>
		<td class="td2">
			<input id="F_fpCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fpCode" data-options="validType:'length[1,30]'" style="width: 200px" value="${bean.fpCode}"/>
		</td>
		<td class="td4">
		</td>
		<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
		<td class="td2">
			<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fUserName}"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;申报部门</td>
		<td class="td2">
			<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly"  name="fDeptName"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fDeptName}"/>
		</td>
		<td style="width: 0px"></td>
		<td class="td1"><span class="style1">*</span>&nbsp;申请时间</td>
		<td class="td2">
			<input class="easyui-datebox" class="dfinput" id="F_fReqTime"  name="fReqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${bean.fReqTime}"/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;采购类型</td>
		<td class="td2">
			<select class="easyui-combobox" id="F_fpPype" name="fpPype" readonly="readonly" required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
				<option value="">--请选择--</option>
				<option value="A10" <c:if test="${bean.fpPype=='A10'}">selected="selected"</c:if>>货物采购</option>
				<option value="A20" <c:if test="${bean.fpPype=='A20'}">selected="selected"</c:if>>工程采购</option>
				<option value="A30" <c:if test="${bean.fpPype=='A30'}">selected="selected"</c:if>>服务采购</option>
				<option value="A40" <c:if test="${bean.fpPype=='A40'}">selected="selected"</c:if>>办公用品及耗材</option>
			</select>											
		</td>
	</tr>
		
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;采购名称</td>
		<td colspan="4">
			<input class="easyui-textbox" type="text" id="F_fpName" readonly="readonly"  name="fpName" required="required" data-options="validType:'length[1,20]'" style="width: 555px" value="${bean.fpName}"/>
		</td>
	</tr>

	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;组织形式</td>
		<td class="td2">
			<input id="F_fOrgType" name="fOrgType.code" readonly="readonly"   class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE&selected=${bean.fOrgType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
		</td>
		
		<td style="width: 0px"></td>
		
		<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
		<td class="td2">
			<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_1'}">
				<input id="F_fpMethod" name="fpMethod.code" readonly="readonly"  class="easyui-combobox" 
				style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=JZCGFS&selected=${bean.fpMethod.code}',
				method:'get',valueField:'code',textField:'text',editable:false"  />
			</c:if>
			<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_2'}">
				<input id="F_fpMethod" name="fpMethod.code" readonly="readonly"  class="easyui-combobox" 
				style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS&selected=${bean.fpMethod.code}',
				method:'get',valueField:'code',textField:'text',editable:false"  />
			</c:if>
		</td>

	</tr> --%>
	
	<tr class="trbody">	
		<%-- <td class="td1">意向代理机构</td>
		<td class="td2">
			<input class="easyui-textbox" type="text" id="fAgencyName"  readonly="readonly"  name="fAgencyName"   style="width: 200px" value="${bean.fAgencyName}"/>
		</td> --%>
		
		<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
		<td class="td2">
			<input class="easyui-textbox" type="text" id="F_fpMethod"  name="fpMethod" readonly="readonly" data-options="prompt:'请到审批人页面填写',validType:'length[1,20]'" style="width: 200px" value="${bean.fpmethod}"/>
		</td>
		<td style="width: 0px">&nbsp;</td>
		<td class="td1"><span class="style1">*</span>&nbsp;采购金额</td>
		<td class="td2">
			<input class="easyui-textbox" type="text" id="F_fpAmount"  name="fpAmount" readonly="readonly" required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${bean.fpAmount}"/>
		</td>
	</tr>
		
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;进口产品</td>
		<td class="td2">
			<input type="radio" name="fIsImp" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsImp=='1'}">checked="checked"</c:if> value="1">是</input>
			<input type="radio" name="fIsImp" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsImp!='1'}">checked="checked"</c:if> value="0">否</input>
		</td>
		<td style="width: 0px">&nbsp;</td>
		<td class="td1"><span class="style1">*</span>&nbsp;是否论证</td>
		<td class="td2">
			<input type="radio" name="fIsInquiry" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsInquiry=='1'}">checked="checked"</c:if> value="1">是</input>
			<input type="radio" name="fIsInquiry" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsInquiry!='1'}">checked="checked"</c:if> value="0">否</input>
		</td>
	</tr>
	
	<tr>
		<td class="td1" valign="top"><span class="style1">*</span>&nbsp;采购说明</td>
		<td colspan="4">
			<input class="easyui-textbox" type="text" id="F_fRemark"  name="fRemark" readonly="readonly" required="required" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fRemark}"/>
		</td>
	</tr>
	
	<tr style="height: 90px;">
		<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;其他需求</p></td>
		<td colspan="4">
			<input class="easyui-textbox" type="text" id="F_fOtherRemark" readonly="readonly"  name="fOtherRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fOtherRemark}"/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;项目需求书</td>
		<td colspan="4">
		<c:if test="${!empty attac}">
			<c:forEach items="${attac}" var="att">
				<c:if test="${att.serviceType=='xmxqs' }">
					<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
				</c:if>
			</c:forEach>
		</c:if>
												
		<c:if test="${empty attac}">
			<span style="color:#999999">暂未上传附件</span>
		</c:if>
		</td>
	</tr>
										
	<tr class="trbody" id="cglzjl" style="display: none;">
		<td class="td1"><span class="style1">*</span>&nbsp;采购论证结论</td>
		<td colspan="4">
		<c:if test="${!empty attac}">
			<c:forEach items="${attac}" var="att">
				<c:if test="${att.serviceType=='cglzjl' }">
					<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
				</c:if>
			</c:forEach>
		</c:if>
												
		<c:if test="${empty attac}">
			<span style="color:#999999">暂未上传附件</span>
		</c:if>
		</td>
	</tr>
										
	<tr class="trbody" id="scyddwhjy" style="display: none;">
		<td class="td1"><span class="style1">*</span>&nbsp;三重一大党委会纪要</td>
		<td colspan="4">
		<c:if test="${!empty attac}">
			<c:forEach items="${attac}" var="att">
				<c:if test="${att.serviceType=='szyd' }">
					<a href='${base}/attachment/download/${att.id}' target="blank" onclick="js_method()" style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
				</c:if>
			</c:forEach>
		</c:if>
												
		<c:if test="${empty attac}">
			<span style="color:#999999">暂未上传附件</span>
		</c:if>
		</td>
	</tr>
										
	<tr class="trbody" id="dxyqdybg" style="display: none;">
		<td class="td1"><span class="style1">*</span>&nbsp;大型仪器设备前期调研报告</td>
		<td colspan="4">
		<c:if test="${!empty attac}">
		<c:forEach items="${attac}" var="att">
			<c:if test="${att.serviceType=='dxyqdybg' }">
				<a href='${base}/attachment/download/${att.id}' target="blank" onclick="js_method()" style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
			</c:if>
		</c:forEach>
		</c:if>
												
		<c:if test="${empty attac}">
			<span style="color:#999999">暂未上传附件</span>
		</c:if>
		</td>
	</tr>
</table>
<script type="text/javascript">
	$(document).ready(function() {
		//批复金额
		var pfAmount = $("#pfAmount").val();
		if(pfAmount !=""){
			$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
		}
		//可用金额
		var syAmount = $("#syAmount").val();
		if(syAmount !=""){
			$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
		}
		//批复时间
		var pfDate = $("#pfDate").val();
		if(pfDate !=""){
			$('#p_pfDate').html(ChangeDateFormat(pfDate));
		}
		
		//采购论证结论
		isInquiry();
		//三重一大党委会纪要
		scyddwhjy();
		//大型仪器设备前期调研报告
		dxyqdybg();
	});
	
	//是否论证	是-显示采购论证结论按钮
	function isInquiry(){
		var isInquiry = $("input[name='fIsInquiry']:checked").val();
		if(isInquiry == "1"){
			$("#cglzjl").show();
		}else {
			$("#cglzjl").hide();
		}
	}
	
	//采购类型为货物类，采购单价大于等于10万，显示大型仪器设备前期调研报告
	function dxyqdybg(){
		var totalFsumMoney = $("#F_fpAmount").val();
		var fpPype = $("#F_fpPype").val(); 
		if(totalFsumMoney>=100000 && fpPype=='A10'){
			$("#dxyqdybg").show();
		}else{
			$("#dxyqdybg").hide();
		}
	}
	
	//采购总金额大于等于10万，要上传三重一大党委会纪要
	function scyddwhjy(){
		var totalFsumMoney = $("#F_fpAmount").val();
		if(totalFsumMoney>=100000){
			$("#scyddwhjy").show();
		}else{
			$("#scyddwhjy").hide();
		}
	}
</script>
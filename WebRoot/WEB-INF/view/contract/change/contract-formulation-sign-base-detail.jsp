<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;签约方名称</td>
				<td class="td2">
					<input type="hidden" id="F_fSignId1" value="${findSign.fSignId}"/>
					<input id="f_fSignName1"  class="easyui-textbox" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 200px" value="${findSign.fSignName}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span id="fLandlineTd1"><span class="style1">*</span>&nbsp;座机联系方式</span></td>
				<td class="td2">
					<span id="f_fLandlinePhone1">
					<input class="easyui-textbox" id="finish_fLandlinePhone1" readonly="readonly" style="width: 206px" value="${findSign.fLandlinePhone}" data-options="validType:'length[1,50]'">
					</span>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;联系人</td>
				<td class="td2">
					<input id="f_fConcUser1"  class="easyui-textbox" readonly="readonly" required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${findSign.fConcUser}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span class="style1">*</span>&nbsp;联系电话</td>
				<td class="td2">
					<input id="f_fConcTel1"  class="easyui-textbox" readonly="readonly" data-options="validType:'length[1,13]'" style="width: 206px" value="${findSign.fConcTel}"/>
				</td>
			</tr>		
			<tr class="trbody" id="fTaxpayerNum_show1" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;纳税人识别号</td>
				<td colspan="4">
					<input id="f_fTaxpayerNum1"  class="easyui-textbox" readonly="readonly" type="text" style="width: 563px" value="${findSign.fTaxpayerNum}"/>
				</td>
			</tr>
			<tr class="trbody" id="fAddress_show1" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;地址</td>
				<td colspan="4">
					<input id="f_fAddress1"  class="easyui-textbox" readonly="readonly" type="text" data-options="" style="width: 563px" value="${findSign.fAddress}"/>
				</td>
			</tr>				
			<tr class="trbody" id="fCardNo_show1" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;银行账户</td>
				<td colspan="4">
					<input id="f_fCardNo1" class="easyui-textbox" readonly="readonly" type="text" data-options="" style="width: 563px" value="${findSign.fCardNo}"/>
				</td >
			</tr>	
			<tr class="trbody" id="fBankName_show1" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;开户银行</td>
				<td colspan="4">
					<input id="f_fBankName1"  class="easyui-textbox" readonly="readonly" type="text" data-options="validType:'length[1,25]'" style="width: 563px" value="${findSign.fBankName}"/>
				</td>
			</tr>	
	</table>
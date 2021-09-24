<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;签约方名称</td>
				<td class="td2">
					<input type="hidden" name="fSignId" id="F_fSignId" value="${signInfo.fSignId}"/>
					<input id="f_fSignName"  class="easyui-textbox" readonly="readonly" required="required" name="fSignName" data-options="validType:'length[1,50]'" style="width: 200px" value="${signInfo.fSignName}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span id="fLandlineTd"><span class="style1">*</span>&nbsp;座机联系方式</span></td>
				<td class="td2">
					<span id="f_fLandlinePhone">
					<input class="easyui-textbox" id="finish_fLandlinePhone" readonly="readonly" name="fLandlinePhone" style="width: 206px" value="${signInfo.fLandlinePhone}" data-options="validType:'length[1,50]'">
					</span>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;联系人</td>
				<td class="td2">
					<input id="f_fConcUser"  class="easyui-textbox" readonly="readonly" required="required"  name="fConcUser" data-options="validType:'length[1,25]'" style="width: 200px" value="${signInfo.fConcUser}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span class="style1">*</span>&nbsp;联系电话</td>
				<td class="td2">
					<input id="f_fConcTel"  class="easyui-textbox" readonly="readonly" name="fConcTel" data-options="validType:'length[1,13]'" style="width: 206px" value="${signInfo.fConcTel}"/>
				</td>
			</tr>		
			<tr class="trbody" id="fTaxpayerNum_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;纳税人识别号</td>
				<td colspan="4">
					<input id="f_fTaxpayerNum"  class="easyui-textbox" readonly="readonly" type="text" name="fTaxpayerNum"  style="width: 563px" value="${signInfo.fTaxpayerNum}"/>
				</td>
			</tr>
			<tr class="trbody" id="fAddress_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;地址</td>
				<td colspan="4">
					<input id="f_fAddress"  class="easyui-textbox" readonly="readonly" type="text" name="fAddress" data-options="" style="width: 563px" value="${signInfo.fAddress}"/>
				</td>
			</tr>				
			<tr class="trbody" id="fCardNo_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;银行账户</td>
				<td colspan="4">
					<input id="f_fCardNo" class="easyui-textbox" readonly="readonly" type="text"  name="fCardNo" data-options="" style="width: 563px" value="${signInfo.fCardNo}"/>
				</td >
			</tr>	
			<tr class="trbody" id="fBankName_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;开户银行</td>
				<td colspan="4">
					<input id="f_fBankName"  class="easyui-textbox" readonly="readonly" type="text"  name="fBankName" data-options="validType:'length[1,25]'" style="width: 563px" value="${signInfo.fBankName}"/>
				</td>
			</tr>	
	</table>
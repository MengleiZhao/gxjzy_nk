<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;签约方名称</td>
				<td class="td2">
					<input type="hidden" id="F_fSignId2" value="${signInfo.fSignId}"/>
					<input id="f_fSignName2"  class="easyui-textbox" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 200px" value="${signInfo.fSignName}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span id="fLandlineTd2"><span class="style1">*</span>&nbsp;座机联系方式</span></td>
				<td class="td2">
					<span id="f_fLandlinePhone2">
					<input class="easyui-textbox" id="finish_fLandlinePhone2" readonly="readonly" style="width: 206px" value="${signInfo.fLandlinePhone}" data-options="validType:'length[1,50]'">
					</span>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;联系人</td>
				<td class="td2">
					<input id="f_fConcUser2"  class="easyui-textbox" readonly="readonly" required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${signInfo.fConcUser}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span class="style1">*</span>&nbsp;联系电话</td>
				<td class="td2">
					<input id="f_fConcTel2"  class="easyui-textbox" readonly="readonly" data-options="validType:'length[1,13]'" style="width: 206px" value="${signInfo.fConcTel}"/>
				</td>
			</tr>		
			<tr class="trbody" id="fTaxpayerNum_show2" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;纳税人识别号</td>
				<td colspan="4">
					<input id="f_fTaxpayerNum2"  class="easyui-textbox" readonly="readonly" type="text" style="width: 563px" value="${signInfo.fTaxpayerNum}"/>
				</td>
			</tr>
			<tr class="trbody" id="fAddress_show2" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;地址</td>
				<td colspan="4">
					<input id="f_fAddress2"  class="easyui-textbox" readonly="readonly" type="text" data-options="" style="width: 563px" value="${signInfo.fAddress}"/>
				</td>
			</tr>				
			<tr class="trbody" id="fCardNo_show2" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;银行账户</td>
				<td colspan="4">
					<input id="f_fCardNo2" class="easyui-textbox" readonly="readonly" type="text" data-options="" style="width: 563px" value="${signInfo.fCardNo}"/>
				</td >
			</tr>	
			<tr class="trbody" id="fBankName_show2" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;开户银行</td>
				<td colspan="4">
					<input id="f_fBankName2"  class="easyui-textbox" readonly="readonly" type="text" data-options="validType:'length[1,25]'" style="width: 563px" value="${signInfo.fBankName}"/>
				</td>
			</tr>	
	</table>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.input_amonut{
		width: 140px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span{
		width:100px;
		margin-bottom:5px;
		display: inline-block;
	}
	.input_amonut1{
		width: 150px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span1{
		width:85px;
		margin-bottom:5px;
		margin-left:15px;
		display: inline-block;
	}
</style>
<div id="dlgdiv" class="easyui-dialog"
     style="width: 650px; height: 550px; padding: 10px 20px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlarge"></div>
</div>
<div style="margin-top: 5px;margin-bottom: 5px;height: 15px;">
	<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">发票明细</a>
	<a style="float: left;">&nbsp;&nbsp;</a>
</div>
<form id="form1">
	<table id="outsideAttendfapiao" class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style=" height: 100px;width:695px;">
		<c:forEach items="${Invoicelist1 }" varStatus="i" var="invoice">
			<tbody id="outsideAttend_${i.index}" >
				<tr>
					<td class="td1" style="width: 100px;">
						&nbsp;&nbsp;<span id="outsideAttendFp_${i.index}">发票${i.index+1}</span>
					</td>
					<td class="td2" colspan="3" id="outsideAttendZfbimagetd_${i.index}" style="width: 150px;">
						<c:if test="${invoice.fileId!=null&&!empty invoice.fileId}">
							<img style="vertical-align:bottom;width: 100px; height: 73px;margin-left:0px" onclick="yl(this.src)" src="${base}/attachment/download/${invoice.fileId}"/>
						</c:if>
					</td>
					<td class="td2" colspan="3" id="">
						<div style="width: auto; height:auto; height:auto;margin-top:5px;margin-left:49px;width: 300px;">
							<p style="margin-bottom:10px;">
								<span class="fp_span" >金额(元)：</span>
								<input class="input_amonut1 a easyui-numberbox" readonly="readonly" name="amount" id="amount_${i.index}" value="${invoice.amount}" onchange="addAmonut(this)"data-options="precision:2"/>
							</p>
							<p style="margin-bottom:5px;" >
								<span class="fp_span">备注：</span>
								<input  class="input_amonut1 easyui-textbox" readonly="readonly" name="remark" id="remark_${i.index}" value="${invoice.remark}" />
							</p>
						</div>
					</td>
				</tr>
			</tbody>
		</c:forEach>
	</table>
</form>	
<div style="height:10px"></div>
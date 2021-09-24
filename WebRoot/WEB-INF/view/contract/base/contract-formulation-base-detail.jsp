<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0">
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;合同编号</td>
			<td colspan="4">
				<input id="F_fcCode" class="easyui-textbox" readonly="readonly" type="text" data-options="validType:'length[1,32]'" style="width: 563px" value="${bean.fcCode}"/>
			</td >
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;合同名称</td>
			<td colspan="4">
				<input class="easyui-textbox" type="text"  id="F_fcTitle" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 563px" value="${bean.fcTitle}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;合同分类</td>
			<td class="td2">
				<input class="easyui-combobox" id="F_fcTypeName" readonly="readonly" required="required" name="fcTypeName"  style="width: 200px" data-options="editable:false,panelHeight:'auto',
					url:'${base}/Formulation/lookupsJson?parentCode=HTFL&selected=${bean.fcType}',
					valueField:'text',
					textField:'text',
				"/>
				<input id="F_fcType" name="fcType" value="${bean.fcType}" hidden="hidden"/>
			</td>
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;合同份数</td>
			<td class="td2">
				<input id="F_fcNum" class="easyui-numberbox" readonly="readonly" required="required" data-options="validType:'length[1,2]',precision:0" style="width: 206px" value="${bean.fcNum}"/>
			</td>
		</tr>
		<tr class="trbody" id="cg1">
			<td class="td1"><span class="style1">*</span>&nbsp;采购订单</td>
			<td  colspan="4">
				<a><input id="F_fPurchName" readonly="readonly" class="easyui-textbox" data-options="prompt:'单击打开选取采购订单'" value="${bean.fPurchName}" style="width: 563px"/></a>
				<input id="F_fPurchNo" hidden="hidden" type="text"data-options="validType:'length[1,32]'" value="${bean.fPurchNo}"/>
			</td>
		</tr>
		<tr class="trbody" id="cg2">
			<td class="td1"><span class="style1">*</span>&nbsp;合同金额小写</td>
			<td class="td2">
				<input class="easyui-numberbox" id="F_fcAmount" readonly="readonly" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" style="width: 200px" value="${bean.fcAmount}"/>
			</td>
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;合同金额大写</td>
			<td class="td2">
				<input id="F_fcAmountMax" class="easyui-textbox" type="text" readonly="readonly" required="true" data-options="validType:'length[1,25]'" style="width: 206px" value="${bean.fcAmountMax}"/>
			</td >
		</tr>
		<%-- <tr class="trbody">
			<td class="td1"><div id="cg3"><span class="style1">*</span>&nbsp;付款方式</div></td>
			<td class="td2">
				<div id="cg4">
				<input class="easyui-combobox" id="F_fPayType" readonly="readonly" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false" style="width: 200px" />
				</div>
			</td>
			<td class="td4">&nbsp;</td>
			<td class="td1">协同部门</td>
			<td class="td2" >
				<select id="F_assisDeptId" class="easyui-combobox" readonly="readonly" data-options="validType:'length[1,20]',editable:false" style="width: 206px" >
					<option value="">--请选择--</option>
					<option value="14" <c:if test="${bean.assisDeptId==14}">selected="selected"</c:if> >设备与安技处</option>
					<option value="35" <c:if test="${bean.assisDeptId==35}">selected="selected"</c:if> >总务处</option>
					<option value="20" <c:if test="${bean.assisDeptId==20}">selected="selected"</c:if> >创业就业指导中心</option>
				</select>					
			</td>
		</tr> --%>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;履约保证金</td>
			<td class="td2">
				<input id="fperformance" class="easyui-numberbox" readonly="readonly" required="required" name="fperformance" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" style="width: 206px" value="${bean.fperformance}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;是否制式合同</td>
			<td class="td2">
				<input type="radio" disabled="disabled" value="0" <c:if test="${bean.standard==0}">checked="checked"</c:if> />否
				<input type="radio" disabled="disabled" value="1" <c:if test="${bean.standard==1}">checked="checked"</c:if> />是
			</td>
			<td class="td4">&nbsp;</td>
		</tr>
		<tr class="trbody" id="dd">
			<td class="td1"><span class="style1">*</span>&nbsp;是否预开发票</td>
			<td class="td2">
				<input type="radio" disabled="disabled" value="0" <c:if test="${bean.isinvoice==0}">checked="checked"</c:if> />否
				<input type="radio" disabled="disabled" value="1" <c:if test="${bean.isinvoice==1}">checked="checked"</c:if> />是
			</td>
			<td class="td4">&nbsp;</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;是否框架合同</td>
			<td class="td2">
				<input type="radio" disabled="disabled" value="0" <c:if test="${bean.iskjht==0}">checked="checked"</c:if> />否
				<input type="radio" disabled="disabled" value="1" <c:if test="${bean.iskjht==1}">checked="checked"</c:if> />是
			</td>
			<td class="td4">&nbsp;</td>
		</tr>
		<tr class="trbody">
			<td class="td1">
				<span class="style1">*</span>&nbsp;合同文本
			</td>
			<td colspan="4" id="htwbtdf">
				<c:forEach items="${formulationAttaList}" var="att">
					<c:if test="${att.serviceType=='fhtwb' }">
						<div>
							<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
						</div>
					</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;预计开始时间</td>
			<td class="td2">
				<input id="F_fContStartTime" class="easyui-datebox" readonly="readonly" class="dfinput" required="required" data-options="validType:'length[1,20]',editable:false" style="width: 200px" value="${bean.fContStartTime}"/>
			</td >
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;预计结束时间</td>
			<td class="td2">
				<input class="easyui-datebox"  class="dfinput" readonly="readonly" id="F_fContEndTime" required="required"data-options="validType:'length[1,20]',editable:false" style="width: 206px" value="${bean.fContEndTime}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1" ><span class="style1">*</span>&nbsp;合同情况说明</td>
			<td colspan="4">
				<input type="text" id="CF_fFlowStauts" name="fFlowStauts" hidden="hidden" value="${bean.fFlowStauts}"/>
				<input id="f_fRemark" class="easyui-textbox" type="text" readonly="readonly"data-options="multiline:true" style="width: 563px;height: 90px" value="${bean.fRemark}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
			<td class="td2">
				<input id="F_fDeptName" class="easyui-textbox" readonly="readonly" type="text" data-options="validType:'length[1,50]'" style="width: 200px" value="${bean.fDeptName}"/>
			</td >
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
			<td class="td2">
				<input id="F_fOperator" class="easyui-textbox" readonly="readonly" type="text" required="true" data-options="validType:'length[1,25]'" style="width: 206px" value="${bean.fOperator}"/>
			</td >
		</tr>
	</table>
<script type="text/javascript">
$("#loan_ledger_list_top_estChargeTime1").datebox({
    onSelect : function(beginDate){
        $('#loan_ledger_list_top_estChargeTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

function fPurchNo_DC() {
	var win = creatFirstWin('选择采购单', 940, 600, 'icon-search',
			'/PurchaseApply/PurchNoList');
	win.window('open');
}

</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 预算信息 -->
<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px;margin-top: 0px">
<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
	<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
		<tr class="trbody">
			<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目</td>
			<td colspan="3"  style="padding-right: 5px;">
				<a href="#">
				<input class="easyui-textbox" style="width: 635px;height: 30px;"
				name="indexName" value="${applyBean.indexName}" id="F_fBudgetIndexName"
				data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
				</a>
			</td>
		</tr>
	</table>	
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
			<tr>
				<td class="window-table-td1" style="width: 128px"><p>批复金额：</p></td>
				<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
				
				<td class="window-table-td1"><p>预算年度：</p></td>
				<td class="window-table-td2"><p id="p_pfDate">${fn:substring(bean.pfDate, 0, 4)}</p></td>
			</tr>
			
			<tr>
				<td class="window-table-td1"><p>可用额度：</p></td>
				<td class="window-table-td2"><p id="p_syAmount">${applyBean.indexAmount}</p></td>
			</tr>
	</table>				
</div>
</div>

<!-- 基本信息 -->
<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px">
<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
		<tr class="trbody">
			<td class="td1" style="width: 70px;"><span class="style1">*</span> 事项摘要</td>
			<td colspan="3">
				<input class="easyui-textbox" style="width: 616px;height: 30px;margin-left: 10px" readonly="readonly" value="${applyBean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
			</td>
		</tr>
		
		<tr class="trbody">
			<td class="td1" style="width: 70px;"> 同行人</td>
			<td colspan="3">
				<input class="easyui-textbox" style="width: 616px;height: 30px;margin-left: 10px" readonly="readonly" id="travelAttendPeop" value="${applyBean.travelAttendPeop}" name="travelAttendPeop" required="required"/>
			</td>
		</tr>
		
		<tr class="trbody" style="line-height: 65px;">
			<td class="td1" style="width: 70px;"><span class="style1">*</span>出行事由</td>
			<td colspan="3">
				<textarea name="reason" id="reason" readonly="readonly" class="easyui-textbox" data-options="multiline:true"
					oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
					style="margin-left: 10px ;width:616px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${applyBean.reason }</textarea>
			</td>
		</tr>
		
		<tr class="trbody" style="line-height: 65px;">
			<td class="td1" style="width: 70px;"><span class="style1">*</span>声明</td>
			<td colspan="3">
				<input class="easyui-textbox" style="width: 616px;height: 60px;margin-left: 10px;" readonly="readonly" data-options="multiline:true" value="本人申请本次公务采取非公共交通方式出行，如有意外发生，本人自愿承担因此而产生的对第三者的全部责任，纠纷与学院无关。" name="statement" required="required" />
			</td>
		</tr>
		
		<tr class="trbody">
			<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
			<td class="td2" >
			<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
			</td>
			<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
			<td class="td2" >
			<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 261px;height: 30px;margin-left: 10px " >
			</td>
		</tr>
	</table>
</div>				
</div>
<!-- 出差人员名单 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 715px">
	<div title="行程清单" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<div style="overflow:auto;margin-top: 0px;">
		<jsp:include page="apply_travel_itinerary_city.jsp" />
	</div>
	</div>
</div>
<!-- 附件信息 -->
<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px">
<div title="附件信息" data-options="collapsible:false"
	style="overflow:auto;">		
	<table class="window-table" cellspacing="0" cellpadding="0" style="width:707px;">
		<tr>
			<td class="td1" style="width:55px;text-align: left">
				附件:
			</td>
			<td colspan="3" id="tdf">
				<c:forEach items="${attaList}" var="att">
					<div>
					<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
					</div>
				</c:forEach>
			</td>
		</tr>
	</table>
</div>
</div>
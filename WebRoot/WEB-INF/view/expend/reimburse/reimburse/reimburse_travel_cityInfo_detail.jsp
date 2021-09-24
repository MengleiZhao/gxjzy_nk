<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3"  style="padding-right: 5px;">
								<a href="#">
								<input class="easyui-textbox" style="width: 635px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
							<tr>
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								<td class="window-table-td1" style="width: 128px"><p></p></td>
								<td class="window-table-td2"><p></p></td>
							</tr>
							
							<tr hidden="hidden">
								<td class="window-table-td1" style="width: 128px"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
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
									<input class="easyui-textbox" style="width: 616px;height: 30px;margin-left: 10px  " readonly="readonly" value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						
						<tr class="trbody">
							<td class="td1" style="width: 70px;"> 同行人</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 616px;height: 30px;margin-left: 10px" readonly="readonly" id="travelAttendPeop" value="${bean.travelAttendPeop}" name="travelAttendPeop"/>
							</td>
						</tr>
						
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>出行事由</td>
							<td colspan="3">
								<textarea name="reimburseReason" id="reimburseReason" class="easyui-textbox" data-options="multiline:true"
									oninput="textareaNum(this,'textareaNum1')" autocomplete="off" readonly="readonly"
									 style="margin-left: 10px ;width:616px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${bean.reimburseReason}</textarea>
							</td>
						</tr>
						
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>声明</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 616px;height: 60px;margin-left: 10px;" readonly="readonly" data-options="multiline:true" value="${bean.statement}" name="statement" required="required" />
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
				<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px">
				<div title="培训事项调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 715px">
					<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td class="td1" style="width: 80px;"><span class="style1">*</span>是否存在调整</td>
							<td class="td2" colspan="4" >
								<input type="radio" value="1" onclick="radioyes()" disabled="disabled" name="fupdateStatus" id="box1" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
								&nbsp;&nbsp;
								<input type="radio" value="0" onclick="radiono()" disabled="disabled" name="fupdateStatus" id="box2" <c:if test="${bean.fupdateStatus=='0'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
							</td>
						</tr>
						<tr id="radiofupdate" <c:if test="${bean.fupdateStatus=='0'}"> hidden="hidden" </c:if> class="trbody">
							<td class="td1" style="width: 80px;"><span class="style1">*</span>出行调整说明</td>
							<td colspan="3" class="td2" >
								<textarea name="fupdateReason"  id="fupdateReason" class="textbox-text" readonly="readonly"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
							</td>
						</tr>
					</table>
				</div>				
				</div>
				<!-- 出差人员名单 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 715px">
					<div title="行程清单" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="reimburse_travel_itinerary_city_detail.jsp" />
						</div>
					</div>
				</div>
				
				
				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px;height: auto;">
					<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
						<div id="" style="overflow-x:hidden;margin-top: 0px;">
							<jsp:include page="payee-info_detail.jsp" />	
						</div>
					</div>
				</div>
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="width:715px;margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsible:false"
					style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left">
								附件:
							</td>
							<td colspan="3" id="tdf">
								<c:forEach items="${attaList1}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
				</div>
				
		<!-- 审批记录 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;padding:0px;">
				<!-- <div class="window-title"> 审批记录</div> -->
					<jsp:include page="../../../check_history.jsp" />
			</div>
		</div>	
<script type="text/javascript">

//显示详细信息手风琴页面
$(document).ready(function() {
});


var updateradio = 0;
function radiono(){
	acceptItineraryCityReim();
	updateradio=0;
	$('#removeReimId').hide();
	$('#appendReimId').hide();
	$('#radiofupdate').hide();
}

function radioyes(){
	acceptItineraryCityReim();
	updateradio=1;
	$('#removeReimId').show();
	$('#appendReimId').show();
	$('#radiofupdate').show();
//	$.parser.parse("#studentsTravelId");
}
if(updateradio==0){
	sign1 = 0;
	$('#removeReimId').hide();
	$('#appendReimId').hide();
}else{
	sign1 = 1;
	$('#removeReimId').show();
	$('#appendReimId').show();
}
//选择人员
function selectTravelCityPeopReim(index) {
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/reimburse/chooseUserCityReim');
	win.window('open');
}
</script>
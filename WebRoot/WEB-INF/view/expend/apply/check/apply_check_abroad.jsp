<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<script type="text/javascript">
//显示详细信息手风琴页面
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
		$('#p_pfDate').html(pfDate);
	}	
	var applyAmount = $("#applyAmount").val();
	$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	
	var travelMoney = $("#travelMoney").val();
	if(travelMoney !=""){
		$('#p_travelMoney').html(fomatMoney(travelMoney,2)+" [元]");
	}
	var hotelMoney = $("#hotelMoney").val();
	if(hotelMoney !=""){
		$('#p_hotelMoney').html(fomatMoney(hotelMoney,2)+" [元]");
	}
	var foodMoney = $("#foodMoney").val();
	if(foodMoney !=""){
		$('#p_foodMoney').html(fomatMoney(foodMoney,2)+" [元]");
	}
	var pocketMoney = $("#pocketMoney").val();
	if(pocketMoney !=""){
		$('#p_pocketMoney').html(fomatMoney(pocketMoney,2)+" [元]");
	}
	var totalOtherMoney = $("#totalOtherMoney").val();
	if(totalOtherMoney !=""){
		$('#p_totalOtherMoney').html(fomatMoney(totalOtherMoney,2)+" [元]");
	}
	var h = $("#applyTypeHi").val();
	var cxjk = '${abroad.fDiningPlace}';
	if(cxjk==1){
		$('#feteCostId').show();
		$("#fDiningPlaceId1").attr("checked",true);
	} else {
		$('#feteCostId').hide();
		$("#fDiningPlaceId2").attr("checked",true);
		
	}
});
		
function ending(){
	
	
}
		
		
		
//审批
function check(result) {
		var applyType = $('#applyType').val();
		if(1==applyType){
			//通用事项申请
			var userName2 = $('#userName2').textbox('getValue');
			if( result==1 && userName2==""){
				alert('请先选择下级审批人');
				return false;
			}
		}
		if(${!empty xzbgsFile}){
			var meetingSummaryYear1 =$('#meetingSummaryYear1').val();
			var meetingSummaryTime1 =$('#meetingSummaryTime1').val();
			if(meetingSummaryYear1==''||meetingSummaryTime1==''){
				alert('请填写校长办公会会议纪要信息');
				return false;
			}
			var s1="";
			$(".xzbgsfileUrl").each(function(){
				s1=s1+$(this).attr("id")+",";
			});
			if(s1==''){
				alert('请上传校长办公会会议纪要附件');
				return false;
			}
		}
		if(${!empty dwhFile}){
			var meetingSummaryYear2 =$('#meetingSummaryYear2').val();
			var meetingSummaryTime2 =$('#meetingSummaryTime2').val();
			if(meetingSummaryYear2==''||meetingSummaryTime2==''){
				alert('请填写党委会会议纪要信息');
				return false;
			}
			var s2="";
			$(".dwhfileUrl").each(function(){
				s2=s2+$(this).attr("id")+",";
			});
			if(s2==''){
				alert('请上传党委会会议纪要附件');
				return false;
			}
		}
		$('#apply_check_form').form('submit', {
			onSubmit : function() {
				/* flag = $(this).form('enableValidation').form('validate');
				if (flag) { */
					$.messager.progress();
				/* }
				return flag; */
			},
			url : base + '/applyCheck/checkResult',
			success : function(data) {
				/* if (flag) { */
					$.messager.progress('close');
				/* } */
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#applyCheckTab').datagrid('reload');
					$('#indexdb').datagrid('reload');
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
}

function addAmount(){
	
}
function changeHotel(){
	
}
</script>

<form id="apply_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;" >
			<div class="win-left-top-div" >
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="gId" value="${bean.gId}" />
				<!-- 申请单流水号 --><input type="hidden" name="gCode" value="${bean.gCode}" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
				<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 申请类型 --><input type="hidden" id="applyTypeHi" value="${bean.type}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="F_proDetailId"/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
				<!-- 申请时间  --><input type="hidden" id="applyReqTime" name="reqTime" value="${bean.reqTime}"/>
				<!-- 申请事项  --><input type="hidden" id="applyType" name="type" value="${bean.type}"/>
				<!-- 申请总额  --><input type="hidden" id="applyAmount" name="amount" value="${bean.amount}"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
				<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 最早的出发时间  --><input type="hidden" id="maxTime" />
				<!-- 最晚的撤离时间  --><input type="hidden" id="minTime" />
				
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
							<table class="window-table" id="apply_abroadtab" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
								<tr class="trbody">
									<td class="td1" style="width: 10%"><span class="style1">*</span>摘要</td>
									<td colspan="3">
										<c:if test="${operation=='add' }">
											<input class="easyui-textbox" style="width: 620px;height: 30px; " value="${draftAdd}" name="gName" readonly="readonly"   data-options="validType:'length[1,50]'"/>
										</c:if>
										<c:if test="${operation!='add' }">
											<input class="easyui-textbox" style="width: 620px;height: 30px; " value="${bean.gName}" name="gName"  readonly="readonly" data-options="validType:'length[1,50]'"/>
										</c:if>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团组名称</td>
									<td class="td2" >
										<input style="width: 251px; height: 30px;" id="fTeamName" name="fTeamName" class="easyui-textbox" readonly="readonly"
										value="${abroad.fTeamName}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;"><span class="style1">*</span>组团单位</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fAbroadPlace" name="fAbroadPlace" class="easyui-textbox" readonly="readonly"
										value="${abroad.fAbroadPlace}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团长(级别)</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fTeamLeader" name="fTeamLeader" class="easyui-textbox" readonly="readonly"
										value="${abroad.fTeamLeader}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;"></td>
									<td class="td2"> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团员人数</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fTeamPersonNum"  name="fTeamPersonNum" class="easyui-numberbox" readonly="readonly" 
										value="${abroad.fTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;"><span class="style1">*</span>本单位参团人数</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fThisUnitTeamPersonNum"  name="fThisUnitTeamPersonNum" class="easyui-numberbox" readonly="readonly" 
										value="${abroad.fThisUnitTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>开始时间</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="abroadDateStart" name="fAbroadDateStart" class="easyui-datebox" readonly="readonly"
										value="${abroad.fAbroadDateStart}" data-options="required:true" editable="false"/>
									</td>
									
									<td class="td1" style="width:70px;"><span class="style1">*</span>结束时间</td>
									<td class="td2">
										<input type="hidden" name="faId" value="${abroad.faId}" />
										<input style="width: 251px; height: 30px;" id="abroadDateEnd" name="fAbroadDateEnd" class="easyui-datebox" readonly="readonly"
										value="${abroad.fAbroadDateEnd}" data-options="" editable="false"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>出国天数</td>
									<td class="td2" colspan="3">
										<input style="width: 251px; height: 30px;" id="abroadDay" name="fAbroadDayNum" class="easyui-textbox" readonly="readonly"
										value="${abroad.fAbroadDayNum}" readonly="readonly" data-options="required:true,validType:'length[1,2]'"/> 
									</td>
								</tr>
								<tr style="height:4px"></tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>申请事由</td>
									<td class="td2" colspan="3">
										<input class="easyui-textbox" data-options="multiline:true,required:true,validType:'length[0,250]'"
										 name="reason" style="width:620px;height:60px;" value="${bean.reason }" readonly="readonly">
									</td>
								</tr>
								
								<tr class="trbody">
									<td class="td1" style="width:70px;">宴请安排</td>
									<td class="td2" colspan="3">
			                       		<input type="radio" name="fDiningPlace" id="fDiningPlaceId1" disabled="disabled" <c:if test="${abroad.fDiningPlace==1} ">   checked="checked" </c:if>>是
			                        	<input type="radio" name="fDiningPlace" id="fDiningPlaceId2" disabled="disabled" <c:if test="${abroad.fDiningPlace!=1} ">  checked="checked" </c:if>>否
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
									<td class="td2" >
									<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 251px;height: 30px;margin-left: 10px " >
									</td>
									<td class="td1" style="width: 70px;"><span class="style1">*</span> 部门名称</td>
									<td class="td2" >
									<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 251px;height: 30px;margin-left: 10px " >
									</td>
								</tr>
							</table>
						</div>				
					</div>
					<!-- 出国人员信息 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出国人员信息 " data-options="collapsed:false,collapsible:false"	style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span>出国人员</td>
								<td colspan="3" style="padding-left: 5px;">
									<a  id="chooseuserId">
										<input class="easyui-textbox" style="width: 642px;height: 30px;" name="fAbroadPeople" value="${abroad.fAbroadPeople}" id="fAbroadPeople"
										 data-options="prompt:'点击选择出国人员名单',validType:'length[1,200]',icons: [{iconCls:'icon-add'}]" readonly="readonly" required="required"/>
									 </a>
								</td>
							</tr>
						</table>
					</div>
				</div> --%>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出国人员信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<!-- 出访计划（含经停）-->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="../add/abroad_person.jsp" />
						</div>
					</div>
				</div>
				
				<!-- 路线计划 信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出访国家（含经停）" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<!-- 路线计划 -->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="../add/abroad_way_detail.jsp" />
						</div>
					</div>
				</div>
				<!--出行方式 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出行方式" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="../add/travel_way.jsp" />
						</div>
					</div>
				</div>		
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="费用明细" data-options="collapsible:false" style="overflow:auto;">
						<!-- 全部费用-->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/apply_expense_detail.jsp" />
						</div>
						<%-- <!-- 国际旅费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/apply_international_traveling_expense_detail.jsp" />
						</div>
						<!-- 国外城市间交通费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/apply_outside_traffic_international_detail.jsp" />
						</div>
						<!-- 住宿费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/hotelExpense_aboard_detail.jsp" />
						</div>
						<!-- 伙食费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/foodAllowance_aboard_detail.jsp" />
						</div>
						<!-- 公杂费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/miscellaneousFee_detail.jsp" />
						</div>
						<!-- 宴请费 -->
						<div id="feteCostId">
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/feteCost_detail.jsp" />
						</div>
						</div>
						<!-- 其他费用 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="../add/otherExpenses_detail.jsp" />
						</div> --%>
						<div style="margin-top: 20px">
							<a style="float: right;">申请总额：<span style="color: #D7414E"  id="applyAmountAbroad"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
						</div>
					</div>
				</div>
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px">
					<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目:</td>
								<td colspan="3" style="padding-right: 5px;">
									<a onclick="openIndex()" href="#">
									<input class="easyui-textbox" style="width: 642px;height: 30px;"
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
									<td class="window-table-td1"><p></p></td>
									<td class="window-table-td2"><p></p></td>
								</tr>
								
								<tr  hidden="hidden">
									<td class="window-table-td1"><p>批复金额：</p></td>
									<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
									<td class="window-table-td1"><p>可用额度：</p></td>
									<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}元</p></td>
								</tr>
						</table>				
					</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="附件信息" data-options=" collapsible:false"
					style="overflow:auto;padding:10px;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
								<td class="td1" style="width:40px">附件</td>
								<td colspan="4">
									<c:if test="${!empty attaList}">
									<c:forEach items="${attaList}" var="att">
										<c:if test="${att.serviceType=='file'}">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
										</c:if>	
									</c:forEach>
								</c:if>
								<c:if test="${empty attaList}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
								</td>
							</tr>
						
						
					</table>
					
				</div>
				</div>
				<!-- 三重一大会议信息 -->
				<c:if test="${!empty xzbgsFile || !empty dwhFile }">
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="三重一大会议信息" data-options="collapsible:false" style="overflow:auto; ">
						<jsp:include page="../add/check_meeting_infomation.jsp" />
					</div>
				</div>
				</c:if>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;padding:0px;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../../check_history.jsp" />
					</div>
				</div>
			</div>
			
			<c:if test="${checkUser!=1 }">
				<div class="window-left-bottom-div">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<c:if test="${type!=1 }">
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="showFlowDesinger()">
							<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</c:if>
					<c:if test="${type==1 }">
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="openCheckWin('审批意见','2')">
							<img src="${base}/resource-modality/${themenurl}/button/tybzz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</c:if>
				</div>
			</c:if>
			
			<c:if test="${checkUser==1 }">
				<div class="window-left-bottom-div">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</div>
			</c:if>
		</div>
		
		<c:if test="${type!=1 }">
			<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
</div>
</form>

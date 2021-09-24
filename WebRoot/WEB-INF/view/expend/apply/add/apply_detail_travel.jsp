<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
function ChangeDateFormat1(val) {
	var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}

//显示详细信息手风琴页面
$(document).ready(function() {
	//设置时间
	if($("#applyReqTime").val()==""||$("#applyReqTime").val()==null){
		var date = new Date();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
		$("#applyReqTime").val(date);
	} else {
		var date = $("#applyReqTime").val();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
	}
	
});
</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
	<div <c:if test="${bean.fFoodNum!=1 || empty bean.fFoodNum}"> hidden="hidden" </c:if>>
					<a style="display: block; text-align: center;border: 1px solid red;color: red;margin-left: 220px;width: 360px;border-radius: 4px;">您当前出行日期中，伙食费已申报,请核对!</a>
				</div>
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
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
				<!-- 申请总额  --><input type="text" id="applyAmount" hidden="hidden" name="amount" value="${bean.amount}"/>
				<%-- <!-- 住宿费  --><input type="hidden" id="hotelAmount" name="hotelAmount" value="${travelBean.hotelAmount}"/>
				<!-- 伙食补助费  --><input type="hidden" id="foodAmount" name="foodAmount" value="${travelBean.foodAmount}"/> --%>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 各项明细金额 -->
				<input type="hidden" id="outsideAmount" name="OutsideAmount" value="${bean.outsideAmount}" />
				<input type="hidden" id="cityAmount" name="cityAmount" value="${bean.cityAmount}" />
				<input type="hidden" id="hotelAmount" name="hotelAmount" value="${bean.hotelAmount}" />
				<input type="hidden" id="foodAmount" name="foodAmount" value="${bean.foodAmount}" />
				<!-- 隐藏域 -->
				<input type="hidden" name="trId" value="${travelBean.trId}" />
				<input type="hidden" name="travelRId" value="${tPeopBean.travelRId}" />
				<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
				<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
				<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
				
								
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 0px">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3"  style="padding-right: 5px;">
								<input class="easyui-textbox" style="width: 635px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
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
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}</p></td>
							</tr>
					</table>				
				</div>
				</div>
				
				<!-- 基本信息 -->	
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px;">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>事项摘要</td>
							<td colspan="3">
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 635px;height: 30px; " readonly="readonly" value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 635px;height: 30px; " readonly="readonly" value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 出差类型</td>
							<td class="td2" colspan="3">
							<input class="easyui-combobox" id="travelType" name="travelType" readonly="readonly" style="width: 635px;height: 30px;" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=CCLX&selected=${bean.travelType}',method:'POST',valueField:'code',textField:'text'">
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1"><span class="style1">*</span>出差事由</td>
							<td colspan="3">
								<textarea name="reason" id="reason" class="easyui-textbox" readonly="readonly" data-options="multiline:true"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:635px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${bean.reason }</textarea>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
							<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
							<td class="td2" >
							<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 267px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
					</table>
				</div>				
				</div>
				<!-- 出差人员名单 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="行程清单" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px;">
						<jsp:include page="apply_travel_itinerary_detail.jsp" />
					</div>
					<div style="margin-top: 20px">
						<div id="applyHotelHintId" style="color: red;">${bean.fHotelHint}</div>
						<div id="applyTrafficHintId" style="color: red;">${bean.fTrafficHint}</div>
					</div>
					</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsible:false"
					style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left">
								附件:
							</td>
							<td colspan="3" id="tdf">
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<c:if test="${att.serviceType=='null'}">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
				</div>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="check_history.jsp" />
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div" >
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>
<script type="text/javascript">


/* applyTotalAmount();

function applyTotalAmount(){
	//城市间交通费
	//acceptOutsideTraffic();
	var rowsOut = $('#outside_traffic_tab_id').datagrid('getRows');
	var outsideAmount =0;
	for(var i=0; i<rowsOut.length; i++){
		if(rowsOut[i].applyAmount=='' || rowsOut[i].applyAmount==undefined || rowsOut[i].applyAmount=='NaN'){
			outsideAmount =outsideAmount+0;	
		}else{
			outsideAmount =parseFloat(outsideAmount)+parseFloat(rowsOut[i].applyAmount);
		}
	}
			$("#applyOutsideTrafficAmount").html(outsideAmount.toFixed(2)+"元");
	//市内交通费
	//acceptInCity();
	var rowsInCity = $('#in_city_tab_id').datagrid('getRows');
	var inCityAmount =0;
	for(var j=0; j<rowsInCity.length; j++){
		if(rowsInCity[j].fApplyAmount=='' || rowsInCity[j].fApplyAmount==undefined || rowsInCity[j].fApplyAmount=='NaN'){
			inCityAmount =inCityAmount+0;	
		}else{
			inCityAmount =parseFloat(inCityAmount)+parseFloat(rowsInCity[j].fApplyAmount);
		}
	}
			$("#applyInCityAmount").html(inCityAmount.toFixed(2)+"元");
	
	
	//住宿费
	//accepthotel();
	var rowsHotel = $('#hoteltab').datagrid('getRows');
	var hotelAmount =0;
	for(var j=0; j<rowsHotel.length; j++){
		if(rowsHotel[j].applyAmount=='' || rowsHotel[j].applyAmount==undefined || rowsHotel[j].applyAmount=='NaN'){
			hotelAmount =hotelAmount+0;	
		}else{
			hotelAmount =parseFloat(hotelAmount)+parseFloat(rowsHotel[j].applyAmount);
		}
	}
			$("#hotelAmount").html(inCityAmount.toFixed(2)+"元");
	
	//伙食费
	//acceptfood();
	
	var rowsFood = $('#foodtab').datagrid('getRows');
	var foodAmount =0;
	for(var j=0; j<rowsFood.length; j++){
		if(rowsFood[j].fApplyAmount=='' || rowsFood[j].fApplyAmount==undefined || rowsFood[j].fApplyAmount=='NaN'){
			foodAmount =foodAmount+0;	
		}else{
			foodAmount =parseFloat(foodAmount)+parseFloat(rowsFood[j].fApplyAmount);
		}
	}
			$("#foodAmount").html(foodAmount.toFixed(2)+"元");
	
}

 */
</script>
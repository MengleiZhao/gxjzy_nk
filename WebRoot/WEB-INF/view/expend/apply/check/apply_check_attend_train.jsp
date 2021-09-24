<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
.under{
	outline: none;
	width:75px;
    border-bottom: 1px solid #000;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
    background-color: #F0F5F7;
    text-align:center;
    color:#0000CD;
}
</style>
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
	
	//设置支出申请扩展信息
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#applyType').val(h);
	}
	
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
	//批复时间
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
});
//审批
function check(result) {
	$('#apply_check_form').form('submit',{
		onSubmit : function(){
				$.messager.progress();
		},
		url : base + '/applyCheck/checkResult',
		success : function(data) {
				$.messager.progress('close');
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#apply_check_form').form('clear');
				$('#applyCheckTab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}
</script>
<form id="apply_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
	<div <c:if test="${bean.fFoodNum!=1 || empty bean.fFoodNum}"> hidden="hidden" </c:if> id="hiddenId">
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
				<!-- 申请总额  --><input id="applyAmount" name="amount" type="hidden" value="${bean.amount}"/>
				<%-- <!-- 住宿费  --><input type="hidden" id="hotelAmount" name="hotelAmount" value="${travelBean.hotelAmount}"/>
				<!-- 伙食补助费  --><input type="hidden" id="foodAmount" name="foodAmount" value="${travelBean.foodAmount}"/> --%>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 最早的出发时间  --><input type="hidden" id="maxTime" />
				<!-- 最晚的撤离时间  --><input type="hidden" id="minTime" />
				<!-- 用于存放出行人员数组  --><input type="hidden" id="personnelArr" />
				<!-- 是否重复申报伙食费 --><input type="hidden" id="fFoodNum" name="fFoodNum" value="${bean.fFoodNum}" />
				<!-- 隐藏域 -->
				<input type="hidden" name="trId" value="${travelBean.trId}" />
				<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
				<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
				<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
				<input type="hidden" id="travelAttendPeopId" name="travelAttendPeopId" value="${travelBean.travelAttendPeopId}" /><!-- 同行人ID -->
				<input type="hidden" id="travelPersonnelLevel" name="travelPersonnelLevel" value="${travelBean.travelPersonnelLevel}" /><!-- 同行人级别 -->
				<!-- 差旅住宿费提示信息 --><input type="hidden" id="fHotelHint" name="fHotelHint" value="${bean.fHotelHint}" />
				<!-- 差旅交通提示信息 --><input type="hidden" id="fTrafficHint" name="fTrafficHint" value="${bean.fTrafficHint}" />
						
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
				<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
				
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 各项明细金额 -->
				<input type="hidden" id="outsideAmount" name="OutsideAmount" value="${bean.outsideAmount}" />
				<input type="hidden" id="cityAmount" name="cityAmount" value="${bean.cityAmount}" />
				<input type="hidden" id="hotelAmount" name="hotelAmount" value="${bean.hotelAmount}" />
				<input type="hidden" id="foodAmount" name="foodAmount" value="${bean.foodAmount}" />
				<input type="hidden" id="travelAmount" name="travelAmount" value="${bean.travelAmount}" /> <!-- 差旅费 -->
				<input type="hidden" id="meetTrainAmount" name="meetTrainAmount" value="${bean.meetTrainAmount}" /> <!-- 会议、培训费 -->
				
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 0px">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 100px;float: left;"><span style="text-align: left;color: red">*</span>支出项目-培训费</td>
							<td colspan="3"  style="padding-right: 5px;">
								<a href="#">
								<input class="easyui-textbox" style="width: 602px;height: 30px;"
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
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}</p></td>
							</tr>
					</table>				
				</div>
				</div>
				
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 事项摘要</td>
							<td colspan="3">
									<input class="easyui-textbox" style="width: 635px;height: 30px;margin-left: 10px  " readonly="readonly" value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>培训名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 635px;height: 30px;margin-left: 10px  " readonly="readonly" value="${bean.applyName}" name="applyName" required="required" data-options="validType:'length[1,100]'"/>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>培训事由</td>
							<td colspan="3">
								<textarea name="reason" id="reason" class="easyui-textbox" data-options="multiline:true" readonly="readonly"
									oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
									style="margin-left: 10px ;width:635px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${bean.reason }</textarea>
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
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 出发日期</td>
							<td class="td2">
								<input  class="easyui-datebox" style="width: 265px;; height: 30px;" readonly="readonly" id="travelDateStart" name="travelDateStart"
								data-options="" value="${travelBean.travelDateStart}" required="required" editable="false"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 结束日期</td>
							<td class="td2">
								<input class="easyui-datebox" style="width: 267px;; height: 30px;" readonly="readonly" id="travelDateEnd" name="travelDateEnd"
								data-options="" value="${travelBean.travelDateEnd}" required="required" editable="false"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
							<td class="td2">
								<input  class="easyui-combobox" style="width: 265px;; height: 30px;" readonly="readonly" id="fProvinceId" name="fProvinceId"
								value="${travelBean.fProvinceId}" required="required" editable="false"data-options="editable:false,
									url:'${base}/apply/getRegion?id=0&selected=${travelBean.fProvinceId}',
									method:'POST',
									valueField:'id',
									textField:'text'"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
							<td class="td2">
								<input class="easyui-combobox" style="width: 267px;; height: 30px;" readonly="readonly" id="fCityId" name="fCityId"
								value="${travelBean.fCityId}" required="required" editable="false" data-options="editable:false,
									method:'POST',
									url:'${base}/apply/getRegion?selected=${travelBean.fCityId}',
									valueField:'id',
									textField:'text',
									"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
							<td class="td2">
								<input  class="easyui-combobox" style="width: 265px;; height: 30px;" readonly="readonly" id="fDistrictId" name="fDistrictId"
								value="${travelBean.fDistrictId}" required="required" editable="false" data-options="editable:false,
									url:'${base}/apply/getRegion?selected=${travelBean.fDistrictId}',method:'POST',valueField:'id',textField:'text',
									"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
							<td class="td2">
								<input class="easyui-textbox" style="width: 267px;; height: 30px;" readonly="readonly" id="travelAreaName" name="travelAreaName"
								value="${travelBean.travelAreaName}" required="required" />
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 同行人</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 635px;height: 30px;margin-left: 10px" id="travelAttendPeop" readonly="readonly" value="${travelBean.travelAttendPeop}" name="travelAttendPeop" required="required"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 交通工具</td>
							<td colspan="3">
								<input  class="easyui-combobox" style="width: 265px;; height: 30px;" id="vehicle" readonly="readonly" name="vehicle"
								value="${travelBean.vehicle}" required="required" editable="false" />
							</td>
						</tr>
					</table>
				</div>				
				</div>
				<!-- 出差人员名单 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
					<div title="培训费明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px;">
						<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
							<tr>
								<td class="window-table-td1" style="width:20%"><span style="color: red"></span>住宿费</td>
								<td class="window-table-td2" style="width:27%">
									<p style=" color:#0000CD;"></p>
								</td>
								<td class="window-table-td1"></td>
								<td class="td2">
								</td>
							</tr>
							<tr>
								<td class="window-table-td1" colspan="2">
									<p>
										<input class="under" autocomplete="off" id="hotelPersonNum" readonly="readonly" name="hotelPersonNum" value="${travelBean.hotelPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" type="text">人·天
										<input class="under" autocomplete="off" id="realityHotelMoney" readonly="readonly" name="realityHotelMoney" value="${travelBean.realityHotelMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"  type="text">元/人·天
									</p>
								</td>
								<td class="window-table-td1"><p>申请金额：</p></td>
								<td class="td2">
									<input id="hotelMoney" name="hotelMoney" value="${travelBean.hotelMoney}" readonly="readonly" class="easyui-numberbox"
								 style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>
								</td>
							</tr>
							<tr>
								<td class="window-table-td1" style="width:15%"></td>
								<td class="window-table-td2" style="width:27%">
								</td>
								<td class="window-table-td1"><p>定额标准：</p></td>
								<td class="td2">
									<input class="under" id="hotelStds" name="hotelStd" value="${travelBean.hotelStd}" readonly="readonly" type="text">元
								</td>
							</tr>
						</table>
					<div style="height:10px;"></div>
						<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
							<tr>
								<td class="window-table-td1" style="width:20%"><span style="color: red"></span>培训学费</td>
								<td class="window-table-td2" style="width:27%">
									<p style=" color:#0000CD;"></p>
								</td>
								<td class="window-table-td1"><p>申请金额：</p></td>
								<td class="td2">
									<input id="trainMoney" name="trainMoney" readonly="readonly" value="${travelBean.trainMoney}" class="easyui-numberbox"
								 style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>
								</td>
							</tr>
						</table>
					<div style="margin-top: 15px;float: right;">合计金额：<span id="hejiAmount">${bean.amount}</span>元</div>
					<div style="height:10px;"></div>
					
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
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									
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
						<jsp:include page="../../../check_history.jsp" />
					</div>
				</div>
			</div>
			<div class="win-left-bottom-div">
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
			</div>
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>

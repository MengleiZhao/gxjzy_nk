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
	/* //可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	} */
	//批复时间
	var pfDate = $("#pfDate").val();
	if(pfDate !=""){
		$('#p_pfDate').html(pfDate);
	}	
	var applyAmount = $("#applyAmount").val();
	$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	
	var costFood = $("#costFood").val();
	if(costFood !=""){
		$('#costFood_span').html(fomatMoney(costFood,2)+" [元]");
	}
	var costHotel = $("#costHotel").val();
	if(costHotel !=""){
		$('#costHotel_span').html(fomatMoney(costHotel,2)+" [元]");
	}
	var costOther = $("#costOther").val();
	if(costOther !=""){
		$('#costOther_span').html(fomatMoney(costOther,2)+" [元]");
	}
	/* var plan1 = $("#diningPlacePlan1").val();
	var plan2 = $("#diningPlacePlan2").val();
	if(plan1=='1'){
    	$('#tr1').show();
	}else{
		$('#tr1').hide();
	}
	if(plan2=='1'){
    	$('#tr0').show();
	}else{
		$('#tr0').hide();
	} */
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
	/* 	if(${!empty xzbgsFile}){
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
		} */
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
setTimeout('hideColumn()',1000);
function hideColumn(){
	var isForeign = $('input[name="isForeign"]:checked').val();	
	if(isForeign=='1'){
		$('#rec-food-dg').datagrid('hideColumn', 'time');
		$('#rec-food-dg').datagrid('showColumn', 'date');
	}else{
		$('#rec-food-dg').datagrid('showColumn', 'time');
		$('#rec-food-dg').datagrid('hideColumn', 'date');
	}
}
</script>

<form id="apply_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="window-left-top-div" >
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
						<!-- 隐藏域主键 -->
			<input type="hidden" name="jId" value="${receptionBean.jId}" />
			<input type="hidden" id="diningPlaceHi" value="${receptionBean.diningPlace}" />
			<input type="hidden" id="receptionLevelHi" value="${receptionBean.receptionLevel}" />
			<input type="hidden" id="stayYNHi" value="${receptionBean.stayYN}" />
			<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;height: 150px;margin-left: 0px;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span class="style1">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<input class="easyui-textbox" style="width: 642px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
							 readonly="readonly" required="required"/>
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
							
							<tr hidden="hidden">
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}</p></td>
							</tr>
					</table>				
				</div>
				</div>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="基本信息" data-options="collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 摘要</td>
							<td colspan="3">
									<input class="easyui-textbox" readonly="readonly" style="width: 606px;height: 30px; " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
							<!-- 公务接待信息 -->
							<jsp:include page="../add/reception_detail.jsp" />
					</table>
				</div>				
				</div>
				<!-- 参考观察者安排 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="参考观察安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="../add/observe_plan.jsp" />
						</div>
					</div>
				</div> --%>
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="其他安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<tr style="height: 70px;">
							<td colspan="3">
								<textarea name="otherContet" readonly="readonly" id="otherContet" class="textbox-text"   autocomplete="off" 
								  style="width:700px;height:80px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBean.otherContet}</textarea>
							</td>
						</tr>
						</div>
					</div>
				</div> --%>
				<!-- 费用明细 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
							<!--  公务接待申请  明细 -->
							<jsp:include page="../add/mingxi_reception.jsp" />
							<div style="overflow:auto;margin-top: 10px;">
								<span style="float: left;">
									<span style="color: red;"  >申请金额总计： </span>
									<span style="float: right;"  id="applyAmount_span" >&nbsp;</span>
								</span>
							</div>
							<div class="window-table" style="margin-bottom:10px;">
								<div style="">
									<span>被接待人员自行缴纳伙食费和交通费情况</span>
								</div>
								<div style="width:700px;margin-top:10px;display:flex">
									<div style="flex:1;">
									<label>缴费人数&nbsp;</label> 
									<input type="text" name="paymentNum" class="easyui-numberbox" readonly="readonly" style="width:150px;" value="${receptionBean.paymentNum}" />
									</div>
									<div style="flex:1;">
									<label>缴费标准&nbsp; </label> 
									<input type="text" name="paymentStd" class="easyui-textbox" readonly="readonly" style="width:150px;"value="${receptionBean.paymentStd}" />
									</div>
									<div style="flex:1;">
									<label>缴费总金额&nbsp;</label> 
									<input type="text" name="paymentAmount" class="easyui-numberbox" readonly="readonly" style="width:150px;" value="${receptionBean.paymentAmount}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"/>
									</div>
								</div>	
							</div>										
						</div>
					</div>
				</div> --%>
				
				
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr class="trbody">
								<td class="td1" style="width:55px;">附件</td>
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
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="三重一大会议信息" data-options="collapsible:false" style="overflow:auto; ">
							<jsp:include page="../add/check_meeting_infomation.jsp" />
						</div>
				</div> --%>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;">
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
						<%-- <a href="javascript:void(0)" onclick="showFlowDesinger()">
							<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a> --%>
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
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
</div>
</form>

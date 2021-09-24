<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>

<script type="text/javascript">
//显示详细信息手风琴页面
$(document).ready(function() {
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
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
	var applyAmount = $("#applyAmount").val();
	$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	
	var lessonHours = $("#lessonHours").val();
	if(lessonHours !=""){
		$('#totalHout_span').html(fomatMoney(lessonHours,2)+" [小时]");
	}
	var hotelMoney = $("#hotelMoney").val();
	if(hotelMoney !=""){
		$('#p_hotelMoney').html(fomatMoney(hotelMoney,2)+" [元]");
	}
	var foodMoney = $("#foodMoney").val();
	if(foodMoney !=""){
		$('#p_foodMoney').html(fomatMoney(foodMoney,2)+" [元]");
	}
	var lessonMoney1 = $("#lessonMoney1").val();
	if(lessonMoney1 !=""){
		$('#p_lessonMoney1').html(fomatMoney(lessonMoney1,2)+" [元]");
	}
	var lessonMoney2 = $("#lessonMoney2").val();
	if(lessonMoney2 !=""){
		$('#p_lessonMoney2').html(fomatMoney(lessonMoney2,2)+" [元]");
	}
	var lessonMoney3 = $("#lessonMoney3").val();
	if(lessonMoney3 !=""){
		$('#p_lessonMoney3').html(fomatMoney(lessonMoney3,2)+" [元]");
	}
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	if (h == 1) {
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
		/* $("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息'); */
	}
	if (h == 2) {//会议
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 3) {//培训
		$('#sqsqhyxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 4) {//差旅
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 5) {//接待
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 6) {//公务用车
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 7) {//公务出国
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
	}
/* 			
	if (h == 1) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 2) {
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 3) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 4) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 5) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 6) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 7) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
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
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
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
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 0px">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td class="td1" style="width: 60px;"><span style="text-align: left;color: red">*</span> 支出项目:</td>
							<td colspan="3" >
								<input class="easyui-textbox" readonly="readonly" style="width: 637px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width: 707px;height: 50px;">
							<tr>
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								<td class="window-table-td1"><p></p></td>
								<td class="window-table-td2"><p></p></td>
							</tr>
							<tr hidden="hidden">
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}</p></td>
							</tr>
					</table>				
				</div>
				</div>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsible:false,collapsible:false" style="overflow:auto;"
					>
					
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px;padding-left: 2px">
						<tr class="trbody">
									<td class="td1"><span class="style1">*</span>单据编号</td>
									<td colspan="3" ><input
										style="width: 580px;height: 30px;margin-left: 10px"
										readonly="readonly" name="gCode" class="easyui-textbox"
										value="${bean.gCode}"
										data-options="required:true"
										readonly="readonly" /></td>
							</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 摘要</td>
							<td colspan="3" >
									<input class="easyui-textbox" style="width: 580px;height: 30px; " value="${bean.gName}" name="gName" readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<jsp:include page="../add/training_detail.jsp" />
					</table>
				</div>				
				</div>
				
				<!-- 讲师信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="讲师信息" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="../add/train_lecturer.jsp" />
					</div>
				</div>
				</div>
				
				<!-- 培训日程 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="培训日程" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="../add/train_plan.jsp" />
					</div>
				</div>
				</div>
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto">
							<!--  综合预算  明细 -->
						<div style="margin-top: 20px">
							<jsp:include page="../add/mingxi-train-zongheys.jsp" />
						</div>
						<div style="height:10px;"></div>
						<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
								<tr>
									<td class="window-table-td1" style="width:20%"><p>综合预算总计：</p></td>
									<td class="td2" style="width:27%">
										<input class="under" id="zongheMoney" value="${trainingBean.zongheMoney}" name="zongheMoney" readonly="readonly" type="text">元
									</td>
									<td class="window-table-td1"><p>定额标准总计：</p></td>
									<td class="td2">
										<input class="under" id="zongheMoneyStd" value="${trainingBean.zongheMoneyStd}" name="zongheMoneyStd" readonly="readonly" type="text">元
									</td>
								</tr>
						</table>
							<!--  师资费-讲课费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="../add/mingxi-train-lessons.jsp" />
						</div>	
							<!--  师资费-住宿费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="../add/mingxi-train-hotel.jsp" />
						</div>	
							<!--  师资费-伙食费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="../add/mingxi-train-food.jsp" />
						</div>	
							<!--  师资费-城市间交通费 -->
						<div style="overflow:auto;margin-top: 20px">
							<jsp:include page="../add/mingxi-train-trafficCityToCity.jsp" />
						</div>
						<div style="margin-top: 20px">
							<div style="color: red;"><a style="color: red;">${bean.fTrafficHint}</a></div>
						</div>
						<div style="overflow:auto;margin-top: 10px;">
							<span style="float: right;">
								<span style="color: red;"  >申请总额： </span>
								<span style="float: right;"  id="applyAmount_span" >&nbsp;</span>
							</span>
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
									&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
				</div>
				<c:if test="${!empty xzbgsFile || !empty dwhFile }">
				<!-- 三重一大会议信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="三重一大会议信息" data-options="collapsible:false" style="overflow:auto; ">
						<jsp:include page="../add/check_meeting_infomation.jsp" />
					</div>
				</div>
				</c:if>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../../check_history.jsp" />
					</div>
				</div>
			</div>
			
			<c:if test="${checkUser!=1 }">
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
				<div class="win-left-bottom-div">
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
			<div class="window-right-div" style="width:260px;height: 591px">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
		</div>	
</form>
</body>
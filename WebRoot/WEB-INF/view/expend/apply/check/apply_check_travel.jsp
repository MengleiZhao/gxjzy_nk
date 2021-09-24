<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
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
				<!-- 申请总额  --><input type="hidden" id="applyAmount" name="amount" hidden="hidden" value="${bean.amount}"/>
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
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3"  style="padding-right: 5px;">
								<input class="easyui-textbox" style="width: 635px;height: 30px;" value="${bean.indexName}" id="" data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
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
					</table>				
				</div>
				</div>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px;">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 事项摘要</td>
							<td colspan="3">
									<input class="easyui-textbox" style="width: 635px;height: 30px; " value="${bean.gName}" name="gName" readonly="readonly" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 出差类型:</td>
							<td class="td2" colspan="3">
							<input class="easyui-combobox" id="travelType" readonly="readonly" name="travelType" style="width: 635px;height: 30px;" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=CCLX&selected=${bean.travelType }',method:'POST',valueField:'code',textField:'text'">
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>出差事由</td>
							<td colspan="3" >
								<textarea readonly="readonly" name="reason" id="reason" class="textbox-text"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:630px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:6px; margin-bottom:0px;">${bean.reason }</textarea>
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
						<jsp:include page="../add/apply_travel_itinerary_detail.jsp" />
					</div>
					<div style="margin-top: 20px">
						<div style="color: red;">${bean.fHotelHint}</div>
						<div style="color: red;">${bean.fTrafficHint}</div>
					</div>
					</div>
				</div>
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;padding:10px;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left">
								附件:
							</td>
							<td colspan="3" id="tdf">
								<c:if test="${!empty attaList}">
								<c:forEach items="${attaList}" var="att">
									<c:if test="${att.serviceType=='null'}">
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
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
</div>
</form>
</body>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<form id="reimburse_save_form" method="post"  enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" <c:if test="${operation!='add'}"> value="${bean.rCode}"</c:if> <c:if test="${operation=='add'}"> value="${bean.gCode}"</c:if>/>
				<!-- 申请单号 --><input type="hidden" name="gCode" value="${applyBean.gCode}" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}"/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${applyBean.indexId}" id=""/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
				<!-- 培训是否调整 --><input hidden="hidden" id="fupdateStatusid" name="fupdateStatus" value="${bean.fupdateStatus}" />
				<!-- 培训调整说明 --><input hidden="hidden" id="fupdateReasonid" name="fupdateReason" value="${bean.fupdateReason}" />
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 付款方式 --><input type="hidden" name="paymentType" value="${bean.paymentType}" id="paymentType"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="proDetailId"/>
				<!-- 发票明细json -->
				<input type="hidden" id="json1" name="form1"/>
				<input type="hidden" id="json2" name="form2"/>
				<input type="hidden" id="json3" name="form3"/>
				<input type="hidden" id="json4" name="form4"/>
				<input type="hidden" id="json5" name="form5"/>
				<!-- 收款人json -->
				<input type="hidden" id="payerinfoJson" name="payerinfoJson"/>
				<!-- 转账金额 -->
				<input type="hidden" id="payeeAmount"/>
				<input type="hidden" id="payeeAmountgr"/>
				<!-- 应转账金额转账金额 -->
				<input type="hidden" id="skAmount"/>
				<!-- 冲销金额 -->
				<input id="withLoan" value="${bean.withLoan}" hidden="hidden" name="withLoan" />
				<input id="cxAmounts" value="${bean.cxAmount}" name="cxAmount" hidden="hidden"  />
				<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
				<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
				<!-- 列表json -->
				<input type="hidden" id="trainLecturerJson" name="trainLecturer" />
				<input type="hidden" id="trainPlan" name="trainPlan" />
				<input type="hidden" id="zongheJson" name="zongheJson"/>
				<input type="hidden" id="lessonJson" name="lessonJson"/>
				<input type="hidden" id="hotelJson" name="hotelJson"/>
				<input type="hidden" id="foodJson" name="foodJson"/>
				<input type="hidden" id="trafficJson1" name="trafficJson1"/>
				<input type="hidden" id="trafficJson2" name="trafficJson2"/>
				<!-- 综合预算申请金额  --><input type="hidden" id="zongheMoneys" name="zongheMoney" <c:if test="${operation!='add'}"> value="${reimbTrainingBean.zongheMoney}"</c:if> <c:if test="${operation=='add'}"> value="${trainingBean.zongheMoney}"</c:if>/>
				<!-- 综合预算申请金额  --><input type="hidden" id="zongheMoneyStds" name="zongheMoneyStd" <c:if test="${operation!='add'}"> value="${reimbTrainingBean.zongheMoneyStd}"</c:if> <c:if test="${operation=='add'}"> value="${trainingBean.zongheMoneyStd}"</c:if>/>
				<!-- 其它费用：金额标准  --><input type="hidden" id="otherStdH" name="otherStd" <c:if test="${operation!='add'}"> value="${reimbTrainingBean.otherStd}"</c:if> <c:if test="${operation=='add'}"> value="${trainingBean.otherStd}"</c:if>/>
				<!-- 资料、场地、交通费用：金额标准  --><input type="hidden" id="zongheStdH" name="costThreeTermsStd" <c:if test="${operation!='add'}"> value="${reimbTrainingBean.costThreeTermsStd}"</c:if> <c:if test="${operation=='add'}"> value="${trainingBean.costThreeTermsStd}"</c:if>/>
				<!-- 讲课费申请金额  --><input type="hidden" id="lessonsMoney" name="lessonsMoney" value="${reimbTrainingBean.lessonsMoney}"/>
				<!-- 师资费-住宿费金额  --><input type="hidden" id="lessonsHotelMoney" name="lessonsHotelMoney" value="${reimbTrainingBean.lessonsHotelMoney}"/>
				<!-- 师资费-伙食费金额  --><input type="hidden" id="lessonsFoodMoney" name="lessonsFoodMoney" value="${reimbTrainingBean.lessonsFoodMoney}"/>
				<!-- 师资费-城市间交通费金额  --><input type="hidden" id="lessonsOutMoney" name="lessonsOutMoney" value="${reimbTrainingBean.lessonsOutMoney}"/>
				<!-- 师资费-市内交通费金额  --><input type="hidden" id="lessonsInMoney" name="lessonsInMoney" value="${reimbTrainingBean.lessonsInMoney}"/>
				<c:if test="${operation=='edit'}"><input type="hidden" name="tId" value="${reimbTrainingBean.tId}" /></c:if>
				<!-- 附件信息 -->
				<input type="text" id="files" name="files" hidden="hidden">
				<!-- 住宿费人数  --><input type="hidden" id="hotelPersonNums" name="hotelPersonNum"  value="${reimbTrainingBean.hotelPersonNum}"/>
				<!-- 住宿费实际金额  --><input type="hidden" id="realityHotelMoneys" name="realityHotelMoney"  value="${reimbTrainingBean.realityHotelMoney}"/>
				<!-- 住宿费天数  --><input type="hidden" id="hotelDays" name="hotelDay"  value="${reimbTrainingBean.hotelDay}"/>
				<!-- 住宿费标准  --><input type="hidden" id="hotelStdH" name="hotelStd"  value="${reimbTrainingBean.hotelStd}"/>
				<!-- 住宿费申请金额  --><input type="hidden" id="hotelMoneys" name="hotelMoney"  value="${reimbTrainingBean.hotelMoney}"/>
				<!-- 伙食费人数  --><input type="hidden" id="foodPersonNums" name="foodPersonNum"  value="${reimbTrainingBean.foodPersonNum}"/>
				<!-- 伙食费实际金额  --><input type="hidden" id="realityFoodMoneys" name="realityFoodMoney"  value="${reimbTrainingBean.realityFoodMoney}"/>
				<!-- 伙食费天数  --><input type="hidden" id="foodDays" name="foodDay"  value="${reimbTrainingBean.foodDay}"/>
				<!-- 伙食费标准  --><input type="hidden" id="foodStdH" name="foodStd"  value="${reimbTrainingBean.foodStd}"/>
				<!-- 伙食费申请金额  --><input type="hidden" id="foodMoneys" name="foodMoney"  value="${reimbTrainingBean.foodMoney}"/>
				<!-- 培训资料费人数  --><input type="hidden" id="dataPersonNums" name="dataPersonNum"  value="${reimbTrainingBean.dataPersonNum}"/>
				<!-- 培训资料费实际金额  --><input type="hidden" id="realityDataMoneys" name="realityDataMoney"  value="${reimbTrainingBean.realityDataMoney}"/>
				<!-- 培训资料费申请金额  --><input type="hidden" id="dataMoneys" name="dataMoney"  value="${reimbTrainingBean.dataMoney}"/>
				<!-- 培训场地费申请金额  --><input type="hidden" id="spaceMoneys" name="spaceMoney"  value="${reimbTrainingBean.spaceMoney}"/>
				<!-- 交通费申请金额  --><input type="hidden" id="transportMoneys" name="transportMoney"  value="${reimbTrainingBean.transportMoney}"/>
				<!-- 综合申请金额  --><input type="hidden" id="costThreeTermsMoneys" name="costThreeTermsMoney"  value="${reimbTrainingBean.costThreeTermsMoney}"/>
				<!-- 其他费用申请金额  --><input type="hidden" id="otherMoneys" name="otherMoney"  value="${reimbTrainingBean.otherMoney}"/>
				<!-- 其他费用人数  --><input type="hidden" id="otherPersonNums" name="otherPersonNum"  value="${reimbTrainingBean.otherPersonNum}"/>
				<!-- 其他费用实际金额  --><input type="hidden" id="realityOtherMoneys" name="realityOtherMoney"  value="${reimbTrainingBean.realityOtherMoney}"/>
				<!-- 代扣代缴个人所得税金额  --><input type="hidden" id="fIndividualIncomeTax" name="fIndividualIncomeTax"  value="${reimbTrainingBean.fIndividualIncomeTax}"/>
				</div>	
<!-- 预算信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
<div title="预算信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;margin-left: 0px;">				
	<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">					
		<tr class="trbody">
			<td style="width: 60px;"><span class="style1">*</span> 支出项目</td>
			<td colspan="3" style="padding-right: 5px;">
				<input class="easyui-textbox" style="width: 630px;height: 30px;"
				 value="${bean.indexName}" id="F_fBudgetIndexName"
				 readonly="readonly" required="required"/>
			</td>
		</tr>
	</table>	
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left:0px;;margin-bottom: 0px;width: 695px;height: 50px;">
		<tr>
			<td class="window-table-td1"><p style=" color:#0000CD;">申请金额:</p></td>
			<td class="window-table-td2"><p id="applyAmount_span">${applyBean.amount}[元]</p></td>
			<td class="window-table-td1"><p style="color: red;" >报销金额:</p></td>
			<td class="window-table-td2"><p id="p_amount">${bean.amount}[元]</p></td>
		</tr>
		<tr>
			<td class="window-table-td1"><p>归还预算:</p></td>
			<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
		</tr>
		<tr >
			<td class="window-table-td1"><p>是否冲销借款</p></td>
			<td class="window-table-td2">
				<input id="hotelstd_add_sfwj" name="withLoans" value="1"
					type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
				<input id="hotelstd_add_sfwj" name="withLoans" value="0"
					type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1 }">checked="checked"</c:if>/>否
			</td>	
		</tr>
		<tbody id="jk">
			<tr>
				<td class="window-table-td1"><p>借款单号:</p></td>
				<td class="window-table-td2">
					<a href="#" onclick="chooseJkd()">
						<input class="easyui-textbox" id="input_jkdbh" style="width: 250px;height: 30px;" data-options="prompt: '借款单选择' ,icons: [{iconCls:'icon-sousuo'}]"
						value="${bean.loan.lCode}" readonly="readonly" >
						
					</a>
				</td>
			</tr>
			<tr>
				<td class="window-table-td1"><p>本次冲销金额:</p></td>
				<td class="window-table-td2"><p id="cxAmount">[元]</p></td>
				<td class="window-table-td1"><p>剩余应还:</p></td>
				<td class="window-table-td2"><p id="syAmount">[元]</p></td>
			</tr>
		</tbody>
		</table>			
	</div>
</div>	
<!-- 基本信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<table class="window-table" style="margin-top: 3px;width: 695px;padding-right: 5px;" cellspacing="0" cellpadding="0">
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>事项摘要</td>
			<td colspan="3" class="td2">
				<input style="width: 580px; height: 30px;margin-left: 10px" id="gName"  name="gName" class="easyui-textbox" value="${bean.gName}" />
			</td>
		</tr>
			<jsp:include page="reimburse_traininginfo.jsp" />
			</table>
		</div>				
	</div>
</form>	
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="培训事项调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
		<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1" style="width: 80px;"><span class="style1">*</span>是否存在调整</td>
				<td class="td2" colspan="4" >
					<input type="radio" value="1" onclick="radioyes()" name="fupdateStatus" id="box1" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" onclick="radiono()" name="fupdateStatus" id="box2" <c:if test="${bean.fupdateStatus=='0'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td>
			</tr>
			<tr id="radiofupdate" <c:if test="${bean.fupdateStatus=='0'}"> hidden="hidden" </c:if> class="trbody">
				<td class="td1" style="width: 80px;"><span class="style1">*</span>培训调整说明</td>
				<td colspan="3" class="td2" >
					<textarea name="fupdateReason"  id="fupdateReason" class="textbox-text"
							oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
							style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
				</td>
			</tr>
		</table>
	</div>				
</div>
<!-- 调整后讲师信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="讲师信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
		<div style="overflow:auto;margin-top: 0px;">
			<jsp:include page="reimburse_train_lecturer.jsp" />
		</div>
	</div>
</div>
<!-- 调整后培训日程 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="培训日程" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
		<div style="overflow:auto;margin-top: 0px;">
			<jsp:include page="reimburse_train_plan.jsp" />
		</div>
	</div>
</div>
<!-- 费用明细 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
	<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<!--  综合预算  明细 -->
		<div style="margin-top: 20px">
			<jsp:include page="reimburse_mingxi-train-zongheys.jsp" />
		</div>
		<div style="height:10px;"></div>
		<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
				<tr>
					<td class="window-table-td1" style="width:20%">综合预算总计</td>
					<td class="window-table-td2" style="width:27%">
						<input class="under" id="zongheMoney" 
						<c:if test="${operation=='add'}"> value="${trainingBean.zongheMoney}"</c:if>
			 			<c:if test="${operation!='add'}"> value="${reimbTrainingBean.zongheMoney}"</c:if>
						 readonly="readonly" type="text">元
					</td>
					<td class="window-table-td1"><p>定额标准总计：</p></td>
					<td class="td2">
						<input class="under" id="zongheMoneyStd"
						<c:if test="${operation=='add'}"> value="${trainingBean.zongheMoneyStd}"</c:if>
			 			<c:if test="${operation!='add'}"> value="${reimbTrainingBean.zongheMoneyStd}"</c:if>
						readonly="readonly" type="text">元
					</td>
				</tr>
		</table>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_zonghe_invoice.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_zonghe_invoice_edit.jsp" />
			</div>
		</c:if>
		<!--  师资费-讲课费  明细 -->
		<div style="overflow:auto;margin-top: 20px">
			<jsp:include page="reimburse_mingxi-train-lessons.jsp" />
		</div>
		<!--  住宿费  明细 -->
		<div style="overflow:auto;margin-top: 20px">
			<jsp:include page="reimburse_mingxi-train-hotel.jsp" />
		</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_hotel_invoice.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_hotel_invoice_edit.jsp" />
			</div>
		</c:if>
		<!--  伙食费  明细 -->
		<div style="overflow:auto;margin-top: 20px">
			<jsp:include page="reimburse_mingxi-train-food.jsp" />
		</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_food_invoice.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_food_invoice_edit.jsp" />
			</div>
		</c:if>
		<!--  城市间交通费  明细 -->
		<div style="overflow:auto;margin-top: 20px">
			<jsp:include page="reimburse_mingxi-train-trafficCityToCity.jsp" />
		</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_trafficCityToCity_invoice.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_trafficCityToCity_invoice_edit.jsp" />
			</div>
		</c:if>
		<!--  其他费用  明细 -->
		<div style="overflow:auto;margin-top: 20px" hidden="hidden">
			<jsp:include page="reimburse_mingxi-train-trafficInCity.jsp" />
		</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px" hidden="hidden">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_trafficInCity_invoice.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px" hidden="hidden">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_train_trafficInCity_invoice_edit.jsp" />
			</div>
		</c:if>
	</div>
</div>	

<!-- 收款人信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;height: auto;">
	<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
		<div id="" style="overflow-x:hidden;margin-top: 0px;">
			<jsp:include page="payee-info.jsp" />	
		</div>
		<div style="height:10px;"></div>
		<div style="overflow:hidden;margin-top: 0px;height: 40px;">
			<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
				<tr>
					<td class="window-table-td1" style="width:20%">代扣代缴个人所得税：</td>
					<td class="window-table-td2" style="width:27%">
						<input class="under" id="fIndividualIncomeTaxs" value="${reimbTrainingBean.fIndividualIncomeTax}" readonly="readonly" type="text">元
					</td>
					<td class="window-table-td1"><p></p></td>
					<td class="td2">
					</td>
				</tr>
			</table>
		</div>
		<div style="height:10px;"></div>
	</div>
</div>
<!-- 附件信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
<div title="附件信息" data-options="collapsed:false,collapsible:false"
	style="overflow:auto;">		
	<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
		<tr>
			<td style="width:75px;text-align: left">附件
				<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'bxsq','zcgl01')" hidden="hidden">
			</td>
			<td colspan="3" id="tdf">
				&nbsp;&nbsp;
				<a onclick="$('#f').click()" style="font-weight: bold;  " href="#">
					<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>
				<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
					<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
					 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
				</div>
				<c:forEach items="${attaList1}" var="att">
					<div style="margin-top: 5px;">
					<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
					</div>
				</c:forEach>
			</td>
		</tr>
	</table>
</div>
</div>
<script type="text/javascript">
var flag1=0;
var flag2=0;
setTimeout('loadReadonly()',100)
function loadReadonly(){
	if('${bean.fupdateStatus}'==0){
		$('#trainingName').textbox('readonly',true);
		$('#trContent').textbox('readonly',true);
		$('#trainingType').combobox('readonly',true);
		$('#trDateStart').datebox('readonly',true);
		$('#trDateEnd').datebox('readonly',true);
		$('#trAttendNum').numberbox('readonly',true);
		$('#trStaffNum').numberbox('readonly',true);
		$('#trPlace').textbox('readonly',true);
		$('#trAttendPeop').textbox('readonly',true);	
		$('#fProvinceId').combobox('readonly',true);
		$('#fCityId').combobox('readonly',true);
		$('#fDistrictId').combobox('readonly',true);
	}
}

var updateradio = 0;
function radiono(){
	
	updateradio=1;
	$('#radiofupdate').hide();
	$("#dmp1").css("display","none");
	$('#fupdateStatusid').val(0);
	$('#trainingName').textbox('readonly',true);
	$('#trContent').textbox('readonly',true);
	$('#trainingType').combobox('readonly',true);	
	$('#fProvinceId').combobox('readonly',true);
	$('#fCityId').combobox('readonly',true);
	$('#fDistrictId').combobox('readonly',true);
	
	$('#trDateStart').datebox('readonly',true);
	$('#trDateEnd').datebox('readonly',true);
	$('#trAttendNum').numberbox('readonly',true);
	$('#trStaffNum').numberbox('readonly',true);
	$('#trPlace').textbox('readonly',true);
	$('#trAttendPeop').textbox('readonly',true);
	$('#reimburse_save_form').form('reset')
	$("#rp").hide();
	flag2=1;
	$('#dg_train_lecturer').datagrid('reload')
	editIndex1 = undefined;
	$('#dg_train_plan').datagrid('reload')
	editIndex2 = undefined;
	$('#mingxi-zonghe-dg').datagrid('reload')
	editIndex3 = undefined;
	$('#mingxi-lessons-dg').datagrid('reload')
	editIndex4 = undefined;
	$('#mingxi-hotel-dg').datagrid('reload')
	editIndex5 = undefined;
	$('#mingxi-food-dg').datagrid('reload')
	editIndex6 = undefined;
	$('#mingxi-trafficCityToCity-dg').datagrid('reload')
	editIndex7 = undefined;
	$('#mingxi-trafficInCity-dg').datagrid('reload')
	editIndex8 = undefined;
}
function radioyes(){
	updateradio=0;
	$("#dmp1").css("display","block");
	$('#radiofupdate').show();
	$('#fupdateStatusid').val(1);
	$('#trainingName').textbox('readonly',false);
	$('#trContent').textbox('readonly',false);
	$('#trainingType').combobox('readonly',false);
	$('#trDateStart').datebox('readonly',false);
	$('#trDateEnd').datebox('readonly',false);
	$('#trAttendNum').numberbox('readonly',false);
	$('#trStaffNum').numberbox('readonly',false);
	$('#trPlace').textbox('readonly',false);
	$('#trAttendPeop').textbox('readonly',false);	
	$('#fProvinceId').combobox('readonly',false);
	$('#fCityId').combobox('readonly',false);
	$('#fDistrictId').combobox('readonly',false);
	$("#rp").show();
	flag2=0;
}
//接待人员表格添加删除，保存方法
var editIndex1 = undefined;
function endEditingR() {
	if (editIndex1 == undefined) {
		return true
	}
	if ($('#dg_meet_plan').datagrid('validateRow', editIndex1)) {
		var dmp = $('#dg_meet_plan').datagrid('getEditor', {
			index : editIndex1,
			field : 'costDetail'
		});
		$('#dg_meet_plan').datagrid('endEdit', editIndex1);
		editIndex1 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowR(index) {
	if (editIndex1 != index) {
		if (endEditingR()) {
			$('#dg_meet_plan').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex1 = index;
		} else {
			$('#dg_meet_plan').datagrid('selectRow', editIndex1);
		}
	}
}
function appendR() {
	if (endEditingR()) {
		$('#dg_meet_plan').datagrid('appendRow', {});
		editIndex1 = $('#dg_meet_plan').datagrid('getRows').length - 1;
		$('#dg_meet_plan').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
	}
}
function removeitR() {
	if (editIndex1 == undefined) {
		return
	}
	$('#dg_meet_plan').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
			editIndex1);
	editIndex1 = undefined;
}
function acceptR() {
	if (endEditingR()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
}


function changeTime1(){
	var index=$('#dg_meet_plan').datagrid('getRowIndex',$('#dg_meet_plan').datagrid('getSelected'));
	var editors = $('#dg_meet_plan').datagrid('getEditors', index);  
	var endEditor = editors[1]; 
	var startday = Date.parse(new Date(editors[0].target.val()));
	var maxTime = Date.parse(new Date($("#meetingDateEnd").datetimebox('getValue')))+ (16 * 60 * 60 * 1000);
    var minTime = Date.parse(new Date($("#meetingDateStart").datetimebox('getValue')))- (8 * 60 * 60 * 1000);
	var endday = Date.parse(new Date(endEditor.target.val()));
	if(!isNaN(startday)){
    	if((startday>=minTime &&startday<=maxTime) ){
    		if(!isNaN(endday)){
	    		if(endday<startday){
	        		alert("结束日期不能小于开始日期！");
	        		editors[0].target.datetimebox('setValue', '');
	        	}
    		}
    	}else{
    		if(startday>maxTime || startday<minTime){
	    	alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datetimebox('setValue', '');
    		}
    	}
    	
    } 
}


function changeTime2(){
	var index=$('#dg_meet_plan').datagrid('getRowIndex',$('#dg_meet_plan').datagrid('getSelected'));
	var editors = $('#dg_meet_plan').datagrid('getEditors', index);  
	var endEditor = editors[1]; 
	var startday = Date.parse(new Date(editors[0].target.val()));
	var maxTime = Date.parse(new Date($("#meetingDateEnd").datetimebox('getValue')))+ (16 * 60 * 60 * 1000);
    var minTime = Date.parse(new Date($("#meetingDateStart").datetimebox('getValue')))- (8 * 60 * 60 * 1000);
	var endday = Date.parse(new Date(endEditor.target.val()));
	if(!isNaN(endday)){
    	if((endday>=minTime &&endday<=maxTime) ){
    		if(!isNaN(startday)){
	    		if(endday<startday){
	        		alert("结束日期不能小于开始日期！");
	        		editors[1].target.datetimebox('setValue', '');
	        	}
    		}
    	}else{
    		if(endday>maxTime || endday<minTime){
	    	alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datetimebox('setValue', '');
    		}
    	}
    	
    } 
}
function addTotalAmounts(){
	var totalAmount=0;
	var num1=parseFloat($('#zongheMoneys').val());
	if(!isNaN(num1)){
		totalAmount=totalAmount+num1;
	}
	var num2=parseFloat($('#lessonsMoney').val());
	if(!isNaN(num2)){
		totalAmount=totalAmount+num2;
	}
	var num3=parseFloat($('#lessonsHotelMoney').val());
	if(!isNaN(num3)){
		totalAmount=totalAmount+num3;
	}
	var num4=parseFloat($('#lessonsFoodMoney').val());
	if(!isNaN(num4)){
		totalAmount=totalAmount+num4;
	}
	var num5=parseFloat($('#lessonsOutMoney').val());
	if(!isNaN(num5)){
		totalAmount=totalAmount+num5;
	}
	var num6=parseFloat($('#lessonsInMoney').val());
	if(!isNaN(num6)){
		totalAmount=totalAmount+num6;
	}
	$('#reimburseAmount').val(totalAmount.toFixed(2));
	$('#reimbAmount_span').html(fomatMoney(totalAmount,2));
	$('#p_amount').html(fomatMoney(totalAmount,2)+"[元]");
	cx();
}
</script>
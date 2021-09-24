<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div" style="">
		<c:if test="${operation=='add' }">
			<div <c:if test="${applyBean.fFoodNum!=1 || empty applyBean.fFoodNum}"> hidden="hidden" </c:if> id="hiddenReimId">
				<a style="display: block; text-align: center;border: 1px solid red;color: red;margin-left: 220px;width: 360px;border-radius: 4px;">您当前出行日期中，伙食费已申报,请核对!</a>
			</div>
		</c:if>
		<c:if test="${operation=='edit' }">
			<div <c:if test="${bean.fFoodNum!=1 || empty bean.fFoodNum}"> hidden="hidden" </c:if> id="hiddenReimId">
				<a style="display: block; text-align: center;border: 1px solid red;color: red;margin-left: 220px;width: 360px;border-radius: 4px;">您当前出行日期中，伙食费已申报,请核对!</a>
			</div>
		</c:if>
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<form id="reimburse_save_form" method="post" style="height: 0px;" enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" <c:if test="${operation=='add' }">value="${applyBean.gCode}"</c:if><c:if test="${operation=='edit' }"> value="${bean.rCode}"</c:if>/>
				<!-- 申请单流水号 --><input type="hidden" name="gCode"<c:if test="${operation=='add' }">value="${applyBean.gCode}"</c:if><c:if test="${operation=='edit' }">value="${bean.gCode}"</c:if> />
				<!-- 报销事由 --><input type="hidden" name="reimburseReason" value="${bean.reimburseReason}" id="reimburseReason" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<!-- 报销状态 --><input type="hidden" name="reimName" value="${bean.reimName}" id="reimNames" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" <c:if test="${operation=='edit' }">value="${bean.amount}"</c:if><c:if test="${operation=='add'}">value="${applyBean.amount-applyBean.outsideAmount-applyBean.hotelAmount}"</c:if> />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="F_proDetailId"/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 是否含随行学生 --><input type="hidden" id="fWhetherAccompany" name="fWhetherAccompany" value="${bean.fWhetherAccompany}"/>
				<!-- 出差类型 --><input type="hidden" id="travelType" name="travelType" value="${applyBean.travelType}" />
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name="deptName" value="${bean.deptName}" id="input_deptName"/>
				<!-- 报销部门 --><input type="hidden" name="gName" value="${bean.gName}" id="gName"/>
				<!-- 付款方式 --><input type="hidden" name="paymentType" value="${bean.paymentType}" id="paymentType"/>
				<%-- <!-- 申请总额  --><input id="applyAmount" name="amount" type="hidden" value="${bean.amount}"/> --%>
				<!-- 行程是否调整 --><input hidden="hidden" id="fupdateStatusid" name="fupdateStatus" value="${bean.fupdateStatus}" />
				<!-- 行程调整说明 --><input hidden="hidden" id="fupdateReasonid" name="fupdateReason" value="${bean.fupdateReason}" />
				<!-- 最早的出发时间  --><input type="hidden" id="maxTime" />
				<!-- 最晚的撤离时间  --><input type="hidden" id="minTime" />
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<input type="hidden" id="json1" name="form1" />
				<input type="hidden" id="json2" name="form2" />
				<input type="hidden" id="json3" name="form3" />
				<input type="hidden" id="json4" name="form4" />
				<input type="hidden" id="json5" name="form5" />
				<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				</div>
				<input type="hidden" name="trId" <c:if test="${operation!='add' }"> value="${reimTravelBean.trId}"</c:if> />
				<input type="hidden" name="travelRId" value="${tPeopBean.travelRId}" />
				<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
				<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
				<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
				<input type="hidden" id="trainMoneys" name="trainMoney" value="${reimTravelBean.trainMoney}" /><!-- 培训学费 -->
				<input type="hidden" id="travelAttendPeopId" name="travelAttendPeopId" value="${reimTravelBean.travelAttendPeopId}" /><!-- 同行人ID -->
				<input type="hidden" id="travelAttendPeops" name="travelAttendPeop" value="${reimTravelBean.travelAttendPeop}" /><!-- 同行人ID -->
				<input type="hidden" id="travelPersonnelLevel" name="travelPersonnelLevel" value="${reimTravelBean.travelPersonnelLevel}" /><!-- 同行人级别 -->
				<input type="hidden" id="travelDateStarts" name="travelDateStart" value="${reimTravelBean.travelDateStart}" /><!-- 开始时间 -->
				<input type="hidden" id="travelDateEnds" name="travelDateEnd" value="${reimTravelBean.travelDateEnd}" /><!-- 结束时间 -->
				<input type="hidden" id="fProvinceIds" name="fProvinceId" value="${reimTravelBean.fProvinceId}" /><!-- 省 -->
				<input type="hidden" id="fCityIds" name="fCityId" value="${reimTravelBean.fCityId}" /><!-- 市 -->
				<input type="hidden" id="fDistrictIds" name="fDistrictId" value="${reimTravelBean.fDistrictId}" /><!-- 区 -->
				<input type="hidden" id="travelAreaNames" name="travelAreaName" value="${reimTravelBean.travelAreaName}" /><!-- 详细地址 -->
				<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
				<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
				<!-- 是否重复申报伙食费 --><input type="hidden" id="fFoodNum" name="fFoodNum" <c:if test="${operation=='add' }"> value="${applyBean.fFoodNum}"</c:if><c:if test="${operation=='edit' }"> value="${bean.fFoodNum}" </c:if>/>
				<!-- 转账金额 -->
				<input type="hidden" id="payeeAmount"/>
				<!-- 应转账金额转账金额 -->
				<input type="hidden" id="skAmount"/>
				<input type="hidden" id="withLoan" name="withLoan" value="${bean.withLoan }"/>
				<!-- 冲销金额 -->
				<input id="cxAmounts" value="${bean.cxAmount}" name="cxAmount" hidden="hidden"  />
				<!-- 各项明细金额 -->
				<c:if test="${operation=='edit'}">
				<input type="hidden" id="outsideAmount" name="outsideAmount" value="${bean.outsideAmount}" />
				<input type="hidden" id="cityAmount" name="cityAmount" value="${bean.cityAmount}" />
				<input type="hidden" id="hotelAmount" name="hotelAmount" value="${bean.hotelAmount}" />
				<input type="hidden" id="foodAmount" name="foodAmount" value="${bean.foodAmount}" />
				<input type="hidden" id="meetTrainAmount" name="meetTrainAmount" value="${bean.meetTrainAmount}" />
				<input type="hidden" id="travelAmount" name="travelAmount" value="${bean.travelAmount}" />
				<input type="hidden" id="outsideTeacherAmount" name="outsideTeacherAmount" value="${bean.outsideTeacherAmount}" />
				<input type="hidden" id="outsideStudentAmount" name="outsideStudentAmount" value="${bean.outsideStudentAmount}" />
				<input type="hidden" id="cityTeacherAmount" name="cityTeacherAmount" value="${bean.cityTeacherAmount}" />
				<input type="hidden" id="cityStudentAmount" name="cityStudentAmount" value="${bean.cityStudentAmount}" />
				<input type="hidden" id="hotelTeacherAmount" name="hotelTeacherAmount" value="${bean.hotelTeacherAmount}" />
				<input type="hidden" id="hotelStudentAmount" name="hotelStudentAmount" value="${bean.hotelStudentAmount}" />
				<input type="hidden" id="foodTeacherAmount" name="foodTeacherAmount" value="${bean.foodTeacherAmount}" />
				<input type="hidden" id="foodStudentAmount" name="foodStudentAmount" value="${bean.foodStudentAmount}" />
				</c:if>
				<c:if test="${operation=='add'}">
				<input type="hidden" id="outsideAmount" name="outsideAmount" value="0.00" />
				<input type="hidden" id="cityAmount" name="cityAmount" value="${applyBean.cityAmount}" />
				<input type="hidden" id="hotelAmount" name="hotelAmount" value="0.00" />
				<input type="hidden" id="foodAmount" name="foodAmount" value="${applyBean.foodAmount}" />
				<input type="hidden" id="hotelTeacherAmount" name="hotelTeacherAmount" value="0.00" />
				<input type="hidden" id="hotelStudentAmount" name="hotelStudentAmount" value="0.00" />
				<input type="hidden" id="travelAmount" name="travelAmount" value="0.00" />
				<input type="hidden" id="outsideTeacherAmount" name="outsideTeacherAmount" value="0.00" />
				<input type="hidden" id="outsideStudentAmount" name="outsideStudentAmount" value="0.00" />
				<input type="hidden" id="cityTeacherAmount" name="cityTeacherAmount" value="0.00" />
				<input type="hidden" id="cityStudentAmount" name="cityStudentAmount" value="0.00" />
				<input type="hidden" id="foodTeacherAmount" name="foodTeacherAmount" value="0.00" />
				<input type="hidden" id="foodStudentAmount" name="foodStudentAmount" value="0.00" />
				</c:if>
				<!-- json -->
				<input type="hidden" id="travelPeopJson" name="travelPeop" />
				<input type="hidden" id="studentsPeopJson" name="studentsJson" />
				<input type="hidden" id="outsideTrafficJson" name="outsideTraffic" />
				<input type="hidden" id="inCityJson" name="inCity" />
				<input type="hidden" id="hotelJson" name="hotelJson" />
				<input type="hidden" id="otherJson" name="otherJson" />
				<input type="hidden" id="foodJson" name="foodJson" />
				<input type="hidden" id="payerinfoJson" name="payerinfoJson" />
				<input type="hidden" id="indexPeopJson" name="indexJsons" />
				<!-- 附件信息 -->
				<input type="text" id="files" name="files" hidden="hidden">
			</form>	
				<div class="tab-wrapper" id="reimburse-travelinfo-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="reimburset_travelinfo_attend_train_detail.jsp" />
						</div>
						<div title="申请" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="apply_detail_attend_train.jsp" />
						</div>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<c:if test="${bean.type!=1 }">
			<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</div>
<script type="text/javascript">
flashtab('reimburse-travelinfo-add');

//防止不停重新加载
var itineraryurlcount = 0;
function onclickreimburset(){
		
	if(itineraryurlcount>=1){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#index_detail_apply_tab_id').datagrid('reload');
		$('#reimburse_outside_tab_id').datagrid('reload');
		$('#reimbursein_city_tabs_id').datagrid('reload');
		$('#reimbursein_hoteltab').datagrid('reload');
		$('#reimbursein_foodtab').datagrid('reload');
		$('#index_reim_tab_id').datagrid('reload');
		$('#payer_info_tab').datagrid('reload');
		$('#tracel_itinerary_trip_reim_tab_id').datagrid('reload');
		$('#in_city_trip_reim_tab_id').datagrid('reload');
		$('#foodtabTripReim').datagrid('reload');
		$('#hoteltabApplyTripReim').datagrid('reload');
		$('#index_reim_tab_id').datagrid('reload');
		return true;
	}
}
var detaiurlcount = 0;
function onclickdetail(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#tracel_itinerary_tab_id_detail').datagrid('reload');
		$('#tracel_students_tab_apply_id').datagrid('reload');
		$('#rec-other-dg-detail-apply').datagrid('reload');
		$('#outside_traffic_tab_id_detail_apply').datagrid('reload');
		$('#in_city_tab_id_detail').datagrid('reload');
		$('#index_detail_apply_tab_id').datagrid('reload');
		$('#rec-others-detail-dg-apply').datagrid('reload');
		$('#rec-other-detail-apply-dg').datagrid('reload');
		$('#itinerary_toolbar_trip_detail_Id').datagrid('reload');
		$('#tracel_itinerary_detail_trip_tab_apply_id').datagrid('reload');
		$('#rec-other-trip-detail-apply-dg').datagrid('reload');
		$('#check-history-reim-apply-dg').datagrid('reload');
		$.parser.parse("#tracel_itinerary_trip_reim_detail_tab_id");
		return true;
	}
}



//冲销借款
function cx(){
	
	var num1=parseFloat($('#cxAmounts').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	var num6=parseFloat($('#input_jkdamonut').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAmount').val('setValue',num2);
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#cxAmounts').val(num2.toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAmount').numberbox('setValue',0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html((num6-num2).toFixed(2)+" [元]");
			$('#skAmount').numberbox('setValue',(num2-num1).toFixed(2));
		}
	}
	if(!isNaN(num2)){
		if(num2<num3){
			var num5=num3-num2;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function jk(){
	var cxjk = $('input[name="withLoans"]:checked').val();
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	var num1=parseFloat($('#cxAmounts').val());
	var num6=parseFloat($('#input_jkdamonut').val());
	if(cxjk==1){
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#cxAmounts').val(num2.toFixed(2));
			 $('#syAmount').html((num6-num2).toFixed(2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html((num6-num2).toFixed(2)+" [元]");
		}
	}
	}
	if(!isNaN(num2)){
		if(num2<num3){
			var num5=num3-num2;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function onSelect2(date) {
	endday2 = date;
	startday2 = new Date(startday2);
	var d = (endday2 - startday2) / 86400000 + 1;
	if (d > 0) {
		$('#duration').numberbox("setValue", d);
	} else {
		$('#duration').numberbox("setValue", "");
	}
}
//显示详细信息手风琴页面
$(document).ready(function(){
	jk();
	//是否显示 冲销借款信息
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
		$("#editStudentId").hide();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
	}
	if('${bean.fupdateStatus}'==1){
		$('#radiofupdate').show();
	}
	
	var sts = $('input[name="fWhetherAccompanys"]:checked').val();
	if(sts==1){
		$('#reimStudentsTravelId').show();
		$.parser.parse("#reimStudentsTravelId");
	}else{
		$('#reimStudentsTravelId').hide();
	}
	
	//设置申请金额
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	zzAmount();
	$("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			cx();
		}
	});
});

function selectCxjk(){
	var num1=parseFloat($('#input_jkdamonut').val());//借款金额
	var num2=parseFloat($('#reimburseAmount').val());//报销金额
	var num3=parseFloat($('#applyAmount').val());//申请金额
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$("#withLoan").val(1);
		$('#jk').show();
		if(!isNaN(num1)&&!isNaN(num2)){
			if(num2<num1){
				var num4=num1-num2;
				 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
				 $('#cxAmounts').val(num2.toFixed(2));
				 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
				 $('#skAmount').numberbox('setValue',0);
			}else{
				$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
				$('#cxAmounts').val(num1.toFixed(2));
				$('#syAmount').html(fomatMoney(0,2)+" [元]");
				$('#skAmount').numberbox('setValue',(num2-num1).toFixed(2));
			}
		}
		if(!isNaN(num2)){
			if(num2<num3){
				var num5=num3-num2;
				$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
			}else{
				$('#ghAmount').html(fomatMoney(0,2)+" [元]");
			}
		}
	} else {
		$("#withLoan").val(0);
		$('#jk').hide();
		//$('#input_jkdamonut').val(0);
		$('#skAmount').numberbox('setValue',num2.toFixed(2));
	}
}

//保存
function saveReimburse(flowStauts) {
	
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	$('#fupdateReasonid').val($('#fupdateReason').val());//行程调整说明
	
	var jsonStr1 = $("#form1").serializeJson();
	var jsonStr2 = $("#form2").serializeJson2();
	//var jsonStr3 = $("#form3").serializeJson();
	// 在后台反序列话成明细Json的对象集合
	$('#json1').val(jsonStr1);
	$('#json2').val(jsonStr2);
	//$('#json3').val(jsonStr3);
	//设置申请状态
	$('#reimburseStauts').val(flowStauts);
	var nums=parseFloat($('#reimburseAmount').val());//报销金额
	var num3=parseFloat($('#applyAmount').val());//申请金额
	var num1=parseFloat($('#cxAmounts').val());//冲销金额
	var payeeAmount=parseFloat($('#payeeAmount').val());//转账金额
	var skAmount=nums-num1;//报销金额-冲销金额
	var applyAmount1 = (nums-num3).toFixed(2);
	if(isNaN(payeeAmount) || payeeAmount=='' || payeeAmount==undefined){
		payeeAmount =0;
	}
	if(isNaN(skAmount) || skAmount=='' || skAmount==undefined){
		skAmount =0;
	}
	//下面几行是判断是否有调整
	var sts = $('input[name="fupdateStatus"]:checked').val();
	if(sts==1){//如果有调整的
		$('#fupdateStatusid').val(1);
	}else if(sts==0){//如果没有调整的
		$('#fupdateStatusid').val(0);
	}
	
	//下面几行判断是否金额一致
	if(nums!=payeeAmount){
		var info = '报销金额：'+nums+'\n转账总金额：'+payeeAmount+'\n报销金额和转账金额不一致,请核对后在提交！';
		alert(info);
		return false;
	}
	if(flowStauts!="0"){
		var rows = $('#reimburse_outside_tab_id').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fStartDate==''){
				alert("请填写城市间交通费的出发时间！");
				return false;
			}
			if(rows[i].fEndDate==''){
				alert("请填写城市间交通费的到达时间！");
				return false;
			}
			if(rows[i].vehicle==''){
				alert("请填写行城市间交通费的交通工具！");
				return false;
			}
			if(rows[i].vehicleLevel==''){
				alert("请填写城市间交通费的交通工具级别！");
				return false;
			}
			if(rows[i].travelPersonnel==''){
				alert("请填写城市间交通费的出行人员！");
				return false;
			}
			if(rows[i].applyAmount==''){
				alert("请填写城市间交通费的申请金额！");
				return false;
			}
		}
		
		var rowsHotel = $('#reimbursein_hoteltab').datagrid('getRows');
		for(var i=0;i<rowsHotel.length;i++){
			if(rowsHotel[i].checkInTime==''){
				alert("请填住宿费的入住时间！");
				return false;
			}
			if(rowsHotel[i].checkOUTTime==''){
				alert("请填住宿费的退房时间！");
				return false;
			}
			if(rowsHotel[i].locationCity==''){
				alert("请填住宿费的所在城市！");
				return false;
			}
			if(rowsHotel[i].travelPersonnel==''){
				alert("请填住宿费人员信息！");
				return false;
			}
			if( rowsHotel[i].applyAmount ==''){
				alert("请填写住宿费的申请金额！");
				return false;
			}
		}
	}
	//公务出差json
	//isineraryJson();
	//获得城市间交通费的json
	outsideTrafficJson();
	//获得住宿费的json
	getHotelJson();
	//获得市内交通费json
	inCityJson();
	//获得伙食补助费的json
	getfoodJson();
	//获得会务、培训费json
	//getOtherJsons();
	//公务出行预算json
	indexJsonReim();
	//收款人信息表json
	getpayerinfoJson();
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//提交
	var h = $("#reimburseTypeHi").val();
	$('#reimburse_save_form').form('submit', {
		onSubmit : function() {
			if(flowStauts!="0"){
				flag = $(this).form('enableValidation').form('validate');
				 if (flag) {
					//如果校验通过，则进行下一步
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
			}
		},
		url : base + '/reimburse/save?type=12',
		success : function(data) {
			$.messager.progress('close');
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#reimburseTab'+h).datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}





//寻找相关制度
function findSystemFile(id) {
	$.ajax({ 
		url: base+"/cheter/systemFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
}


//打开借款单选择页面
function chooseJkd(){
	var win = creatFirstWin('借款单选择', 840, 450, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
	cx();
}

//转账金额
function  zzAmount(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)){
		num1=0;
	}
	if(isNaN(num2)){
		num2=0;
	}
	if(isNaN(num3)){
		num3=0;
	}
	$("#skAmount").numberbox().numberbox('setValue',num1+num2);
}		
</script>
</body>
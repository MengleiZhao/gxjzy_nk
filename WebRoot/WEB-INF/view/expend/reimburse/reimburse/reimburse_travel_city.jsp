<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<div class="tab-wrapper" id="reimburse-travelinfo-add-city">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销" style="margin-bottom:35px;width: 737px" data-options="">
							<jsp:include page="reimburse_travel_cityInfo.jsp" />
						</div>
						<div title="申请" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="">
							<jsp:include page="apply_detail_travel_city.jsp" />
						</div>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveReimburse(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveReimburse(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
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
flashtab('reimburse-travelinfo-add-city');

//防止不停重新加载
var itineraryurlcount = 0;
function onclickreimburset(){
	if(itineraryurlcount>=0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#reimburse_itinerary_tab_id').datagrid('reload');
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
		$('#tracel_itinerary_city_tab_apply_id').datagrid('reload');
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
	var travelType = '${applyBean.travelType}';
	var indexName = $("#F_fBudgetIndexName").textbox('getValue');

	$("#indexName").val(indexName);
	//设置申请状态
	$('#reimburseStauts').val(flowStauts);
	var nums=parseFloat($('#reimburseAmount').val());//报销金额
	var num3=parseFloat($('#applyAmount').val());//申请金额
	var num1=parseFloat($('#cxAmounts').val());//冲销金额
	var payeeAmount=parseFloat($('#payeeAmount').val());//转账金额
	var payeeAmountgr=parseFloat($('#payeeAmountgr').val());//转账金额
	var skAmount=nums-num1;//报销金额-冲销金额
	var applyAmount1 = (nums-num3).toFixed(2);
	if(isNaN(payeeAmount) || payeeAmount=='' || payeeAmount==undefined){
		payeeAmount =0;
	}
	if(isNaN(payeeAmountgr) || payeeAmountgr=='' || payeeAmountgr==undefined){
		payeeAmountgr =0;
	}
	if(isNaN(skAmount) || skAmount=='' || skAmount==undefined){
		skAmount =0;
	}
	//下面几行是判断是否有调整
	/* var sts = $('input[name="fupdateStatus"]:checked').val();
	if(sts==1){//如果有调整的
		$('#fupdateStatusid').val(1);
	}else if(sts==0){//如果没有调整的
		$('#fupdateStatusid').val(0);
	} */
	var pay = payeeAmount+payeeAmountgr;
	//下面几行判断是否金额一致
	if(flowStauts!="0"){
		if(nums!=pay){
			var info = '报销金额：'+nums+'\n转账总金额：'+pay+'\n报销金额和转账金额不一致,请核对后在提交！';
			alert(info);
			return false;
		}
		var rowsTravel = $('#reim_tracel_itinerary_city_tab_id').datagrid('getRows');
		for(var i=0;i<rowsTravel.length;i++){
			if(rowsTravel[i].tripType==''){
				alert("请选择出行类型！");
				return false;
			}
			if(rowsTravel[i].travelDateStart==''){
				alert("请选择出发日期！");
				return false;
			}
			if(rowsTravel[i].travelDateEnd==''){
				alert("请选择撤离日期！");
				return false;
			}
			if(rowsTravel[i].placeStart==''){
				alert("请填写起始地！");
				return false;
			}
			if(rowsTravel[i].placeEnd==''){
				alert("请填写目的地！");
				return false;
			}
			if(rowsTravel[i].distance==''){
				alert("请填写距离（公里）！");
				return false;
			}
		}
	}
	//公务出行json
	isineraryJsonCityReim();
	getpayerinfoJson();
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	var flag = true;
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
		url : base + '/reimburse/save?type=13',
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
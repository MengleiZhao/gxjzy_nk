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
							<jsp:include page="reimburse_travel_cityInfo_detail.jsp" />
						</div>
						<div title="申请" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="">
							<jsp:include page="apply_detail_travel_city.jsp" />
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
		$.parser.parse("#tracel_itinerary_city_tab_apply_id");
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
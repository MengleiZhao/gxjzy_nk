<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<div class="tab-wrapper" id="reimburse-traininfo-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="reimburset_traininfo.jsp" />
						</div>
						<div title="申请" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="apply_traininfo_detail.jsp" />
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
flashtab('reimburse-traininfo-add');

//防止不停重新加载
var itineraryurlcount = 0;
function onclickreimburset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#payer_info_tab').datagrid('reload');
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
		$('#apply_dg_train_lecturer').datagrid('reload');
		$('#apply_dg_train_plan').datagrid('reload');
		$('#apply_mingxi-zonghe-dg').datagrid('reload');
		$('#apply_mingxi-lessons-dg').datagrid('reload');
		$('#apply_mingxi-hotel-dg').datagrid('reload');
		$('#apply_mingxi-food-dg').datagrid('reload');
		$('#apply_mingxi-trafficCityToCity-dg').datagrid('reload');
		$('#apply_mingxi-trafficInCity-dg').datagrid('reload');
		$.parser.parse("#check-history-reim-apply-dg");
		$('#check-history-reim-apply-dg').datagrid('reload');
		return true;
	}
}
//冲销借款
function cx(){
	var fIndividualIncomeTax = isNaN(parseFloat($('#fIndividualIncomeTax').val()))?0:parseFloat($('#fIndividualIncomeTax').val());;					//代扣代缴个人所得税金额
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAccount').numberbox('setValue',num2-fIndividualIncomeTax);
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2-fIndividualIncomeTax<num1){
			var num4=num1-num2-fIndividualIncomeTax;
			 $('#cxAmount').html(fomatMoney(num2-fIndividualIncomeTax,2)+" [元]");
			 $('#cxAmounts').val((num2-fIndividualIncomeTax).toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAccount').numberbox('setValue',0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
			$('#skAccount').numberbox('setValue',(num2-fIndividualIncomeTax-num1).toFixed(2));
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
	var fIndividualIncomeTax = isNaN(parseFloat($('#fIndividualIncomeTax').val()))?0:parseFloat($('#fIndividualIncomeTax').val());;					//代扣代缴个人所得税金额
	var cxjk = $('input[name="withLoans"]:checked').val();
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(cxjk==1){
	var num1=parseFloat(${bean.loan.leastAmount});
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2-fIndividualIncomeTax<num1){
			var num4=num1-num2-fIndividualIncomeTax;
			 $('#cxAmount').html(fomatMoney((num2-fIndividualIncomeTax),2)+" [元]");
			 $('#cxAmounts').val((num2-fIndividualIncomeTax).toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
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
		$('#trDayNum').numberbox("setValue", d);
	} else {
		$('#trDayNum').numberbox("setValue", "");
	}
}
//显示详细信息手风琴页面
$(document).ready(function() {
	jk();
	//是否显示 冲销借款信息
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
	}
	//设置申请金额
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}

	var h = $("#reimburseTypeHi").val();
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}
	zzAmount();
	$("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			cx();
		}
	});
	
	if('${operation}'=='edit'){
		flag2=1;
		flag1=1;
	}
	if('${bean.fupdateStatus}'==0){
		$("#rp").hide();
		flag1=1;
		flag2=1;
	}else if('${bean.fupdateStatus}'==1){
		$("#addId").hide();
		$("#removeId").hide();
		$("#appendId").hide();
		$("#editId").show();
		$("#rp1").show();
		$("#addId1").hide();
		$("#removeId1").hide();
		$("#appendId1").hide();
		$("#editId1").show();
	}
	addTotalAmounts();
});

function selectCxjk(){
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
		$('#withLoan').val(1);
	} else {
		$('#jk').hide();
		$('#withLoan').val(0);
		$('#input_jkdamonut').val(0);
		cx();
	}
}

//保存
function saveReimburse(flowStauts) {

	$('#indexName').val($('#F_fBudgetIndexName').textbox('getValue'));//预算指标名称
	$('#fupdateReasonid').val($('#fupdateReason').val());//接待调整说明
	//获取列表json
	getTrainLecturerJson();
	getTrainPlanJson();
	getHotelJson();
	getFoodJson();
	getLessonJson();
	getTrafficJson1();
	getTrafficJson2();
	
	var lessonsDG = $('#mingxi-lessons-dg').datagrid('getRows');
	var lessonsFlag = true;
	if(lessonsDG.length>0){
		for(var i = 0; i < lessonsDG.length; i++) {
			var reimbSum = parseFloat(lessonsDG[i].reimbSum);
			if(isNaN(reimbSum)){
				lessonsFlag = false;
				break;
			}
		}
	}

	
	var trafficCityToCity = $('#mingxi-trafficCityToCity-dg').datagrid('getRows');
	var trafficCityToCityFlag = true;
	if(trafficCityToCity.length>0){
		for(var i = 0; i < trafficCityToCity.length; i++) {
			var reimbSum = parseFloat(trafficCityToCity[i].reimbSum);
			if(isNaN(reimbSum)){
				trafficCityToCityFlag = false;
				break;
			}
		}
	}
	
	var jsonStr1 = $("#form1").serializeJson();
	var jsonStr2 = $("#form2").serializeJson();
	var jsonStr3 = $("#form3").serializeJson();
	var jsonStr4 = $("#form4").serializeJson();
	var jsonStr5 = $("#form5").serializeJson();
	
	
	// 在后台反序列话成明细Json的对象集合
	
	$('#json1').val(jsonStr1);
	$('#json2').val(jsonStr2);
	$('#json3').val(jsonStr3);
	$('#json4').val(jsonStr4);
	$('#json5').val(jsonStr5);
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	var nums=parseFloat($('#reimburseAmount').val());//报销金额
	//综合预算标准
	var train_num = parseInt($('#trDayNum').numberbox('getValue'));//培训天数
	var zongheapplyAmount = isNaN(parseFloat($('#zongheMoney').val()))?0:parseFloat($('#zongheMoney').val());;					//综合预算申请金额
	var zongherowAmount = isNaN(parseFloat($('#zongheMoneyStds').val()))?0:parseFloat($('#zongheMoneyStds').val());;					//综合预算申请金额
	var fIndividualIncomeTax = isNaN(parseFloat($('#fIndividualIncomeTax').val()))?0:parseFloat($('#fIndividualIncomeTax').val());;					//代扣代缴个人所得税金额

	var num3=parseFloat($('#applyAmount').val());//申请金额
	var payeeAmount=parseFloat($('#payeeAmount').val());//转账金额
	var payeeAmountgr=parseFloat($('#payeeAmountgr').val());//转账金额
	var num1=parseFloat($('#cxAmounts').val());//冲销金额
	var skAmount=parseFloat((nums-num1-fIndividualIncomeTax).toFixed(2));//报销金额-冲销金额-个人所得税金额
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
	//下面几行判断是否有冲销借款
	var cxjk = $('input[name="withLoans"]:checked').val();
	
	if(flowStauts!=0){
		if(flag2==0){
			alert('请保存讲师信息');
			return ;
		}
		if(flag1==0){
			alert('请保存培训日程');
			return ;
		}
		if(isNaN(nums)){
			alert('报销金额不能为空！');
			return false;
		}
		if(zongheapplyAmount>zongherowAmount){
			alert('综合预算总额不得超过定额标准总额！');
			return;
		}
		if(!trafficCityToCityFlag){
			alert('请填写师资费-城市间交通费申请金额！');
			return false;
		}
		if(!lessonsFlag){
			alert('请填写师资费-讲课费申请金额！');
			return false;
		}
		var pay = payeeAmountgr+payeeAmount;
		if(cxjk==1){//如果有冲销借款的
			var lCode = $("#input_jkdbh").textbox('getValue');
			if(lCode==''){
				alert('请选择借款单！');
				return false;
			}else if(skAmount!=pay){
				var num4=parseFloat($('#input_jkdamonut').val());//借款单金额
				var info = '总报销金额：'+nums+'\n冲销金额：'+num4+'\n个税金额：'+fIndividualIncomeTax+'\n转账总金额：'+pay+'\n实际报销金额(除去个税金额和冲销金额)和转账金额不一致,请核对后在提交！';
				alert(info);
				return false;
			}
		}else if(cxjk==0){
			//没有冲销借款的
			if(nums-fIndividualIncomeTax != pay){
				var info = '总报销金额：'+nums+'\n个税金额：'+fIndividualIncomeTax+'\n转账总金额：'+pay+'\n实际报销金额(除去个税金额)和转账金额不一致,请核对后在提交！';
				alert(info);
				return false;
			}
		}
	}
	
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	$('#reimburseStauts').val(flowStauts);
	var h = $("#reimburseTypeHi").val();
	//收款人json
	getpayerinfoJson();
	var flag = true;
	//提交
	$('#reimburse_save_form').form('submit', {
		onSubmit : function(){
			if(flowStauts!=0){
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
		url : base + '/reimburse/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#reimburse_save_form').form('clear');
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
	$("#skAccount").numberbox().numberbox('setValue',num1+num2);
}	
</script>

</body>


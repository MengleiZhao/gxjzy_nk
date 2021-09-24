<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<div class="tab-wrapper" id="reimburse-meetinginfo-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="reimburset_meetinginfo.jsp" />
						</div>
						<div title="申请单" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="apply_meetinginfo_detail.jsp" />
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
flashtab('reimburse-meetinginfo-add');


//防止不停重新加载
var itineraryurlcount = 0;
function onclickreimburset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		/* $('#reimburse_itinerary_tab_id').datagrid('reload');
		$('#reimburse_outside_tab_id').datagrid('reload');
		$('#reimbursein_city_tab_id').datagrid('reload');
		$('#reimbursein_hoteltab').datagrid('reload');
		$('#reimbursein_foodtab').datagrid('reload'); */
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
		/* $('#tracel_itinerary_tab_id_detail').datagrid('reload');
		$('#outside_traffic_tab_id_detail').datagrid('reload');
		$('#in_city_tab_id_detail').datagrid('reload');
		$('#hoteltab_detail').datagrid('reload');*/
		$('#appli-detail-dg1').datagrid('reload'); 
		$('#dg_meet_plan1').datagrid('reload');
		$('#check-history-reim-apply-dg').datagrid('reload');
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
		 $('#skAccount').numberbox('setValue',num2);
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#cxAmounts').val(num2.toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAccount').numberbox('setValue',0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html((num6-num1).toFixed(2)+" [元]");
			$('#skAccount').numberbox('setValue',(num2-num1).toFixed(2));
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
	var num6=parseFloat($('#input_jkdamonut').val());
	if(cxjk==1){
	var num1=parseFloat($('#cxAmounts').val());
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#cxAmounts').val(num2.toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html((num6-num1).toFixed(2)+" [元]");
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
		$('#duration').numberbox("setValue", 0);
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

	var h = $("#reimburseTypeHi").val()
	zzAmount();
	if (h == 1) {
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
		/* $("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息'); */
	}
	if (h == 2) {//会议
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 3) {//培训
		$('#spbxhyxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 4) {//差旅
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 5) {//接待
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 6) {//公务用车
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 7) {//公务出国
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
	}
	$("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			cx();
		}
	});
});


function selectCxjk(){
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
		$('#withLoan').val(1);
	} else {
		$('#input_jkdamonut').val(0);
		$('#input_jkdbh').textbox('setValue','');
		$('#withLoan').val(0);
		$('#jk').hide();
		cx();
	}
}

//保存
function saveReimburse(flowStauts) {
	/* var paymentType= $('#paymentTypeShow').combobox('getValues');
	$('#paymentType').val(paymentType); */
	var fupdateReason = $('#fupdateReason').val();
	var fupdateStatus = $(':radio[name="fupdateStatus"]:checked').val();
	if(fupdateReason=='' && fupdateStatus == 1){
		alert('请填写会议调整说明');
		return false;
	}
	//会议日程
	acceptMeet();
	var rows2 = $('#dg_meet_plan_reimb').datagrid('getRows');
	var meetPLan = "";
	for (var i = 0; i < rows2.length; i++) {
		meetPLan = meetPLan + JSON.stringify(rows2[i]) + ",";
	}
	$('#meetPlanJson').val(meetPLan);
	//费用明细
	//accept();
	/* var rows = $('#reimb-meeting-mingxi').datagrid('getRows');
	var mingxiJson = "";
	for (var i = 0; i < rows.length; i++) {
		mingxiJson = mingxiJson + JSON.stringify(rows[i]) + ",";
	}
	$('#mingxiJson').val(mingxiJson); */
	
	$('#indexName').val($('#F_fBudgetIndexName').textbox('getValue'));//预算指标名称
	var jsonStr1 = $("#form1").serializeJson();
	// 在后台反序列话成明细Json的对象集合
	$('#json1').val(jsonStr1);
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	var nums=parseFloat($('#reimburseAmount').val());
	/* var meetAmount = 0.00;
	var meetapplyAmount = 0.00;
	var meetplanrows = $('#reimb-meeting-mingxi').datagrid('getRows');
	for (var i = 0; i < meetplanrows.length; i++) {
		meetAmount = parseFloat(meetplanrows[i].totalStandard) + parseFloat(meetAmount);
		meetapplyAmount = parseFloat(meetplanrows[i].applySum) + parseFloat(meetapplyAmount);
	}
	if(meetapplyAmount>meetAmount){
		alert('综合预算报销总额不得超过费用标准总额！');
		return;
	} */
	var attendNum = isNaN(parseFloat($('#attendNum').numberbox("getValue")))?0:parseFloat($('#attendNum').numberbox("getValue"));//参会人数
	var duration = isNaN(parseFloat($('#duration').numberbox("getValue")))?0:parseFloat($('#duration').numberbox("getValue"));//会议天数
	var staffNum = isNaN(parseFloat($('#staffNum').numberbox("getValue")))?0:parseFloat($('#staffNum').numberbox("getValue"));//工作人数
	var hotelPersonNum = parseFloat($('#hotelPersonNum').val());
	var foodPersonNum = parseFloat($('#foodPersonNum').val());
	var printingPersonNum = parseFloat($('#printingPersonNum').val());
	if (isNaN(hotelPersonNum)) {
		hotelPersonNum = 0;
	}
	if (isNaN(foodPersonNum)) {
		foodPersonNum = 0;
	}
	if (isNaN(printingPersonNum)) {
		printingPersonNum = 0;
	}
	if (((staffNum+attendNum)*(duration-1)) < hotelPersonNum ){
		$('#hotelPersonNum').val(0);
		getHotelMoney();
		alert('住宿费人·天超出标准，请重新填写！');
		return false;
	}
	if (((staffNum+attendNum)*duration) < foodPersonNum){
		$('#foodPersonNum').val(0);
		getFoodMoney();
		alert('伙食费人·天超出标准，请重新填写！');
		return false;
	}
	if ((staffNum+attendNum) < printingPersonNum){
		$('#printingPersonNum').val(0);
		getPrintingMoney();
		alert('文件印刷费人·天超出标准，请重新填写！');
		return false;
	}
	
	var hotelStdMoney = $('#hotelStdUpdate').val();
	var foodStdMoney = $('#foodStdUpdate').val();
	var otherStdMoney = $('#otherStdUpdate').val();
	var hotelMoney = $('#hotelMoney').val();
	if (hotelMoney == '' || hotelMoney == '0') {
		hotelStdMoney = 0;
	}
	var foodMoney = $('#foodMoney').val();
	if (foodMoney == '' || foodMoney == '0') {
		foodStdMoney = 0;
	}
	var otherMoney = $('#p_otherAllMoney').html();
	if (otherMoney == '' || otherMoney == '0.00元') {
		otherStdMoney = 0;
	}
	
	var stdMoney = Number(hotelStdMoney) + Number(foodStdMoney) + Number(otherStdMoney);
	if(Number(stdMoney) < nums) {
		alert('报销总额不得超过定额标准总额！');
		return false;
	}
	var payeeAmount=parseFloat($('#payeeAmount').val());//转账金额
	var payeeAmountgr=parseFloat($('#payeeAmountgr').val());//转账金额
	if(isNaN(payeeAmount)){
		payeeAmount=0;
	}
	if(isNaN(payeeAmountgr)){
		payeeAmountgr=0;
	}
	var num1 = parseFloat($('#cxAmounts').val());
	var skAmount=nums-num1;//报销金额-冲销金额cxAmounts
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(nums)){
		alert('请填写费用明细');
		return false;
	}
	var sts = $('#fupdateStatusid').val();
	if(sts==1){//如果有调整的
		$('#fupdateReasonid').val($('#fupdateReason').val());
	}else if(sts==0){//如果没有调整的
		$('#fupdateReasonid').val('');
	}
	//下面几行判断是否有冲销借款
	var cxjk = $('input[name="withLoans"]:checked').val();
	var pay = payeeAmount+payeeAmountgr;
	if(cxjk==1){//如果有冲销借款的
		var lCode = $("#input_jkdbh").textbox('getValue');
		if(lCode==''){
			alert('请选择借款单！');
			return false;
		}else if(skAmount!=pay){
			var info = '报销金额：'+nums+'\n冲销金额：'+num1+'\n转账总金额：'+pay+'\n冲销后的报销金额和转账金额不一致,请核对后在提交！';
			alert(info);
			return false;
		}
	}else if(cxjk==0){
		//没有冲销借款的
		if(nums!=pay){
			var info = '报销金额：'+nums+'\n转账总金额：'+pay+'\n报销金额和转账金额不一致,请核对后在提交！';
			alert(info);
			return false;
		}
	}
	
	getpayerinfoJson();
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	$('#reimburseStauts').val(flowStauts);
	
	$('#hotelPersonNumHidden').val($('#hotelPersonNum').val());
	$('#realityHotelMoneyHidden').val($('#realityHotelMoney').val());
	$('#hotelMoneyHidden').val($('#hotelMoney').val());
	$('#hotelStdHidden').val($('#hotelStdUpdate').val());
	$('#foodPersonNumHidden').val($('#foodPersonNum').val());
	$('#realityFoodMoneyHidden').val($('#realityFoodMoney').val());
	$('#foodMoneyHidden').val($('#foodMoney').val());
	$('#foodStdHidden').val($('#foodStdUpdate').val());
	$('#printingPersonNumHidden').val($('#printingPersonNum').val());
	$('#realityPrintingMoneyHidden').val($('#realityPrintingMoney').val());
	$('#printingMoneyHidden').val($('#printingMoney').val());
	$('#rentMoneyHidden').val($('#rentMoney').val());
	$('#trafficMoneyHidden').val($('#trafficMoney').val());
	$('#otherMoneyHidden').val($('#otherMoney').val());
	$('#otherStdHidden').val($('#otherStdUpdate').val());
	$('#hotelStdSingleHidden').val($('#p_hotelStd').val());
	$('#foodStdSingleHidden').val($('#p_foodStd').val());
	$('#otherStdSingleHidden').val($('#p_otherStd').val());
	
	if(parseFloat(nums)>parseFloat(num3)&&flowStauts==1){
		/* var rows = $('#rmxdg').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].standard!="据实列支"&&rows[i].standard!=null){
				if(parseFloat(rows[i].reimbSum)>parseFloat(rows[i].standard)){
					alert("报销金额不能超过支出标准！")
					return;
				}
			}
		} */
		var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfil?standard='+num3+"&amount="+nums+"&applyAmount="+(nums-num3).toFixed(2)+"&sts="+flowStauts);
		win.window('open');
	}else{
		var h = $("#reimburseTypeHi").textbox().textbox('getValue');
		
		//提交
		$('#reimburse_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					//如果校验通过，则进行下一步
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
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


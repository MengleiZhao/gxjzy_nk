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
	
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
	//可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	}
	//批复时间
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
});

function deleteAndAdd(){
	 $("#outsideAmount").val(0);
	 $("#cityAmount").val(0);
	 $("#hotelAmount").val(0);
	 $("#foodAmount").val(0);
	$('#applyInCityAmountTrip').html(0.00+'[元]');
	$("#applyFoodAmountTrip").html(0.00+"[元]");
	$("#hotelAmountsTrip").html(0.00+"[元]");
	$("#applyTotalAmountTrip").html(0.00+"[元]");
	$("#applyOutsideTrafficAmount").html(0.00+"[元]");
	$('#applyInCityAmount').html(0.00+'[元]');
	$("#applyFoodAmount").html(0.00+"[元]");
	$("#hotelAmounts").html(0.00+"[元]");
	$("#applyTotalAmount").html(0.00+"[元]");
}

		var numType1 = 0;
		var numType2 = 0;

//保存
function saveApply(flowStauts) {
	var reasonString  = $("#reason").textbox('getValue');
	if(flowStauts!='0'){
		if(reasonString==''){
			alert("请填写培训事由！");
			return;
		}
	}
	// 在后台反序列化成明细Json的对象集合
	var type = '${type}';
	
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);
		
	
	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);
	
	var flag = true;
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			if(flowStauts!='0'){
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
		url : base + '/apply/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#applyTab'+type).datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

//打开指标选择页面
function openIndex() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}

function chooseArea(){
	var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose');
	win.window('open');
}

//未编辑或者已经编辑完毕的行
function addDays(rows,index){
	var hoteldays=rows[index]['hotelDays'];
	if(hoteldays==null){
		hoteldays=0;
		return parseInt(hoteldays);
	}
	return parseInt(hoteldays); 
}


//未编辑或者已经编辑完毕的行
function addDays1(rows,index){
	var traveldays=rows[index]['travelDays'];
	if(traveldays==null){
		traveldays=0;
		return parseInt(traveldays);
	}
	return parseInt(traveldays); 
}
var updateradio = 0;
function radiono(){
	acceptStudents();
	updateradio=1;
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
	for (var i = rows.length-1; i >= 0 ; i--) {
		$('#tracel_students_tab_id').datagrid('deleteRow',i);
	}
	editIndexStudents = undefined;
	$('#editStudentId').hide();
	$('#addStudentId').hide();
	$('#removeStudentId').hide();
	$('#appendStudentId').hide();
	$('#studentsTravelId').hide();
}

function radioyes(){
	updateradio=0;
	$('#editStudentId').hide();
	$('#addStudentId').show();
	$('#removeStudentId').show();
	$('#appendStudentId').show();
	$('#studentsTravelId').show();
	sign1 = 0;
	$.parser.parse("#studentsTravelId");
}
$('#travelType').combobox({
	onChange: function (newValue, oldValue) {
		$('#check_system_div').load('${base}/apply/refreshProcess?fpPype='+newValue+'&id=${bean.gId}');
	}
});

$('#vehicle').combobox({
	onSelect: function (newValue, oldValue) {
		getPersonlevel();
	}
});
</script>
<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
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
				<!-- 申请人ID --><input type="hidden" id="fUserId" name="user" value="${bean.user}" />
				<!-- 申请人级别 --><input type="hidden" id="fUserLevelId" value="${bean.userLevel}" />
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
								<a onclick="openIndex()" href="#">
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
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}</p></td>
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
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px " value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px  " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>培训名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px  " value="${bean.applyName}" name="applyName" required="required" data-options="validType:'length[1,100]'"/>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>培训事由</td>
							<td colspan="3">
								<textarea name="reason" id="reason" class="easyui-textbox" data-options="multiline:true"
									oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
									style="margin-left: 10px ;width:625px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${bean.reason }</textarea>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
							<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
							<td class="td2" >
							<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 270px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 出发日期</td>
							<td class="td2">
								<input  class="easyui-datebox" style="width: 265px;; height: 30px;" id="travelDateStart" name="travelDateStart"
								data-options="" value="${travelBean.travelDateStart}" required="required" editable="false"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 结束日期</td>
							<td class="td2">
								<input class="easyui-datebox" style="width: 270px;; height: 30px;" id="travelDateEnd" name="travelDateEnd"
								data-options="" value="${travelBean.travelDateEnd}" required="required" editable="false"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
							<td class="td2">
								<input  class="easyui-combobox" style="width: 265px;; height: 30px;" id="fProvinceId" name="fProvinceId"
								value="${travelBean.fProvinceId}" required="required" editable="false"data-options="editable:false,
									url:'${base}/apply/getRegion?id=0&selected=${travelBean.fProvinceId}',
									method:'POST',
									valueField:'id',
									textField:'text',
									onSelect: function(rec){
										$('#fCityId').combobox('setValue', '');
									    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${travelBean.fCityId}';
									    $('#fCityId').combobox('reload', url);
									    }"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
							<td class="td2">
								<input class="easyui-combobox" style="width: 270px;; height: 30px;" id="fCityId" name="fCityId"
								value="${travelBean.fCityId}" required="required" editable="false" data-options="editable:false,
									method:'POST',
									url:'${base}/apply/getRegion?selected=${travelBean.fCityId}',
									valueField:'id',
									textField:'text',
									onSelect: function(rec){
										$('#fDistrictId').combobox('setValue', '');
									    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${travelBean.fDistrictId}';
									    $('#fDistrictId').combobox('reload', url);
									    }"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
							<td class="td2">
								<input  class="easyui-combobox" style="width: 265px;; height: 30px;" id="fDistrictId" name="fDistrictId"
								value="${travelBean.fDistrictId}" required="required" editable="false" data-options="
								editable:false,
								method:'POST',
								valueField:'id',
								textField:'text'"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
							<td class="td2">
								<input class="easyui-textbox" style="width: 270px;; height: 30px;" id="travelAreaName" name="travelAreaName"
								value="${travelBean.travelAreaName}" required="required" />
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 同行人</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px" id="travelAttendPeop" value="${travelBean.travelAttendPeop}" name="travelAttendPeop" data-options="validType:'length[1,200]',editable:false,
								icons:[{iconCls:'icon-add',handler: function(e){
					     selectTravelAttendPeopAttend();
					     }},{
							iconCls:'icon-remove',
							handler: function(e){
								//$(e.data.target).textbox('clear');
								$('#travelAttendPeop').textbox('setValue','');
								$('#travelAttendPeopId').val('');
								$('#travelPersonnelLevel').val('');
								getStandHotelAttendQuota();
								getPersonlevel();
							}
						}]"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 交通工具</td>
							<td colspan="3">
								<input  class="easyui-combobox" style="width: 265px;; height: 30px;" id="vehicle" name="vehicle"
								value="${travelBean.vehicle}" required="required" editable="false"data-options="prompt:'--请选择--',
									editable:true,
									required:true,
									valueField:'text',
                           			multiple: true,
									textField:'text',
									method:'post',
									url:base+'/apply/comboboxJson'
									"/>
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
										<input class="under" autocomplete="off" id="hotelPersonNum" name="hotelPersonNum" value="${travelBean.hotelPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="hotelPersonNumOnChange(this.value)" type="text">人·天
										<input class="under" autocomplete="off" id="realityHotelMoney" name="realityHotelMoney" value="${travelBean.realityHotelMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="realityHotelMoneyOnChange(this.value)" type="text">元/人·天
									</p>
								</td>
								<td class="window-table-td1"><p>申请金额：</p></td>
								<td class="td2">
									<input id="hotelMoney" name="hotelMoney" value="${travelBean.hotelMoney}" class="easyui-numberbox"
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
									<input id="trainMoney" name="trainMoney" value="${travelBean.trainMoney}" class="easyui-numberbox"
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
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
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
								<c:forEach items="${attaList}" var="att">
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
			</div>
			<div class="window-left-bottom-div" >
				<a href="javascript:void(0)" onclick="saveApply(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveApply(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
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
<script type="text/javascript">
function onShowPanelSHIAttend(){
	var fProvinceId =  $("#fProvinceId").combobox('getValue');
	if(fProvinceId==""){
		alert('请先选择省级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fProvinceId;
    $('#fCityId').combobox('reload', url);
}
function onShowPanelQUAttend(){
	var fCityId =  $("#fCityId").combobox('getValue');
	if(fCityId==""){
		alert('请先选择市级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fCityId;
    $('#fDistrictId').combobox('reload', url);
}
function selectTravelAttendPeopAttend() {
	var fDistrictId = $("#fDistrictId").textbox('getValue');
	if(fDistrictId==""){
		alert('请先选择培训地点！');
		return false;
	}
	var peopId = $('#travelAttendPeopId').val();
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?editType=attendTrain&peopId='+peopId);
	win.window('open');

}

function hotelPersonNumOnChange(val){
	var realityHotelMoney = parseFloat($('#realityHotelMoney').val());
	var hotelPersonNum = parseFloat(val);
	if(isNaN(realityHotelMoney)){
		realityHotelMoney = 0;
	}
	if(isNaN(hotelPersonNum)){
		hotelPersonNum = 0;
	}

	var userId = $("#travelAttendPeopId").val();
		userId =userId.substr(0,userId.length-1);; //出行人员数
		userId = userId.split(',');
		
		var day0 = $("#travelDateStart").datebox('getValue'); //开始时间
		var day1 = $("#travelDateEnd").datebox('getValue'); //结束时间
		var startday = Date.parse(new Date(day0));//入住时间
		var endday = Date.parse(new Date(day1));//退房时间
		if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
			return false;
		}
		var days;//天数
		days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(startday)&&!isNaN(endday)){
			days+=1;
		}
	var trDayNum=isNaN(days)?0:days;
	if(isNaN(trDayNum)){
		trDayNum = 0;
	}
	if(((userId.length+1)*(trDayNum-1))<hotelPersonNum){
		alert('住宿费人·天超标，请重新填写！');
		$('#hotelPersonNum').val('');
		hotelPersonNum = 0;
	}
	
	$('#hotelMoney').numberbox('setValue',hotelPersonNum*realityHotelMoney);
	getStandHotelAttendQuota();
	getPersonlevel();
}
$("#hotelMoney").numberbox({
	onChange: function(newValue, oldValue) {
		var hotelPersonNum = Number($('#hotelPersonNum').val());
		var hotelStd = Number($('#hotelStds').val());
		var hotelMoneyVal = Number(newValue);
		if(hotelMoneyVal>hotelStd){
			alert('申请金额超出定额标准金额！');
			$('#realityHotelMoney').val(0);
			$('#hotelPersonNum').val(0)
			$('#hotelAmount').val(0)
			return false;
		}
		if(hotelMoneyVal==0){
			$('#hotelAmount').val(0)
			$('#realityHotelMoney').val(0);
		}else{
			$('#hotelAmount').val(hotelMoneyVal);
			$('#realityHotelMoney').val(fomatMoney(hotelMoneyVal/hotelPersonNum,2));
		}
		
		allMoney();
	}
});
$("#trainMoney").numberbox({
	onChange: function(newValue, oldValue) {
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		$("#meetTrainAmount").val(newValue);
		allMoney();
	}
});

function realityHotelMoneyOnChange(val){
	
	var hotelPersonNum = parseFloat($('#hotelPersonNum').val());
	var realityHotelMoney = parseFloat(val);
	if(isNaN(hotelPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(realityHotelMoney)){
		realityHotelMoney = 0;
	}
	$('#hotelMoney').numberbox('setValue',hotelPersonNum*realityHotelMoney);
}


function getPersonlevel(){
	var travelPersonnelLevel = $("#travelPersonnelLevel").val();
	var fDistrictId = $("#fDistrictId").val();
	var fUserLevelId = $("#fUserLevelId").val();
	//通过级别获取交通工具提示
	var numArray = travelPersonnelLevel.split(',');
	var arrs = new Array();
	arrs.push(fUserLevelId);
	for (var j = 0; j < numArray.length; j++) {
		var leve = {};
		if(numArray[j]!=''){
			leve = numArray[j];
			arrs.push(leve);
		}
	}
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h]== arrs[c]) {//通过id属性进行匹配；
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
	}
	//通过级别和地区id获取住宿费提示
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getHotelStandardRegionId?id='+fDistrictId+'&level='+arrs.toString(),
		success:function (data){
			$("#applyHotelHintLeadId").remove();
			$("#applyHotelHintId").html('<a id="applyHotelHintLeadId" style="color: red">'+data+'</a>');
			$("#fHotelHint").val(data);
		}
	});
debugger;
	$("#applyTrafficHintLeadId").remove();
	$("#applyTrafficHintStaffId").remove();
	if(arrs.length>1){
		$("#applyTrafficHintId").html('<a id="applyTrafficHintLeadId" style="color: red">党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱<br>其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱</a>');
		$("#fTrafficHint").val("党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱<br>其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱");
	}else{
		if(arrs[0]==2){
			$("#applyTrafficHintId").html('<a id="applyTrafficHintLeadId" style="color: red">党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱</a>');
		$("#fTrafficHint").val("党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱");
		}else{
			if(arrs[0]==3){
				$("#applyTrafficHintId").html('<a id="applyTrafficHintStaffId" style="color: red">其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱</a>');
		$("#fTrafficHint").val("其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱");
			}
		}
	}
}
function getStandHotelAttendQuota(){
	var day0 = $("#travelDateStart").datebox('getValue'); //开始时间
	var day1 = $("#travelDateEnd").datebox('getValue'); //结束时间
	var city = $("#fDistrictId").textbox('getValue'); //所在城市
	var userId = $("#travelAttendPeopId").val(); //出行人员
	var fUserId = $("#fUserId").val(); //申请人员
	debugger;
	if(userId!=''){
		userId +=","+fUserId;
	}else{
		userId =fUserId;
	}
	
	var startday = Date.parse(new Date(day0));//入住时间
	var endday = Date.parse(new Date(day1));//退房时间
	if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
		return false;
	}
	if(city==''||userId==''){
		return false;
	}
	var days;//天数
	days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
	if(!isNaN(startday)&&!isNaN(endday)){
		days+=1;
	}
	days=isNaN(days)?0:days;
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getStandardHotelAttend?configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
		success:function (data){
			
			$("#hotelStds").val(data[0].standard);
		}
	});
}

function allMoney(){
	var hotelMoney = isNaN(parseFloat($("#hotelMoney").numberbox('getValue')))?0:parseFloat($("#hotelMoney").numberbox('getValue'));
	var trainMoney = isNaN(parseFloat($("#trainMoney").numberbox('getValue')))?0:parseFloat($("#trainMoney").numberbox('getValue'));
	$("#hejiAmount").html(hotelMoney+trainMoney);
	$("#applyAmount").val(hotelMoney+trainMoney);
}
</script>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


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
	//设置支出申请扩展信息
	var cxjk = '${abroad.fDiningPlace}';
	if(cxjk==1){
		$('#feteCostReimId').show();
		$("#fDiningPlace1").attr("checked",true);
	} else {
		$('#feteCostReimId').hide();
		$("#fDiningPlace2").attr("checked",true);
	}
});


//保存
function saveApply(flowStauts) {
	// 在后台反序列化成明细Json的对象集合
	accept();
	var type = '${type}';
	var rows;
	if(type=='1'){
		rows = $('#appli-detail-dg').datagrid('getRows');
	}else{
		//bakup 2019-05-08 差旅明细使用固定配置
		$('#appli-detail-dg-travel').datagrid('acceptChanges');
		rows = $('#appli-detail-dg-travel').datagrid('getRows');
	}
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#mingxiJson').val(mingxi);
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);

	//在后台反序列话成被接待人员Json的对象集合
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	if (h == 5) {
		acceptR();
		var rows2 = $('#rpt').datagrid('getRows');
		var recePeop = "";
		for (var i = 0; i < rows2.length; i++) {
			recePeop = recePeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#recePeopJson').val(recePeop);
	}

	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);

	if($('#applyAmount').textbox('getValue')==""||$('#applyAmount').textbox('getValue')=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	}
	
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if(!standardFlag()) {//standardFlag()方法在mingxi.jsp
				$(".easyui-accordion").accordion('select','费用明细'); 
				flag = false;
			} else if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/apply/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#applyTab'+h).datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

//明细只加载一遍(在改变表格内容时如果有url他会优先加载url而不会加载手写的内容，所以只加载一遍会使表格不去请求url中的内容)
var mingxinum=1;
$("#appli-detail-dg").datagrid({
	onBeforeLoad: function () {
		if(mingxinum != 1) {
			return false;
		} else {
			mingxinum = mingxinum + 1;
			return true;
		}
	}
});

//重新计算开支标准的方法（重新计算开支标准，清空申请金额）
function calculateStandard(newValue, oldValue) {
	accept();//先保存明细
	var rows = $('#appli-detail-dg').datagrid('getRows');
	var mingxi = "";
	
	for (var i = 0; i < rows.length; i++) {
		if(i==0) {
			rows[i].applySum=0;//清空申请金额
			rows[i].standard=parseFloat((rows[i].standard/oldValue)*newValue);//重新计算开支标准
			mingxi = mingxi + "["+JSON.stringify(rows[i]);
		} else {
			rows[i].applySum=0;//清空申请金额
			rows[i].standard=parseFloat((rows[i].standard/oldValue)*newValue);//重新计算开支标准
			mingxi = mingxi + "," + JSON.stringify(rows[i]);
		}
	}
	mingxi = mingxi + "]";
	var data = $.parseJSON(mingxi); 
	$('#appli-detail-dg').datagrid('loadData', data);
	$('#num1').textbox('setValue',0);
	$('#applyAmount').textbox('setValue',0);
}

</script>
			<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 697px">
						<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto">
							<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:695px;">
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>摘要</td>
									<td colspan="3">
										<input class="easyui-textbox" style="width: 587px;height: 30px; " value="${applyBean.gName}" readonly="readonly" data-options="validType:'length[1,50]'"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团组名称</td>
									<td class="td2" >
										<input style="width: 230px; height: 30px;" class="easyui-textbox" readonly="readonly"
										value="${abroad.fTeamName}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td  class="td1" style="width:70px"><span class="style1">*</span>组团单位</td>
									<td class="td2">
										<input style="width: 236px; height: 30px;"  class="easyui-textbox" readonly="readonly"
										value="${abroad.fAbroadPlace}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团长(级别)</td>
									<td class="td2">
										<input style="width: 230px; height: 30px;"  class="easyui-textbox" readonly="readonly"
										value="${abroad.fTeamLeader}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;float: right;"></td>
									<td class="td2"> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团员人数</td>
									<td class="td2">
										<input style="width: 230px; height: 30px;" id="fTeamPersonNum"  name="fTeamPersonNum" class="easyui-numberbox" readonly="readonly" 
										value="${abroad.fTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:90px;"><span class="style1">*</span>本单位参团人数</td>
									<td class="td2">
										<input style="width: 236px; height: 30px;" id="fThisUnitTeamPersonNum"  name="fThisUnitTeamPersonNum" class="easyui-numberbox" readonly="readonly" 
										value="${abroad.fThisUnitTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>开始时间</td>
									<td class="td2">
										<input style="width: 230px; height: 30px;" class="easyui-datebox" readonly="readonly"
										value="${abroad.fAbroadDateStart}" data-options="required:true" editable="false"/>
									</td>
									
									<td class="td1" style="width:70px;"><span class="style1">*</span>结束时间</td>
									<td class="td2">
										<input type="hidden" name="faId" value="${abroad.faId}" />
										<input style="width: 236px; height: 30px;" class="easyui-datebox" readonly="readonly"
										value="${abroad.fAbroadDateEnd}" data-options="" editable="false"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>出国天数</td>
									<td class="td2" colspan="3">
										<input style="width: 230px; height: 30px;" class="easyui-textbox" readonly="readonly"
										value="${abroad.fAbroadDayNum}" readonly="readonly" data-options="required:true,validType:'length[1,2]'"/> 
									</td>
								</tr>
								<tr style="height:3px">
								</tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>申请事由</td>
									<td class="td2" colspan="3">
										<input class="easyui-textbox" data-options="multiline:true,required:true,validType:'length[0,250]'" readonly="readonly"
										  style="width:587px;height:60px;" value="${applyBean.reason }">
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;">宴请安排</td>
									<td class="td2" colspan="3">
			                       		<input type="radio" value="1" id="fDiningPlace1" disabled="disabled"  <c:if test="${abroad.fDiningPlace==1} ">   checked="checked" </c:if>>是
			                        	<input type="radio" value="0" id="fDiningPlace2" disabled="disabled" <c:if test="${abroad.fDiningPlace!=1} ">  checked="checked" </c:if>>否
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width: 70px"><span class="style1">*</span> 经办人</td>
									<td class="td2" >
									<input class="easyui-textbox"  readonly="readonly" value="${applyBean.userNames}" style="width: 230px;height: 30px;margin-left: 10px " >
									</td>
									<td class="td1" style="width: 70px"><span class="style1">*</span> 部门名称</td>
									<td class="td2" >
									<input class="easyui-textbox" readonly="readonly" value="${applyBean.deptName}" style="width: 236px;height: 30px;margin-left: 10px " >
									</td>
								</tr>
							</table>
						</div>				
					</div>
				<!-- 出国人员信息 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
					<div title="出国人员信息 " data-options="collapsed:false,collapsible:false"	style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span>出国人员</td>
								<td colspan="3" style="padding-left: 5px;">
									<a >
										<input class="easyui-textbox" style="width: 642px;height: 30px;" name="fAbroadPeople" value="${abroad.fAbroadPeople}" id="fAbroadPeople"
										 data-options="prompt:'点击选择出国人员名单',validType:'length[1,200]',icons: [{iconCls:'icon-add'}]" readonly="readonly" required="required"/>
									 </a>
								</td>
							</tr>
						</table>
					</div>
				</div> --%>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
					<div title="出国人员信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<!-- 出访计划（含经停）-->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="abroad_person_detail.jsp" />
						</div>
					</div>
				</div>
				<!-- 路线计划 信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
					<div title="出访国家（含经停）" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<!-- 路线计划 -->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="abroad_way_detail.jsp" />
						</div>
					</div>
				</div>
				<!--出行方式 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
					<div title="出行方式" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="travel_way_detail.jsp" />
						</div>
					</div>
				</div>		
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px;width: 717px">
					<div title="费用明细" data-options="collapsible:false" style="overflow:auto;">
						<!-- 全部费用-->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_expense_detail.jsp" />
						</div>
					
						<%-- <!-- 国际旅费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_international_traveling_expense_detail.jsp" />
						</div>
						<!-- 国外城市间交通费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_outside_traffic_international_detail.jsp" />
						</div>
						<!-- 住宿费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="hotelExpense_aboard_detail.jsp" />
						</div>
						<!-- 伙食费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="foodAllowance_aboard_detail.jsp" />
						</div>
						<!-- 公杂费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="miscellaneousFee_detail.jsp" />
						</div>
						<!-- 宴请费 -->
						<div id="feteCostReimId">
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="feteCost_detail.jsp" />
						</div>
						</div>
						<!-- 其他费用 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="otherExpenses_detail.jsp" />
						</div> --%>
						<div style="margin-top: 20px">
							<a style="float: right;">申请总额：<span style="color: #D7414E"  id="applyAmountAbroad"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
						</div>
					</div>
				</div>
			<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px;width: 717px">
					<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目:</td>
								<td colspan="3" style="padding-right: 5px;">
									<a onclick="openIndex()" href="#">
									<input class="easyui-textbox" style="width: 642px;height: 30px;"
									name="indexName" value="${applyBean.indexName}" id="F_fBudgetIndexName"
									data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
									</a>
								</td>
							</tr>
						</table>	
						<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
								<tr>
									<td class="window-table-td1"><p>批复金额：</p></td>
									<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
									
									<td class="window-table-td1"><p>预算年度：</p></td>
									<td class="window-table-td2"><p id="p_pfDate">${fn:substring(bean.pfDate, 0, 4)}</p></td>
								</tr>
								<tr>
									<td class="window-table-td1"><p>可用额度：</p></td>
									<td class="window-table-td2"><p id="p_syAmount"><fmt:formatNumber groupingUsed="true" value="${bean.syAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
								</tr>
						</table>				
					</div>
				</div>
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
				<div title="附件信息" data-options=" collapsible:false"
					style="overflow:auto;padding:10px;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
								<td class="td1" style="width:40px">附件</td>
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
				<c:if test="${!empty applyBean.meetingSummaryYear1}">
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:697px;">
					<div title="三重一大会议信息" data-options="collapsible:false" style="overflow:hidden; ">
						<jsp:include page="check_meeting_infomation_detail.jsp" />
					</div>
				</div>
				</c:if>
				<!-- 审批记录 事前申请 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
					<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../../check_history_reim_apply.jsp" />
					</div>
				</div>

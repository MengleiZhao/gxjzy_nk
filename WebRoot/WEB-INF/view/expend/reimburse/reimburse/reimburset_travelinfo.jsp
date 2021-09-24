<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="预算信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">					
						<tr class="trbody">
							<td style="width: 60px;"><span class="style1">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<a onclick="openIndex()" href="#">
								<input class="easyui-textbox" style="width: 630px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left:0px;;margin-bottom: 0px;width: 695px;height: 50px;">
						<tr>
							<td class="window-table-td1"><p>使用部门:</p></td>
							<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
							
							<td class="window-table-td1"><p>批复时间:</p></td>
							<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
						</tr>
						<tr hidden="hidden">
							<td class="window-table-td1"><p>批复金额:</p></td>
							<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
							
							<td class="window-table-td1"><p>可用余额:</p></td>
							<td class="window-table-td2"><p id="p_syAmount"><fmt:formatNumber groupingUsed="true" value="${bean.syAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
						</tr>
						<tr>
							<td class="window-table-td1"><p style="color: red;" >报销金额:</p></td>
							<td class="window-table-td2"><p id="p_amount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
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
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
			<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;width: 717px">
				<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span>事项摘要</td>
							<td colspan="3" class="td2" >
								<input style="width: 635px; height: 30px;margin-left: 10px" id="gNames" class="easyui-textbox"
								value="${bean.gName}" />
							</td>
						</tr>
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span>单据编号</td>
							<td colspan="3" class="td2" >
								<input style="width: 635px;height: 30px;margin-left: 10px" readonly="readonly" name="gCode" class="easyui-textbox"
								value="${applyBean.gCode}" data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
							</td>
						</tr>
						
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}"style="width: 265px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
							<td class="td2" >
								<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 267px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						</table>
						
					</div>				
				</div>
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="行程调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
					<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td class="td1" style="width: 80px;"><span class="style1">*</span>行程是否调整</td>
							<td class="td2" colspan="4" >
								<input type="radio" value="1" onclick="radioyes()" name="fupdateStatus" id="box1" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
								&nbsp;&nbsp;
								<input type="radio" value="0" onclick="radiono()" name="fupdateStatus" id="box2" <c:if test="${bean.fupdateStatus=='0'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
							</td>
						</tr>
						<tr id="radiofupdate" hidden="hidden" class="trbody">
							<td class="td1" style="width: 80px;"><span class="style1">*</span>行程调整说明</td>
							<td colspan="3" class="td2" >
								<textarea name="fupdateReason"  id="fupdateReason" class="textbox-text"
									oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
									style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7;
									 margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
							</td>
						</tr>
					</table>
				</div>				
			</div>
			<!-- 出差人员名单 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="行程清单" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
					<div style="overflow:auto;margin-top: 0px;">
						<jsp:include page="apply_travel_itinerary.jsp" />
					</div>
				</div>
			</div>
			<!-- 费用明细 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
				<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					 <!-- 城市间交通费 -->
					<div style="overflow:auto;">
						<jsp:include page="apply_outside_traffic.jsp" />
					</div>
					<c:if test="${operation=='add'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 城市间交通费发票明细 -->
							<jsp:include page="mingxi_travel_outside.jsp" />
						</div>
					</c:if>
					<c:if test="${operation=='edit'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 城市间交通费发票明细 -->
							<jsp:include page="mingxi_travel_outside_edit.jsp" />
						</div>
					</c:if>
					<!-- 市内交通费 -->
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="apply_in_city.jsp" />
					</div>
					<!-- 住宿费 -->
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="hotelExpense.jsp" />
					</div>
					<c:if test="${operation=='add'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 住宿费发票明细 -->
							<jsp:include page="mingxi_travel_hotel.jsp" />
						</div>
					</c:if>
					<c:if test="${operation=='edit'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 住宿费发票明细 -->
							<jsp:include page="mingxi_travel_hotel_edit.jsp" />
						</div>
					</c:if>
					<!-- 伙食费 -->
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="foodAllowance.jsp" />
					</div>
					<!-- 会务、培训 -->
					<div style="overflow:auto;margin-top: 20px;" hidden="hidden">
						<jsp:include page="otherExpenses_travels.jsp" />
					</div>
					<c:if test="${operation=='add'}">		
						<div style="overflow:hidden;margin-top: 0px" hidden="hidden">
							<!-- 会务、培训发票明细 -->
							<jsp:include page="mingxi_travel_meet_train.jsp" />
						</div>
					</c:if>
					<c:if test="${operation=='edit'}">		
						<div style="overflow:hidden;margin-top: 0px" hidden="hidden">
							<!-- 会务、培训发票明细 -->
							<jsp:include page="mingxi_travel_meet_train_edit.jsp" />
						</div>
					</c:if>
					<div>
						<c:if test="${operation=='add'}">	
						<a style="float: right;margin-right: 30px;">报销总额：<span style="color: #D7414E"  id="rapplyTotalAmount"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount-applyBean.outsideAmount-applyBean.hotelAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
						</c:if>
						<c:if test="${operation=='edit'}">	
						<a style="float: right;margin-right: 30px;">报销总额：<span style="color: #D7414E"  id="rapplyTotalAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
						</c:if>
					</div>
				</div>
			</div>

			<!-- 收款人信息 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
					<div id="" style="overflow-x:hidden;margin-top: 0px;">
						<jsp:include page="payee-info.jsp" />	
					</div>
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
var updateradio = '${bean.fupdateStatus}';
var type = '${applyBean.travelType }';
var fWhetherAccompany = '${bean.fWhetherAccompany}';
function radiono(){
	updateradio=1;
	sign1=1;
	sign=1;
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk=="1"){
		$('#editStudentId').show();
		$('#addStudentId').hide();
		$('#removeStudentId').hide();
		$('#appendStudentId').hide();
	}else{
		$('#editStudentId').hide();
		$('#addStudentId').hide();
		$('#removeStudentId').hide();
		$('#appendStudentId').hide();
	}
	$('#radiofupdate').hide();
	$('#reimburse_itinerary_toolbar_Id').hide();
	$('#reimburse_hoteltool').show();
	$('#fupdateStatusid').val(0);
	$('#rEditId').hide();
	$('#reimburse_itinerary_tab_id').datagrid('reload');
	$('#reimburse_outside_tab_id').datagrid('reload');
	$('#reimbursein_city_tabs_id').datagrid('reload');
	$('#reimbursein_hoteltab').datagrid('reload');
	$('#reimbursein_foodtab').datagrid('reload');
	$("input[name='fWhetherAccompanys']").attr("disabled",true);
	acceptOutsideTrafficReim();
}
function radioyes(){
	updateradio=0;
	sign1=0;
	sign=1;
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk=="1"){
		$('#editStudentId').hide();
		$('#addStudentId').show();
		$('#removeStudentId').show();
		$('#appendStudentId').show();
	}else{
		$('#editStudentId').show();
		$('#addStudentId').hide();
		$('#removeStudentId').hide();
		$('#appendStudentId').hide();
	}
	
	$('#reimburse_itinerary_toolbar_Id').show();
	$('#reimburse_hoteltool').show();
	$('#radiofupdate').show();
	$('#fupdateStatusid').val(1);
	$('#rEditId').show();
	$("input[name='fWhetherAccompanys']").attr("disabled",false);
}
if(updateradio==0){
	sign1 = 0;
	$('#rEditId').hide();
	$('#editStudentId').hide();
	$('#radiofupdate').hide();
	$("input[name='fWhetherAccompanys']").attr("disabled",true);
}else{
	sign1 = 1;
	$('#rEditId').show();
	$('#editStudentId').show();
	$('#radiofupdate').show();
	$("input[name='fWhetherAccompanys']").attr("disabled",false);
}
if(fWhetherAccompany==0){
	sign1 = 0;
	$('#removeStudentId').hide();
	$('#appendStudentId').hide();
	$('#addStudentId').hide();
	$('#editStudentId').hide();
	$("input[name='fWhetherAccompanys']").attr("disabled",true);
}else{
	sign1 = 1;
	$('#removeStudentId').hide();
	$('#appendStudentId').hide();
	$('#addStudentId').hide();
	$('#editStudentId').hide();
	$("input[name='fWhetherAccompanys']").attr("disabled",true);
}

function radionoS(){
	$('#fWhetherAccompany').val(0);
	acceptStudentsReim();
	var rows = $('#reim_tracel_students_tab_id').datagrid('getRows');
	for (var i = rows.length-1; i >= 0 ; i--) {
		$('#reim_tracel_students_tab_id').datagrid('deleteRow',i);
	}
	editIndexStudents = undefined;
	$('#editStudentId').hide();
	$('#addStudentId').hide();
	$('#removeStudentId').hide();
	$('#appendStudentId').hide();
	$('#reimStudentsTravelId').hide();
}

function radioyesS(){
	$('#fWhetherAccompany').val(1);
	$('#editStudentId').hide();
	$('#addStudentId').show();
	$('#removeStudentId').show();
	$('#appendStudentId').show();
	$('#reimStudentsTravelId').show();
	$.parser.parse("#reimStudentsTravelId");
}
//打开指标选择页面
function openIndex() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}

</script>
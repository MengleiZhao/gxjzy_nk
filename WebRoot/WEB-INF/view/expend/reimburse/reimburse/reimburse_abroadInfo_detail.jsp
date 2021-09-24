<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
			<form id="reimburse_save_form" method="post"  enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode"  <c:if test="${operation=='add' }">value="${applyBean.gCode}"</c:if><c:if test="${operation=='edit' }"> value="${bean.rCode}"</c:if>/>
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销类型 --><input type="hidden" id="reimburseAmount" name="amount" <c:if test="${operation=='edit' }">value="${bean.amount}"</c:if><c:if test="${operation=='add'}">value="${applyBean.amount}"</c:if>/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${applyBean.indexId}" id=""/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" <c:if test="${operation=='add' }"> value="${applyBean.proDetailId}"</c:if><c:if test="${operation=='edit' }"> value="${bean.proDetailId}"</c:if> id="proDetailId"/>
				<input type="hidden" id="json1" name="form1" />
				<input type="hidden" id="json2" name="form2" />
				<input type="hidden" id="json3" name="form3" />
				<input type="hidden" id="json4" name="form4" />
				<input type="hidden" id="json5" name="form5" />
				<input type="hidden" id="json6" name="form6" />
				<!-- 收款人信息 -->
				<input hidden="hidden" id="payeeAmounts" name="payeeAmount" value="${payee.payeeAmount}"/>
				<input hidden="hidden" id="payerinfoJson" name="payerinfoJson"/>
				
				<!-- 最早的出发时间  --><input type="hidden" id="maxTime" />
				<!-- 最晚的撤离时间  --><input type="hidden" id="minTime" />
				<!-- 申请总额  --><input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				<!-- 国际旅费  --><input type="hidden" id="travelMoney" name="travelMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.travelMoney}" </c:if><c:if test="${operation=='add'}"> value="${abroad.travelMoney}" </c:if>/>
				<!-- 住宿费  --><input type="hidden" id="hotelMoney" name="hotelMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.hotelMoney}"</c:if><c:if test="${operation=='add'}"> value="${abroad.hotelMoney}"</c:if>/>
				<!-- 伙食费  --><input type="hidden" id="foodMoney" name="foodMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.foodMoney}"</c:if><c:if test="${operation=='add'}"> value="${abroad.foodMoney}"</c:if>/>
				<!-- 公杂费  --><input type="hidden" id="mixMoney" name="mixMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.mixMoney}" </c:if><c:if test="${operation=='add'}"> value="${abroad.mixMoney}" </c:if>/>
				<!-- 宴请费  --><input type="hidden" id="feteMoney" name="feteMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.feteMoney}"</c:if><c:if test="${operation=='add'}"> value="${abroad.feteMoney}"</c:if>/>
				<!-- 国外交通费  --><input type="hidden" id="trafficMoney" name="trafficMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.trafficMoney}"</c:if><c:if test="${operation=='add'}"> value="${abroad.trafficMoney}"</c:if>/>
				<!-- 其他费用  --><input type="hidden" id="totalOtherMoney" name="totalOtherMoney" <c:if test="${operation=='edit' }"> value="${abroadEdit.totalOtherMoney}"</c:if><c:if test="${operation=='add'}"> value="${abroad.totalOtherMoney}"</c:if>/>
				<!-- 所有列表json -->
				<input type="hidden" id="travelJson" name="travelJson" />
				<input type="hidden" id="outsideTrafficJson" name="trafficJson1" />
				<input type="hidden" id="hotelJson" name="hotelJson" />
				<input type="hidden" id="foodJson" name="foodJson" />
				<input type="hidden" id="feeJson" name="feeJson" />
				<input type="hidden" id="feteJson" name="feteJson" />
				<input type="hidden" id="otherJson" name="otherJson" />
				<input type="hidden" id="abroadPlanJson" name="abroadPlanJson" />
				</div>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="基本信息" data-options=" collapsible:false" style="overflow:auto;width: 717px">
					<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span> 单据编号</td>
									<td colspan="3" class="td2" >
										<input style="width: 595px;height: 30px;" name="gCode" class="easyui-textbox"
										value="${bean.gCode}" data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>摘要</td>
									<td colspan="3" class="td2" >
										<input class="easyui-textbox" style="width: 595px;height: 30px; " value="${bean.gName}" name="gName"   readonly="readonly"  required="required" data-options="validType:'length[1,50]'"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团组名称</td>
									<td class="td2" >
										<input style="width: 230px; height: 30px;" id="fTeamName" name="fTeamName" class="easyui-textbox" readonly="readonly"
										value="${abroadEdit.fTeamName}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px"><span class="style1">*</span>组团单位</td>
									<td class="td2">
										<input style="width: 236px; height: 30px;" id="fAbroadPlace" name="fAbroadPlace" class="easyui-textbox" readonly="readonly" 
										value="${abroadEdit.fAbroadPlace}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团长(级别)</td>
									<td class="td2">
										<input style="width: 230px; height: 30px;" id="fTeamLeader" name="fTeamLeader" class="easyui-textbox" readonly="readonly" 
										value="${abroadEdit.fTeamLeader}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td  class="td1" style="width:70px;"></td>
									<td class="td2"> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团员人数</td>
									<td class="td2">
										<input style="width: 230px; height: 30px;" id="fTeamPersonNum"  name="fTeamPersonNum" class="easyui-numberbox" readonly="readonly" 
										value="${abroadEdit.fTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:100px;"><span class="style1">*</span>本单位参团人数</td>
									<td class="td2">
										<input style="width: 236px; height: 30px;" id="fThisUnitTeamPersonNum"  name="fThisUnitTeamPersonNum" class="easyui-numberbox" readonly="readonly" 
										value="${abroadEdit.fThisUnitTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>开始时间</td>
									<td class="td2">
										<input style="width: 230px; height: 30px;" id="abroadDateStart" name="fAbroadDateStart" class="easyui-datebox" readonly="readonly" 
										value="${abroadEdit.fAbroadDateStart}" data-options="required:true" editable="false"/>
									</td>
									
									<td class="td1" style="width:70px;"><span class="style1">*</span>结束时间</td>
									<td class="td2">
										<input type="hidden" name="faId" value="${abroadEdit.faId}" />
										<input style="width: 236px; height: 30px;" id="abroadDateEnd" name="fAbroadDateEnd" class="easyui-datebox"   readonly="readonly" 
										value="${abroadEdit.fAbroadDateEnd}" data-options="onSelect:onSelectAbroad3,required:true" editable="false"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>出国天数</td>
									<td class="td2" colspan="3">
										<input style="width: 230px; height: 30px;" id="abroadDay" name="fAbroadDayNum" class="easyui-textbox"  readonly="readonly" 
										value="${abroadEdit.fAbroadDayNum}" readonly="readonly" data-options="required:true,validType:'length[1,2]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;">宴请安排</td>
									<td class="td2" colspan="3">
			                       		<input type="radio" name="fDiningPlace" id="fDiningPlaceId1" disabled="disabled"  onclick="checkedFete1()" value="1" <c:if test="${abroadEdit.fDiningPlace==1} "> checked </c:if>>是
			                        	<input type="radio" name="fDiningPlace" id="fDiningPlaceId2" disabled="disabled" onclick="checkedFete2()" value="0" <c:if test="${abroadEdit.fDiningPlace!=1} "> checked </c:if>>否
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>备注</td>
									<td class="td2" colspan="3">
										<input class="easyui-textbox" id="remark" name="remark" data-options="multiline:true,required:true,validType:'length[0,250]'"  readonly="readonly"
										  style="width:595px;height:60px;" value="${abroadEdit.remark }">
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width: 70px;"><span class="style1">*</span> 付款方式</td>
									<td class="td2">
										<input class="easyui-combobox" value="${bean.paymentType}" readonly="readonly" style="width: 230px; height: 30px;" data-options="editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'code',textField:'text'"/>
									</td>
									<td class="td1" style="width: 70px;"></td>
									<td class="td2">
									</td>
								</tr>								
								<tr class="trbody" style="line-height: 36px;">
									<td class="td1" style="width: 70px;">经办人</td>
									<td class="td2" >
										<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}" style="width: 230px;height: 30px;margin-left: 10px " >
									</td>
									<td class="td1" style="width: 70px;">部门名称</td>
									<td class="td2" >
										<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 236px;height: 30px;margin-left: 10px " >
									</td>
								</tr>
						</table>
					</div>				
				</div>
				<!-- 出国人员信息 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出国人员信息 " data-options="collapsed:false,collapsible:false"	style="overflow:auto;;width: 707px">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 10px;width: 695px">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span>出国人员</td>
								<td colspan="3" style="padding-left: 5px;">
									<a id="chooseuserId">
										<input class="easyui-textbox" style="width: 625px;height: 30px;" name="fAbroadPeople" value="${abroadEdit.fAbroadPeople}" id="fAbroadPeople"
										 data-options="prompt:'点击选择出国人员名单',validType:'length[1,200]',icons: [{iconCls:'icon-add'}]" readonly="readonly" required="required"/>
									 </a>
								</td>
							</tr>
						</table>
					</div>
				</div> --%>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出国人员信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="abroad_person_detail_reim.jsp" />
						</div>
					</div>
				</div>
				
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="公务出国调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
						<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
							<tr class="trbody">
								<td class="td1"style="width: 80px;"><span class="style1">*</span>是否存在调整</td>
								<td class="td2" colspan="3" >
									<input type="radio" value="1" onclick="radioyes()" disabled="disabled" readonly="readonly" name="fupdateStatus" id="box3" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
									&nbsp;&nbsp;
									<input type="radio" value="0" onclick="radiono()" disabled="disabled" readonly="readonly" name="fupdateStatus" id="box4" <c:if test="${bean.fupdateStatus=='0'}">checked="checked" </c:if>  style="vertical-align: middle;"/>&nbsp;&nbsp;否
								</td>
							</tr>
							<tr id="radiofupdate" hidden="hidden" class="trbody">
								<td class="td1"  style="width: 80px;"><span class="style1">*</span>调整说明</td>
								<td colspan="3" class="td2" >
									<textarea name="fupdateReason"  id="fupdateReason" class="textbox-text" readonly="readonly"
											oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
											style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
								</td>
							</tr>
						</table>
					</div>				
				</div>
				</form>		
				<!-- 路线计划 信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出访国家（含经停）" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
						<!-- 路线计划 -->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="abroad_way_detail_reim.jsp" />
						</div>
					</div>
				</div>
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="费用明细" data-options="collapsible:false" style="overflow:auto;width: 717px">
						<!-- 国际旅费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_international_traveling_expense_detail_reim.jsp" />
						</div>
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 国际旅费发票明细 -->
								<jsp:include page="mingxi_abroad_mix_detail.jsp" />
							</div>
						<!-- 国外城市间交通费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_outside_traffic_international_detail_reim.jsp" />
						</div>
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 国外城市间交通费发票明细 -->
								<jsp:include page="mingxi_abroad_outside_edtail.jsp" />
							</div>
						<!-- 住宿费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="hotelExpense_aboard_detail_reim.jsp" />
						</div>
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 住宿费发票明细 -->
								<jsp:include page="mingxi_abroad_hotel_edtail.jsp" />
							</div>
						<!-- 伙食费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="foodAllowance_aboard_detail_reim.jsp" />
						</div>
						<!-- 公杂费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="miscellaneousFee_detail_reim.jsp" />
						</div>
						<!-- 宴请费 -->
						<div id="feteCostId">
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="feteCost_detail_reim.jsp" />
						</div>
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 宴请费发票明细 -->
								<jsp:include page="mingxi_abroad_fete_edtail.jsp" />
							</div>
						</div>
						<!-- 其他费用 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="otherExpenses_detail_reim.jsp" />
						</div>
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 其他费用发票明细 -->
								<jsp:include page="mingxi_abroad_other_edtail.jsp" />
							</div>
						<div style="margin-top: 20px">
							<a style="float: right;">报销总额：<span style="color: #D7414E"  id="applyAmountAbroad"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
						</div>
					</div>
				</div>
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px">
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
							<td class="window-table-td2"><p id="p_amount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
						</tr>
						<tr>
							<td class="window-table-td1"><p>归还预算:</p></td>
							<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
						</tr>
						<tr >
							<td class="window-table-td1"><p>是否冲销借款</p></td>
							<td class="window-table-td2">
								<input id="hotelstd_add_sfwj" name="withLoan" value="1"
									type="radio" onclick="selectCxjk(this)" disabled="disabled" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
								<input id="hotelstd_add_sfwj" name="withLoan" value="0"
									type="radio" onclick="selectCxjk(this)" disabled="disabled" <c:if test="${bean.withLoan!=1 }">checked="checked"</c:if>/>否
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
				
				
				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="收款人信息" data-options=" collapsible:false"
						style="overflow:auto;padding:0px;">
						<input hidden="hidden" value="${payee.pId}" name="pId"/>
						<div id="" style="overflow-x:hidden;margin-top: 10px;">
							<jsp:include page="payee-info_detail.jsp" />	
						</div>
						<input hidden="hidden" id="num2" name="payeeAmount" value="${payee.payeeAmount}" readonly="readonly" precision="2"/>
					</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
				<div title="附件信息" data-options=" collapsible:false"
					style="overflow:auto;padding:10px;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
								<td style="width:55px;text-align: left">附件</td>
								<td colspan="4">
									<c:if test="${!empty attaList1}">
									<c:forEach items="${attaList1}" var="att">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
									</c:forEach>
								</c:if>
								<c:if test="${empty attaList1}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
								</td>
							</tr>		
					</table>
				</div>
				</div>
			
		<!-- 审批记录报销 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;padding:0px;">
				<!-- <div class="window-title"> 审批记录</div> -->
					<jsp:include page="../../../check_history.jsp" />
			</div>
		</div>
<script type="text/javascript">
var updateradio = 0;
function radiono(){
	updateradio=1;
	$('#radiofupdate').hide();
	$('#fupdateStatusid').val(0);
}
function radioyes(){
	$('#radiofupdate').show();
	$('#fupdateStatusid').val(1);
}
//冲销借款
function cx(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAccount').numberbox('setValue',num2);
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAccount').numberbox('setValue',0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
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
	var cxjk = $('input[name="withLoan"]:checked').val();
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(cxjk==1){
	var num1=parseFloat(${bean.loan.leastAmount});
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
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
		$('#duration').numberbox("setValue", d);
	} else {
		$('#duration').numberbox("setValue", "");
	}
}
//显示详细信息手风琴页面
$(document).ready(function() {
	jk();
	//是否显示 冲销借款信息
	var cxjk = $('input[name="withLoan"]:checked').val();
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
	zzAmount();
	$("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			cx();
		}
	});
	
	var cxjk = '${abroadEdit.fDiningPlace}';
	if(cxjk==1){
		$('#feteCostId').show();
		$("#fDiningPlaceId1").attr("checked",true);
	} else {
		$('#feteCostId').hide();
		$("#fDiningPlaceId2").attr("checked",true);
		
	}
});

function selectCxjk(){
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
		cx();
	}
}

//保存
function saveReimburse(flowStauts) {
	$('#indexName').val($('#F_fBudgetIndexName').textbox('getValue'));//预算指标名称
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
	
	abroadPlanJson();					 //行程清单
	travelJson();                        //国际旅费
	outsideTrafficJson();                //国外城市间交通费
	getHotelJson();						 //住宿费
	getfoodJson();						 //伙食费
	getFeeJson();						 //公杂费
	var cxjk = $('input[name="fDiningPlace"]:checked').val();
	if(cxjk==1){
	getFeteCostJson();					 //宴请费
	}
	getOtherJson();						 //其他费用
	getpayerinfoJson();
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	var nums=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	var applyAmount1 = (nums-num3).toFixed(2);
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	$('#reimburseStauts').val(flowStauts);
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
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfil?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1+"&sts="+flowStauts);
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
				 ;
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
//日期设置
function onSelectAbroad3(date) {
	endday5 = date;
	startday5 =new Date(startday5);
	if(startday5 !=undefined){
		var d = (endday5 - startday5) / 86400000 + 1;
		if (d > 0) {
			$('#abroadDay').textbox("setValue", d);
		} else {
			$('#abroadDay').textbox("setValue", "");
		}
	}
	$("#maxTime").val(endday5);
	
}

function chooseuser(index) {
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=abroad&tabId=apply_abroadtab');
	win.window('open');

}


function countMoney(){
	var travelMoney = $("#travelMoney").val();
	var hotelMoney = $("#hotelMoney").val();
	var foodMoney = $("#foodMoney").val();
	var mixMoney = $("#mixMoney").val();
	var feteMoney = $("#feteMoney").val();
	var trafficMoney = $("#trafficMoney").val();
	var totalOtherMoney = $("#totalOtherMoney").val();
	if(travelMoney=='NaN'||travelMoney==''||travelMoney==undefined||travelMoney==null){
		travelMoney=0;
	}
	if(hotelMoney=='NaN'||hotelMoney==''||hotelMoney==undefined||hotelMoney==null){
		hotelMoney=0;
	}
	if(foodMoney=='NaN'||foodMoney==''||foodMoney==undefined||foodMoney==null){
		foodMoney=0;
	}
	if(mixMoney=='NaN'||mixMoney==''||mixMoney==undefined||mixMoney==null){
		mixMoney=0;
	}
	if(feteMoney=='NaN'||feteMoney==''||feteMoney==undefined||feteMoney==null){
		feteMoney=0;
	}
	if(trafficMoney=='NaN'||trafficMoney==''||trafficMoney==undefined||trafficMoney==null){
		trafficMoney=0;
	}
	if(totalOtherMoney=='NaN'||totalOtherMoney==''||totalOtherMoney==undefined||totalOtherMoney==null){
		totalOtherMoney=0;
	}
	$("#applyAmountAbroad").html(listToFixed((parseFloat(travelMoney)+parseFloat(hotelMoney)+parseFloat(foodMoney)+parseFloat(mixMoney)+parseFloat(feteMoney)+parseFloat(trafficMoney)+parseFloat(totalOtherMoney)))+"元");
	$("#applyAmount").val((parseFloat(travelMoney)+parseFloat(hotelMoney)+parseFloat(foodMoney)+parseFloat(mixMoney)+parseFloat(feteMoney)+parseFloat(trafficMoney)+parseFloat(totalOtherMoney)).toFixed(2));
}
</script>


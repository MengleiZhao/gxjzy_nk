<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
			<!-- 预算信息 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="预算信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;margin-left: 0px;">
				<jsp:include page="apply_index_multiple.jsp" />
			</div>
			</div>
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
			<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;width: 717px">
				<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>事项摘要</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px" id="gNames" value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>培训名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px" id="reimName" value="${bean.reimName}" name="reimName" required="required" data-options="validType:'length[1,100]'"/>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 65px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>培训事由</td>
							<td colspan="3">
								<textarea name="reimburseReasons" id="reimburseReasons" class="easyui-textbox" data-options="multiline:true"
									oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
									style="margin-left: 10px ;width:625px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${bean.reimburseReason}</textarea>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}"style="width: 260px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
							<td class="td2" >
								<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 262px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>出发日期</td>
							<td class="td2">
								<input  class="easyui-datebox" style="width: 260px;; height: 30px;" id="travelDateStart" 
								data-options="" value="${reimTravelBean.travelDateStart}" required="required" editable="false"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span>结束日期</td>
							<td class="td2">
								<input class="easyui-datebox" style="width: 262px;; height: 30px;" id="travelDateEnd" 
								data-options="" value="${reimTravelBean.travelDateEnd}" required="required" editable="false"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
							<td class="td2">
								<input  class="easyui-combobox" style="width: 260px;; height: 30px;" id="fProvinceId" 
								value="${reimTravelBean.fProvinceId}" required="required" editable="false"data-options="editable:false,
									url:'${base}/apply/getRegion?id=0&selected=${reimTravelBean.fProvinceId}',
									method:'POST',
									valueField:'id',
									textField:'text',
									onSelect: function(rec){
										$('#fCityId').combobox('setValue', '');
									    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${reimTravelBean.fCityId}';
									    $('#fCityId').combobox('reload', url);
									    }"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
							<td class="td2">
								<input class="easyui-combobox" style="width: 262px;; height: 30px;" id="fCityId" 
								value="${reimTravelBean.fCityId}" required="required" editable="false" data-options="
									url:'${base}/apply/getRegion?selected=${reimTravelBean.fCityId}',
									editable:false,
									method:'POST',
									valueField:'id',
									textField:'text',
									onSelect: function(rec){
										$('#fDistrictId').combobox('setValue', '');
									    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${reimTravelBean.fDistrictId}';
									    $('#fDistrictId').combobox('reload', url);
									    }"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
							<td class="td2">
								<input  class="easyui-combobox" style="width: 260px;; height: 30px;" id="fDistrictId" 
								value="${reimTravelBean.fDistrictId}" required="required" editable="false" data-options="
									editable:false,
									method:'POST',
									valueField:'id',
									textField:'text'
									"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
							<td class="td2">
								<input class="easyui-textbox" style="width: 262px;; height: 30px;" id="travelAreaName" name="travelAreaName"
								value="${reimTravelBean.travelAreaName}" required="required" />
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 同行人</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 625px;height: 30px;margin-left: 10px" id="travelAttendPeop" value="${reimTravelBean.travelAttendPeop}" required="required" data-options="validType:'length[1,200]',editable:false,
								icons:[{iconCls:'icon-add',handler: function(e){
					     selectTravelAttendPeopAttend();
					     }},{
							iconCls:'icon-remove',
							handler: function(e){
								//$(e.data.target).textbox('clear');
								$('#travelAttendPeop').textbox('setValue','');
								$('#travelAttendPeops').val('');
								$('#travelAttendPeopId').val('');
								$('#travelPersonnelLevel').val('');
							}
						}]"/>
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
			<!-- 费用明细 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
				<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px;">
					<div style="height:10px;"></div>
						<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
							<tr>
								<td class="window-table-td1" style="width:20%"><span style="color: red"></span>培训学费</td>
								<td class="window-table-td2" style="width:27%">
									<p style=" color:#0000CD;"></p>
								</td>
								<td class="window-table-td1"><p>申请金额：</p></td>
								<td class="td2">
									<input id="trainMoney" value="${reimTravelBean.trainMoney}" class="easyui-numberbox"
								 style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>
								</td>
							</tr>
						</table>
						<div style="height:10px;"></div>
					</div>
					 <!-- 城市间交通费 -->
					<div style="overflow:auto;">
						<jsp:include page="apply_outside_traffic_attend_train.jsp" />
					</div>
					<c:if test="${operation=='add'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 城市间交通费发票明细 -->
							<jsp:include page="mingxi_travel_outside_attend_train.jsp" />
						</div>
					</c:if>
					<c:if test="${operation=='edit'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 城市间交通费发票明细 -->
							<jsp:include page="mingxi_travel_outside_edit_attend_train.jsp" />
						</div>
					</c:if>
					<!-- 市内交通费 -->
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="apply_in_city_attend_train.jsp" />
					</div>
					<!-- 住宿费 -->
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="hotelExpense_attend_train.jsp" />
					</div>
					<c:if test="${operation=='add'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 住宿费发票明细 -->
							<jsp:include page="mingxi_travel_hotel_attend_train.jsp" />
						</div>
					</c:if>
					<c:if test="${operation=='edit'}">		
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 住宿费发票明细 -->
							<jsp:include page="mingxi_travel_hotel_edit_attend_train.jsp" />
						</div>
					</c:if>
					<!-- 伙食费 -->
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="foodAllowance_attend_train.jsp" />
					</div>
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
	$('#rEditId').hide();
	$('#editStudentId').hide();
	$('#radiofupdate').hide();
	$("input[name='fWhetherAccompanys']").attr("disabled",true);
}else{
	$('#rEditId').show();
	$('#editStudentId').show();
	$('#radiofupdate').show();
	$("input[name='fWhetherAccompanys']").attr("disabled",false);
}
if(fWhetherAccompany==0){
	$('#removeStudentId').hide();
	$('#appendStudentId').hide();
	$('#addStudentId').hide();
	$('#editStudentId').hide();
	$("input[name='fWhetherAccompanys']").attr("disabled",true);
}else{
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
function onShowPanelSHIAttendReim(){
	var fProvinceId =  $("#fProvinceId").combobox('getValue');
	if(fProvinceId==""){
		alert('请先选择省级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fProvinceId;
    $('#fCityId').combobox('reload', url);
}
function onShowPanelQUAttendReim(){
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
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/reimburse/chooseUserAttendTrain?editType=attendTrain&peopId='+peopId);
	win.window('open');
}

function allProIndexList(){
	var outsideAmount = $("#outsideAmount").val();
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = $("#hotelAmount").val();
	var foodAmount = $("#foodAmount").val();
	var meetTrainAmount = $("#meetTrainAmount").val();
	if(outsideAmount=='NaN'||outsideAmount==''||outsideAmount==undefined||outsideAmount==null){
		outsideAmount=0;
	}
	if(cityAmount=='NaN'||cityAmount==''||cityAmount==undefined||cityAmount==null){
		cityAmount=0;
	}
	if(hotelAmount=='NaN'||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
		hotelAmount=0;
	}
	if(foodAmount=='NaN'||foodAmount==''||foodAmount==undefined||foodAmount==null){
		foodAmount=0;
	}
	if(meetTrainAmount=='NaN'||meetTrainAmount==''||meetTrainAmount==undefined||meetTrainAmount==null){
		meetTrainAmount=0;
	}
	$('#travelAmount').val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2));
	$("#rapplyTotalAmount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2)+"元");
	$("#p_amount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2)+"元");
	$("#reimburseAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2));
}

function allTeacherList(){
	acceptIndexReim();
	var outsideTeacherAmount = parseFloat($('#outsideTeacherAmount').val());
	var cityTeacherAmount = parseFloat($('#cityTeacherAmount').val());
	var hotelTeacherAmount = parseFloat($('#hotelTeacherAmount').val());
	var foodTeacherAmount = parseFloat($('#foodTeacherAmount').val());
	if(outsideTeacherAmount=='NaN'||outsideTeacherAmount==''||outsideTeacherAmount==undefined||outsideTeacherAmount==null){
		outsideTeacherAmount=0;
	}
	if(cityTeacherAmount=='NaN'||cityTeacherAmount==''||cityTeacherAmount==undefined||cityTeacherAmount==null){
		cityTeacherAmount=0;
	}
	if(hotelTeacherAmount=='NaN'||hotelTeacherAmount==''||hotelTeacherAmount==undefined||hotelTeacherAmount==null){
		hotelTeacherAmount=0;
	}
	if(foodTeacherAmount=='NaN'||foodTeacherAmount==''||foodTeacherAmount==undefined||foodTeacherAmount==null){
		foodTeacherAmount=0;
	}
	var teacher = foodTeacherAmount+hotelTeacherAmount+cityTeacherAmount+outsideTeacherAmount;
	var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
		if(rowsIndex[i].fCostName=='差旅费' && rowsIndex[i].fCostTheir=='教师费用'){
			$('#index_reim_tab_id').datagrid('updateRow',{
				index: i,
				row: {
					fCostAmount: teacher
				}
			});
		}
    }
}


function allStudentList(){
	acceptIndexReim();
	var outsideStudentAmount = parseFloat($('#outsideStudentAmount').val());
	var cityStudentAmount = parseFloat($('#cityStudentAmount').val());
	var hotelStudentAmount = parseFloat($('#hotelStudentAmount').val());
	var foodStudentAmount = parseFloat($('#foodStudentAmount').val());
	if(outsideStudentAmount=='NaN'||outsideStudentAmount==''||outsideStudentAmount==undefined||outsideStudentAmount==null){
		outsideStudentAmount=0;
	}
	if(cityStudentAmount=='NaN'||cityStudentAmount==''||cityStudentAmount==undefined||cityStudentAmount==null){
		cityStudentAmount=0;
	}
	if(hotelStudentAmount=='NaN'||hotelStudentAmount==''||hotelStudentAmount==undefined||hotelStudentAmount==null){
		hotelStudentAmount=0;
	}
	if(foodStudentAmount=='NaN'||foodStudentAmount==''||foodStudentAmount==undefined||foodStudentAmount==null){
		foodStudentAmount=0;
	}
	var student = outsideStudentAmount+cityStudentAmount+hotelStudentAmount+foodStudentAmount;
	var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
		if(rowsIndex[i].fCostName=='差旅费' && rowsIndex[i].fCostTheir=='学生费用'){
			$('#index_reim_tab_id').datagrid('updateRow',{
				index: i,
				row: {
					fCostAmount: student
				}
			});
		}
    }
}

function huizong(){
	var outsideAmount = $("#outsideAmount").val();
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = $("#hotelAmount").val();
	var foodAmount = $("#foodAmount").val();
	var meetTrainAmount = $("#meetTrainAmount").val();
	if(isNaN(outsideAmount)||outsideAmount==''||outsideAmount==undefined||outsideAmount==null){
		outsideAmount=0;
	}
	if(isNaN(cityAmount)||cityAmount==''||cityAmount==undefined||cityAmount==null){
		cityAmount=0;
	}
	if(isNaN(hotelAmount)||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
		hotelAmount=0;
	}
	if(isNaN(foodAmount)||foodAmount==''||foodAmount==undefined||foodAmount==null){
		foodAmount=0;
	}	
	if(meetTrainAmount=='NaN'||meetTrainAmount==''||meetTrainAmount==undefined||meetTrainAmount==null){
		meetTrainAmount=0;
	}
	$("#rapplyTotalAmount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2)+"元");
	$("#p_amount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2)+"元");
	$("#reimburseAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2));
}

$('#trainMoney').numberbox({
	onChange: function (newValue, oldValue) {
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		var newValue = isNaN(parseFloat(newValue))?0:parseFloat(newValue);
		$("#trainMoneys").val(newValue);
		$("#meetTrainAmount").val(newValue);
		allProIndexList();
		indexAmountName();
	}
});
$('#travelDateStart').datebox({
	onHidePanel: function(){
		var travelDateStarts = $('#travelDateStart').datebox('getValue');
		$("#travelDateStarts").val(travelDateStarts);
	}
});
$('#travelDateEnd').datebox({
	onHidePanel: function(){
		
		var travelDateEnds = $('#travelDateEnd').datebox('getValue');
		$("#travelDateEnds").val(travelDateEnds);
	}
});
$('#fProvinceId').combobox({
	onSelect: function(rec){
		
	    $('#fCityId').combobox('setValue', '');
	    $('#fDistrictId').combobox('setValue', '');
		var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${reimTravelBean.fCityId}';
	    $('#fCityId').combobox('reload', url);
		$("#fProvinceIds").val(rec.id);
	}
});
$('#fCityId').combobox({
	onSelect: function(rec){
		
	    if(rec.id==''){
	    $('#fDistrictId').combobox('setValue', '');
	    	return false;
	    }
	    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${reimTravelBean.fDistrictId}';
	    $('#fDistrictId').combobox('reload', url);
		$("#fCityIds").val(rec.id);
	}
});
$('#fDistrictId').combobox({
	onSelect: function(date){
		
		$("#fDistrictIds").val(date.id);
	}
});
$('#travelAreaName').textbox({
	onChange: function(newValue, oldValue){
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		$("#travelAreaNames").val(newValue);
	}
});
$('#gNames').textbox({
	onChange: function(newValue, oldValue){
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		$("#gName").val(date);
	}
});
$('#reimName').textbox({
	onChange: function(newValue, oldValue){
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		$("#reimNames").val(date);
	}
});
</script>
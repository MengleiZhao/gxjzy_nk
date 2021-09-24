<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>
<!-- 餐费 -->
<div class="window-table" style="margin-bottom:10px">

	<c:if test="${detail!='detail'}">
	<div style="float: left;">
		<span>费用名称：</span>
		<span style=" color:black;">餐费</span>
		<span style="margin-left: 30px">
		<span>原申请金额：</span>
		<span style=" color:black;"><fmt:formatNumber groupingUsed="true" value="${receptionBean.costFood}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
		</span>
	</div>
	<%-- <div style="margin-right:40px;">
	<a href="javascript:void(0)" onclick="removeit2()" style="float: right;margin-right: 22px;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append2()" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div> --%>
	
	</c:if>

	<table id="rec-food-dg-reim" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	url: '${base}/reimburse/applyReceptionFoodPage?rId=${bean.rId}',
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	 onClickRow: onClickRow1,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>	
			<c:if test="${receptionBean.isForeign==0}">
			<th data-options="field:'time',required:'required',align:'center',width:136,formatter:ChangeDateFormatIndex">时间</th>
			</c:if>
			<c:if test="${receptionBean.isForeign==1}">
			<th data-options="field:'date',required:'required',align:'center',width:136,formatter:ChangeDateFormat">日期</th>
			</c:if>
			<th data-options="field:'place',required:'required',align:'center',width:158">地点</th>	
			<th data-options="field:'fFoodType',required:'required',align:'center',width:100">标准</th>
			<th data-options="field:'fPersonNum',required:'required',align:'center',width:85">用餐总人数</th>	
            <th data-options="field:'fOtherNum',required:'required',align:'center',width:90">其中陪餐人数</th>
			<th data-options="field:'fReimbCostFood',required:'required',align:'center',width:100">金额(元)</th>
		</tr>
	</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<span style="float: right;"  id="costFood_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBeanEdit.costFood}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
			
		</span>
	</div>
</div>
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 餐费发票明细 -->
				<jsp:include page="mingxi_reception_food_detail.jsp" />
			</div>
<div style="height:10px;"></div>
<!-- 住宿费 -->
<div class="window-table" style="margin-bottom:10px;">
	<c:if test="${detail!='detail'}">
	<div style="float: left;">
	<span>费用名称：</span>
	<span style=" color:black;">住宿费</span>
	<span style="margin-left: 30px">
	<span>原申请金额：</span>
	<span style=" color:black;"><fmt:formatNumber groupingUsed="true" value="${receptionBean.costHotel}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
	</span>
	</div>
	</c:if>
	<table id="rec-hotel-dg-reim" class="easyui-datagrid" style="width:694px;height:auto;"
	data-options="
	toolbar: '#appli-detail-tb',
	url: '${base}/reimburse/applyReceptionHotelPage?rId=${bean.rId}',
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowR,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'hID',hidden:true"></th>
			<th data-options="field:'mark',hidden:true"></th>			
			<th data-options="field:'fName',required:'required',align:'center',width:110">姓名</th>
			<th data-options="field:'fPlace',required:'required',align:'center',width:200">住宿地点</th>
			<th data-options="field:'fRoomType',required:'required',align:'center',width:124">住宿房型</th>
			<th data-options="field:'fStartTime',required:'required',align:'center',width:130,formatter:ChangeDateFormat">入住日期</th>
			<th data-options="field:'fEndTime',required:'required',align:'center',width:130,formatter:ChangeDateFormat">退房日期</th>
			<th data-options="field:'fCostHotel',required:'required',align:'center',width:120">金额(元)</th>
			<th data-options="field:'positionCode',hidden:true,editor:'textbox'"></th>								
													
		</tr>
	</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<span style="float: right;"  id="costHotel_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBeanEdit.costHotel}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
		</span>
	</div>
</div>
<div style="overflow:hidden;margin-top: 0px">
	<!-- 住宿费发票明细 -->
	<jsp:include page="mingxi_travel_hotel_detail.jsp" />
</div>
<div style="height:10px;"></div>


<!-- 其他费用 -->
<div class="window-table">
	<div id="rph" style="height:30px;padding-top : 8px">
	<div style="float: left;">
		<span>费用名称：</span>
		<span style=" color:black;">其他费用</span>
		<span style="margin-left: 30px">
		<span>原申请金额：</span>
		<span style=" color:black;"><fmt:formatNumber groupingUsed="true" value="${receptionBean.costOther}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
		</span>
	</div>
		<%-- <a href="javascript:void(0)" onclick="removeit2()" id="removeit2Id" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append2()" id="append2Id" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
	</div>
	<table id="rec-other-dg-reim" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/reimburse/applyReceptionOtherPage?rId=${bean.rId}',
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowOther, 
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'oID',hidden:true"></th>
				<th data-options="field:'fCostName',required:'required',align:'center',width:195,editor:'textbox'">项目内容</th>
				<th data-options="field:'fCost',required:'required',align:'center',width:191,editor:{type:'numberbox',options:{onChange:addNumOther2,precision:2,groupSeparator:','}}">金额(元)</th>
				<th data-options="field:'fRemark',width:281,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<span style="float: right;"  id="costOther_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBeanEdit.costOther}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
			
		</span>
	</div>
</div>
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 其他费用发票明细 -->
				<jsp:include page="mingxi_reception_other_detail.jsp" />
			</div>
<script type="text/javascript">
$(function(){
	$("#costTraffics").numberbox({
	    onChange : function(newValue,oldValue){
	    	
	    	$('#costTraffic').val(newValue);
	    	addTotalNum();
	    }
	});
	$("#costRents").numberbox({
	    onChange : function(newValue,oldValue){
	    	
	    	$('#costRent').val(newValue);
	    	addTotalNum();
	    }
	});
});
//计算总金额
function addTotalNum(){
	
	var totalNum =0;
	var num1 =parseFloat($('#costHotel').val());
	var num2 =parseFloat($('#costFood').val());
	var num3 =parseFloat($('#costOther').val());
	var num4 =parseFloat($('#costTraffic').val());
	var num5 =parseFloat($('#costRent').val());
	if(!isNaN(num1)){
		totalNum = totalNum+num1;
	}if(!isNaN(num2)){
		totalNum = totalNum+num2;
	}if(!isNaN(num3)){
		totalNum = totalNum+num3;
	}if(!isNaN(num4)){
		totalNum = totalNum+num4;
	}if(!isNaN(num5)){
		totalNum = totalNum+num5;
	}
	//给两个总额框赋值
	$('#reimburseAmount').val(totalNum.toFixed(2));
	var applyAmount = $('#applyAmount').val();
	$('#reimAmount_span').html(fomatMoney(totalNum,2)+" [元]");
	$('#p_amount').html(fomatMoney(totalNum,2)+" [元]");
	if(!isNaN(totalNum)){
		if(totalNum<applyAmount){
			var num5=applyAmount-totalNum;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function addNum1(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined ||newVal==''){
		return false;
	}
	var reDayNum =parseInt($('#reDayNum').numberbox('getValue'));
	var index=$('#rec-hotel-dg-reim').datagrid('getRowIndex',$('#rec-hotel-dg-reim').datagrid('getSelected'));
    var editors = $('#rec-hotel-dg-reim').datagrid('getEditors', index); 
	if(isNaN(reDayNum)){
		editors[3].target.numberbox('setValue', '');
		alert('请选择开始时间或结束时间！');
		return false;
	}
	
	if(reDayNum<=parseFloat(newVal)){
		//var index=$('#rec-hotel-dg-reim').datagrid('getRowIndex',$('#rec-hotel-dg-reim').datagrid('getSelected'));
	    //var editors = $('#rec-hotel-dg-reim').datagrid('getEditors', index); 
	    //var ed1 = editors[3]; 
	    //var ed2 = editors[4]; 
	    //var num1 =parseFloat(ed1.target.val());
	    //var num2 =parseFloat(ed2.target.val());
	    //var num3 =num1*num2;
	    //if(!isNaN(num1) &&!isNaN(num2)){
	    //}
	    editors[3].target.numberbox('setValue', '');
	    alert('住宿天数要小于接待天数，请重新填写！');
	    return false;
	}else{
		if(parseFloat(newVal)<=0){
			editors[3].target.numberbox('setValue', '');
			alert('住宿天数应该大于0，请重新填写！');
			return false;
		}
	}
}

//计算住宿费总额
function addAmount1(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var rows = $('#rec-hotel-dg-reim').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fCostHotel']))) {
	    	 num1 += parseFloat(rows[i]['fCostHotel']);
    	 }
	}
     var num = parseFloat(newValue);
     var row = $('#rec-hotel-dg-reim').datagrid('getSelected');
     var numOld = parseFloat(row.fCostHotel);
     if(!isNaN(num)){
    	 if(!isNaN(numOld) && isNaN(parseFloat(oldValue))){
				return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			}else{
				num1 = num1 + num;
			}
		 }
	 } 
   //给两个框赋值
		$('#costHotel').val(num1.toFixed(2));
		$('#costHotel_span').html(fomatMoney(num1,2)+" [元]");
		addTotalNum();
}
//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingR() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#rec-hotel-dg-reim').datagrid('validateRow', editIndex)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			var tr = $('#rec-hotel-dg-reim').datagrid('getEditors', editIndex);
			var text2=tr[1].target.combotree('getText');
			if(text2!='--请选择--'){
				tr[1].target.combotree('setValue',text2);
			}
			var text3=tr[2].target.combotree('getText');
			if(text3!='--请选择--'){
				tr[2].target.combotree('setValues',text3);
			}
			$('#rec-hotel-dg-reim').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if(updateradio==0){
			if (editIndex != index) {
				if (endEditingR()) {
					$('#rec-hotel-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndex = index;
				} else {
					$('#rec-hotel-dg-reim').datagrid('selectRow', editIndex);
				}
			}
		}else{
			alert('住宿费无法编辑,请点击调整按钮进行编辑！');
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#rec-hotel-dg-reim').datagrid('appendRow', {});
			editIndex = $('#rec-hotel-dg-reim').datagrid('getRows').length - 1;
			$('#rec-hotel-dg-reim').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitR() {
		if (editIndex == undefined) {
			return
		}
		$('#rec-hotel-dg-reim').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
		var rows = $('#rec-hotel-dg-reim').datagrid('getRows');
		/* var travelDays=0;
		var hotelDays=0;
		for(var i=0;i<rows.length;i++){
			if(rows[i].travelDays!=""&&rows[i].travelDays!=null){
				travelDays += parseInt(rows[i].travelDays);
			}
			if(rows[i].hotelDays!=""&&rows[i].hotelDays!=null){
				hotelDays += parseInt(rows[i].hotelDays);
			}
		}
		$('#travelTotalDays').val(travelDays);
		$('#hotelTotalDays').val(hotelDays);
		calcTravelCost(); */
	}
	function acceptR() {
		if (endEditingR()) {
			$('#rec-hotel-dg-reim').datagrid('acceptChanges');
		}
	}
	
	
	

</script>
<script type="text/javascript">
function addNum2(){
	var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
    var editors = $('#rec-food-dg-reim').datagrid('getEditors', index); 
    var ed1 = editors[1]; 
    var ed2 = editors[2]; 
    //var ed3 = editors[3];
    var num1 =parseFloat(ed1.target.val());
    var num2 =parseFloat(ed2.target.val());
    //var num3 =parseFloat(ed3.target.val());
    if(!isNaN(num1) &&!isNaN(num2)){
    var num4 =num1;
    	editors[3].target.numberbox('setValue', num4);
    }
}

//计算餐费总额
function addAmount2(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined || newValue==''){
		return false;
	}
	var rows = $('#rec-food-dg-reim').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
    	 }
	}
     var num = parseFloat(newValue);
     var row = $('#rec-food-dg-reim').datagrid('getSelected');
     var numOld = parseFloat(row.fCostFood);
     var fCostStd = parseFloat(row.fCostStd);
     var fPersonNum = parseFloat(row.fPersonNum);
     
     if(num>(fPersonNum*fCostStd)){
    	 var rindex = $('#rec-food-dg-reim').datagrid('getRowIndex', row); 
         var positions = $('#rec-food-dg-reim').datagrid('getEditor',{
     		index:rindex,
     		field : 'fCostFood',
     	});
         var fCostStdString ='当前项报销不能超出'+fPersonNum*fCostStd+'，请重新填写！' ;
         alert(fCostStdString);
    	 $(positions.target).numberbox('setValue', '');
    	 return false;
     }
     if(!isNaN(num)){
    	 if(!isNaN(numOld) && isNaN(parseFloat(oldValue))){
				return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			}else{
				num1 = num1 + num;
			}
		 }
	 } 
   //给两个框赋值
		$('#costFood').val(num1.toFixed(2));
		$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
		addTotalNum();
}

//接待人员表格添加删除，保存方法
var editIndex1 = undefined;
function endEditing1() {
	if (editIndex1 == undefined) {
		return true
	}
	if ($('#rec-food-dg-reim').datagrid('validateRow', editIndex1)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-food-dg-reim').datagrid('endEdit', editIndex1);
		editIndex1 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow1(index) {
	if(updateradio==0){
		if (editIndex1 != index) {
			if (endEditing1()) {
				$('#rec-food-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex1 = index;
			} else {
				$('#rec-food-dg-reim').datagrid('selectRow', editIndex1);
			}
		}
	}else{
		alert('餐费无法编辑，请点击调整按钮进行编辑！');
	}
}
function append1() {
	if (endEditing1()) {
		$('#rec-food-dg-reim').datagrid('appendRow', {});
		editIndex1 = $('#rec-food-dg-reim').datagrid('getRows').length - 1;
		$('#rec-food-dg-reim').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
	}
}
function removeit1() {
	if (editIndex1 == undefined) {
		return
	}
	$('#rec-food-dg-reim').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
			editIndex1);
	editIndex1 = undefined;
	/* var travelDays=0;
	var hotelDays=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].travelDays!=""&&rows[i].travelDays!=null){
			travelDays += parseInt(rows[i].travelDays);
		}
		if(rows[i].hotelDays!=""&&rows[i].hotelDays!=null){
			hotelDays += parseInt(rows[i].hotelDays);
		}
	}
	$('#travelTotalDays').val(travelDays);
	$('#hotelTotalDays').val(hotelDays);
	calcTravelCost(); */
}
function accept1() {
	if (endEditing1()) {
		$('#rec-food-dg-reim').datagrid('acceptChanges');
	}
}
</script>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndex2 = undefined;
function endEditing2() {
	if (editIndex2 == undefined) {
		return true
	}
	if ($('#rec-other-dg-reim').datagrid('validateRow', editIndex2)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-other-dg-reim').datagrid('endEdit', editIndex2);
		editIndex2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowOther(index) {
	if(updateradio==0){
		if (editIndex2 != index) {
			if (endEditing2()) {
				$('#rec-other-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex2 = index;
			} else {
				$('#rec-other-dg-reim').datagrid('selectRow', editIndex2);
			}
		}
	}else{
		alert('其他费用无法编辑，请点击调整按钮进行编辑！');
	}
}
function append2() {
	if (endEditing2()) {
		$('#rec-other-dg-reim').datagrid('appendRow', {});
		editIndex2 = $('#rec-other-dg-reim').datagrid('getRows').length - 1;
		$('#rec-other-dg-reim').datagrid('selectRow', editIndex2).datagrid('beginEdit',editIndex2);
	}
}
function removeit2() {
	if (editIndex2 == undefined) {
		return
	}
	$('#rec-other-dg-reim').datagrid('cancelEdit', editIndex2).datagrid('deleteRow',
			editIndex2);
	editIndex2 = undefined;
	var rows = $('#rec-other-dg-reim').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCost']))) {
	    	 num1 += parseFloat(rows[i]['fCost']);
   	 }
	}
    //给两个总额框赋值
	$('#costOther').val(num1.toFixed(2));
	$('#costOther_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
}
function accept2() {
	if (endEditing2()) {
		$('#rec-other-dg-reim').datagrid('acceptChanges');
	}
}

//计算金额
function addNumOther2(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var rows = $('#rec-other-dg-reim').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fCost']))) {
	    	 num1 += parseFloat(rows[i]['fCost']);
    	 }
	}
     //
     var num = parseFloat(newValue);
     var row = $('#rec-other-dg-reim').datagrid('getSelected');
     var numOld = parseFloat(row.fCost);
     if(!isNaN(num)){
    	 if(!isNaN(numOld) && isNaN(parseFloat(oldValue))){
				return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			}else{
				num1 = num1 + num;
			}
		 }
	 } 
   //给两个框赋值
		$('#costOther').val(num1.toFixed(2));
		$('#costOther_span').html(fomatMoney(num1,2)+" [元]");
		addTotalNum();
}


function reloadOut(rec){
	var row = $('#rec-hotel-dg-reim').datagrid('getSelected');
	var rindex = $('#rec-hotel-dg-reim').datagrid('getRowIndex', row); 
	var ed = $('#rec-hotel-dg-reim').datagrid('getEditor',{
		index:rindex,
		field : 'fRoomType'  
	});
	
		$(ed.target).combotree('setValue', '');
		var url = base+'/apply/lookupsJson?parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	 /* $(ed.target).combobox('setValue', '2016'); */
}

function onClickCellType(){
	var row = $('#rec-hotel-dg-reim').datagrid('getSelected');
	var rindex = $('#rec-hotel-dg-reim').datagrid('getRowIndex', row); 
	var positions = $('#rec-hotel-dg-reim').datagrid('getEditor',{
		index:rindex,
		field : 'position'  
	});
	var ed = $('#rec-hotel-dg-reim').datagrid('getEditor',{
		index:rindex,
		field : 'fRoomType'  
	});
	
		var position = $(positions.target).combotree('getValues');
		$(ed.target).combotree('setValue', '');
		var url = base+'/apply/lookupsJson?parentCode='+position;
    	$(ed.target).combotree('reload', url);
}

/* 以下是住宿费、餐费、其他费用的json */

function receptionHotelJson(){
	acceptR();
	var rows2 = $('#rec-hotel-dg-reim').datagrid('getRows');
	var hotelJson = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			hotelJson = hotelJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#receptionHotelJson').val(hotelJson);
		return true;
	}
}
function receptionFoodJson(){
	accept1();
	var rows2 = $('#rec-food-dg-reim').datagrid('getRows');
	var foodJson = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			foodJson = foodJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#receptionFoodJson').val(foodJson);
		return true;
	}
}
function receptionOtherJson(){
	accept2();
	var rows2 = $('#rec-other-dg-reim').datagrid('getRows');
	var otherJson = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			otherJson = otherJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#receptionOtherJson').val(otherJson);
		return true;
	}
}
</script>
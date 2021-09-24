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
	
	<div style="">
	<a href="javascript:void(0)" onclick="removeit1()" style="float: right"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append1()" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	
	</c:if>

	<table id="rec-food-dg-reim" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionFood?id=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyReceptionFoodPage?rId=${bean.rId}',
	</c:if>
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
			<th data-options="field:'time',required:'required',align:'center',width:136,editor:{type:'datetimebox'},formatter:ChangeDateFormatIndex">时间</th>
			</c:if>
			<c:if test="${receptionBean.isForeign==1}">
			<th data-options="field:'date',required:'required',align:'center',width:140,editor:{type:'datebox'},formatter:ChangeDateFormat">日期</th>
			</c:if>
			<th data-options="field:'place',required:'required',align:'center',width:158,editor:{type:'textbox'}">地点</th>	
			<th data-options="field:'fFoodType',required:'required',align:'center',width:100,editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                onShowPanel:chooseStd,
                                onSelect:setStd,
                                onHidePanel:changeNum,
                                editable:false
                            }}">标准</th>
			<th data-options="field:'fPersonNum',required:'required',align:'center',width:85,editor:{type:'numberbox',options:{onChange:addNum2,editable: true}}">用餐总人数</th>	
            <th data-options="field:'fOtherNum',required:'required',align:'center',width:90,editor:{type:'numberbox',options:{readonly: true,onChange:judgePerson}}">其中陪餐人数</th>
			<th data-options="field:'fReimbCostFood',required:'required',align:'center',width:100,editor:{type:'numberbox',options:{onChange:addAmount2,editable: true,precision:2,groupSeparator:','}}">金额(元)</th>
			<!-- 伙食标准 --><th data-options="field:'fCostStd',required:'required',hidden:true,editor:{type:'numberbox',options:{editable: true}}"></th>
			<!-- 总标准 --><th data-options="field:'fCostFood',required:'required',hidden:true,editor:{type:'numberbox',options:{editable: true}}"></th>
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
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 餐费发票明细 -->
				<jsp:include page="mingxi_reception_food.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 餐费发票明细 -->
				<jsp:include page="mingxi_reception_food_edit.jsp" />
			</div>
		</c:if>
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
	<div id="hotel_bar">
	<a href="javascript:void(0)" onclick="removeitR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<table id="rec-hotel-dg-reim" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: '#appli-detail-tb',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionHotel?id=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyReceptionHotelPage?rId=${bean.rId}',
	</c:if>
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
			<th data-options="field:'fName',required:'required',align:'center',width:110,editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                onShowPanel:choosePeople,
                                onHidePanel:clearPosition,
                                onSelect:setPosition,
                                onUnselect:unsetPosition,
                                editable:false
                            }}">姓名</th>
			<th data-options="field:'fPlace',required:'required',align:'center',width:200,editor:{
							type:'textbox',
							options:{editable:true}}">住宿地点</th>
			<th data-options="field:'fRoomType',required:'required',align:'center',width:124,editor:{
						type: 'combotree',
						filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								},options: {
						valueField:'code',
						textField:'text',
	                	prompt:'-请选择-',
	                	panelHeight:'atuo',
	                	editable: false,
	                	onShowPanel:reloadUrl,
	                	}}">住宿房型</th>
			<!-- <th data-options="field:'fCostStd',required:'required',align:'center',width:120,editor:{type:'numberbox',options:{onChange:addNum1,precision:2,groupSeparator:','}}">费用标准(元/天)</th> -->
			<th data-options="field:'fStartTime',required:'required',align:'center',width:130,editor:{type:'datebox',options:{editable: false}},formatter:ChangeDateFormat">入住日期</th>
			<th data-options="field:'fEndTime',required:'required',align:'center',width:130,editor:{type:'datebox',options:{editable: false}},formatter:ChangeDateFormat">退房日期</th>
			<th data-options="field:'fCostHotel',required:'required',align:'center',width:120,editor:{type:'numberbox',options:{onChange:addAmount1,editable: true,precision:2,groupSeparator:','}}">金额(元)</th>
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
<div style="height:10px;"></div>

<%-- <div class="window-table" style="margin-bottom:10px">
<table class="window-table-readonly" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;">
		<tr>
			<td class="window-table-td1" style="width:66px;"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:black">交通费</p>
			</td>
			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="window-table-td2">
				<input id="costTraffics" class="easyui-numberbox" value="${receptionBeanEdit.costTraffic}" data-options="icons: [{iconCls:'icon-yuan'}]"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>
				style="height:25px;"/>
			</td>
		</tr>
</table>
</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 交通费发票明细 -->
				<jsp:include page="mingxi_travel_outside.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 交通费发票明细 -->
				<jsp:include page="mingxi_travel_outside_edit.jsp" />
			</div>
		</c:if>
<div style="height:15px;"></div>
<div class="window-table" style="margin-bottom:10px">
<table class="window-table-readonly" cellspacing="0" cellpadding="0" style="margin-left: 0px;width: 707px;">
		<tr>
			<td class="window-table-td1" style="width:66px;"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:black;">会议室租金</p>
			</td>
			
			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="window-table-td2">
				<input id="costRents" class="easyui-numberbox" value="${receptionBeanEdit.costRent}" data-options="icons: [{iconCls:'icon-yuan'}]"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>
				style="height:25px;"/>
			</td>
		</tr>
</table>
</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 会议室租金发票明细 -->
				<jsp:include page="mingxi_reception_costRent.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 会议室租金发票明细 -->
				<jsp:include page="mingxi_reception_costRent_edit.jsp" />
			</div>
		</c:if>
<div style="height:15px;"></div> --%>

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
		<a href="javascript:void(0)" onclick="removeit2()" id="removeit2Id" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append2()" id="append2Id" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<table id="rec-other-dg-reim" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionOther?id=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyReceptionOtherPage?rId=${bean.rId}',
	</c:if>
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
<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 其他费用发票明细 -->
				<jsp:include page="mingxi_reception_other.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 其他费用发票明细 -->
				<jsp:include page="mingxi_reception_other_edit.jsp" />
			</div>
		</c:if>
<script type="text/javascript">
$(function(){
	$("#costTraffics").numberbox({
	    onChange : function(newValue,oldValue){
	    	
	    	$('#costTraffic').val(newValue);
	    	addTotalNum();
	    	cx();
	    }
	});
	$("#costRents").numberbox({
	    onChange : function(newValue,oldValue){
	    	
	    	$('#costRent').val(newValue);
	    	addTotalNum();
	    	cx();
	    }
	});
});
//计算总金额
function addTotalNum(){
	
	var totalNum =0;
	var num1 =parseFloat($('#costHotel').val());
	var num2 =parseFloat($('#costFood').val());
	var num3 =parseFloat($('#costOther').val());
	/* var num4 =parseFloat($('#costTraffic').val());
	var num5 =parseFloat($('#costRent').val()); */
	if(!isNaN(num1)){
		totalNum = totalNum+num1;
	}if(!isNaN(num2)){
		totalNum = totalNum+num2;
	}if(!isNaN(num3)){
		totalNum = totalNum+num3;
	}/* if(!isNaN(num4)){
		totalNum = totalNum+num4;
	}if(!isNaN(num5)){
		totalNum = totalNum+num5;
	} */
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
		cx();
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
			if (editIndex != index) {
				if (endEditingR()) {
					$('#rec-hotel-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndex = index;
				} else {
					$('#rec-hotel-dg-reim').datagrid('selectRow', editIndex);
				}
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
	     var num1 = 0;
	     for (var i = 0; i < rows.length; i++) {
	    	 if (!isNaN(parseFloat(rows[i]['fCostHotel']))) {
		    	 num1 += parseFloat(rows[i]['fCostHotel']);
	    	 }
		}
	     $('#costHotel').val(num1.toFixed(2));
			$('#costHotel_span').html(fomatMoney(num1,2)+" [元]");
			addTotalNum();
			cx();
	}
	function acceptR() {
		if (endEditingR()) {
			$('#rec-hotel-dg-reim').datagrid('acceptChanges');
		}
	}
	
	function choosePeople(){
		$('#rec-hotel-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
				index);
		var index=$('#rec-hotel-dg-reim').datagrid('getRowIndex',$('#rec-hotel-dg-reim').datagrid('getSelected'));
			var new_arrs= recepNameArr();
			var people = $('#rec-hotel-dg-reim').datagrid('getEditor',{
				index:index,
				field:'fName'
			});
			$(people.target).combobox({
	            data: new_arrs,
	            valueField: 'id',
	            multiple: true,
	            textField: 'text',
			});
	}
	function clearPosition(){
		positionCodes = "";
	}
	function unsetPosition(rec){
		var unsetcodes = rec.id+"@"+rec.positionCode+",";
		/* positionCodes.replace(unsetcodes,"");
		console.log(positionCodes) */
		var items=positionCodes.split(unsetcodes) ;
		var newStr=items.join("");
		positionCodes =newStr;
		var row = $('#rec-hotel-dg-reim').datagrid('getSelected');
		var rindex = $('#rec-hotel-dg-reim').datagrid('getRowIndex', row); 
		var ed2 = $('#rec-hotel-dg-reim').datagrid('getEditor',{
			index:rindex,
			field : 'positionCode'  
		});
		$(ed2.target).textbox('setValue', positionCodes.substring(0,positionCodes.length-1));
	}
	var positionCodes = "";
	function setPosition(rec){
		var row = $('#rec-hotel-dg-reim').datagrid('getSelected');
		var rindex = $('#rec-hotel-dg-reim').datagrid('getRowIndex', row); 
		/* var ed = $('#rec-hotel-dg-reim').datagrid('getEditor',{
			index:rindex,
			field : 'position'  
		});
		$(ed.target).textbox('setValue', rec.position); */
		var ed1 = $('#rec-hotel-dg-reim').datagrid('getEditor',{
			index:rindex,
			field : 'fRoomType'  
		});
		$(ed1.target).combotree('setValue', '');
		var ed2 = $('#rec-hotel-dg-reim').datagrid('getEditor',{
			index:rindex,
			field : 'positionCode'  
		});
		positionCodes =positionCodes+rec.id+"@"+rec.positionCode+",";
		$(ed2.target).textbox('setValue', positionCodes.substring(0,positionCodes.length-1));
		/* var url = base+'/apply/lookupsJson?parentCode='+rec.positionCode;
	    $(ed1.target).combotree('reload', url); */
	}	
	
	function reloadUrl(){
		
		var row = $('#rec-hotel-dg-reim').datagrid('getSelected');
		var rindex = $('#rec-hotel-dg-reim').datagrid('getRowIndex', row); 
		var ed = $('#rec-hotel-dg-reim').datagrid('getEditor',{
			index:rindex,
			field : 'positionCode'  
		});
		var positionCode = $(ed.target).textbox('getValue');
		var ss= positionCode.split(",");
		var code ='';
		if(positionCode!=''){
			var isForeign =$('#isForeign').val();
			if(isForeign==0){
				if(positionCode.indexOf("SBJYX")>=0 ){
					code ='SBJYX';
				}else{
					code ='SBJJYS';
				}
				/* for(var  j = 0; j < ss.length; j++){
					if(ss[j]=='SBJYX'){
						code ='SBJYX';
					}else{
						code ='SBJJYS';
					}
				} */
			}else{
				if(positionCode.indexOf("ZWJB-04")>=0||positionCode.indexOf("ZWJB-05")>=0 ){
					code ='ZWJB-04';
				}else{
					code ='ZWJB-03';
				}
				/* for(var  j = 0; j < ss.length; j++){
					if(ss[j]=='ZWJB-04'||ss[j]=='ZWJB-05'){
						code ='ZWJB-04';
					}else{
						code ='ZWJB-03';
					}
				} */
			}
		}
		var ed1 = $('#rec-hotel-dg-reim').datagrid('getEditor',{
			index:rindex,
			field : 'fRoomType'  
		});
		var url = base+'/apply/lookupsJson?parentCode='+code;
	    $(ed1.target).combotree('reload', url);
	}
</script>
<script type="text/javascript">
function addNum2(){
	var rePeopNum =parseInt($('#rePeopNum').numberbox('getValue'));
	var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
    var editors = $('#rec-food-dg-reim').datagrid('getEditors', index); 
    var ed1 = editors[3]; 
    var ed2 = editors[6]; 
    var ed3 = $('#rec-food-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fOtherNum'
	});
    var ed4 = $('#rec-food-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fFoodType'
	});
    var foodType =ed4.target.val();
    var num1 =parseFloat(ed1.target.val());
    var num2 =parseFloat(ed2.target.val());
    var num3 =parseFloat(ed3.target.val());
    if(!isNaN(num1)){
	    if(isNaN(rePeopNum)){
			alert("请填写接待对象人数！");
			ed1.target.numberbox('setValue','');
			return false;
		}else if(foodType==''){
			alert("请选择标准！");
			ed1.target.numberbox('setValue','');
			return false;
		}else{
			if(foodType!="日常伙食"){
				if(foodType=="早餐"||foodType=="正餐"){
					if(num1>rePeopNum){
						alert("用餐人数不能超过接待对象人数！");
						ed1.target.numberbox('setValue','');
						return false;
					}
				}else{
					var num5 =0;
					if(!isNaN(num3)){
						num5=num3;
					}
					if(num1-num5>rePeopNum){
						alert("用餐人数不能超过接待对象人数！");
						ed1.target.numberbox('setValue','');
						return false;
					}
				}
			}
		}
    }
    if(!isNaN(num1) &&!isNaN(num2)){
    var num4 =parseFloat((num1*num2).toFixed(2));
    	editors[7].target.numberbox('setValue', num4);
    	editors[5].target.numberbox('setValue', num4);
    }
    judgePerson(num3,'');
}

//计算餐费总额
function addAmount2(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined || newValue==''){
		return false;
	}
	var rows = $('#rec-food-dg-reim').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fReimbCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fReimbCostFood']);
    	 }
	}
     var num = parseFloat(newValue);
     var row = $('#rec-food-dg-reim').datagrid('getSelected');
     var numOld = parseFloat(row.fReimbCostFood);
     var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
     var editors = $('#rec-food-dg-reim').datagrid('getEditors', index); 
     var fCostStd = parseFloat(editors[7].target.numberbox('getValue'));
     var fPersonNum = parseFloat(row.fPersonNum);
     var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
	 var std = $('#rec-food-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fFoodType'
		});
	 var foodType=std.target.combobox('getValue');
     if(foodType!='日常伙食'&&foodType!='正餐'){
    	 
	     if(num>fCostStd){
	    	 var rindex = $('#rec-food-dg-reim').datagrid('getRowIndex', row); 
	         var positions = $('#rec-food-dg-reim').datagrid('getEditor',{
	     		index:rindex,
	     		field : 'fReimbCostFood',
	     	});
	         var fCostStdString ='当前项报销不能超出'+fCostStd+'，请重新填写！' ;
	         alert(fCostStdString);
	    	 $(positions.target).numberbox('setValue', '');
	    	 return false;
	     }
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
		cx();
}

//接待人员表格添加删除，保存方法
var editIndex1 = undefined;
function endEditing1() {
	if (editIndex1 == undefined) {
		return true;
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
		if (editIndex1 != index) {
			if (endEditing1()) {
				$('#rec-food-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex1 = index;
				var row =$('#rec-food-dg-reim').datagrid('getRows')[index];
				var isForeign = $('#isForeign').val();
				if(isForeign==0){
					if(row.fFoodType=='宴请'){
						var ed =$('#rec-food-dg-reim').datagrid('getEditor',{index:index,field:'fOtherNum'});
						$(ed.target).numberbox('readonly', false);
					}
				}else{
					if(row.fFoodType!='日常伙食'){
						var ed =$('#rec-food-dg-reim').datagrid('getEditor',{index:index,field:'fOtherNum'});
						$(ed.target).numberbox('readonly', false);
					}
				}
			} else {
				$('#rec-food-dg-reim').datagrid('selectRow', editIndex1);
			}
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
	var rows = $('#rec-food-dg-reim').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fReimbCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fReimbCostFood']);
   	 }
	}
    //给两个框赋值
	$('#costFood').val(num1.toFixed(2));
	$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
	cx();
}
function accept1() {
	if (endEditing1()) {
		$('#rec-food-dg-reim').datagrid('acceptChanges');
	}
}
function chooseStd(){
	$('#rec-food-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
			index);
	var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
		var std = $('#rec-food-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fFoodType'
		});
		var isForeign = $('#isForeign').val();	
		if(isForeign==0){
			$(std.target).combobox({
	            data: stdArr,
	            valueField: 'id',
	            multiple: false,
	            textField: 'text',
			});
		}else{
			$(std.target).combobox({
	            data: stdArrWb,
	            valueField: 'id',
	            multiple: false,
	            textField: 'text',
			});
		}
}
function changeNum(){
	var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
	var ed = $('#rec-food-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fFoodType'
	});
	var foodType=ed.target.val();
	if(foodType!='正餐'){
		addNum2();
	}
}
function setStd(rec){
	var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
	var ed = $('#rec-food-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fCostStd'
	});
	var ed1 = $('#rec-food-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fOtherNum'
	});
	var ed2 = $('#rec-food-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fReimbCostFood'
	});
	var isForeign = $('#isForeign').val();
	if(isForeign==0){
		if(rec.text!='正餐'){
			$(ed.target).numberbox('setValue',rec.std);
			//addNum2();
		}else{
			$(ed.target).numberbox('setValue','');
			$(ed2.target).numberbox('setValue','');
		}
		if(rec.text=='宴请'){
			$(ed1.target).numberbox('readonly',false);
		}else {
			$(ed1.target).numberbox('setValue','');
			$(ed1.target).numberbox('readonly',true);
		}
	}else{
		$(ed.target).numberbox('setValue',rec.std);
		//addNum2();
		if(rec.text!='日常伙食'){
			$(ed1.target).numberbox('readonly',false);
		}else {
			$(ed1.target).numberbox('setValue','');
			$(ed1.target).numberbox('readonly',true);
		}
	}
}
function judgePerson(n,o){
	var isForeign = $('#isForeign').val();	
	if(isForeign==1){
		var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
		var ed = $('#rec-food-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fPersonNum'
		});
		var ed1 = $('#rec-food-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fOtherNum'
		});
		
		var num1=parseInt($(ed.target).numberbox('getValue'));
		var num2=parseInt(n);
		if(!isNaN(num2)){
				if(num1<num2){
					alert('陪餐人数不能超过用餐总人数');
					$(ed1.target).numberbox('setValue','');
				}else{
					
					if(num1-num2<=5){
						if((num2/(num1-num2))>1){
							alert('陪餐人数超过标准,请重新填写');
							$(ed1.target).numberbox('setValue','');
						}
					}else{
						if(((num2-5)/(num1-num2-5))>0.5){
							alert('陪餐人数超过标准,请重新填写');
							$(ed1.target).numberbox('setValue','');
						}
					}
				}
			}
	}else{
		var index=$('#rec-food-dg-reim').datagrid('getRowIndex',$('#rec-food-dg-reim').datagrid('getSelected'));
		var ed = $('#rec-food-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fPersonNum'
		});
		var ed1 = $('#rec-food-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fOtherNum'
		});
		
		var num1=parseInt($(ed.target).numberbox('getValue'));
		var num2=parseInt(n);
		if(!isNaN(num2)){
				if(num1<num2){
					alert('陪餐人数不能超过用餐总人数');
					$(ed1.target).numberbox('setValue','');
				}else{
					
					if(num1-num2<=10){
						if(num2>3){
							alert('陪餐人数超过标准,请重新填写');
							$(ed1.target).numberbox('setValue','');
						}
					}else{
						if((num2/(num1-num2))>(1/3)){
							alert('陪餐人数超过标准,请重新填写');
							$(ed1.target).numberbox('setValue','');
						}
					}
				}
			}
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
		if (editIndex2 != index) {
			if (endEditing2()) {
				$('#rec-other-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex2 = index;
			} else {
				$('#rec-other-dg-reim').datagrid('selectRow', editIndex2);
			}
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
		cx();
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
		for (var i = 0; i < rows2.length; i++) {
			 if(rows2[i].fName==''){
				alert("请将住宿费里的姓名填写完整");
				return false;
			} if(rows2[i].fPlace==''){
				alert("请将住宿费里的住宿地点填写完整");
				return false;
			} if(rows2[i].fRoomType==''){
				alert("请将住宿费里的住宿房型填写完整");
				return false;
			} 
			if(rows2[i].fStartTime==''){
				alert("请将住宿费里的入住日期填写完整");
				return false;
			} 
			if(rows2[i].fRoomType==''){
				alert("请将住宿费里的退房日期填写完整");
				return false;
			} 
			hotelJson = hotelJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#receptionHotelJson').val(hotelJson);
		return true;
}
function receptionFoodJson(){
	accept1();
	var rows2 = $('#rec-food-dg-reim').datagrid('getRows');
	var foodJson = "";
		var isForeign = $('#isForeign').val();	
		for (var i = 0; i < rows2.length; i++) {
			if(isForeign==0){
				if(rows2[i].time==''){
					alert("请将餐费里的时间填写完整");
					return false;
				}
			}else{
				if(rows2[i].date==''){
					alert("请将餐费里的日期填写完整");
					return false;
				}
			}
			if(rows2[i].place==''){
				alert("请将餐费里的地点填写完整");
				return false;
			}
			if(rows2[i].fFoodType==''){
				alert("请将餐费里的标准填写完整");
				return false;
			}
			if(rows2[i].fPersonNum==''){
				alert("请将餐费里的用餐总人数填写完整");
				return false;
			}
			foodJson = foodJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#receptionFoodJson').val(foodJson);
		return true;
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
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>
<!-- 餐费 -->
<div class="window-table" style="margin-bottom:10px">

	<c:if test="${empty detail}">
	<div style="float: left;">
		<span>费用名称：</span>
		<span style=" color:black;">餐费</span>
	</div>
	<div style="margin-right:0px;">
	<a href="javascript:void(0)" onclick="removeit1()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append1()" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div> 
	
	</c:if>

	<table id="rec-food-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/receptionFood?id=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
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
			<!-- <th data-options="field:'costDetail',required:'required',align:'center',width:100,editor:'textbox'">序号</th> -->
			<th data-options="field:'time',required:'required',align:'center',width:140,editor:{type:'datetimebox',options:{showSeconds:false}},formatter:ChangeDateFormatIndex">时间</th>
			<th data-options="field:'date',required:'required',align:'center',width:140,editor:{type:'datebox'},formatter:ChangeDateFormat">日期</th>
			<th data-options="field:'place',required:'required',align:'center',width:190,editor:{type:'textbox'}">地点</th>
			<th data-options="field:'fFoodType',required:'required',align:'center',width:120,editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                onShowPanel:chooseStd,
                                onSelect:setStd,
                                onHidePanel:changeNum,
                                editable:false
                            }}">标准</th>
			<th data-options="field:'fPersonNum',required:'required',align:'center',width:115,editor:{type:'numberbox',options:{onChange:addNum2,editable: true}}">用餐总人数</th>
			<th data-options="field:'fOtherNum',required:'required',align:'center',width:116,editor:{type:'numberbox',options:{readonly: true,onChange:judgePerson}}">其中陪餐人数</th>
			<!-- 伙食标准 --><th data-options="field:'fCostStd',required:'required',hidden:true,editor:{type:'numberbox',options:{editable: true}}"></th>
			<!-- 总标准 --><th data-options="field:'fCostFood',required:'required',hidden:true,editor:{type:'numberbox',options:{editable: true,onChange:addAmount2}}"></th>
		</tr>
	</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<%-- <span style="float: right;"  id="costFood_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBean.costFood}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span> --%>
			<input  id="costFood" name="costFood" class="easyui-numberbox" style="width: 100px; height: 25px;" value="${receptionBean.costFood}" <c:if test="${!empty detail}"> readonly="readonly" </c:if> data-options="icons: [{iconCls:'icon-yuan'}],precision:2" />
			<input type="hidden" id="costFoodStd" name="costFoodStd" value="${receptionBean.costFoodStd}"  />
			<input type="hidden" id="costFoodStdVal"  value="${receptionBean.costFoodStd}"  />
			<input type="hidden" id="costFoodVal"  value="${receptionBean.costFood}"  />
		</span>
	</div>
	
</div>
<div style="height:10px;"></div>
<!-- 住宿费 -->
<div class="window-table" style="margin-bottom:10px;">

	<div style="margin-bottom:10px;">
	<span>费用名称：</span>
	<span style=" color:black;">住宿费</span>
	</div>
	<table border="1" style="width:705px;border-collapse: collapse;border-radius: 5px;-webkit-border-radius:5px;border: 1px solid #D9E3E7">
	<tr style="height: 70px;">
		<td style="width:100px;text-align:center">
		<span>住宿安排</span>
		</td>
		<td colspan="3"><textarea name="hotelContet" id="hotelContet" 
				class="textbox-text" autocomplete="off" <c:if test="${!empty detail}"> readonly="readonly" </c:if>
				style="width:600px;height:80px;resize:none; border:0;outline:none; margin-top:5px; margin-bottom:0px;">${receptionBean.hotelContet}</textarea>
		</td>
	</tr>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<%-- <span style="float: right;"  id="costHotel_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBean.costHotel}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span> --%>
			<input  id="costHotel" name="costHotel"  class="easyui-numberbox" <c:if test="${!empty detail}"> readonly="readonly" </c:if> style="width: 100px; height: 25px;" value="${receptionBean.costHotel}"  data-options="icons: [{iconCls:'icon-yuan'}],precision:2" />
		</span>
	</div>
</div>
<div style="height:10px;"></div>



<!-- 其他费用 -->
<div class="window-table">
	<c:if test="${empty detail}">
	<div id="rph" style="height:30px;padding-top : 8px">
	<div style="float: left;">
		<span>费用名称：</span>
		<span style=" color:black;">其他费用</span>
	</div>
		<a href="javascript:void(0)" onclick="removeit2()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append2()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<table id="rec-other-dg" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rph',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/receptionOther?id=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow2, 
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
				<th data-options="field:'fCost',required:'required',align:'center',width:191,editor:{type:'numberbox',options:{onChange:addNumOther,precision:2,groupSeparator:','}}">金额[元]</th>
				<th data-options="field:'fRemark',width:293,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<span style="float: right;"  id="costOther_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBean.costOther}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
			<input type="hidden" id="costOther" name="costOther" value="${receptionBean.costOther}"  />
		</span>
	</div>
	
	<input type="hidden" id="otherJson" name="otherJson" />
</div>

<input type="hidden" id="hotelJson" name="hotelJson"/>
<input type="hidden" id="foodJson" name="foodJson"/>
<script type="text/javascript">
$(function(){
	
	$("#costHotel").numberbox({
	    onChange : function(newValue,oldValue){
	    	addTotalNum();
	    }
	});
});
$.fn.datebox.defaults.parser = function(s){
	 var t = Date.parse(s);
	 if (!isNaN(t)){
	  return new Date(t);
	 } else {
	  return new Date();
	 }
	};
//计算总金额
function addTotalNum(){
	var totalNum =0;
	var num1 =parseFloat($('#costHotel').numberbox('getValue'));
	var num2 =parseFloat($('#costFood').numberbox('getValue'));
	var num3 =parseFloat($('#costOther').val());
	/* var num4 =parseFloat($('#costTraffic').numberbox('getValue'));
	var num5 =parseFloat($('#costRent').numberbox('getValue')); */
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
	$('#applyAmount').val(totalNum.toFixed(2));
	$('#applyAmount_span').html(fomatMoney(totalNum,2)+" [元]");
}


</script>
<script type="text/javascript">
function addNum2(){
	var rePeopNum =parseInt($('#rePeopNum').numberbox('getValue'));
	var index=$('#rec-food-dg').datagrid('getRowIndex',$('#rec-food-dg').datagrid('getSelected'));
    var editors = $('#rec-food-dg').datagrid('getEditors', index); 
    var ed1 = $('#rec-food-dg').datagrid('getEditor',{
		index:index,
		field:'fPersonNum'
	});
    var ed2 = $('#rec-food-dg').datagrid('getEditor',{
		index:index,
		field:'fCostStd'
	});
    var ed3 = $('#rec-food-dg').datagrid('getEditor',{
		index:index,
		field:'fOtherNum'
	});
    var ed4 = $('#rec-food-dg').datagrid('getEditor',{
		index:index,
		field:'fFoodType'
	});
    var num1 =parseFloat(ed1.target.val());
    var foodType =ed4.target.val();
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
    }
    judgePerson(num3,'');
}

//计算餐费总额
function addAmount2(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var rows = $('#rec-food-dg').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
    	 }
	}
     var num = parseFloat(newValue);
     var row = $('#rec-food-dg').datagrid('getSelected');
     var numOld = parseFloat(row.fCostFood);
     /* var fCostStd = parseFloat(row.fCostStd);
     var fPersonNum = parseFloat(row.fPersonNum); */
     
     /* if(num>(fPersonNum*fCostStd)){
    	 var rindex = $('#rec-food-dg').datagrid('getRowIndex', row); 
         var positions = $('#rec-food-dg').datagrid('getEditor',{
     		index:rindex,
     		field : 'fCostFood',
     	});
         var fCostStdString ='当前项报销不能超出'+fPersonNum*fCostStd+'，请重新填写！' ;
         alert(fCostStdString);
    	 $(positions.target).numberbox('setValue', '');
    	 return false;
     } */
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
		$('#costFoodStd').val(num1.toFixed(2));
		//$('#costFood').numberbox('setValue',num1);
		//$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
		addTotalNum();
}
$("#costFood").numberbox({
			onChange : function(newValue, oldValue) {
					var std =parseFloat($('#costFoodStd').val());
					var isForeign = $('input[name="isForeign"]:checked').val();
					if(isNaN(std)&&newValue!=''&&isForeign==0){
						alert('请添加餐费明细!');
						$("#costFood").numberbox('setValue','');
						return;
					}else{
						if(isForeign==0){
							if(newValue>std){
								alert('合计金额不能超出'+std+'元，请重新填写!');
								$("#costFood").numberbox('setValue','');
							}
						}
						addTotalNum();
					}
				}
});
//接待人员表格添加删除，保存方法
var editIndex1 = undefined;
function endEditing1() {
	if (editIndex1 == undefined) {
		return true
	}
	if ($('#rec-food-dg').datagrid('validateRow', editIndex1)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-food-dg').datagrid('endEdit', editIndex1);
		editIndex1 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow1(index) {
	if (editIndex1 != index) {
		if (endEditing1()) {
			$('#rec-food-dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex1 = index;
			var row =$('#rec-food-dg').datagrid('getRows')[index];
			var isForeign = $('input[name="isForeign"]:checked').val();	
			if(isForeign==0){
				if(row.fFoodType=='宴请'){
					var ed =$('#rec-food-dg').datagrid('getEditor',{index:index,field:'fOtherNum'});
					$(ed.target).numberbox('readonly', false);
				}
			}else{
				if(row.fFoodType!='日常伙食'){
					var ed =$('#rec-food-dg').datagrid('getEditor',{index:index,field:'fOtherNum'});
					$(ed.target).numberbox('readonly', false);
				}
			}
		} else {
			$('#rec-food-dg').datagrid('selectRow', editIndex1);
		}
	}
}
function append1() {
	if (endEditing1()) {
		$('#rec-food-dg').datagrid('appendRow', {});
		editIndex1 = $('#rec-food-dg').datagrid('getRows').length - 1;
		$('#rec-food-dg').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
	}
}
function removeit1() {
	if (editIndex1 == undefined) {
		return
	}
	$('#rec-food-dg').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
			editIndex1);
	editIndex1 = undefined;
	var rows = $('#rec-food-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
   	 }
	}
    $('#costFoodStd').val(num1.toFixed(2));
    var costFood = $("#costFood").numberbox('getValue');
    var std =parseFloat($('#costFoodStd').val());
	var isForeign = $('input[name="isForeign"]:checked').val();
	if(isNaN(std)&&costFood!=''&&isForeign==0){
		alert('请添加餐费明细!');
		$("#costFood").numberbox('setValue','');
		return;
	}else{
		if(isForeign==0){
			if(costFood>std){
				alert('合计金额不能超出'+std+'元，请重新填写!');
				$("#costFood").numberbox('setValue','');
			}
		}
		addTotalNum();
	}
}
function accept1() {
	if (endEditing1()) {
		$('#rec-food-dg').datagrid('acceptChanges');
	}
}

function chooseStd(){
	$('#rec-food-dg').datagrid('selectRow', index).datagrid('beginEdit',
			index);
	var index=$('#rec-food-dg').datagrid('getRowIndex',$('#rec-food-dg').datagrid('getSelected'));
		var std = $('#rec-food-dg').datagrid('getEditor',{
			index:index,
			field:'fFoodType'
		});
		var isForeign = $('input[name="isForeign"]:checked').val();	
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
	addNum2();
}
function setStd(rec){
	var index=$('#rec-food-dg').datagrid('getRowIndex',$('#rec-food-dg').datagrid('getSelected'));
	var ed = $('#rec-food-dg').datagrid('getEditor',{
		index:index,
		field:'fCostStd'
	});
	var ed1 = $('#rec-food-dg').datagrid('getEditor',{
		index:index,
		field:'fOtherNum'
	});
	
	var isForeign = $('input[name="isForeign"]:checked').val();	
	if(isForeign==0){
		$(ed.target).numberbox('setValue',rec.std);
		/* if(addNum2()==false){
			return false;
		}else{
			
		} */
		if(rec.text=='宴请'){
			$(ed1.target).numberbox('readonly',false);
		}else {
			$(ed1.target).numberbox('setValue','');
			$(ed1.target).numberbox('readonly',true);
		}
	}else{
		$(ed.target).numberbox('setValue',rec.std);
		/* if(addNum2()==false){
			return false;
		}else{
			addNum2();
		} */
		if(rec.text!='日常伙食'){
			$(ed1.target).numberbox('readonly',false);
		}else {
			$(ed1.target).numberbox('setValue','');
			$(ed1.target).numberbox('readonly',true);
		}
	}
}
function judgePerson(n,o){
	var isForeign = $('input[name="isForeign"]:checked').val();	
	if(isForeign==1){
		var index=$('#rec-food-dg').datagrid('getRowIndex',$('#rec-food-dg').datagrid('getSelected'));
		var ed = $('#rec-food-dg').datagrid('getEditor',{
			index:index,
			field:'fPersonNum'
		});
		var ed1 = $('#rec-food-dg').datagrid('getEditor',{
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
		var index=$('#rec-food-dg').datagrid('getRowIndex',$('#rec-food-dg').datagrid('getSelected'));
		var ed = $('#rec-food-dg').datagrid('getEditor',{
			index:index,
			field:'fPersonNum'
		});
		var ed1 = $('#rec-food-dg').datagrid('getEditor',{
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
	if ($('#rec-other-dg').datagrid('validateRow', editIndex2)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-other-dg').datagrid('endEdit', editIndex2);
		editIndex2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow2(index) {
	if (editIndex2 != index) {
		if (endEditing2()) {
			$('#rec-other-dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex2 = index;
		} else {
			$('#rec-other-dg').datagrid('selectRow', editIndex2);
		}
	}
}
function append2() {
	if (endEditing2()) {
		$('#rec-other-dg').datagrid('appendRow', {});
		editIndex2 = $('#rec-other-dg').datagrid('getRows').length - 1;
		$('#rec-other-dg').datagrid('selectRow', editIndex2).datagrid('beginEdit',editIndex2);
	}
}
function removeit2() {
	if (editIndex2 == undefined) {
		return
	}
	$('#rec-other-dg').datagrid('cancelEdit', editIndex2).datagrid('deleteRow',
			editIndex2);
	editIndex2 = undefined;
	var rows = $('#rec-other-dg').datagrid('getRows');
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
		$('#rec-other-dg').datagrid('acceptChanges');
	}
}

//计算金额
function addNumOther(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var rows = $('#rec-other-dg').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fCost']))) {
	    	 num1 += parseFloat(rows[i]['fCost']);
    	 }
	}
     //
     var num = parseFloat(newValue);
     var row = $('#rec-other-dg').datagrid('getSelected');
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


</script>
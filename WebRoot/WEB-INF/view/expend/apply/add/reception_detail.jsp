<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访单位</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="receptionObject" readonly="readonly"
			value="${receptionBean.receptionObject}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1"><span class="style1">*</span> 来访日期</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 238px; height: 30px;" name="reDateStart" id="reDateStart" readonly="readonly"
			value="${receptionBean.reDateStart}" data-options="" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访活动名称</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="receptionContent" readonly="readonly"
			value="${receptionBean.receptionContent}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 120px"><span class="style1">*</span> 来访单位带队领导姓名</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 238px; height: 30px;" name="diningPlacePlan1" readonly="readonly"
			value="${receptionBean.diningPlacePlan1}" data-options="" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 120px"><span class="style1">*</span> 来访单位带队领导职务</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="diningPlacePlan2" readonly="readonly"
			value="${receptionBean.diningPlacePlan2}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span>领导级别</td>
		<td class="td2" >
		<select id="receptionLevels1" class="easyui-combobox"
			name="receptionLevel1" style="width: 230px; height: 30px;" data-options="required:true" editable="false">
				<option value="1" <c:if test="${receptionBean.receptionLevel1=='1'}"> selected="selected" </c:if>>省部级</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel1=='2'}"> selected="selected" </c:if>>司局级</option>
				<option value="3" <c:if test="${receptionBean.receptionLevel1=='3'}"> selected="selected" </c:if>>处级以下（含处级）</option>
			</select>

		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 随行人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 238px; height: 30px;" name="attendPeopNum" readonly="readonly"
			value="${receptionBean.attendPeopNum}" data-options="" />
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" name="diningPlacePlan3" readonly="readonly"
			value="${receptionBean.diningPlacePlan3}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐总人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 238px; height: 30px;" name="rePeopNum" readonly="readonly"
			value="${receptionBean.rePeopNum}" data-options="" />
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐地点类型</td>
		<td class="td2">
			<select id="receptionLevel" class="easyui-combobox" readonly="readonly"
			name="receptionLevel" style="width: 230px; height: 30px;" data-options="required:true" editable="false">
				<option value="1" <c:if test="${receptionBean.receptionLevel=='1'}"> selected="selected" </c:if>>学校内部</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel=='2'}"> selected="selected" </c:if>>学校外部</option>
				<%-- <option value="3" <c:if test="${receptionBean.receptionLevel=='3'}"> selected="selected" </c:if>>执行任务</option>
				<option value="4" <c:if test="${receptionBean.receptionLevel=='4'}"> selected="selected" </c:if>>学习交流</option>
				<option value="5" <c:if test="${receptionBean.receptionLevel=='5'}"> selected="selected" </c:if>>检查指导</option>
				<option value="6" <c:if test="${receptionBean.receptionLevel=='6'}"> selected="selected" </c:if>>请示汇报工作</option>
				<option value="7" <c:if test="${receptionBean.receptionLevel=='7'}"> selected="selected" </c:if>>其他</option> --%>
			</select>
		</td>
		<%-- <td class="td1" style="width: 70px"><span class="style1">*</span>是否有外宾接待</td>
		<td class="td2" colspan="3" >
			<input type="radio" name="isForeign" value="1" onclick="foreignYes()" disabled="disabled" <c:if test="${receptionBean.isForeign==1}">checked="checked"</c:if> />是
			<input type="radio" name="isForeign" value="0" onclick="foreignNo()" disabled="disabled" <c:if test="${receptionBean.isForeign==0}">checked="checked"</c:if> />否
		</td> --%>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐地点</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 238px; height: 30px;" name="diningPlace" readonly="readonly"
			value="${receptionBean.diningPlace}" data-options="" />
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 费用预算</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 238px; height: 30px;" name="amount" readonly="readonly"
			value="${bean.amount}" data-options="" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 经办人</td>
		<td class="td2" >
		<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 230px;height: 30px;margin-left: 10px " >
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 部门名称</td>
		<td class="td2" >
		<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 238px;height: 30px;margin-left: 10px " >
		</td>
	</tr>
	<%-- <tr style="height: 70px;">
		<td class="td1" style="width: 70px;"><span class="style1">*</span>接待事由</td>
		<td colspan="3">
			<textarea name="receptionContent" readonly="readonly" id="receptionContent" class="textbox-text"   autocomplete="off" 
			  style="width:600px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBean.receptionContent}</textarea>
		</td>
	</tr> --%>
<%-- <tr class="trbody">
	<td class="td1" style="width:55px;"><span class="style1">*</span>接待公函及其他附件 </td>
	<td colspan="4"><c:if test="${!empty attaList}">
			<c:forEach items="${attaList}" var="att">
			<c:if test="${att.serviceType=='jdgh' }">
				<a href='${base}/attachment/download/${att.id}'
					style="color: #666666;font-weight: bold;">${att.originalName}</a>
				<br>
			</c:if>
			</c:forEach>
			
		</c:if> </td>
</tr> --%>
<input  type="hidden" id="totalPerson" />
<script type="text/javascript">

var yanqing ="";
var zhengcan ="";
var zaocan ="";

//支出标准获取
 function zcbz(){
	
	 $.ajax({
			url: base+ "/hotelStandard/calcCost?outType=recep",
			type : 'post',
			async : true,
			dataType:'json',
		    contentType:'application/json;charset=UTF-8',
			success : function(json) {
				for (var i = 0; i < json.length; i++) {
					var costDetail = json[i].costDetail;
					if(costDetail=="宴请"){
						yanqing =parseInt(json[i].standard);
					}
					if(costDetail=="早餐"){
						zaocan =parseInt(json[i].standard);
					}
					if(costDetail=="正餐"){
						zhengcan =parseInt(json[i].standard);
					}
				}
			}		
		});
 }
function someCheck1() {
	
	
    var personNum = parseFloat($('#totalPerson').val());
    if($('#box1').is(':checked')){
    	$('#tr1').show();
    	$('#diningPlacePlan1').val(1);
    	
    	var unitFeteNum =parseInt($('#unitFeteNum').numberbox('getValue'));
    	var attendPeopNum =parseInt($('#attendPeopNum').numberbox('getValue'));
    	if (isNaN(unitFeteNum)) {
    		return false;
    	}
    	if (isNaN(attendPeopNum)) {
    		return false;
    	}
    	if (endEditing1()){
        	$('#rec-food-dg').datagrid('insertRow', {
        		index: 2,
        		row:{
        		fFoodType: '宴请',
        		fCostStd: yanqing*(unitFeteNum+attendPeopNum),
        		fPersonNum:(unitFeteNum+attendPeopNum),
        		//fNum: 1,
        		fCostFood:yanqing*(unitFeteNum+attendPeopNum)
        		}
        	});
        	
    		}
    	
    	
	}else{
		
		$('#tr1').hide();
		$('#diningPlacePlan1').val(0);
		var rows = $('#rec-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fFoodType=="宴请"){
				var fPersonNumOld = rows[i].fPersonNum;
				//如果宴请隐藏，把宴请的人次加入到正餐里面
				if($('#box2').is(':checked')){
		    		var rowsbox2 = $('#rec-food-dg').datagrid('getRows');
		    		for(var j=0;j<rowsbox2.length;j++){
		    			if(rowsbox2[j].fFoodType=="正餐"){
		    				$('#rec-food-dg').datagrid('selectRow', j).datagrid('beginEdit', j);
		    	    		var editors = $('#rec-food-dg').datagrid('getEditors', j); 
		    	    		var old = editors[2].target.numberbox('getValue');
		    	    		
		    	    		editors[1].target.numberbox('setValue', (parseInt(old)+parseInt(fPersonNumOld))*zhengcan);
		    	    		editors[2].target.numberbox('setValue', parseInt(old)+parseInt(fPersonNumOld));
		    	    		editors[3].target.numberbox('setValue', (parseInt(old)+parseInt(fPersonNumOld))*zhengcan);
		    	    		$('#rec-food-dg').datagrid('endEdit', j);
		    			}
		    		}
		    	}
				deleteIndex = i;
	    		var index = $('#rec-food-dg').datagrid('getRowIndex',rows[i]);
	             $('#rec-food-dg').datagrid('deleteRow',index);
				editIndex1 = undefined;
			}
		}
		
	}
    var rows = $('#rec-food-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
   	 }
	}
  //给两个框赋值
	$('#costFood').val(num1.toFixed(2));
	$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
    return;
}

function someCheck2() {
	
//	var personNum = $('#totalPerson').val();
var reDayNum =parseInt($('#reDayNum').numberbox('getValue'));
var personNum =parseInt($('#rePeopNum').numberbox('getValue'));
	var costZAOCAN = "";
	var costZHENGCAN = "";
	if(!isNaN(personNum)){
		costZAOCAN =personNum*parseFloat(zaocan);
		costZHENGCAN =personNum*parseFloat(zhengcan);
    }
    if($('#box2').is(':checked')){
    	$('#tr0').show();
    	$('#diningPlacePlan2').val(1);
    	if (endEditing1()){
        	$('#rec-food-dg').datagrid('insertRow', {
        		index: 1,
        		row:{
        		fFoodType: '早餐',
        		fCostStd: zaocan*personNum*reDayNum,
        		fPersonNum:personNum*reDayNum,
        		//fNum: 1,
        		fCostFood:zaocan*personNum*reDayNum
        		}
        	});
        	
        	if($('#box1').is(':checked')){
        		var unitFeteNum =parseInt($('#unitFeteNum').numberbox('getValue'));
            	var attendPeopNum =parseInt($('#attendPeopNum').numberbox('getValue'));
            	$('#rec-food-dg').datagrid('insertRow', {
            		index: 2,
            		row:{
            		fFoodType: '正餐',
            		fCostStd:  zhengcan*((personNum*reDayNum*2)-(unitFeteNum+attendPeopNum)),
            		fPersonNum:(personNum*reDayNum*2)-(unitFeteNum+attendPeopNum),
            		//fNum: 1,
            		fCostFood:zhengcan*((personNum*reDayNum*2)-(unitFeteNum+attendPeopNum))
            		}
            	});
        	}else{
        		$('#rec-food-dg').datagrid('insertRow', {
            		index: 2,
            		row:{
            		fFoodType: '正餐',
            		fCostStd: zhengcan*personNum*2*reDayNum,
            		fPersonNum:personNum*2*reDayNum,
            		//fNum: 1,
            		fCostFood:zhengcan*personNum*2*reDayNum
            		}
            	});
        	}
        	
    		}
	}else{
		$('#tr0').hide();
		$('#diningPlacePlan2').val(0);
		var rows = $('#rec-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fFoodType=="早餐"){
				var index = $('#rec-food-dg').datagrid('getRowIndex',rows[i]);
	             $('#rec-food-dg').datagrid('deleteRow',index);
				editIndex1 = undefined;
			}
			if(rows[i].fFoodType=="正餐"){
				var index = $('#rec-food-dg').datagrid('getRowIndex',rows[i]);
	             $('#rec-food-dg').datagrid('deleteRow',index);
				editIndex1 = undefined;
			}
		}
	}
    var rows = $('#rec-food-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
   	 }
	}
  //给两个框赋值
	$('#costFood').val(num1.toFixed(2));
	$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
    return;
}

/* function someCheck3() {
	var personNum = $('#totalPerson').val();
    if($('#box3').is(':checked')){
    	$('#diningPlacePlan3').val(1);
    	if (endEditing1()){
        	$('#rec-food-dg').datagrid('insertRow', {
        		index: 3,
        		row:{
        		fFoodType: '自助餐',
        		fPersonNum:personNum,
        		}
        	});
    		}
	}else{
		$('#diningPlacePlan3').val(0);
		var deleteIndex =0;
		var rows = $('#rec-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fFoodType=="自助餐"){
				deleteIndex = i;
				$('#rec-food-dg').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
						deleteIndex);
				editIndex1 = undefined;
			}
		}
	}
    var rows = $('#rec-food-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
   	 }
	}
  //给两个框赋值
	$('#costFood').val(num1);
	$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
    return;
} */

/* function someCheck4() {
	var personNum = $('#totalPerson').val();
    if($('#box4').is(':checked')){
    	$('#diningPlacePlan4').val(1);
    	if (endEditing1()){
        	$('#rec-food-dg').datagrid('insertRow', {
        		index: 4,
        		row:{
        		fFoodType: '份饭',
        		fPersonNum:personNum,
        		}
        	});
    		}
	}else{
		$('#diningPlacePlan4').val(0);
		var deleteIndex =0;
		var rows = $('#rec-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fFoodType=="份饭"){
				deleteIndex = i;
				$('#rec-food-dg').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
						deleteIndex);
				editIndex1 = undefined;
			}
		}
	}
    var rows = $('#rec-food-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
   	 }
	}
  //给两个框赋值
	$('#costFood').val(num1);
	$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
    return;
} */

/* function someCheck5() {
	var personNum = $('#totalPerson').val();
    if($('#box5').is(':checked')){
    	$('#diningPlacePlan5').val(1);
    	if (endEditing1()){
        	$('#rec-food-dg').datagrid('insertRow', {
        		index: 5,
        		row:{
        			mark: 1,
        			fPersonNum:personNum,
        		}
        	});
    		}
	}else{
		$('#diningPlacePlan5').val(0);
		var deleteIndex =0;
		var rows = $('#rec-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			console.log(rows[i].fFoodType)
			if(rows[i].mark==1){
				deleteIndex = i;
				$('#rec-food-dg').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
						deleteIndex);
				editIndex1 = undefined;
			}
		}
	}
    var rows = $('#rec-food-dg').datagrid('getRows');
    var num1 = 0;
    for (var i = 0; i < rows.length; i++) {
   	 if (!isNaN(parseFloat(rows[i]['fCostFood']))) {
	    	 num1 += parseFloat(rows[i]['fCostFood']);
   	 }
	}
  //给两个框赋值
	$('#costFood').val(num1);
	$('#costFood_span').html(fomatMoney(num1,2)+" [元]");
	addTotalNum();
    return;
} */

var startday5='${receptionBean.reDateStart}';
var endday5='${receptionBean.reDateEnd}';

$("#reDateStart").datebox({
    onSelect : function(beginDate){
    	startday5 = beginDate;
    	endday5 = new Date(endday5);
    	var d = (endday5 - startday5) / 86400000 + 1;
    	if (d > 0) {
    		$('#reDayNum').numberbox("setValue", d);
    	} else {
    		$('#reDayNum').numberbox("setValue", "");
    	}
        $('#reDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});


	
	function onSelect8(date) {
		endday5 = date;
		startday5 = new Date(startday5);
		var d = (endday5 - startday5) / 86400000 + 1;
		if (d > 0) {
			$('#reDayNum').numberbox("setValue", d);
		} else {
			$('#reDayNum').numberbox("setValue", "");
		}
	}

	$(document).ready(function() {
		//设值复选框的值
		var h = $("#receptionLevelHi").val();
		if (h != "") {
			$('#receptionLevel').textbox().textbox('setValue', h);
		}
	});

	
	
	
	$(function(){
		
		zcbz();
		$("#rePeopNum").numberbox({
		    onChange : function(newValue,oldValue){
		    	//动态添加住宿费列表行和删除行
		    	var newRowNum =parseInt(newValue);
		    	var oldRowNum =parseInt(oldValue);
		    	if(!isNaN(newRowNum) && isNaN(oldRowNum)){
		    	for(var i=0;i<=newRowNum-1;i++){
		    		if (endEditingR()){
		        	$('#rec-hotel-dg').datagrid('appendRow', {});
		    			}
		    		}
		    	}
		    	if(!isNaN(newRowNum) &&!isNaN(oldRowNum)){
		    		if(newRowNum<oldRowNum){
		    			for(var j=oldRowNum;j>newRowNum;j--){
		    				$('#rec-hotel-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
		    						j-1);
		    				editIndex = undefined;
		    				var rows = $('#rec-hotel-dg').datagrid('getRows');
		    			     var num1 = 0;
		    			     for (var i = 0; i < rows.length; i++) {
		    			    	 if (!isNaN(parseFloat(rows[i]['fCostHotel']))) {
		    				    	 num1 += parseFloat(rows[i]['fCostHotel']);
		    			    	 }
		    				}
		    			     //给两个框赋值
		    					$('#costHotel').val(num1.toFixed(2));
		    					$('#costHotel_span').html(fomatMoney(num1,2)+" [元]");
		    					addTotalNum();
				        }
				    }else if(newRowNum>oldRowNum){
				    	for(var i=0;i<=newRowNum-oldRowNum-1;i++){
				    		if (endEditingR()){
				        	$('#rec-hotel-dg').datagrid('appendRow', {});
				    		}
				    	}
				    }
		    	}
		    	//计算总人数
		    	//addPersonNum();
		    	// 得到rows对象
		    	var rows = $('#rec-food-dg').datagrid('getRows'); // 这段代码是
		    	var copyRows = [];
		        for ( var j= 0; j < rows.length; j++) {
		         copyRows.push(rows[j]);
		        }
		    	for (var i = 0; i < copyRows.length; i++){
		    		var index = $('#rec-food-dg').datagrid('getRowIndex',copyRows[j]);
		             $('#rec-food-dg').datagrid('deleteRow',index);
					editIndex1 = undefined;
		    	}
		    	someCheck1();
		    	someCheck2();
		    	/* someCheck3();
		    	someCheck4();
		    	someCheck5(); */
		    }
		});
		$("#attendPeopNum").numberbox({
		    onChange : function(newValue,oldValue){
		    	//addPersonNum();
		    	if(newValue==undefined || oldValue==undefined || newValue==''){
		    		return false;
		    	}
		    	var rows = $('#rec-food-dg').datagrid('getRows'); // 这段代码是
		    	var unitFeteNum =parseInt($('#unitFeteNum').numberbox('getValue'));//宴请人数
		    	if(parseInt(unitFeteNum)<=10){
		    		if(parseInt(newValue)>3){
		    			alert('陪餐人数不能超过3人,请重新填写！');
		    			$('#attendPeopNum').numberbox('setValue','');
		    			return false;
		    		}
		    		if(parseInt(newValue)>parseInt(unitFeteNum)){
		    			alert('陪餐人数不能超过宴请人数,请重新填写！');
		    			$('#attendPeopNum').numberbox('setValue','');
		    			return false;
		    		}
		    	}else{
		    		
		    		var unitFeteNumDivide = parseInt(unitFeteNum/3);
		    		if(parseInt(newValue)>unitFeteNumDivide){
		    			alert('陪餐人数不能超过宴请人1/3,请重新填写！');
		    			$('#attendPeopNum').numberbox('setValue','');
		    			return false;
		    		}
		    	}
		    	var copyRows = [];
		        for ( var j= 0; j < rows.length; j++) {
		         copyRows.push(rows[j]);
		        }
		    	for (var i = 0; i < copyRows.length; i++){
		    		var index = $('#rec-food-dg').datagrid('getRowIndex',copyRows[j]);
		             $('#rec-food-dg').datagrid('deleteRow',index);
					editIndex1 = undefined;
		    	}
		    	someCheck1();
		    	someCheck2();
		    	/* someCheck3();
		    	someCheck4();
		    	someCheck5(); */
		    }
		});
	});
	/* addPersonNum();
		//计算总人数
		function addPersonNum(){
	    	var personNum = 0;
	    	var rePeopNum =parseInt($('#rePeopNum').numberbox('getValue'));
	    	var attendPeopNum =parseInt($('#attendPeopNum').numberbox('getValue'));
	    	if (!isNaN(rePeopNum)) {
	    		personNum = personNum + rePeopNum;
	    	}
	    	if (!isNaN(attendPeopNum)) {
	    		personNum = personNum + attendPeopNum;
	    	}
	    	$('#totalPerson').val(personNum);
		} */
		
		
		
		$("#unitFeteNum").numberbox({
		    onChange : function(newValue,oldValue){
		    	if(newValue==undefined || oldValue==undefined || newValue==''){
		    		return false;
		    	}
		    	var personNum =parseInt($('#rePeopNum').numberbox('getValue'));//接待人数
		    	if(parseInt(personNum)<parseInt(newValue)){
	    			alert('宴请人数不能超过接待人数,请重新填写！');
	    			$('#unitFeteNum').numberbox('setValue','');
	    			return false;
		    	}
		    	
		    }
		});
</script>

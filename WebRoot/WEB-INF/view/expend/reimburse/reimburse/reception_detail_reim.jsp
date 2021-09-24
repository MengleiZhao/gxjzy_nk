<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访单位</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="receptionObject" readonly="readonly"
			value="${receptionBeanEdit.receptionObject}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访日期</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 236px; height: 30px;" name="reDateStart" id="reDateStart" readonly="readonly" <c:if test="${bean.fupdateStatus!='1'}"> readonly="readonly"</c:if>
			value="${receptionBeanEdit.reDateStart}" data-options="required:true"/>
		</td>	
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访活动名称</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="receptionContent" readonly="readonly"
			value="${receptionBeanEdit.receptionContent}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访单位带队领导姓名</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 236px; height: 30px;" name="diningPlacePlan1" id="diningPlacePlan1" readonly="readonly" <c:if test="${bean.fupdateStatus!='1'}"> readonly="readonly"</c:if>
			value="${receptionBeanEdit.diningPlacePlan1}" data-options="required:true,validType:'length[1,5]'"/>
		</td>	
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访单位带队领导职务</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="diningPlacePlan2" readonly="readonly"
			value="${receptionBeanEdit.diningPlacePlan2}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 接待级别</td>
		<td class="td2">
			<select id="receptionLevel1" class="easyui-combobox" readonly="readonly"
			name="receptionLevel1" style="width: 236px; height: 30px;" data-options="required:true" >
				<option value="1" <c:if test="${receptionBeanEdit.receptionLevel1=='1'}"> selected="selected" </c:if>>省部级</option>
				<option value="2" <c:if test="${receptionBeanEdit.receptionLevel1=='2'}"> selected="selected" </c:if>>司局级</option>
				<option value="3" <c:if test="${receptionBeanEdit.receptionLevel1=='3'}"> selected="selected" </c:if>>处级以下（含处级）</option>
			</select>
		</td>	
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 随行人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" name="attendPeopNum" readonly="readonly"
			value="${receptionBeanEdit.attendPeopNum}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 236px; height: 30px;" name="diningPlacePlan3" id="diningPlacePlan3" readonly="readonly" <c:if test="${bean.fupdateStatus!='1'}"> readonly="readonly"</c:if>
			value="${receptionBeanEdit.diningPlacePlan3}" data-options="required:true,validType:'length[1,5]'"/>
		</td>	
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐总人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" name="rePeopNum" readonly="readonly"
			value="${receptionBeanEdit.rePeopNum}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐地点类型</td>
		<td class="td2">
			<select id="receptionLevel" class="easyui-combobox"  readonly="readonly"
			name="receptionLevel" style="width: 230px; height: 30px;" data-options="required:true" editable="false">
				<option value="1" <c:if test="${receptionBeanEdit.receptionLevel=='1'}"> selected="selected" </c:if>>学校内部</option>
				<option value="2" <c:if test="${receptionBeanEdit.receptionLevel=='2'}"> selected="selected" </c:if>>学校外部</option>
				<%-- <option value="3" <c:if test="${receptionBeanEdit.receptionLevel=='3'}"> selected="selected" </c:if>>执行任务</option>
				<option value="4" <c:if test="${receptionBeanEdit.receptionLevel=='4'}"> selected="selected" </c:if>>学习交流</option>
				<option value="5" <c:if test="${receptionBeanEdit.receptionLevel=='5'}"> selected="selected" </c:if>>检查指导</option>
				<option value="6" <c:if test="${receptionBeanEdit.receptionLevel=='6'}"> selected="selected" </c:if>>请示汇报工作</option>
				<option value="7" <c:if test="${receptionBeanEdit.receptionLevel=='7'}"> selected="selected" </c:if>>其他</option> --%>
			</select>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 236px; height: 30px;" name="diningPlace" id="diningPlace" readonly="readonly" <c:if test="${bean.fupdateStatus!='1'}"> readonly="readonly"</c:if>
			value="${receptionBeanEdit.diningPlace}" data-options="required:true,validType:'length[1,5]'"/>
		</td>	
		<td class="td1" style="width: 70px"><span class="style1">*</span> 报销金额</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 236px; height: 30px;" name="amount" id="amount" readonly="readonly" <c:if test="${bean.fupdateStatus!='1'}"> readonly="readonly"</c:if>
			value="${bean.amount}" data-options="required:true,validType:'length[1,5]'"/>
		</td>
	</tr>
	<%-- <tr class="trbody">
		<td class="td1"  style="width: 70px"><span class="style1">*</span>接待级别</td>
		<td class="td2" >
		<select id="receptionLevel1" class="easyui-combobox" readonly="readonly"
			name="receptionLevel1" style="width: 230px; height: 30px;" data-options="required:true" >
				<option value="1" <c:if test="${receptionBean.receptionLevel1=='1'}"> selected="selected" </c:if>>院级以上</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel1=='2'}"> selected="selected" </c:if>>院级及以下</option>
			</select>

		</td>
	</tr> --%>
	<%-- <tr style="height: 70px;">
		<td class="td1" style="width: 70px;"><span class="style1">*</span>接待事由</td>
		<td colspan="3">
			<textarea name="receptionContent"  id="receptionContent" class="textbox-text"  readonly="readonly" oninput="textareaNum(this,'textareaNum2')" autocomplete="off" 
			  style="width:580px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBeanEdit.receptionContent}</textarea>
		</td>
	</tr> --%>
	<%-- <tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 付款方式</td>
		<td class="td2">
			<input class="easyui-combobox" value="${bean.paymentType}" readonly="readonly" style="width: 230px; height: 30px;" data-options="editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'code',textField:'text'"/>
		</td>
		<td class="td1" style="width: 70px;"></td>
		<td class="td2">
		</td>
	</tr>	 --%>
	<tr class="trbody">
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 经办人</td>
		<td class="td2" >
		<input class="easyui-textbox" id="userName" name="userName" readonly="readonly" value="${bean.userName}" style="width: 230px;height: 30px;margin-left: 10px " >
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 部门名称</td>
		<td class="td2" >
		<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 236px;height: 30px;margin-left: 10px " >
		</td>
	</tr>
	<%-- <tr class="trbody">
	<td class="td1" style="width:70px;"><span class="style1">*</span>接待公函及其他附件 </td>
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
	<%-- <tr style="height: 70px;">
		<td class="td1" style="width: 70px;">备注说明</td>
		<td colspan="3">
			<textarea name="reimburseReason" readonly="readonly" id="reimburseReason" class="textbox-text"   autocomplete="off" 
			  style="width:580px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${bean.reimburseReason}</textarea>
		</td>
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
        	$('#rec-food-dg-reim').datagrid('insertRow', {
        		index: 2,
        		row:{
        		fFoodType: '宴请',
        		fCostStd: yanqing,
        		fPersonNum:(unitFeteNum+attendPeopNum),
        		//fNum: 1,
        		fCostFood:yanqing*(unitFeteNum+attendPeopNum)
        		}
        	});
        	
    		}
    	
    	
	}else{
		$('#tr1').hide();
		$('#diningPlacePlan1').val(0);
		$('#fFeteTime').datebox('setValue','');//宴请时间
		$('#unitFeteSite').textbox('setValue','');//宴请地点
		$('#unitFeteNum').numberbox('setValue','');//宴请人数
		$('#attendPeopNum').numberbox('setValue','');//陪餐人数
		var rows = $('#rec-food-dg-reim').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fFoodType=="宴请"){
				var fPersonNumOld = rows[i].fPersonNum;
				//如果宴请隐藏，把宴请的人次加入到正餐里面
				if($('#box2').is(':checked')){
		    		var rowsbox2 = $('#rec-food-dg-reim').datagrid('getRows');
		    		for(var j=0;j<rowsbox2.length;j++){
		    			if(rowsbox2[j].fFoodType=="正餐"){
		    				$('#rec-food-dg-reim').datagrid('selectRow', j).datagrid('beginEdit', j);
		    	    		var editors = $('#rec-food-dg-reim').datagrid('getEditors', j); 
		    	    		var old = editors[2].target.numberbox('getValue');
		    	    		
		    	    		editors[1].target.numberbox('setValue', zhengcan);
		    	    		editors[2].target.numberbox('setValue', parseInt(old)+parseInt(fPersonNumOld));
		    	    		editors[3].target.numberbox('setValue', (parseInt(old)+parseInt(fPersonNumOld))*zhengcan);
		    	    		$('#rec-food-dg-reim').datagrid('endEdit', j);
		    			}
		    		}
		    	}
				deleteIndex = i;
	    		var index = $('#rec-food-dg-reim').datagrid('getRowIndex',rows[i]);
	             $('#rec-food-dg-reim').datagrid('deleteRow',index);
				editIndex1 = undefined;
			}
		}
		
	}
    var rows = $('#rec-food-dg-reim').datagrid('getRows');
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
	
var reDayNum =parseInt($('#reDayNum').numberbox('getValue'));
var personNum =parseInt($('#rePeopNum').numberbox('getValue'));
    if($('#box2').is(':checked')){
    	$('#tr0').show();
    	$('#diningPlacePlan2').val(1);
    	if (endEditing1()){
        	$('#rec-food-dg-reim').datagrid('insertRow', {
        		index: 1,
        		row:{
        		fFoodType: '早餐',
        		fCostStd: zaocan,
        		fPersonNum:personNum*reDayNum,
        		//fNum: 1,
        		fCostFood:zaocan*personNum*reDayNum
        		}
        	});
        	
        	if($('#box1').is(':checked')){
        		var unitFeteNum =parseInt($('#unitFeteNum').numberbox('getValue'));
            	var attendPeopNum =parseInt($('#attendPeopNum').numberbox('getValue'));
            	$('#rec-food-dg-reim').datagrid('insertRow', {
            		index: 2,
            		row:{
            		fFoodType: '正餐',
            		fCostStd:  zhengcan,
            		fPersonNum:(personNum*reDayNum*2)-(unitFeteNum+attendPeopNum),
            		//fNum: 1,
            		fCostFood:zhengcan*((personNum*reDayNum*2)-(unitFeteNum+attendPeopNum))
            		}
            	});
        	}else{
        		$('#rec-food-dg-reim').datagrid('insertRow', {
            		index: 2,
            		row:{
            		fFoodType: '正餐',
            		fCostStd: zhengcan,
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
		$('#diningPlace').textbox('setValue','');
		var rows = $('#rec-food-dg-reim').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(rows[i].fFoodType=="早餐"){
				var index = $('#rec-food-dg-reim').datagrid('getRowIndex',rows[i]);
	             $('#rec-food-dg-reim').datagrid('deleteRow',index);
				editIndex1 = undefined;
			}
			if(rows[i].fFoodType=="正餐"){
				var index = $('#rec-food-dg-reim').datagrid('getRowIndex',rows[i]);
	             $('#rec-food-dg-reim').datagrid('deleteRow',index);
				editIndex1 = undefined;
			}
		}
	}
    var rows = $('#rec-food-dg-reim').datagrid('getRows');
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


var startday5='${receptionBeanEdit.reDateStart}';
var endday5='${receptionBeanEdit.reDateEnd}';

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
		        	$('#rec-hotel-dg-reim').datagrid('appendRow', {});
		    			}
		    		}
		    	}
		    	if(!isNaN(newRowNum) &&!isNaN(oldRowNum)){
		    		if(newRowNum<oldRowNum){
		    			for(var j=oldRowNum;j>newRowNum;j--){
		    				$('#rec-hotel-dg-reim').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
		    						j-1);
		    				editIndex = undefined;
		    				var rows = $('#rec-hotel-dg-reim').datagrid('getRows');
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
				        	$('#rec-hotel-dg-reim').datagrid('appendRow', {});
				    		}
				    	}
				    }
		    	}
		    	//计算总人数
		    	//addPersonNum();
		    	// 得到rows对象
		    	var rows = $('#rec-food-dg-reim').datagrid('getRows'); // 这段代码是
		    	var copyRows = [];
		        for ( var j= 0; j < rows.length; j++) {
		         copyRows.push(rows[j]);
		        }
		    	for (var i = 0; i < copyRows.length; i++){
		    		var index = $('#rec-food-dg-reim').datagrid('getRowIndex',copyRows[j]);
		             $('#rec-food-dg-reim').datagrid('deleteRow',index);
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
		    	var rows = $('#rec-food-dg-reim').datagrid('getRows'); // 这段代码是
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
		    		var index = $('#rec-food-dg-reim').datagrid('getRowIndex',copyRows[j]);
		             $('#rec-food-dg-reim').datagrid('deleteRow',index);
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
		
		function requiredValidatebox(){
			var fFeteTime = $("#fFeteTime").datebox('getValue');
			var unitFeteSite = $("#unitFeteSite").textbox('getValue');
			var unitFeteNum = $("#unitFeteNum").numberbox('getValue');
			var attendPeopNum = $("#attendPeopNum").numberbox('getValue');
			if(fFeteTime=='' || unitFeteSite=='' || unitFeteNum=='' || attendPeopNum==''){
				return false;
			}
			return true;
		}
</script>

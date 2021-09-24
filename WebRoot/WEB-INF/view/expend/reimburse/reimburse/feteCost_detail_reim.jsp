<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-fete-dg-reim" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#costFete_ids',
	url: '${base}/reimburse/feteCostJson?rId=${abroadEdit.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'fId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fAddress',width:115,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                editable:false,
                                multiple:false,
                                onHidePanel:cityFeteId,
                                onShowPanel:clickComboxFeteCity
                            }}">所在城市</th>
				<th data-options="field:'fAddress',hidden:true,align:'center',editor:{type:'textbox',options:{onChange:feteCity,editable:false}}">所在城市</th>
				<th data-options="field:'standard',align:'center',width:115,editor:{type:'numberbox',options:{editable:false}}">费用标准(每人)</th>
				<th data-options="field:'fFeeNum',align:'center',width:75,editor:{type:'numberbox',options:{onChange:peopleNum1}}">宴请人数</th>
				<th data-options="field:'fAccompanyNum',align:'center',width:75,editor:{type:'numberbox',options:{onChange:peopleNum2}}">陪餐人数</th>
				<th data-options="field:'countStandard',align:'center',width:110,editor:{type:'numberbox',options:{editable:false}}">总额标准（外币）</th>
				<th data-options="field:'currency',align:'center',width:45,editor:{type:'textbox',options:{editable:false}}">币种</th>
				<th data-options="field:'fApplyAmount',align:'center',width:133,editor:{type:'numberbox',options:{onChange:addNumFete,precision:2,groupSeparator:','}}">报销金额(人民币)</th>
			</tr>
		</thead>
	</table>
	<div id="costFete_ids" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">宴请费用</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id=""><fmt:formatNumber groupingUsed="true" value="${abroad.feteMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="feteCostAmounts"><fmt:formatNumber groupingUsed="true" value="${abroadEdit.feteMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndex3 = undefined;
function endEditing3() {
	if (editIndex3 == undefined) {
		return true
	}
	if ($('#rec-fete-dg-reim').datagrid('validateRow', editIndex3)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#rec-fete-dg-reim').datagrid('getEditors', editIndex3);
		var text=tr[0].target.combobox('getText');
		if(text!='--请选择--'){
			tr[0].target.combobox('setValue',text);
		}
		$('#rec-fete-dg-reim').datagrid('endEdit', editIndex3);
		editIndex3 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow3(index) {
	if(sign==1){
		if (editIndex3 != index) {
			if (endEditing3()) {
				$('#rec-fete-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex3 = index;
			} else {
				$('#rec-fete-dg-reim').datagrid('selectRow', editIndex3);
			}
		}
	}else{
		alert("请先保存出访计划！");
		return false;
	}
}
function append3() {
	if (endEditing3()) {
		$('#rec-fete-dg-reim').datagrid('appendRow', {});
		editIndex3 = $('#rec-fete-dg-reim').datagrid('getRows').length - 1;
		$('#rec-fete-dg-reim').datagrid('selectRow', editIndex3).datagrid('beginEdit',editIndex3);
	}
}
function removeit3() {
	if (editIndex3 == undefined) {
		return
	}
	$('#rec-fete-dg-reim').datagrid('cancelEdit', editIndex3).datagrid('deleteRow',
			editIndex3);
	editIndex3 = undefined;
	calcFeteCost();
	countMoney();
}
function accept3() {
	if (endEditing3()) {
		$('#rec-fete-dg-reim').datagrid('acceptChanges');
	}
}

//计算金额
function addNumFete(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
 	if(newValue==''){
 		newValue=0.00;
 	}
 	var rows = $('#rec-fete-dg-reim').datagrid('getRows');
 	var index=$('#rec-fete-dg-reim').datagrid('getRowIndex',$('#rec-fete-dg-reim').datagrid('getSelected'));
      var num1 = 0;
      for(var i=0;i<rows.length;i++){
 		if(i==index){
 			num1+=parseFloat(newValue);
 		}else{
 			num1+=addNumsFete(rows,i);
 		}
 	}
 		$("#feteCostAmounts").html(fomatMoney(num1,2)+"[元]");
 		$("#feteMoney").val(num1.toFixed(2));
 		countMoney();
}
function addNumsFete(rows,index){
	var num=0;
	if(rows[index].fApplyAmount!=''&&rows[index].fApplyAmount!='NaN'&&rows[index].fApplyAmount!=undefined){
		num = parseFloat(rows[index].fApplyAmount);
	}else{
		num =0;
	}
	return num;
}
function calcFeteCost(){
	//计算总额
	var rows = $('#rec-fete-dg-reim').datagrid('getRows');
	var feteAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fApplyAmount))?0.00:parseFloat(rows[i].fApplyAmount);
		feteAmount=feteAmount+money;
	}
	$('#feteCostAmounts').html(feteAmount.toFixed(2)+'[元]');
	$('#feteMoney').val(feteAmount.toFixed(2));
}
//选中时给出行人员设置id
function cityFeteId(){
	var index=$('#rec-fete-dg-reim').datagrid('getRowIndex',$('#rec-fete-dg-reim').datagrid('getSelected'));
	var fAddressId = $('#rec-fete-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fAddressId'
	});
	var fAddress = $('#rec-fete-dg-reim').datagrid('getEditor',{
		index:index,
		field:'fAddress'
	});
	$(fAddressId.target).textbox('setValue', fAddress.target.combobox('getValues'));
}
function clickComboxFeteCity(){
	var index=$('#rec-fete-dg-reim').datagrid('getRowIndex',$('#rec-fete-dg-reim').datagrid('getSelected'));
	$('#rec-fete-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_city_fete();
		var fAddress = $('#rec-fete-dg-reim').datagrid('getEditor',{
			index:index,
			field:'fAddress'
		});
		$(fAddress.target).combobox({
            data: new_arrs,
            valueField: 'id',
            multiple: false,
            textField: 'text',
		});
}
function new_arr_city_fete(){
	var rows = $('#abroad-plan-dg').datagrid('getRows');
	var arrs = new Array();
	for (var i = 0; i < rows.length; i++) {
		var idAndName = {};
		idAndName.id = rows[i].arriveCountryId;
		idAndName.text = rows[i].arriveCountry;
		arrs.push(idAndName);
	}
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h].id == arrs[c].id ) {//通过id属性进行匹配；
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
		}
	return arrs;
}

function feteCity(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var index=$('#rec-fete-dg-reim').datagrid('getRowIndex',$('#rec-fete-dg-reim').datagrid('getSelected'));
	
    var city = newVal; //所在城市
    if(city==''){
    	var ed = $('#rec-fete-dg-reim').datagrid('getEditor',{
			index:index,
			field : 'applyAmount'  
		});
		$(ed.target).numberbox('setValue', 0.00);
    	return false;
    }
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCostAbroad?configId='+city,
			success:function (data){
				
				var ed1 = $('#rec-fete-dg-reim').datagrid('getEditor',{
					index:index,
					field : 'standard'  
				});
				var ed2 = $('#rec-fete-dg-reim').datagrid('getEditor',{
					index:index,
					field : 'currency'  
				});
				var ed3 = $('#rec-fete-dg-reim').datagrid('getEditor',{
					index:index,
					field : 'fFeeNum'  
				});
				var ed4 = $('#rec-fete-dg-reim').datagrid('getEditor',{
					index:index,
					field : 'fAccompanyNum'  
				});
				var ed5 = $('#rec-fete-dg-reim').datagrid('getEditor',{
					index:index,
					field : 'countStandard'  
				});
				$(ed1.target).numberbox('setValue', data[0].foodMoney);
				$(ed2.target).textbox('setValue', data[0].currency);
				if($(ed3.target).numberbox('getValue')!='' && $(ed4.target).numberbox('getValue')!=''){
					var fFeeNum =  parseFloat($(ed3.target).numberbox('getValue'));
					if(isNaN((ed3.target).numberbox('getValue'))){
						 fFeeNum = 0;
					}
					
					var fAccompanyNum = parseFloat($(ed4.target).numberbox('getValue'));
					if(isNaN((ed4.target).numberbox('getValue'))){
						 fAccompanyNum = 0;
					}
				    $(ed5.target).numberbox('setValue', (fAccompanyNum+fFeeNum)*parseFloat(data[0].foodMoney));
				}
			}
	});
}

//宴请人数
function peopleNum1(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var index=$('#rec-fete-dg-reim').datagrid('getRowIndex',$('#rec-fete-dg-reim').datagrid('getSelected'));
	
	 	if(newVal==''){
	    	var ed = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'fApplyAmount'  
			});
			$(ed.target).numberbox('setValue', 0.00);
			//总额标准
	    	var ed1 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'countStandard'  
			});
			$(ed1.target).numberbox('setValue', 0.00);
	    	return false;
	    }else{
	    	var ed1 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'standard'
			});
			var ed4 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'fAccompanyNum'
			});
			var ed5 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'countStandard'
			});
			if(!isNaN(parseFloat($(ed1.target).numberbox('getValue'))) && !isNaN(parseFloat($(ed4.target).numberbox('getValue')))){
				$(ed5.target).numberbox('setValue',(parseFloat($(ed4.target).numberbox('getValue'))+parseFloat(newVal))*parseFloat($(ed1.target).numberbox('getValue')));
			}
	    }
}

//陪餐人数
function peopleNum2(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var index=$('#rec-fete-dg-reim').datagrid('getRowIndex',$('#rec-fete-dg-reim').datagrid('getSelected'));
	if(newVal==''){
    	var ed = $('#rec-fete-dg-reim').datagrid('getEditor',{
			index:index,
			field : 'fApplyAmount'
		});
		$(ed.target).numberbox('setValue', 0.00);
		var ed1 = $('#rec-fete-dg-reim').datagrid('getEditor',{
			index:index,
			field : 'countStandard'  
		});
		$(ed1.target).numberbox('setValue', 0.00);
    	return false;
	   }else{
		   var ed1 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'standard'
			});
			var ed4 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'fFeeNum'
			});
			var ed5 = $('#rec-fete-dg-reim').datagrid('getEditor',{
				index:index,
				field : 'countStandard'
			});
			if(!isNaN(parseFloat($(ed1.target).numberbox('getValue'))) && !isNaN(parseFloat($(ed4.target).numberbox('getValue')))){
				$(ed5.target).numberbox('setValue',(parseFloat($(ed4.target).numberbox('getValue'))+parseFloat(newVal))*parseFloat($(ed1.target).numberbox('getValue')));
			}
	   }
}



function getFeteCostJson(){
	accept3();
	var rows1 = $('#rec-fete-dg-reim').datagrid('getRows');
	var feteCost = "";
	for (var i = 0; i < rows1.length; i++) {
		feteCost = feteCost + JSON.stringify(rows1[i]) + ",";
	}
	$('#feteJson').val(feteCost);
}
</script>
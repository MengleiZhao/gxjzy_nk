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
	//设置时间
	if($("#applyReqTime").val()==""||$("#applyReqTime").val()==null){
		var date = new Date();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
		$("#applyReqTime").val(date);
	} else {
		var date = $("#applyReqTime").val();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
	}
	var cxjk = '${abroad.fDiningPlace}';
	if(cxjk==1){
		$('#feteCostId').show();
		$("#fDiningPlaceId1").attr("checked",true);
	} else {
		$('#feteCostId').hide();
		$("#fDiningPlaceId2").attr("checked",true);
	}
	
	//设置支出申请扩展信息
	var h = $("#applyTypeHi").val();
	if (h != "") {
		$('#applyType').val(h);
	}
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
	//可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	}
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	
	var travelMoney = $("#travelMoney").val();
	if(travelMoney !=""){
		$('#p_travelMoney').html(fomatMoney(travelMoney,2)+" [元]");
	}
	var hotelMoney = $("#hotelMoney").val();
	if(hotelMoney !=""){
		$('#p_hotelMoney').html(fomatMoney(hotelMoney,2)+" [元]");
	}
	var foodMoney = $("#foodMoney").val();
	if(foodMoney !=""){
		$('#p_foodMoney').html(fomatMoney(foodMoney,2)+" [元]");
	}
	var pocketMoney = $("#pocketMoney").val();
	if(pocketMoney !=""){
		$('#p_pocketMoney').html(fomatMoney(pocketMoney,2)+" [元]");
	}
	var totalOtherMoney = $("#totalOtherMoney").val();
	if(totalOtherMoney !=""){
		$('#p_totalOtherMoney').html(fomatMoney(totalOtherMoney,2)+" [元]");
	}
});


//保存
function saveApply(flowStauts) {
	if($('#applyAmount_span').html()=='&nbsp;'||parseInt($('#applyAmount_span').html())<=0){
		alert('请注意填写费用明细金额！');
		return ;
	}
	// 在后台反序列化成明细Json的对象集合
	var h = $("#applyTypeHi").val();
	
	//出国人员信息
	/* var abroadPersonRows = $('#abroad-person-dg').datagrid('getRows');
	var ids = '';
	for (var i = 0 ; i < abroadPersonRows.length ; i++) {
		ids = ids + abroadPersonRows[i].id+',';
	}
	ids = ids.substring(0, ids.length-1);
	$('#abroadPeople').val(ids); */
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	/* if(s==''){
		alert('请上传附件');
		return
	} */
	$("#files").val(s);
	abroadPlanJson();					 //行程清单
	travelWayJson();                    //出行方式
	abroadPersonJson();
	//travelJson();                        //国际旅费
	//outsideTrafficJson();                //国外城市间交通费
	//getHotelJson();						 //住宿费
	//getfoodJson();						 //伙食费
	//getFeeJson();						 //公杂费
	//var cxjk = $('input[name="fDiningPlace"]:checked').val();
	//if(cxjk==1){
	//getFeteCostJson();					 //宴请费
	//}
	//getOtherJson();						 //其他费用
	
	//费用明细json
	expenseDetailJson();
	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);
	//宴请安排
	$('#fDiningPlace').val($('input[name="fDiningPlace"]:checked').val());
	
	
	if($('#applyAmount').val()==""||$('#applyAmount').val()=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	}
	
	//校验
	//预算指标
	var budgetIndexName = $('#F_fBudgetIndexName').val();
	if(budgetIndexName == ''){
		alert('请选择支出项目！');
		return;
	}
	//申请金额
	var applyAmount = $('#applyAmount').val();
	if(applyAmount == '' || applyAmount == '0.00') {
		alert('请填写费用明细申请金额！');
		return;
	}
	var syAmount = $('#syAmount').val();
	if(parseFloat(syAmount)<parseFloat(applyAmount)){
		alert('预算可用金额不足,请重新选择支出项目！');
		return;
	}
	//提交
	$('#apply_save_form').form('submit', {
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
		url : base + '/apply/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			} 
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#applyTab'+h).datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

//打开指标选择页面
function openIndex() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}

function standardFlag() {
	var row = $('#appli-detail-dg').datagrid('getRows');
	for(var i=0;i<row.length;i++) {
		if(row[i].standard!="据实列支") {//当开支标准不等于据实列支是，判断
			if(parseFloat(row[i].applySum)>parseFloat(row[i].standard)){
				alert('申请金额不能大于开支标准，请核对！');
				return false;
			}
		}
	}
	return true;
}

//计算申请总额
function addNum(newValue,oldValue) {
	var type = '${type}';
	
	if (type!='1' && type!='6') {
		//bakup 2019-05-08 差旅明细使用固定配置
		
		//2-计算当前编辑行
		var row = $('#appli-detail-dg-travel').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg-travel').datagrid('getRowIndex',$('#appli-detail-dg-travel').datagrid('getSelected'));//获得选中行的行号
		var tr = $('#appli-detail-dg-travel').datagrid('getEditors', index);
		var standar = row.standard;
		var price = parseFloat(newValue);
		var priceOld = parseFloat(row.applySum);//判断之前是否有数据
		//计算总额：1-计算非编辑行
		var rows = $('#appli-detail-dg-travel').datagrid('getRows');
		var totalPrice = 0;
		var pri = 0;
		for(var i=0; i<rows.length; i++){
			
			if(i==index){
				pri =parseFloat(newValue);
			}else{
				totalPrice+=addNums(rows,i);
			} 
		}
		//3-两类数值相加得到总额
		if(!isNaN(price)){
			if(parseFloat(newValue) > standar){
				alert('申请金额不能大于开支标准，请核对！');
				tr[0].target.numberbox('setValue','0');
				newValue=0;
			} else {
				//原先有数据且未改动的，不能进入总额合计
				if(!isNaN(priceOld) && isNaN(parseFloat(oldValue))){
					return;
				} else {
					totalPrice = totalPrice + price;
				}
			}
		}
		//给两个总额框赋值
		$('#applyAmount').val(totalPrice.toFixed(2));//
		$('#applyAmount_span').html(fomatMoney(totalPrice,2)+" [元]");
		$('#num1').numberbox('setValue',totalPrice.toFixed(2));
		return;
	} else {
		var row = $('#appli-detail-dg').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg').datagrid('getEditors', index);
		var standar= tr[1].target.textbox('getValue');//获得选中行的开支标准
		
		if(parseFloat(newValue)>parseFloat(standar)){
			
			alert('申请金额不能大于开支标准，请核对！');
			tr[2].target.textbox('setValue','0');
			newValue=0;
		}
		
		var num = 0;
		var rows = $('#appli-detail-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].applySum!=""&&rows[i].applySum!=null){
					num += parseFloat(rows[i].applySum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#num1').textbox('setValue',num.toFixed(2));
		$('#applyAmount').val(num.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
	}
}
//未编辑或者已经编辑完毕的行
function addNums(rows,index){
	
	var amount=rows[index]['applySum'];
	if(amount==null){
		amount=0;
		return parseFloat(amount);
	}
	return parseFloat(amount); 
}
//明细表格添加删除，保存方法
/* var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#appli-detail-dg').datagrid('validateRow', editIndex)) {
		var ed = $('#appli-detail-dg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#appli-detail-dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#appli-detail-dg').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#appli-detail-dg').datagrid('selectRow', editIndex);
		}
	}
}
function append() {
	if (endEditing()) {
		$('#appli-detail-dg').datagrid('appendRow', {});
		editIndex = $('#appli-detail-dg').datagrid('getRows').length - 1;
		$('#appli-detail-dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	//页面随滚动条置底
	var div = document.getElementById('easyAcc');
	div.scrollTop = div.scrollHeight;
}
function removeit() {
	if (editIndex == undefined) {
		return
	}
	$('#appli-detail-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#appli-detail-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
	}
	$('#num1').textbox('setValue',num);
	$('#applyAmount').val(num);
	$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
}
function accept() {
	if (endEditing()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
} */

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
	$('#applyAmount').val(0);
	$('#applyAmount_span').html(fomatMoney(0,2)+" [元]");
}
var endday5 = null;
//日期设置
function onSelectAbroad2(date) {
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
//自动获得费用明细
function calcTravelCost(){
	
	var aboard_num = $("#abroadDay").textbox('getValue');//出国天数
	
	if(aboard_num==''){
		return;
	}
	
	$('#appli-detail-dg-travel').datagrid({
		url: base+'/hotelStandard/calcCost?outType=aboard',
		queryParams:{
			aboard_num: aboard_num
		}
	});
}
	
$(function(){
	$("#fTeamPersonNum").numberbox({
	    onChange : function(newValue,oldValue){
	    	if(newValue==undefined || oldValue==undefined){
				return false;
			}
	    	$("#travelPerson").numberbox('setValue',newValue);
			$("#hotelPerson").numberbox('setValue',newValue);
			$("#foodPerson").numberbox('setValue',newValue);
			$("#pocketPerson").numberbox('setValue',newValue);
	    	//动态添加列表行和删除行
	    	/* var newRowNum =parseInt(newValue);
	    	var oldRowNum =parseInt(oldValue);
	    	if(!isNaN(newRowNum) && isNaN(oldRowNum)){
	    	for(var i=0;i<=newRowNum-1;i++){
	    		if (endEditingR()){
	        	$('#abroad-people-dg').datagrid('appendRow', {});
	    			}
	    		}
	    	}
	    	if(!isNaN(newRowNum) &&!isNaN(oldRowNum)){
	    		if(newRowNum<oldRowNum){
	    			for(var j=oldRowNum;j>newRowNum;j--){
	    				$('#abroad-people-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
	    						j-1);
	    				editIndex = undefined;
			        }
			    }else if(newRowNum>oldRowNum){
			    	for(var i=0;i<=newRowNum-oldRowNum-1;i++){
			    		if (endEditingR()){
			        	$('#abroad-people-dg').datagrid('appendRow', {});
			    		}
			    	}
			    }
	    	} */
	    	
	    	
	    	
	    }
	});
});

$("#abroadDateStart").datebox({
    onSelect : function(beginDate){
    	startday5 = beginDate;
    	endday5= new Date(endday5);
    	if(endday5 !=undefined){
    		var d = (endday5 - startday5) / 86400000 + 1;
    		if (d > 0) {
    			$('#abroadDay').textbox("setValue", d);
    		} else {
    			$('#abroadDay').textbox("setValue", "");
    		}
    	}
    	$("#minTime").val(startday5);
        $('#abroadDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

$('#abroadDay').numberbox({
	onChange: function(newValue, oldValue){
		
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		
		$("#hotelDay").numberbox('setValue',newValue);
		$("#foodDay").numberbox('setValue',newValue);
		$("#pocketDay").numberbox('setValue',newValue);
	}
});
function chooseuser(index) {
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=abroad&tabId=apply_abroadtab');
	win.window('open');

}

function checkedFete1(){
	var cxjk = $('input[name="fDiningPlace"]:checked').val();
	if(cxjk==1){
		$('#feteCostId').show();
		$('#rec-fete-dg').datagrid('reload');
	} else {
		$('#feteCostId').hide();
		var feeRows = $('#rec-fete-dg').datagrid('getRows');
		for(var i = feeRows.length-1 ; i >= 0 ; i--){
			$('#rec-fete-dg').datagrid('deleteRow',i);
		}
		editIndex3 = undefined;
		calcFeteCost();
		countMoney();
	}
}

function checkedFete2(){
	
	var cxjk = $('input[name="fDiningPlace"]:checked').val();
	if(cxjk==1){
		$('#feteCostId').show();
		$('#rec-fete-dg').datagrid('reload');
	} else {
		$('#feteCostId').hide();
		var feeRows = $('#rec-fete-dg').datagrid('getRows');
		for(var i = feeRows.length-1 ; i >= 0 ; i--){
			$('#rec-fete-dg').datagrid('deleteRow',i);
		}
		editIndex3 = undefined;
		calcFeteCost();
		countMoney();
	}
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

function reloadProcess() {
	var indexId = $('#F_fBudgetIndexCode').val();
	if (indexId != '' || indexId != null) {
		$('#check_system_div').load('${base}/apply/refreshApplyProcess?indexId='+indexId+'&applyType=7');
	}
}

	$(document).ready(function() {
		$('#F_fBudgetIndexName').textbox({
			onChange : function(newValue, oldValue) {
				reloadProcess();
			}
		});
	});
</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="gId" value="${bean.gId}" />
				<!-- 申请单流水号 --><input type="hidden" name="gCode" value="${bean.gCode}" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
				<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 申请类型 --><input type="hidden" id="applyTypeHi" value="${bean.type}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="F_proDetailId"/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
				<!-- 申请时间  --><input type="hidden" id="applyReqTime" name="reqTime" value="${bean.reqTime}"/>
				<!-- 申请事项  --><input type="hidden" id="applyType" name="type" value="${bean.type}"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 最早的出发时间  --><input type="hidden" id="maxTime" />
				<!-- 最晚的撤离时间  --><input type="hidden" id="minTime" />
				<!-- 申请总额  --><input type="hidden" id="applyAmount" name="amount" value="${bean.amount}"/>
				<!-- 国际旅费  --><input type="hidden" id="travelMoney" name="travelMoney" value="${abroad.travelMoney}"/>
				<!-- 住宿费  --><input type="hidden" id="hotelMoney" name="hotelMoney" value="${abroad.hotelMoney}"/>
				<!-- 伙食费  --><input type="hidden" id="foodMoney" name="foodMoney" value="${abroad.foodMoney}"/>
				<!-- 公杂费  --><input type="hidden" id="mixMoney" name="mixMoney" value="${abroad.mixMoney}"/>
				<!-- 宴请费  --><input type="hidden" id="feteMoney" name="feteMoney" value="${abroad.feteMoney}"/>
				<!-- 国外交通费  --><input type="hidden" id="trafficMoney" name="trafficMoney" value="${abroad.trafficMoney}"/>
				<!-- 其他费用  --><input type="hidden" id="totalOtherMoney" name="totalOtherMoney" value="${abroad.totalOtherMoney}"/>
				<!-- 是否宴请 --><input type="hidden" id="fDiningPlace" value="${abroad.fDiningPlace}"/>
				
				<!-- 出国人员信息  --><input type="hidden" id="abroadPeople" name="abroadPeopleJson" />
				
				<!-- 所有列表json -->
				<input type="hidden" id="travelJson" name="travelJson" />
				<input type="hidden" id="outsideTrafficJson" name="trafficJson1" />
				<input type="hidden" id="hotelJson" name="hotelJson" />
				<input type="hidden" id="foodJson" name="foodJson" />
				<input type="hidden" id="feeJson" name="feeJson" />
				<input type="hidden" id="feteJson" name="feteJson" />
				<input type="hidden" id="otherJson" name="otherJson" />
				<input type="hidden" id="abroadPlanJson" name="abroadPlanJson" />
				<input type="hidden" id="travelWayJson" name="travelWayJson" />
				
				
				<!-- 基本信息 -->
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="基本信息" data-options="collapsed:false,collapsible:false"style="overflow:">
							<table class="window-table" id="apply_abroadtab" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
								<%-- <tr>
									<td class="td1">单据编号</td>
									<td colspan="3">
										<c:if test="${operation=='add' }">
											<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${applyCodeAdd}" name="gCode" required="required" 
											data-options="validType:'length[1,50]',editable:false" />
										</c:if>
										<c:if test="${operation!='add' }">
											<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gCode}" name="gCode" required="required" 
											data-options="validType:'length[1,50]',editable:false"/>
										</c:if>
									</td>
								</tr> --%>
								<tr class="trbody">
									<td class="td1" style="width: 10%"><span class="style1">*</span>摘要</td>
									<td colspan="3">
										<c:if test="${operation=='add' }">
											<input class="easyui-textbox" style="width: 620px;height: 30px; " value="${draftAdd}" name="gName"   required="required" data-options="validType:'length[1,50]'"/>
										</c:if>
										<c:if test="${operation!='add' }">
											<input class="easyui-textbox" style="width: 620px;height: 30px; " value="${bean.gName}" name="gName"   required="required" data-options="validType:'length[1,50]'"/>
										</c:if>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团组名称</td>
									<td class="td2" >
										<input style="width: 251px; height: 30px;" id="fTeamName" name="fTeamName" class="easyui-textbox" 
										value="${abroad.fTeamName}"  data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;"><span class="style1">*</span>组团单位</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fAbroadPlace" name="fAbroadPlace" class="easyui-textbox"  
										value="${abroad.fAbroadPlace}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团长(级别)</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fTeamLeader" name="fTeamLeader" class="easyui-textbox" 
										value="${abroad.fTeamLeader}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;"></td>
									<td class="td2"> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>团员人数</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fTeamPersonNum"  name="fTeamPersonNum" class="easyui-numberbox"  
										value="${abroad.fTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
									<td class="td1" style="width:70px;"><span class="style1">*</span>本单位参团人数</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="fThisUnitTeamPersonNum"  name="fThisUnitTeamPersonNum" class="easyui-numberbox"  
										value="${abroad.fThisUnitTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>开始时间</td>
									<td class="td2">
										<input style="width: 251px; height: 30px;" id="abroadDateStart" name="fAbroadDateStart" class="easyui-datebox"  
										value="${abroad.fAbroadDateStart}" data-options="required:true" editable="false"/>
									</td>
									
									<td class="td1" style="width:70px;"><span class="style1">*</span>结束时间</td>
									<td class="td2">
										<input type="hidden" name="faId" value="${abroad.faId}" />
										<input style="width: 251px; height: 30px;" id="abroadDateEnd" name="fAbroadDateEnd" class="easyui-datebox"  
										value="${abroad.fAbroadDateEnd}" data-options="onSelect:onSelectAbroad2,required:true" editable="false"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;"><span class="style1">*</span>出国天数</td>
									<td class="td2" colspan="3">
										<input style="width: 251px; height: 30px;" id="abroadDay" name="fAbroadDayNum" class="easyui-textbox"  
										value="${abroad.fAbroadDayNum}" readonly="readonly" data-options="required:true,validType:'length[1,2]'"/> 
									</td>
								</tr>
								<tr style="height:4px"></tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>申请事由</td>
									<td class="td2" colspan="3">
										<input class="easyui-textbox" data-options="multiline:true,required:true,validType:'length[0,250]'"
										 name="reason" style="width:620px;height:60px;" value="${bean.reason }">
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width:70px;">宴请安排</td>
									<td class="td2" colspan="3">
			                       		<input type="radio" name="fDiningPlace" id="fDiningPlaceId1"  onclick="checkedFete1()" value="1" <c:if test="${abroad.fDiningPlace==1} "> checked </c:if>>是
			                        	<input type="radio" name="fDiningPlace" id="fDiningPlaceId2" onclick="checkedFete2()" value="0" <c:if test="${abroad.fDiningPlace!=1} "> checked </c:if>>否
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
									<td class="td2" >
									<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 251px;height: 30px;margin-left: 10px " >
									</td>
									<td class="td1" style="width: 70px;"><span class="style1">*</span> 部门名称</td>
									<td class="td2" >
									<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 251px;height: 30px;margin-left: 10px " >
									</td>
								</tr>
							</table>
						</div>				
					</div>
				<!-- 出国人员信息 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出国人员信息 " data-options="collapsed:false,collapsible:false"	style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span>出国人员</td>
								<td colspan="3" style="padding-left: 5px;">
									<a  <c:if test="${operation=='add' }">  onclick="chooseuser()"</c:if> id="chooseuserId">
										<input class="easyui-textbox" style="width: 642px;height: 30px;" name="fAbroadPeople" value="${abroad.fAbroadPeople}" id="fAbroadPeople"
										 data-options="prompt:'点击选择出国人员名单',validType:'length[1,200]',icons: [{iconCls:'icon-add'}]" readonly="readonly" required="required"/>
									 </a>
								</td>
							</tr>
						</table>
					</div>
				</div> --%>
				
				<!--出国人员信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出国人员信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<!-- 出访计划（含经停）-->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="abroad_person.jsp" />
						</div>
					</div>
				</div>
				
				<!--出访计划（含经停）信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出访国家（含经停）" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<!-- 出访计划（含经停）-->
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="abroad_way.jsp" />
						</div>
					</div>
				</div>
				<!--出行方式 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="出行方式" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="travel_way.jsp" />
						</div>
					</div>
				</div>
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="费用明细" data-options="collapsible:false" style="overflow:auto;">
						<!-- 全部费用-->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_expense_add.jsp" />
						</div>
					
						<%-- <!-- 国际旅费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_international_traveling_expense.jsp" />
						</div>
						<!-- 国外城市间交通费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="apply_outside_traffic_international.jsp" />
						</div>
						<!-- 住宿费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="hotelExpense_aboard.jsp" />
						</div>
						<!-- 伙食费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="foodAllowance_aboard.jsp" />
						</div>
						<!-- 公杂费 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="miscellaneousFee.jsp" />
						</div>
						<!-- 宴请费 -->
						<div id="feteCostId">
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="feteCost.jsp" />
						</div>
						</div>
						<!-- 其他费用 -->
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="otherExpenses.jsp" />
						</div> --%>
						<div style="margin-top: 20px">
							<a style="float: right;">申请总额：<span style="color: #D7414E"  id="applyAmountAbroad"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
						</div>
					</div>
				</div>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px">
					<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
								<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目:</td>
								<td colspan="3" style="padding-right: 5px;">
									<a onclick="openIndex()" href="#">
									<input class="easyui-textbox" style="width: 642px;height: 30px;"
									name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
									data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
									</a>
								</td>
							</tr>
						</table>	
						<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
								<tr>
									<td class="window-table-td1"><p>批复金额：</p></td>
									<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
									
									<td class="window-table-td1"><p>预算年度：</p></td>
									<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								</tr>
								
								<tr>
									<td class="window-table-td1"><p>可用额度：</p></td>
									<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}元</p></td>
									
									<%-- <td class="window-table-td1"><p>累计支出:</p></td>
									<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td> --%>
								</tr>
						</table>				
					</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="附件信息" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr>
							<td class="td1" style="width:40px;">
								附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'file','zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
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
								<c:forEach items="${attaList}" var="att">
									<c:if test="${att.serviceType=='file'}">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
									</c:if>	
								</c:forEach>
							</td>
						</tr>
						
						
					</table>
					
				</div>
				</div>
				
				
				
	
				<!-- 下级审批人 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<c:if test="${type==1 }">
						<div title="下级审批人" data-options="collapsed:false,collapsible:false" 
						style="overflow:auto;">
							<c:if test="${type!=1}">
							</c:if>
							<jsp:include page="nextrole.jsp" />
						</div>
					</c:if>
				</div>
				
				
				<c:if test="${operation!='add' }">
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
						<!-- <div class="window-title"> 审批记录</div> -->
						<c:if test="${type!=1 }">
							<jsp:include page="../../../check_history.jsp" />
						</c:if>												
						
						<c:if test="${type==1 }">
							<jsp:include page="../check/check_history.jsp" />												
						</c:if>												
					</div>
				</div>
				</c:if>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="saveApply(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveApply(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="showFlowDesinger()">
				<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>

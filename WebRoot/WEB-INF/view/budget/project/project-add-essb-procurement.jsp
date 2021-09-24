<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 990px">
		<div title="政府采购明细表" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 980px">
		<div style="overflow:auto;margin-top: 0px;">
			<table id="pro_purchase_tab_essb_id" class="easyui-datagrid" style="width:980px;height:auto"
			data-options="
			singleSelect: true,
			toolbar: '#purchase_toolbar_essb_Id',
			<c:if test="${!empty bean.FProId}">
			url: '${base}/project/findByfProIdGetPur?id=${bean.FProId}&fIfSoftware=0',
			</c:if>
			<c:if test="${empty bean.FProId}">
			url: '',
			</c:if>
			method: 'post',
			onClickRow: onClickRowpurchaseReim1Essb,
			striped : true,
			nowrap : false,
			rownumbers:true,
			scrollbarSize:0,
			onLoadSuccess:onLoadSuccessPurTabEssb
			">
				<thead>
					<tr>
						<th data-options="field:'fItemsDetail',align:'center',editor:{type:'textbox', options:{requerd:true}}" style="width: 15%">品目明细</th>
						<th data-options="field:'fItemsCodeName',align:'center',editor:{type:'combobox',
						options:{
							hasDownArrow:false,
							editable:true,
							required:true,
							valueField:'code',
							textField:'text',
							method:'post',
							url:base+'/purchaseCatagl/getItemsCodeName',
							onSelect:afterPurSuccessEssb,
						}
					}" style="width: 15%">品目编码及名称</th>
						<th data-options="field:'fItemsCode',align:'center',hidden:true,editor:{type:'textbox', options:{requerd:true}}" style="width: 15%">品目编码</th>
						<th data-options="field:'fItemsName',align:'center',hidden:true,editor:{type:'textbox', options:{requerd:true}}" style="width: 15%">品目名称</th>
						<th data-options="field:'subName',width:160,align:'center'
								,editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     var row = $('#pro_purchase_tab_essb_id').datagrid('getSelected');
									     var index = $('#pro_purchase_tab_essb_id').datagrid('getRowIndex',row);
									     chooseOutSubNameProEssb(index)
									     }}]}}" style="width: 15%">经济分类科目</th>
						<th data-options="field:'subCode',align:'center',hidden:true,editor:{type:'textbox', options:{requerd:true}}" style="width: 15%">经济分类科目编码</th>
						<th data-options="field:'fIfThreeAssets',width:150,align:'center',
							editor:{type:'combobox',options:{valueField:'id',textField:'text',
							data:[{id:'1',text:'是'},
			                	{id:'0',text:'否'}],
			                	prompt:'-请选择-',panelHeight:'atuo',editable: false}},formatter:isorno" style="width: 15%">是否新增三项资产</th>
						<th data-options="field:'fProcurementNum',align:'center',editor:{type:'numberbox', options:{requerd:true,onChange:onChangeProcurementNumEssb}}" style="width: 15%">采购数量</th>
						<th data-options="field:'fMeasurement',align:'center',editor:{type:'textbox', options:{requerd:true,onChange:onChangeMeasurementEssb}}" style="width: 15%">计量单位</th>
						<th data-options="field:'fUnitPrice',align:'center',editor:{type:'numberbox', options:{requerd:true,onChange:onChangeUnitPriceEssb}}" style="width: 15%">采购单价（元）</th>
						<th data-options="field:'fAmount',align:'center',editor:{type:'numberbox', options:{requerd:true,editable:false}}" style="width: 15%">总计</th>
						<th data-options="field:'fPlanDate',align:'center',editor:{type:'datebox', options:{requerd:true}},formatter:ChangeDateFormatProPurEssb" style="width: 15%">计划采购日期</th>
						<th data-options="field:'fRefiningExplain',align:'center',editor:{type:'textbox', options:{requerd:true}}" style="width: 15%">参数</th>
						<th data-options="field:'fAllocationStandard',align:'center',editor:{type:'textbox', options:{requerd:true}}" style="width: 15%">采购配置标准</th>
					</tr>
				</thead>
			</table>
			<div id="purchase_toolbar_essb_Id" style="height:30px;padding-top : 8px">
				<a style="float: right;">&nbsp;&nbsp;</a>
				<a href="javascript:void(0)" id="removeStudentId" onclick="removeitpurchaseReimEssb()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
				<a style="float: right;">&nbsp;&nbsp;</a>
				<a href="javascript:void(0)" id="appendStudentId" onclick="appendpurchaseReimEssb()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
				<a style="float: right;">&nbsp;&nbsp;</a>
			</div>
			<input type="hidden" id="purchasePeopJson" name="purchaseJson" />
			</div>
	</div>
	
	
	
	
	<table cellpadding="0" cellspacing="0" style="width:990px;height:auto">
		<tr class="trbody">
			<td style="float: left;margin-top: 20px" colspan="5">是否为一采多年项目
	     		<input type="radio" value="1" name="ifPurchaseManyYearsPro" onclick="onClickIfPurchaseManyYearsPro1Essb()" <c:if test="${bean.ifPurchaseManyYearsPro=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
				&nbsp;&nbsp;
				<input type="radio" value="0" name="ifPurchaseManyYearsPro" onclick="onClickIfPurchaseManyYearsPro2Essb()" <c:if test="${bean.ifPurchaseManyYearsPro=='0'||bean.ifPurchaseManyYearsPro==''||empty bean.ifPurchaseManyYearsPro}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
			</td>
		</tr>
	</table>

<div id="purManyYearsPro_toolbar_essb_Id" style="height:30px;width: 970px;margin-top: 15px;margin-right: 30px">
	<input type="hidden" id="purManyYearsProJson" name="purManyYearsProJson"/>
	<a style="float: right;" href="javascript:void(0)" id="purManyYearsProremoveitId" onclick="purManyYearsProremoveitEssb()"
		<c:if test="${bean.ifPurchaseManyYearsPro=='0'||bean.ifPurchaseManyYearsPro==''||empty bean.ifPurchaseManyYearsPro}"> 
		 hidden="hidden"
		</c:if>
	><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a style="float: right;" href="javascript:void(0)" id="purManyYearsProAppendId" onclick="purManyYearsProAppendEssb()"
		<c:if test="${bean.ifPurchaseManyYearsPro=='0'||bean.ifPurchaseManyYearsPro==''||empty bean.ifPurchaseManyYearsPro}"> 
		 hidden="hidden"
		</c:if>
	><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<div style="height:30px;width: 970px;margin-top: 5px;color: red">
		采购总金额：<span style="color: red" id="purYearsTotalshow"><fmt:formatNumber groupingUsed="true" value="${bean.governmentPurAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>元
	</div>
</div>
<table id="purManyYearsProTabEssbId" class="easyui-datagrid" style="width:980px;height:auto"
			data-options="
			singleSelect: true,
			toolbar: '#purManyYearsPro_toolbar_essb_Id',
			rownumbers : true,
			url: '${base}/project/getPurchaseManyYearsPro?fProId=${bean.FProId}&fIfSoftware=0',
			method: 'post',
			onClickRow: onClickRow_purManyYearsProEssb
			">
				<thead>
					<tr>
						<th data-options="field:'purYear',align:'center',editor:{type:'textbox', options:{requerd:true}}" style="width:33%">采购年度</th>
						<th data-options="field:'yearAmount',align:'center',editor:{type:'textbox', options:{requerd:true,onChange:onChangeYearAmountEssb}}" style="width:33%">年度预算安排金额</th>
						<th data-options="field:'fExplain',align:'center',editor:{type:'textbox', options:{requerd:true}}" style="width:33%">说明</th>
					</tr>
				</thead>
</table>


	</div>
<script type="text/javascript">
var sign1 = 0;

//接待人员表格添加删除，保存方法
var editIndexpurchaseReimEssb = undefined;
function endEditingpurchaseReimEssb() {
	if (editIndexpurchaseReimEssb == undefined) {
		return true
	}
	if ($('#pro_purchase_tab_essb_id').datagrid('validateRow', editIndexpurchaseReimEssb)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#pro_purchase_tab_essb_id').datagrid('getEditors', editIndexpurchaseReimEssb);
		$('#pro_purchase_tab_essb_id').datagrid('endEdit', editIndexpurchaseReimEssb);
		editIndexpurchaseReimEssb = undefined;
		return true;
	} else {
		return false;
	}
}

function onClickRowpurchaseReim1Essb(index) {
	
	if (editIndexpurchaseReimEssb != index) {
		if (endEditingpurchaseReimEssb()) {
			$('#pro_purchase_tab_essb_id').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexpurchaseReimEssb = index;
		} else {
			$('#pro_purchase_tab_essb_id').datagrid('selectRow', editIndexpurchaseReimEssb);
		}
	}
}

function appendpurchaseReimEssb() {
	if (endEditingpurchaseReimEssb()) {
		$('#pro_purchase_tab_essb_id').datagrid('appendRow', {
		});
		editIndexpurchaseReimEssb = $('#pro_purchase_tab_essb_id').datagrid('getRows').length - 1;
		$('#pro_purchase_tab_essb_id').datagrid('selectRow', editIndexpurchaseReimEssb).datagrid('beginEdit',editIndexpurchaseReimEssb);
	}
}
function removeitpurchaseReimEssb() {
	if (editIndexpurchaseReimEssb == undefined) {
		return
	}
	$('#pro_purchase_tab_essb_id').datagrid('cancelEdit', editIndexpurchaseReimEssb).datagrid('deleteRow',
			editIndexpurchaseReimEssb);
	editIndexpurchaseReimEssb = undefined;
	var rows = $('#pro_purchase_tab_essb_id').datagrid('getRows');
	var travelDays=0;
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
}
function acceptpurchaseReimEssb() {
	if (endEditingpurchaseReimEssb()) {
		$('#pro_purchase_tab_essb_id').datagrid('acceptChanges');
	}
}
	
function purchasePeopJsonReimEssb(){
	
	acceptpurchaseReimEssb();
	var rows2 = $('#pro_purchase_tab_essb_id').datagrid('getRows');
	var purchasePeop = "";
	if(rows2==''){
		return false;
	}else{
		var flag1 = true;
		for (var y = 0; y < rows2.length; y++) {
		if(!isNotEmpty(rows2[y].fItemsDetail)||!isNotEmpty(rows2[y].fItemsCodeName)||!isNotEmpty(rows2[y].subName)
					||isNaN(rows2[y].fIfThreeAssets)||isNaN(rows2[y].fProcurementNum)
					||!isNotEmpty(rows2[y].fMeasurement)||isNaN(rows2[y].fUnitPrice)||isNaN(rows2[y].fAmount)){
				flag1 = false;
			}
		}
		if(!flag1){
			return false;
		}
		for (var i = 0; i < rows2.length; i++) {
			purchasePeop = purchasePeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#purchasePeopJson').val(purchasePeop);
		return true;
	}
}

function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return '';
	}
}

//时间格式化
function ChangeDateFormatProPurEssb(val) {
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
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

function afterPurSuccessEssb(rec){
	var row = $('#pro_purchase_tab_essb_id').datagrid('getSelected');
	var rindex = $('#pro_purchase_tab_essb_id').datagrid('getRowIndex', row); 
	var ed = $('#pro_purchase_tab_essb_id').datagrid('getEditors',rindex);
	$.ajax({
		 type: "post",
         url: base + "/purchaseCatagl/findbyFId?id="+rec.id,
         contentType: "json",
         async : 'false',
         success: function (datas) {
			datas = eval("(" + datas + ")");
			ed[1].target.combobox('setValue',datas.fpurName+"("+datas.fpurCode+")");
			ed[2].target.textbox('setValue',datas.fpurCode);
			ed[3].target.textbox('setValue',datas.fpurName);
         }
		
	});
}

function chooseOutSubNameProEssb(rIndex){
	var ejProCode="";
	var code = '';
	var fProOrBasic = '${bean.FProOrBasic}';
	var planStartYear = $('#pro_add_planStartYear').numberbox('getValue');
	if(planStartYear==''||planStartYear==null||planStartYear==undefined){
		alert('请先填写计划开始执行年份');
		return false;
	}
	var win=creatFirstWin('选择-支出预算事项',600,550,'icon-search','/project/toChooseProcurment?tabId=pro_purchase_tab_essb_id&rIndex='+rIndex+'&fProOrBasic='+fProOrBasic+'&ejProCode='+ejProCode+'&code='+code+'&ejplanStartYear='+planStartYear);
	win.window('open');
}

function onLoadSuccessPurTabEssb(){
	var fprocurementStatus = $('input[name="fprocurementStatus"]:checked').val();
	if(fprocurementStatus=='1'){
		$('#zhengfuId').css('display','');
	}
}

function onChangeProcurementNumEssb(newVal,oldVal){
	newVal = isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var index=$('#pro_purchase_tab_essb_id').datagrid('getRowIndex',$('#pro_purchase_tab_essb_id').datagrid('getSelected'));
	var fUnitPrices = $('#pro_purchase_tab_essb_id').datagrid('getEditor',{
		index:index,
		field : 'fUnitPrice'
	});
	var fUnitPrice = isNaN(parseFloat($(fUnitPrices.target).numberbox('getValue')))?0:parseFloat($(fUnitPrices.target).numberbox('getValue'));
	var fAmount = $('#pro_purchase_tab_essb_id').datagrid('getEditor',{
		index:index,
		field : 'fAmount'  
	});
	
	$(fAmount.target).numberbox('setValue',fUnitPrice*newVal);
}


function onChangeUnitPriceEssb(newVal,oldVal){
	newVal = isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var index=$('#pro_purchase_tab_essb_id').datagrid('getRowIndex',$('#pro_purchase_tab_essb_id').datagrid('getSelected'));
	var fProcurementNums = $('#pro_purchase_tab_essb_id').datagrid('getEditor',{
		index:index,
		field : 'fProcurementNum'  
	});
	var fProcurementNum = isNaN(parseFloat($(fProcurementNums.target).numberbox('getValue')))?0:parseFloat($(fProcurementNums.target).numberbox('getValue'));
	var fAmount = $('#pro_purchase_tab_essb_id').datagrid('getEditor',{
		index:index,
		field : 'fAmount'  
	});
	$(fAmount.target).numberbox('setValue',fProcurementNum*newVal);
}

/* 一采多年列表操作 */	
var purManyYearsProEditEssbIndex = undefined;

//添加一行
function purManyYearsProAppendEssb() {
	 if (purManyYearsProEndEditingEssb()) {
			$('#purManyYearsProTabEssbId').datagrid('appendRow', {});
			beginIndex = $('#purManyYearsProTabEssbId').datagrid('getRows').length - 1;
			$('#purManyYearsProTabEssbId').datagrid('selectRow', beginIndex).datagrid('beginEdit', beginIndex);
			purManyYearsProEditEssbIndex=beginIndex;
		}
}
//删除一行
function purManyYearsProremoveitEssb() {
	if (purManyYearsProEditEssbIndex == undefined) {
		alert('请点击要删除的行！');
		return;
	}
	$('#purManyYearsProTabEssbId').datagrid('cancelEdit', purManyYearsProEditEssbIndex).datagrid('deleteRow',
			purManyYearsProEditEssbIndex);
	purManyYearsProEditEssbIndex = undefined;
	yearAmountAllEssb();
}

//使列表结束编辑状态
function purManyYearsProAcceptEssb() {
	if (purManyYearsProEndEditingEssb()) {
		$('#purManyYearsProTabEssbId').datagrid('acceptChanges');
	}
}
//结束编辑状态
function purManyYearsProEndEditingEssb() {
	if (purManyYearsProEditEssbIndex == undefined) {
		return true;
	}
	if ($('#purManyYearsProTabEssbId').datagrid('validateRow', purManyYearsProEditEssbIndex)) {
		$('#purManyYearsProTabEssbId').datagrid('endEdit', purManyYearsProEditEssbIndex);
		purManyYearsProEditEssbIndex = undefined;
		return true;
	} else {
		return false;
	}
}
//行被点击事件
function onClickRow_purManyYearsProEssb(index){
	if (purManyYearsProEditEssbIndex != index){
		if (purManyYearsProEndEditingEssb()){
			$('#purManyYearsProTabEssbId').datagrid('selectRow', index).datagrid('beginEdit', index);
			purManyYearsProEditEssbIndex = index;
		} else {
			$('#purManyYearsProTabEssbId').datagrid('selectRow', purManyYearsProEditEssbIndex);
		}
	}
}

//存入json
function getPurManyYearsProJsonEssb(){
	 purManyYearsProAcceptEssb();
	var rows = $('#purManyYearsProTabEssbId').datagrid('getRows');
	var performance = "";
	for (var j = 0; j < rows.length; j++) {
		performance = performance + JSON.stringify(rows[j]) + ",";
	}
	$('#purManyYearsProJson').val(performance);
}

function onClickIfPurchaseManyYearsPro1Essb(){
	$('#purManyYearsProremoveitId').show();
	$('#purManyYearsProAppendId').show();
}

function onClickIfPurchaseManyYearsPro2Essb(){
	$('#purManyYearsProremoveitId').hide();
	$('#purManyYearsProAppendId').hide();
	 purManyYearsProAcceptEssb();
	 var rows = $('#purManyYearsProTabEssbId').datagrid('getRows');
	 for (var i = rows.length-1; i >=0; i--) {
		 $('#purManyYearsProTabEssbId').datagrid('deleteRow',i);
	}
	 purManyYearsProEditEssbIndex = undefined;
}

function onChangeYearAmountEssb(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(isNaN(parseFloat(newVal))||newVal==''){
		newVal = 0;
	}
     var num1 = 0;
	 var rows = $('#purManyYearsProTabEssbId').datagrid('getRows');
	 var index=$('#purManyYearsProTabEssbId').datagrid('getRowIndex',$('#purManyYearsProTabEssbId').datagrid('getSelected'));
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsYearAmountEssb(rows,i);
		}
	}
		$("#purYearsTotalshow").html(num1.toFixed(2));
		$("#pro_add_governmentPurAmount").val(num1.toFixed(2));
}


function addNumsYearAmountEssb(rows,index){
	var num=0;
	if(rows[index].yearAmount!=''&&rows[index].yearAmount!='NaN'&&rows[index].yearAmount!=undefined){
		num = parseFloat(rows[index].yearAmount);
	}else{
		num =0;
	}
	return num;
}

function yearAmountAllEssb(){
	var rows = $('#purManyYearsProTabEssbId').datagrid('getRows');
	var num1 = 0;
    for(var i=0;i<rows.length;i++){
		num1+=addNumsYearAmountEssb(rows,i);
	}
		$("#purYearsTotalshow").html(num1.toFixed(2));
		$("#pro_add_governmentPurAmount").val(num1.toFixed(2));
}


function onChangeMeasurementEssb(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var flagMe = true;
	var str = newVal;
	var arr = ["批","套"];
	for (var i = 0; i < arr.length; i++) {
		if(str.indexOf(arr[i])>=0){
			flagMe = false;
			break;
		}
	}
	if(!flagMe){
		var index=$('#pro_purchase_tab_essb_id').datagrid('getRowIndex',$('#pro_purchase_tab_essb_id').datagrid('getSelected'));
		var fMeasurement = $('#pro_purchase_tab_essb_id').datagrid('getEditor',{
			index:index,
			field : 'fMeasurement'  
		});
		$(fMeasurement.target).textbox('setValue','');
	}
}
</script>
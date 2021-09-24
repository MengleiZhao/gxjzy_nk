<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table id="invoice-coupon-dg" class="easyui-datagrid" style="width:900px;height:auto"
data-options="
toolbar: '#invoice-coupon-tb',
method: 'post',
onClickRow: couponOnClickRow,
striped : true,
nowrap : false,
rownumbers:true,
scrollbarSize:0,
singleSelect: true,
">
<thead>
	<tr>
		<th data-options="field:'icId',hidden:true"></th>
		<th data-options="field:'iId',hidden:true"></th>
		<th data-options="field:'goodsService',align:'center',width:135,editor:{type:'textbox',options:{required: true,validType:'length[1,100]'}}">货物或应税劳务、服务名称</th>
		<th data-options="field:'norms',align:'center',width:140,editor:{type:'textbox',options:{required: false,validType:'length[0,50]'}}">规格型号</th>
		<th data-options="field:'unit',align:'center',width:100,editor:{type:'textbox',options:{required: false,validType:'length[0,10]'}}">单位</th>
		<th data-options="field:'number',align:'center',width:100,editor:{type:'textbox',options:{required: true,validType:'length[1,10]'}}">数量</th>
		<th data-options="field:'univalent',align:'center',width:100,editor:{type:'numberbox',options:{required: true,precision:2}}">单价[元]</th>
		<th data-options="field:'amount',align:'center',width:100,editor:{type:'numberbox',options:{required: true,precision:2,onChange:couponAmountChange}}">金额[元]</th>
		<th data-options="field:'taxRate',align:'center',width:100,editor:{type:'numberbox',options:{required: true,precision:2,onChange:couponTaxRateChange}}">税率%</th>
		<th data-options="field:'tax',align:'center',width:100,editor:{type:'numberbox',options:{required: true,precision:2,readonly:'readonly'}}">税额[元]</th>
	</tr>
</thead>
</table>

<div id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
	<table cellpadding="0" cellspacing="0" style="width: 100%">
	<tr style="height: 30px">
		<td>
			<a style="color: #ff6800">&nbsp;&nbsp;合计</a>
		</td>
		<td align="center" style="width: 100px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style="color: #ff6800" id="coupon-amount">0.00</a>
		</td>	
		<td align="center" style="width: 100px"></td>	
		<td align="center" style="padding-right: 10px;width: 100px">
			&nbsp;&nbsp;&nbsp;&nbsp;<a style="color: #ff6800" id="coupon-tax">0.00</a>
		</td>		
	</tr>
	</table>
</div>

<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 900px">
	<tr class="trbody" style="height: 50px">
		<td class="td1">价税合计（大写）</td>
		<td class="td2">
			<input class="easyui-textbox" name="priceCapitals" id="priceCapitals" style="width: 300px" data-options="" readonly="readonly"/>
		</td>
		
		<td style="width: 90px">
			<input type="hidden" name="iId" id="invoice_iId"/>
			<input type="hidden" name="type" id="invoice_type"/>
		</td>
		
		<td class="td1">价税合计（小写）</td>
		<td class="td2">
			<input class="easyui-textbox" name="priceLowerCase" id="priceLowerCase" style="width: 300px" data-options="" readonly="readonly"/>
		</td>
	</tr>
</table>


<div id="invoice-coupon-tb" style="height:30px">
	<a href="javascript:void(0)" onclick="couponRemoveit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="couponAppend()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>

<script type="text/javascript">
//表格添加删除，保存方法
var couponEditIndex = undefined;
function couponEndEditing() {
	if (couponEditIndex == undefined) {
		return true
	}
	if ($('#invoice-coupon-dg').datagrid('validateRow', couponEditIndex)) {
		var ed = $('#invoice-coupon-dg').datagrid('getEditor', {
			index : couponEditIndex,
			field : 'costDetail'
		});
		$('#invoice-coupon-dg').datagrid('endEdit', couponEditIndex);
		couponEditIndex = undefined;
		return true;
	} else {
		return false;
	}
}

//票面金额发生改变
function couponAmountChange(newValue, oldValue){
	var row = $("#invoice-coupon-dg").datagrid('getSelected');//获得选择行
	var index=$("#invoice-coupon-dg").datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $("#invoice-coupon-dg").datagrid('getEditors', index);
	var taxRate= tr[6].target.textbox('getValue');//获得选中行的税率
	
	//计算编辑行的税额
	if(taxRate!=null&&taxRate!="") {
		tr[7].target.textbox('setValue',(parseFloat(newValue)*parseFloat(taxRate)/100).toFixed(2));//税额=金额*税率
	} else {
		tr[7].target.textbox('setValue',0);
	}
	
	//计算除了当前编辑行外的金额合计和税额合计
	var rows = $("#invoice-coupon-dg").datagrid('getRows');//获得所有的票面行
	var amountSum=0;//金额合计
	var taxSum=0;//税额合计
	for(var i=0;i<rows.length;i++){
		if(i!=index){//除了当前编辑行
			if(rows[i].amount!=""&&rows[i].amount!=null){//金额输入框不为空
				amountSum += parseFloat(rows[i].amount);//金额依次相加
				if(rows[i].taxRate!=""&&rows[i].taxRate!=null){//税额输入框不为空
					taxSum = parseFloat(rows[i].amount)*parseFloat(rows[i].taxRate)/100;//税额=金额*税率
				}
			}
		}
	}
	
	//计算当前编辑行的金额和税额
	if(newValue!=""&&newValue!=null) {
		amountSum += parseFloat(newValue);
		if(taxRate!=""&&taxRate!=null){
			taxSum += parseFloat(newValue)*parseFloat(taxRate)/100;//税额=金额*税率
		}
	}
	
	//合计设值
	$("#coupon-amount").text(amountSum.toFixed(2));
	$("#coupon-tax").text(taxSum.toFixed(2));
	
	$("#priceLowerCase").textbox('setValue',(amountSum+taxSum).toFixed(2));//价税合计小写赋值
	$("#priceCapitals").textbox('setValue',convertCurrency((amountSum+taxSum).toFixed(2)));//调用大小写转换方法
}

//票面税率发生改变
function couponTaxRateChange(newValue, oldValue) {
	var row = $("#invoice-coupon-dg").datagrid('getSelected');//获得选择行
	var index=$("#invoice-coupon-dg").datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $("#invoice-coupon-dg").datagrid('getEditors', index);
	var amount= tr[5].target.textbox('getValue');//获得选中行的金额
	
	if(amount!=null&&amount!="") {
		tr[7].target.textbox('setValue',(parseFloat(newValue)*parseFloat(amount)/100).toFixed(2));
	} else {
		tr[7].target.textbox('setValue',0);
	}
	
	//计算除了当前编辑行外的金额合计和税额合计
	var rows = $("#invoice-coupon-dg").datagrid('getRows');//获得所有的票面行
	var amountSum=0;//金额合计
	var taxSum=0;//税额合计
	for(var i=0;i<rows.length;i++){
		if(i!=index){//除了当前编辑行
			if(rows[i].amount!=""&&rows[i].amount!=null){//金额输入框不为空
				amountSum += parseFloat(rows[i].amount);//金额依次相加
				if(rows[i].taxRate!=""&&rows[i].taxRate!=null){//税额输入框不为空
					taxSum = parseFloat(rows[i].amount)*parseFloat(rows[i].taxRate)/100;//税额=金额*税率
				}
			}
		}
	}
	
	//计算当前编辑行的金额和税额
	if(amount!=""&&amount!=null){
		amountSum +=  parseFloat(amount);
		if(newValue!=""&&newValue!=null){
			taxSum += parseFloat(newValue)*parseFloat(amount)/100;//税额=金额*税率
		}
	}
	
	//合计设值
	$("#coupon-amount").text(amountSum.toFixed(2));
	$("#coupon-tax").text(taxSum.toFixed(2));
	
	$("#priceLowerCase").textbox('setValue',(amountSum+taxSum).toFixed(2));//价税合计小写赋值
	$("#priceCapitals").textbox('setValue',convertCurrency((amountSum+taxSum).toFixed(2)));//调用大小写转换方法
}

//以下为表格操作方法
function couponOnClickRow(index) {
	if (couponEditIndex != index) {
		if (couponEndEditing()) {
			$('#invoice-coupon-dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			couponEditIndex = index;
		} else {
			$('#invoice-coupon-dg').datagrid('selectRow', couponEditIndex);
		}
	}
}

function couponAppend() {
	if (couponEndEditing()) {
		$('#invoice-coupon-dg').datagrid('appendRow', {});
		couponEditIndex = $('#invoice-coupon-dg').datagrid('getRows').length - 1;
		$('#invoice-coupon-dg').datagrid('selectRow', couponEditIndex).datagrid('beginEdit',
				couponEditIndex);
	}
}
function couponRemoveit() {
	if (couponEditIndex == undefined) {
		return
	}
	$('#invoice-coupon-dg').datagrid('cancelEdit', couponEditIndex).datagrid('deleteRow',
			couponEditIndex);
	couponEditIndex = undefined;
}
function couponAccept() {
	if (couponEndEditing()) {
		$('#invoice-coupon-dg').datagrid('acceptChanges');
	}
}

</script>
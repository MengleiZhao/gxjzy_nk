<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
		<table id="payer_info_tab" class="easyui-datagrid" style="width:695px;height:auto"
		data-options="
		singleSelect: true,
		<c:if test="${!empty bean.rId}">
		url: '${base}/Enforcing/getSignInfoByCondition?fContId=${bean.payId}',
		</c:if>
		<c:if test="${empty bean.rId}">
		url: '',
		</c:if>
		<c:if test="${empty detail}">
		onClickRow: onClickRowPayerinfo,
		</c:if>
		method: 'post',
		striped : true,
		nowrap : false,
		rownumbers:true,
		scrollbarSize:0,
		onLoadSuccess:countAmount
		">
			<thead>
				<tr>
					<th data-options="field:'pId',hidden:true"></th>
					<th data-options="field:'rId',hidden:true"></th>
					<th data-options="field:'payeeId',align:'center',hidden:true,editor:{type:'textbox',options:{editable:true}}">收款人ID</th>
					<th data-options="field:'biddingName',align:'center'" width="25%">收款人</th>
					<th data-options="field:'fCardNo',align:'center',editor:{type:'textbox',options:{editable:false,required:true}}" width="25%">银行账户</th>
					<th data-options="field:'fBankName',align:'center',editor:{type:'textbox',options:{editable:false,required:true}}" width="25%">开户银行</th>
					<th data-options="field:'payeeAmount',align:'center',editor:{type:'numberbox',options:{editable:false,required:true,precision:2,iconCls:'icon-yuan',onChange:payeeAmounts}}" width="25%">转账金额</th>
				</tr>
			</thead>
		</table>
</div>
<script type="text/javascript">

function aftersuccess(rec){
	
	var row = $('#payer_info_tab').datagrid('getSelected');
	var rindex = $('#payer_info_tab').datagrid('getRowIndex', row); 
	var ed = $('#payer_info_tab').datagrid('getEditors',rindex);
	$.ajax({
		 type: "post",
         url: base + "/reimburse/findbypayeeId?id="+rec.code,
         contentType: "json",
         async : 'false',
         success: function (datas) {
			datas = eval("(" + datas + ")");
			ed[0].target.textbox('setValue',datas.payeeId);
			ed[2].target.textbox('setValue',datas.bankAccount);
			ed[3].target.textbox('setValue',datas.bank);
         }
		
	});
}
//接待人员表格添加删除，保存方法
var editIndexinfo = undefined;
function endEditinginfo() {
	if (editIndexinfo == undefined) {
		return true;
	}
	if ($('#payer_info_tab').datagrid('validateRow', editIndexinfo)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#payer_info_tab').datagrid('getEditors', editIndexinfo);
		var text=tr[1].target.combotree('getText');
		if(text!='--请选择--'){
			tr[1].target.textbox('setValue',text);
		}
		var text1=tr[2].target.textbox('getText');
		if(text1!='--请选择--'){
			tr[2].target.textbox('setValue',text1);
		}
		$('#payer_info_tab').datagrid('endEdit', editIndexinfo);
		editIndexinfo = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowPayerinfo(index) {
	if (editIndexinfo != index) {
		if (endEditinginfo()) {
			$('#payer_info_tab').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexinfo = index;
		} else {
			$('#payer_info_tab').datagrid('selectRow', editIndexinfo);
		}
	}
}
function appendinfo() {
	if (endEditinginfo()) {
		$('#payer_info_tab').datagrid('appendRow', {
		});
		editIndexinfo = $('#payer_info_tab').datagrid('getRows').length - 1;
		$('#payer_info_tab').datagrid('selectRow', editIndexinfo).datagrid('beginEdit',editIndexinfo);
	}
}
function removeInfo() {
	if (editIndexinfo == undefined) {
		return
	}
	$('#payer_info_tab').datagrid('cancelEdit', editIndexinfo).datagrid('deleteRow',
			editIndexinfo);
	editIndexinfo = undefined;
	countAmount();
	/* var rows = $('#payer_info_tab').datagrid('getRows');
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
	$('#hotelTotalDays').val(hotelDays); */
}
function acceptpayerinfo() {
	if (endEditinginfo()) {
		$('#payer_info_tab').datagrid('acceptChanges');
	}
}
//获得json数据
function getpayerinfoJson(){
	acceptpayerinfo();
	$('#payer_info_tab').datagrid('acceptChanges');
	var rows = $('#payer_info_tab').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#payerinfoJson").val(entities);
}	
// Easyui中textbox中input事件失效的原因是 easy TextBox控件不是修改你的border 而是，将input进行了隐藏。然后用一个框放到了外面。实现所有浏览器效果统一。
$('#bankAccount').textbox({
	inputEvents: $.extend({},$.fn.textbox.defaults.inputEvents,{
	keyup: function(event){
		var tempValue = $(this).val();
        if(null != tempValue && '' != tempValue && undefined != tempValue){
        	 var info=_getBankInfoByCardNo(tempValue);
        	$('#bankName').textbox('setValue',info.bankName); //银行名称 
        }
	}})
});

function payeeAmounts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	
	var rows = $('#payer_info_tab').datagrid('getRows');
	var index=$('#payer_info_tab').datagrid('getRowIndex',$('#payer_info_tab').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsPayee(rows,i);
		}
	}
		$("#payeeAmount").val(num1);
}


function addNumsPayee(rows,index){
	var num=0;
	if(rows[index].payeeAmount!=''&&rows[index].payeeAmount!='NaN'&&rows[index].payeeAmount!=undefined){
		num = parseFloat(rows[index].payeeAmount);
	}else{
		num =0;
	}
	return num;
}

function countAmount(){
	//添加转账金额
	$('#payer_info_tab').datagrid('updateRow',{
		index: 0,
		row: {
			'payeeAmount':$('#f_amount').numberbox('getValue')
		}
	});
	
	var rows = $('#payer_info_tab').datagrid('getRows');
	var index=$('#payer_info_tab').datagrid('getRowIndex',$('#payer_info_tab').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsPayee(rows,i);
		}
	}
		$("#payeeAmount").val(num1);
}
</script>
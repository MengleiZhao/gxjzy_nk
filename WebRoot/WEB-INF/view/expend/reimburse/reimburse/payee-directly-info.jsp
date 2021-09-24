<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 00px">
		<table id="payer_info_tab" class="easyui-datagrid" style="width:695px;height:auto"
		data-options="
		singleSelect: true,
		toolbar: '#payer_info_toolbar',
		<c:if test="${!empty bean.drId}">
		url: '${base}/reimburse/payerInfojson?rId=${bean.drId}',
		</c:if>
		<c:if test="${empty bean.drId}">
		url: '',
		</c:if>
		method: 'post',
		<c:if test="${empty detail}">
		onClickRow: onClickRowPayerinfo,
		</c:if>
		striped : true,
		nowrap : false,
		rownumbers:true,
		scrollbarSize:0,
		">
			<thead>
				<tr>
					<th data-options="field:'pId',hidden:true"></th>
					<th data-options="field:'rId',hidden:true"></th>
					<th data-options="field:'payeeId',align:'center',hidden:true,editor:{type:'textbox',options:{editable:true}}" width="12%">收款人ID</th>
					<th data-options="field:'payeeName',align:'center',editor:{type:'textbox',options:{editable:true,required:true}}" width="25%">收款人</th>
					<th data-options="field:'bankAccount',align:'center',editor:{type:'textbox',options:{editable:true,required:true}}" width="25%">银行账户</th>
					<th data-options="field:'bank',align:'center',editor:{type:'textbox',options:{editable:true,required:true}}" width="25%">开户银行</th>
					<th data-options="field:'payeeAmount',align:'center',editor:{type:'numberbox',options:{editable:true,precision:2,required:true}}" width="25.5%">转账金额</th>
				</tr>
			</thead>
		</table>
		<c:if test="${!empty operation}">
			<div id="payer_info_toolbar" style="height:30px;padding-top : 8px">
				<a href="javascript:void(0)" onclick="removeInfo()" hidden="hidden" id="outsideRemoveitId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
				<a style="float: right;">&nbsp;&nbsp;</a>
				<a href="javascript:void(0)" onclick="appendinfo()" hidden="hidden" id="outsideAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			</div>
		</c:if>

</div>
<script type="text/javascript">

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
	if(sign==1){
	if (editIndexinfo != index) {
		if (endEditinginfo()) {
			$('#payer_info_tab').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexinfo = index;
		} else {
			$('#payer_info_tab').datagrid('selectRow', editIndexinfo);
		}
	}
	}else{
		alert("不能编辑！");
		return false;
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
	var rows = $('#payer_info_tab').datagrid('getRows');
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
	
</script>
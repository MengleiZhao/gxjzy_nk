<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
		<table id="payer_info_student_tab" class="easyui-datagrid" style="width:695px;height:auto"
		data-options="
		singleSelect: true,
		toolbar: '#payer_info_student_toolbar',
		<c:if test="${!empty bean.drId}">
		url: '${base}/directlyReimburse/payerInfojson?drId=${bean.drId}',
		</c:if>
		<c:if test="${empty bean.drId}">
		url: '',
		</c:if>
		onClickRow: onClickRowDPayerinfoStudent,
		method: 'post',
		striped : true,
		nowrap : false,
		rownumbers:true,
		scrollbarSize:0,
		">
			<thead>
				<tr>
					<th data-options="field:'sclass',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="17%">班级</th>
					<th data-options="field:'payeeName',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="17%">姓名</th>
					<th data-options="field:'proName',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">项目</th>
					<th data-options="field:'numberDays',align:'center',editor:{type:'numberbox',options:{required:true,editable:true}}" width="10%">天数</th>
					<th data-options="field:'everyoneAmount',align:'center',editor:{type:'numberbox',options:{required:true,editable:true,precision:2}}" width="17%">金额/人</th>
					<th data-options="field:'bankAccount',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">建行账号</th>
					<th data-options="field:'payeeAmount',align:'center',editor:{type:'numberbox',options:{required:true,editable:true,precision:2,onChange:payeeAmountDirStudent}}" width="17%">总金额</th>
					<th data-options="field:'tel',align:'center',editor:{type:'textbox',options:{required:true,editable:true,precision:0}}" width="25%">联系号码</th>
					<th data-options="field:'remark',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="30%">备注</th>
				</tr>
			</thead>
		</table>
		<div id="payer_info_student_toolbar" style="height:30px;padding-top : 8px">
			<a href="javascript:void(0)" onclick="removeStudentInfo()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="appendStudentInfo()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			
			<a href="#" onclick="studentDetailImput()">
				<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
			<a href="${base}/directlyReimburse/directRimDetailDownload?type=student">
				<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/mbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
			<a style="text-align: right;">
				合计金额：<span style="color: red" id="studentAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>元</span>
			</a>
			
		</div>

</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexStudentInfo = undefined;
function endEditingStudentInfo() {
	if (editIndexStudentInfo == undefined) {
		return true;
	}
	if ($('#payer_info_student_tab').datagrid('validateRow', editIndexStudentInfo)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#payer_info_student_tab').datagrid('getEditors', editIndexStudentInfo);
		var text=tr[1].target.combotree('getText');
		if(text!='--请选择--'){
			tr[1].target.textbox('setValue',text);
		}
		var text1=tr[2].target.textbox('getText');
		if(text1!='--请选择--'){
			tr[2].target.textbox('setValue',text1);
		}
		$('#payer_info_student_tab').datagrid('endEdit', editIndexStudentInfo);
		editIndexStudentInfo = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowDPayerinfoStudent(index) {
	if (editIndexStudentInfo != index) {
		if (endEditingStudentInfo()) {
			$('#payer_info_student_tab').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			var tr = $('#payer_info_student_tab').datagrid('getEditors', index);
			var text1=tr[2].target.textbox('getText');
			if(text1!='--请选择--'){
				tr[2].target.textbox('setValue',text1);
				if(text1=="现金"){
			    	tr[2].target.textbox({
			    	    required: false
			    	});
			    	tr[3].target.textbox({
			   	    	required: false
			   		});
			    }else{
			    	tr[2].target.textbox({
			    	    required: true
			    	});
			    	tr[3].target.textbox({
			   	    	required: true
			   		});
			    }
			}
			editIndexStudentInfo = index;
		} else {
			$('#payer_info_student_tab').datagrid('selectRow', editIndexStudentInfo);
		}
	}
}
function appendStudentInfo() {
	if (endEditingStudentInfo()) {
		$('#payer_info_student_tab').datagrid('appendRow', {
		});
		editIndexStudentInfo = $('#payer_info_student_tab').datagrid('getRows').length - 1;
		$('#payer_info_student_tab').datagrid('selectRow', editIndexStudentInfo).datagrid('beginEdit',editIndexStudentInfo);
	}
}
function removeStudentInfo() {
	if (editIndexStudentInfo == undefined) {
		return
	}
	$('#payer_info_student_tab').datagrid('cancelEdit', editIndexStudentInfo).datagrid('deleteRow',
			editIndexStudentInfo);
	editIndexStudentInfo = undefined;
	var rows = $('#payer_info_student_tab').datagrid('getRows');
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
function acceptpayerStudentInfo() {
	if (endEditingStudentInfo()) {
		$('#payer_info_student_tab').datagrid('acceptChanges');
	}
}
//获得json数据
function getpayerinfoStudentJson(){
	acceptpayerStudentInfo();
	$('#payer_info_student_tab').datagrid('acceptChanges');
	var rows = $('#payer_info_student_tab').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
		entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#payerinfoStudentJson").val(entities);
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
function onSelectType(rec){
	var index=$('#payer_info_student_tab').datagrid('getRowIndex',$('#payer_info_student_tab').datagrid('getSelected'));
    var bank = $('#payer_info_student_tab').datagrid('getEditor',{
		index: index,
		field : 'bank'  
	});
    var bankAccount = $('#payer_info_student_tab').datagrid('getEditor',{
		index: index,
		field : 'bankAccount'  
	});
    if(rec.text=="现金"){
    	$(bankAccount.target).textbox({
    	    required: false
    	});
   	   $(bank.target).textbox({
   	    	required: false
   		});
    }else{
    	$(bankAccount.target).textbox({
    	    required: true
    	});
   	   $(bank.target).textbox({
   	    	required: true
   		});
    }
}
function payeeAmountDirStudent(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	
	var rows = $('#payer_info_student_tab').datagrid('getRows');
	var index=$('#payer_info_student_tab').datagrid('getRowIndex',$('#payer_info_student_tab').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsPayee(rows,i);
		}
	}
		$("#payeeAmount").val(num1);
		$("#studentAmount").html(num1+'[元]');
}

//弹出学生明细导入页面
function studentDetailImput(type){
	acceptpayerStudentInfo();
	var win = creatFirstWin('支出明细导入', 500, 200, 'icon-search', '/directlyReimburse/imputDetailJsp?type=student&tabId=payer_info_student_tab');
	win.window('open');
}


function exportStudentDetailMoney(){
	var rows = $('#payer_info_student_tab').datagrid('getRows');
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		num1+=addNumsPayee(rows,i);
	}
		$("#payeeAmount").val(num1);
		$("#studentAmount").html(num1+'[元]');
}
</script>
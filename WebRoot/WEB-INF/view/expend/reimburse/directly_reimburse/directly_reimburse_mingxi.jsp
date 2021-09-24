<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab">
<table id="drmxdg" class="easyui-datagrid"  style="width:660px;height:auto;"
data-options="
toolbar: '#drmxtb',
<c:if test="${!empty bean.drId}">
url: '${base}/directlyReimburse/mingxi?id=${bean.drId}',
</c:if>
<c:if test="${empty bean.drId}">
url: '',
</c:if>
method: 'post',
<c:if test="${empty detail}">
onClickRow: onClickRow,
</c:if>
striped : true,
nowrap : false,
rownumbers:true,
scrollbarSize:0,
singleSelect: true,
">
<thead>
	<tr>
		<th data-options="field:'cId',hidden:true"></th>
		<%-- <th data-options="field:'costDetail',required:'required',align:'center',width:150,editor:{
								editable:true,
								type:'combobox',
								options:{
									valueField:'feName',
									textField:'feName',
									method:'post',
									url:'${base}/ExpenditureMatter/lookupsJsonAll?type=8',
									onSelect:function(item){
													var index=$('#drmxdg').datagrid('getRowIndex',$('#drmxdg').datagrid('getSelected'));
													var tr = $('#drmxdg').datagrid('getEditors', index);
													tr[1].target.textbox('setValue', item.feStandard);
													tr[1].target.textbox('textbox').attr('readonly',true);
												}
								}
							}">支出明细</th> --%>
		<th data-options="field:'costDetail',required:'required',align:'center',width:200,editor:{type:'textbox',options:{precision:2}}">支出明细</th>
		<!-- <th data-options="field:'standard',required:'required',align:'center',width:150,editor:{type:'textbox',options:{precision:2}}">支出标准</th> -->
		<th data-options="field:'applySum',required:'required',align:'center',width:190,editor:{type:'numberbox',options:{onChange:setFsumMoneys,precision:2}}">申请金额</th>
		<th data-options="field:'remark',required:'required',align:'center',width:245,editor:'textbox'">备注</th>
		
	</tr>
</thead>
</table>

</div>

<c:if test="${empty detail}">
<div id="drmxtb" style="height:30px" >
	<%-- <a style="color: red;">申请总额：</a><input style="width: 100px;height:25px;" id="num1" class="easyui-numberbox" value="${bean.amount}" readonly="readonly"/> --%>
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<input type="hidden" id="drMingxiJson" name="mingxi"/>

<script type="text/javascript">
function standardFlag() {
	var row = $('#drmxdg').datagrid('getRows');
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
	var num = 0;
	var index=$('#drmxdg').datagrid('getRowIndex',$('#drmxdg').datagrid('getSelected'));
	var rows = $('#drmxdg').datagrid('getRows');
	var tr = $('#drmxdg').datagrid('getEditors', index);
	var standar= tr[1].target.textbox('getValue');//获得选中行的开支标准
	
	if(parseFloat(newValue)>parseFloat(standar)){
		/* //改变没有通过的字体颜色
		tr[2].target.textbox('textbox').css('color','red'); */
		
		alert('申请金额不能大于开支标准，请核对！');
		tr[2].target.textbox('setValue','0');
		newValue=0;
	}
	
	
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
	$('#num2').val(num.toFixed(2));
	//$('#directlyReimburseAmount').textbox('setValue',num.toFixed(2));
}


//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#drmxdg').datagrid('validateRow', editIndex)) {
		var ed = $('#drmxdg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#drmxdg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#drmxdg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#drmxdg').datagrid('selectRow', editIndex);
		}
	}
}
function append() {
	if (endEditing()) {
		$('#drmxdg').datagrid('appendRow', {});
		editIndex = $('#drmxdg').datagrid('getRows').length - 1;
		$('#drmxdg').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
	}
	/* //页面随滚动条置底
	var div = document.getElementById('easyAcc');
	div.scrollTop = div.scrollHeight; */
}
function removeit() {
	if (editIndex == undefined) {
		return
	}
	$('#drmxdg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#drmxdg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
	}
	$('#num1').textbox('setValue',num.toFixed(2));
	$('#num2').val(num.toFixed(2));
	$('#directlyReimburseAmount').textbox('setValue',num.toFixed(2));
}
function accept() {
	if (endEditing()) {
		$('#drmxdg').datagrid('acceptChanges');
	}
}
</script>


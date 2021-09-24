<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab">
<table id="rmxdg" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
toolbar: '#rmtxb',
<c:if test="${!empty bean.rId}">
url: '${base}/reimburse/mingxi?rId=${bean.rId}',
</c:if>
method: 'post',
<c:if test="${empty detail2}">
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
		<th data-options="field:'costDetail',required:'required',align:'center',width:120">支出明细</th>
		<th data-options="field:'standard',required:'required',align:'center',width:120,">支出标准</th>
		<th data-options="field:'applySum',required:'required',align:'right',width:120,">申请金额[元]</th>
		<th data-options="field:'reimbSum',required:'required',align:'right',width:120,editor:{type:'numberbox',options:{onChange:changeSum,precision:2}}">报销金额[元]</th>
		<th data-options="field:'remark',required:'required',align:'center',width:156,editor:'textbox'">备注</th>
	</tr>
</thead>
</table>
<c:if test="${empty detail2}">
<div id="rmtxb" style="height:30px">
<a style="color: red;">实际报销总额：</a><input style="width: 100px; height:25px;" id="num1" class="easyui-textbox" value="0" readonly="readonly"/>
<a style="color: red;">超出报销金额：</a><input style="width: 100px; height:25px;" id="applyAmount" name="applyAmount" class="easyui-textbox" value="0" readonly="readonly"/>
</div>
</c:if>
<input type="hidden" id="rMingxiJson" name="mingxi"/>
<input type="hidden" id="nums" name="nums" value=""/>
<input type="hidden" id="num3" name="num3" value=""/>
<input type="hidden" id="applyAmount1" name="applyAmount1" value=""/>

</div>

<script type="text/javascript">

//核对报销金额
function changeSum(newValue, oldValue) {
	
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var index=$('#rmxdg').datagrid('getRowIndex',$('#rmxdg').datagrid('getSelected'));
	var rows = $('#rmxdg').datagrid('getRows');
	var num = 0;
	var numb = 0;
	var numc = 0;
	for(var i=0;i<rows.length;i++){
		numc+=addNum3(rows,i);
	}
	for(var j=0;j<rows.length;j++){
		if(j==index){
			num=parseFloat(newValue);
		}else{
			numb+=addNum2(rows,j);
		}  
	}
	numb=(parseFloat(numb)+parseFloat(num));
	numb=parseFloat(numb);
	$('#num1').textbox('setValue',numb);
	$('#nums').val(numb);
	$('#num2').val(numb);
	$('#num3').val(numc);
	$('#reimburseAmount').val(numb);
	if(numb>numc){
		$('#applyAmount').textbox('setValue',numb-numc);
		$('#applyAmount1').val(numb-numc);
	}else{
		$('#applyAmount').textbox('setValue','0');
		$('#applyAmount1').val(0);
	}
}

//未编辑或者已经编辑完毕的行
function addNum2(rows,index){
	
	var reimbSum=rows[index]['reimbSum'];
	if(reimbSum=="" ||reimbSum==null){
		return 0;
	}else{
		return parseFloat(reimbSum);
	}
}
//未编辑或者已经编辑完毕的行
function addNum3(rows,index){
	
	var applySum=rows[index]['applySum'];
	if(applySum=="" ||applySum==null){
		return 0;
	}else{
		return parseFloat(applySum);
	}
}
//加载完以后自动计算金额
$('#rmxdg').datagrid({onLoadSuccess : function(data){
	changeSum(0,0);
}});
//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#rmxdg').datagrid('validateRow', editIndex)) {
		var ed = $('#rmxdg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#rmxdg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#rmxdg').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#rmxdg').datagrid('selectRow', editIndex);
		}
	}
}

function accept() {
	if (endEditing()) {
		$('#rmxdg').datagrid('acceptChanges');
	}
}
</script>


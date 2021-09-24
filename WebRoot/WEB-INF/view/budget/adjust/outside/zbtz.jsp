<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="zbtz" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
toolbar: '#zbtztb',
<c:if test="${!empty bean.aId}">
url: '${base}/outsideAdjust/findIndex?aId='+${bean.aId},
</c:if>
<c:if test="${empty bean.aId}">
url: '${base}/outsideAdjust/findIndex',
</c:if>
method: 'post',
<c:if test="${empty detail}">
onClickRow: onClickCellOutcome,
</c:if>
striped : true,
nowrap : false,
singleSelect: true,
">
<thead>
	<tr>
	<th data-options="field:'biId',hidden:true"></th>
		<th data-options="field:'pid',hidden:true"></th>
		<th data-options="field:'num'" width="5%">序号</th>
		<th data-options="field:'indexName'"  width="17%">预算项目名称</th>
		<th data-options="field:'activity'" width="20%">指标名称</th>
		<th data-options="field:'pfAmount'" width="20%">批复金额[万元]</th>
		<th data-options="field:'syAmount'" width="20%">指标可用金额[万元]</th>
		<th data-options="field:'changeAmount',width:130,editor:{type:'numberbox',options:{onChange:addDc,precision:2}}" width="20%">指标调整金额[万元]</th>
		
	</tr>
</thead>
</table>
<c:if test="${empty detail}">
<div id="zbtztb" style="height:30px">
	<%-- <a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a> --%>
	<a style="color: red;">调整金额：</a><input style="width: 100px;" id="snum" class="easyui-numberbox" value="0" readonly="readonly"/>
	<a href="javascript:void(0)" onclick="Index()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/zbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<!-- 隐藏域  -->
<input type="hidden" id="outsideJson" name="outsideJson"/>
<input type="hidden" id="tzType" name="tzType"/>

<script type="text/javascript">

function addDc(newValue ,oldValue) {
	var num = 0;
	var index=$('#zbtz').datagrid('getRowIndex',$('#zbtz').datagrid('getSelected'));
	var rows = $("#zbtz").datagrid("getRows");
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].changeAmount!="" && rows[i].changeAmount!=null){
				num += parseFloat(rows[i].changeAmount);
			}
		}
	}
	if(newValue!=""){
		num += parseFloat(newValue);
	}
	$('#snum').textbox('setValue',num.toFixed(2));
}
//加载完以后自动计算金额
$('#zbtz').datagrid({onLoadSuccess : function(data){
	addDc("","");
}});
//跳出指标选择页面
function Index() {
	var win = creatFirstWin('指标选择', 860,580, 'icon-search', '/outsideAdjust/index');
	win.window('open');
}

var editIndex_outcome = undefined;
function endEditingOutcome(){
	if (editIndex_outcome == undefined){return true}
	if ($('#zbtz').datagrid('validateRow', editIndex_outcome)){
		$('#zbtz').datagrid('endEdit', editIndex_outcome);
		editIndex_outcome = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellOutcome(index, field){
	if (editIndex_outcome != index){
		if (endEditingOutcome()){
			$('#zbtz').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#zbtz').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_outcome = index;
		} else {
			setTimeout(function(){
				$('#zbtz').datagrid('selectRow', editIndex_outcome);
			},0);
		}
	}
}
</script>
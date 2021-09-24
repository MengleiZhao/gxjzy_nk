<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="zbdr" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
toolbar: '#zbdrtb',
<c:if test="${!empty bean.inId}">
url: '${base}/insideAdjust/findIndex?inId='+${bean.inId}+'&adType=IN',
</c:if>
<c:if test="${empty bean.inId}">
url: '${base}/insideAdjust/findIndex',
</c:if>
method: 'post',
<c:if test="${empty detail}">
onClickRow: onClickCellOutcome2,
</c:if>
striped : true,
nowrap : false,
singleSelect: true,
">
<thead>
	<tr>
		<th data-options="field:'bId',hidden:true"></th>
		<th data-options="field:'pid',hidden:true"></th>
		<th data-options="field:'indexType',hidden:true"></th>
		<th data-options="field:'num',align:'center'" width="7%">序号</th>
		<th data-options="field:'indexName',align:'center'" width="15%">预算项目名称</th>
		<th data-options="field:'activity',align:'center'" width="13%">指标名称</th>
		<th data-options="field:'pfAmount',align:'center'" width="18%">批复金额</th>
		<th data-options="field:'syAmount',align:'center'" width="18%">指标可用金额</th>
		<th data-options="field:'changeAmount',align:'center',editor:{type:'numberbox',options:{onChange:addDr,precision:2}}"  width="18%">指标调增金额</th>
		<th data-options="field:'deptName',align:'center'" width="15%">调增部门</th>
	</tr>
</thead>
</table>
<c:if test="${empty detail}">
<div id="zbdrtb" style="height:30px">
	<a style="color: red;">调增金额：</a><input style="width: 100px;;height: 25px" id="snum2" class="easyui-numberbox" value="0" readonly="readonly"/>
	<a style="color: green;">未分配金额：</a><input style="width: 100px;;height: 25px" id="snum3" class="easyui-numberbox" value="0" readonly="readonly"/>
	<a href="javascript:void(0)" onclick="drIndex();" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/zbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<!-- 隐藏域  -->
<input type="hidden" id="insideDrJson" name="dr"/>
<input type="hidden" id="drType" name="drType"/>

<script type="text/javascript">
function addDr(newValue ,oldValue) {
	var num = 0;
	var index=$('#zbdr').datagrid('getRowIndex',$('#zbdr').datagrid('getSelected'));
	var rows = $('#zbdr').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].changeAmount!="" && rows[i].changeAmount!=null){
				num += parseFloat(rows[i].changeAmount);
			}
		}
	}
	if(newValue!=""&&newValue!=null){
		num += parseFloat(newValue);
		num = parseFloat($('#snum2').textbox('getValue'))-num;
	}
	num = num.toFixed(2);
	if(num<0){
		alert("调入金额超过调出金额，请核对！");
		var editors = $('#zbdr').datagrid('getEditors', index); 
		 var changeAmount = editors[0];    
		 changeAmount.target.numberbox("setValue",0);  
	} else {
		if(newValue=="" && oldValue==""){
			$('#snum3').textbox('setValue',0);
		}else{
			$('#snum3').textbox('setValue',num);
		}
		
	}
}
//加载完以后自动计算金额
$('#zbdr').datagrid({onLoadSuccess : function(data){
	addDr("","");
}});

//跳出指标选择页面
function drIndex() {
	var changeType = $("#changeType").val();
	var indexType = $("#indexType").combobox('getValue');
	if(indexType==''){
		alert('请选择指标类型!');
		return false;
	}
	var isAcrossDept = $("input[name=isAcrossDept]:checked").val();
	var win = creatFirstWin('指标选择', 720,580, 'icon-search', '/insideAdjust/index?type=1&changeType='+changeType+'&isAcrossDept='+isAcrossDept+'&indexType='+indexType);
	win.window('open');
}

var editIndex_outcome2 = undefined;
function endEditingOutcome2(){
	if (editIndex_outcome2 == undefined){return true}
	if ($('#zbdr').datagrid('validateRow', editIndex_outcome2)){
		$('#zbdr').datagrid('endEdit', editIndex_outcome2);
		editIndex_outcome2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellOutcome2(index, field){
	if (editIndex_outcome2 != index){
		if (endEditingOutcome2()){
			$('#zbdr').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#zbdr').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_outcome2 = index;
		} else {
			setTimeout(function(){
				$('#zbdr').datagrid('selectRow', editIndex_outcome2);
			},0);
		}
	}
}
</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="zbdc" class="easyui-datagrid"  style="width:660px;height:auto" data-options="
			toolbar: '#zbdctb',
			<c:if test="${!empty bean.inId}">
			url: '${base}/insideAdjust/findIndex?inId='+${bean.inId}+'&adType=OUT',
			</c:if>
			<c:if test="${empty bean.inId}">
			url: '${base}/insideAdjust/findIndex',
			</c:if>
			method: 'post',
			<c:if test="${empty detail}">
			onClickRow: onClickCellOutcome,
			</c:if>
			striped : true,
			nowrap : false,
			singleSelect: true
">
<thead>
	<tr style="margin-top: 10px">
		<th data-options="field:'bId',hidden:true"></th>
		<th data-options="field:'pid',hidden:true"></th>
		<th data-options="field:'deptCode',hidden:true"></th>
		<th data-options="field:'indexType',hidden:true"></th>
		<th data-options="field:'proUseType',hidden:true"></th>
		<th data-options="field:'num',align:'center'" width="7%">序号</th>
		<th data-options="field:'indexName',align:'center'" width="15%">预算项目名称</th>
		<th data-options="field:'activity',align:'center'" width="13%">指标名称</th>
		<th data-options="field:'pfAmount',align:'center'" width="18%">批复金额</th>
		<th data-options="field:'syAmount',align:'center'" width="18%">指标可用金额</th>
		<th data-options="field:'changeAmount',align:'center',editor:{type:'numberbox',options:{onChange:addDc,precision:2}}" width="18%">指标调减金额</th>
		<th data-options="field:'deptName',align:'center'" width="15%">调减部门</th>
	</tr>
</thead>
</table>
<c:if test="${empty detail}">
<div id="zbdctb" style="height:30px">
<a style="color: red;">调减金额：</a><input style="width: 100px;height: 25px" id="snum1" class="easyui-numberbox" value="0" readonly="readonly"/>
<a href="javascript:void(0)" onclick="dcIndex();" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/zbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<!-- 隐藏域  -->
<input type="hidden" id="insideDcJson" name="dc"/>
<input type="hidden" id="dcType" name="dcType"/>

<script type="text/javascript">

function addDc(newValue ,oldValue) {
	var num = 0;
	var index=$('#zbdc').datagrid('getRowIndex',$('#zbdc').datagrid('getSelected'));
	var rows = $("#zbdc").datagrid("getRows");
	for(var i=0;i<rows.length;i++){
		if(i==index){
			if(newValue>rows[i].syAmount){
				alert("调出金额不能大于剩余金额");
				//获取正在编辑的行
				var editors = $('#zbdc').datagrid('getEditors', index); 
				 var changeAmount = editors[0];    
				 changeAmount.target.numberbox("setValue",0);    
				return false;
			}
		}else{
			if(rows[i].changeAmount!="" && rows[i].changeAmount!=null){
				num += parseFloat(rows[i].changeAmount);
			}
		}
	}
	if(newValue!=""){
		num += parseFloat(newValue);
	}
	$('#snum1').textbox('setValue',num.toFixed(2));
	$('#snum2').textbox('setValue',num.toFixed(2));
	$('#amount').val(num.toFixed(2));
}
//加载完以后自动计算金额
$('#zbdc').datagrid({onLoadSuccess : function(data){
	addDc("","");
	
	setTimeout(function(){
		onLoadSuccessZBDCIndex(data);
	}, 2000);
	;
}});
//跳出指标选择页面
function dcIndex() {
	var changeType = $("#changeType").val();
	var indexType = $("#indexType").combobox('getValue');
	if(indexType==''){
		alert('请选择指标类型!');
		return false;
	}
	var isAcrossDept = $("input[name=isAcrossDept]:checked").val();
	var win = creatFirstWin('指标选择', 720,580, 'icon-search', '/insideAdjust/index?type=0&changeType='+changeType+'&isAcrossDept='+isAcrossDept+'&indexType='+indexType);
	win.window('open');
}

var editIndex_outcome = undefined;
function endEditingOutcome(){
	if (editIndex_outcome == undefined){return true}
	if ($('#zbdc').datagrid('validateRow', editIndex_outcome)){
		$('#zbdc').datagrid('endEdit', editIndex_outcome);
		editIndex_outcome = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellOutcome(index, field){
	if (editIndex_outcome != index){
		if (endEditingOutcome()){
			$('#zbdc').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#zbdc').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_outcome = index;
		} else {
			setTimeout(function(){
				$('#zbdc').datagrid('selectRow', editIndex_outcome);
			},0);
		}
	}
}

function onLoadSuccessZBDCIndex(data){
	if(data.length==0){
		return false;
	}
	var indexType = $("#indexType").combobox('getValue');
	var changeType = $("#changeType").combobox('getValue');
	if(indexType==''){
		alert('请选择指标类型!');
		return false;
	}
	var isAcrossDept = $("input[name=isAcrossDept]:checked").val();
	for(var i=0;i<data.rows.length;i++){
		if(i==0){
			$("#insideDeptId").val(data.rows[0].deptCode);
			$('#check-system-table').load('${base}/insideAdjust/refreshProcessByIdAndType?fpPype='+changeType+'&insideDeptId='+data.rows[0].deptCode+'&isAcrossDept='+isAcrossDept);
			$('#proUseType').val(data.rows[0].proUseType);
		}
	}
}
</script>
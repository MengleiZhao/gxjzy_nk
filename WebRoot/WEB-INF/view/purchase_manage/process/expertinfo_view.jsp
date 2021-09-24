<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="zbtz" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
singleSelect: true,
toolbar: '#zbtztb',
<c:if test="${!empty bean.fbIdId}">
url: '${base}/expertgl/findIndex?fbIdId='+${bean.fbIdId},
</c:if>
<c:if test="${empty bean.fbIdId}">
url: '${base}/expertgl/findIndex',
</c:if>
method: 'post',
<c:if test="${empty detail}">
onClickRow: onClickCellOutcome
</c:if>
">
<thead>
	<tr>
		<th data-options="field:'feId',hidden:true"></th>
		<th data-options="field:'fexpertName',width:70,editor:'textbox'">专家名称</th>
		<th data-options="field:'fidNumber',width:80,editor:'textbox'">身份证号</th>
		<th data-options="field:'ftel',width:90,editor:'textbox'">办公电话</th>
		<th data-options="field:'feducation',width:70,editor:'textbox'">专家学历</th>
		<th data-options="field:'fjobTime',width:70,editor:'textbox'">工作年限</th>
		<th data-options="field:'ffield',width:80,editor:'textbox'">擅长领域</th>
		<th data-options="field:'fhomeAddr',width:100,editor:'textbox'">家庭住址</th>
		<th data-options="field:'fremark',width:100,editor:'textbox'">备注</th>
		
	</tr>
</thead>
</table>
<div id="zbtztb" style="height:30px">
	<%-- <a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
	<!-- <a style="float: right;">&nbsp;&nbsp;</a> -->
	<a href="javascript:void(0)" onclick="checkedExpert()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div> 

<!-- 隐藏域  -->
<input type="hidden" id="eids" name="eids"/>
<input type="hidden" id="tzType" name="tzType"/>

<script type="text/javascript">
	//跳出专家选择页面
	function checkedExpert() {
		var win = creatFirstWin('指标选择', 840, 450, 'icon-search', '/cgbid/index');
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
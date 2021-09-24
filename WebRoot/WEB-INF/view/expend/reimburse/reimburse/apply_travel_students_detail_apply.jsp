<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="tracel_students_tab_apply_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/applyStudentsPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ftsId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fName',width:120,align:'center',editor:{type:'textbox', options:{requerd:true}}">姓名</th>
				<th data-options="field:'fGender',width:150,align:'center',
					editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'1',text:'男'},
	                	{id:'0',text:'女'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false}},formatter:isorno">性别</th>
				<th data-options="field:'fIdentityNumber',width:210,align:'center',editor:{type:'textbox', options:{requerd:true}}">身份证号</th>
				<th data-options="field:'fTel',width:190,align:'center',editor:{type:'numberbox', options:{requerd:true}}">联系电话</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
function isorno(val){
	if(val=='1'){
		return '男';
	}else if(val=='0'){
		return '女';
	}else{
		return '';
	}
}
</script>
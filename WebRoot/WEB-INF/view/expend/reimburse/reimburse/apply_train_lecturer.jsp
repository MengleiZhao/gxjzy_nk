<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="apply_dg_train_lecturer" class="easyui-datagrid" 
	style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rpl',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/trainLecturer?id=${trainingBean.tId}',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
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
				<th data-options="field:'lId',hidden:true"></th>
				<th data-options="field:'lecturerName',width:120,align:'center'">讲师姓名</th>
				<th data-options="field:'fUnit',width:120,align:'center'">工作单位</th>
				<th data-options="field:'lecturerLevel',width:180,align:'center'">职称/职务</th>
				<th data-options="field:'administrationLevel',width:180,align:'center'">行政级别</th>
				<th data-options="field:'fIdentityNumber',width:180,align:'center'">身份证号</th>
				<th data-options="field:'phoneNum',width:120,align:'center'">手机号</th>
				<th data-options="field:'lecturerLevelCode',hidden:true,editor:'textbox'"></th>
				<th data-options="field:'isOutside',width:90,align:'center',formatter:isorno">是否异地</th>
				<th data-options="field:'bank',width:180,align:'center',editor:'textbox'">开户行名称</th>
				<th data-options="field:'bankCard',width:150,align:'center',editor:'textbox'">银行卡号</th>
				<th data-options="field:'administrationLevelCode',hidden:true,width:150,align:'center'">行政级别编号</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return val;
	}
}
</script>
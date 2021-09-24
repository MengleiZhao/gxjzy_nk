<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="apply_dg_train_plan" class="easyui-datagrid" 
	style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/trainPlan?id=${trainingBean.tId}',
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
				<th data-options="field:'planId',hidden:true"></th>
				<th data-options="field:'timeStart',width:130,align:'center',formatter:ChangeDateFormatTrain">培训日期</th>
				<th data-options="field:'startHourMinute',width:130,align:'center'">起始时间</th>
				<th data-options="field:'endHourMinute',width:130,align:'center'">结束时间</th>
				<th data-options="field:'arrange',width:205,align:'center'">培训内容</th>
				<th data-options="field:'lecturerName',width:135,align:'center'">讲师姓名</th>
				<th data-options="field:'lessonTime',width:80,align:'center'">学时</th>
				<th data-options="field:'lecturerNumber',hidden:true,editor:'textbox'">讲师身份证号</th>
			</tr>
		</thead>
	</table>
</div>

	
<script type="text/javascript">

//时间格式化
function ChangeDateFormatTrain(val) {
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
		return "";
	}
	t = new Date(val);
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
</script>
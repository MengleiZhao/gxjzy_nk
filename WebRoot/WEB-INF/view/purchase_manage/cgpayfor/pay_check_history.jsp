<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/cgpayforcheck/history?id=${bean.fpId}',
method: 'post'
">
<thead>
	<tr>
		<th data-options="field:'cId',hidden:true"></th>
		<th data-options="field:'fuserName',width:165">审批人姓名</th>
		<th data-options="field:'fcheckTime',width:165,formatter: ChangeDateFormat">审批时间</th>
		<th data-options="field:'fcheckResult',width:165,formatter:YJ">审批意见</th>
		<th data-options="field:'fcheckRemake',width:165">审批内容</th>
	</tr>
</thead>
</table>

<script type="text/javascript">
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
	var t, y, m, d, h, i, s;
	if (val == null) {
		return "";
	}
	t = new Date(val)
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d)+ ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);;
}

function YJ(val) {
	if(val==0) {
		return "<span style='color:red'>不通过</span>";
	}
	if(val==1) {
		return "<span style='color:green'>通过</span>";
	}
}
</script>

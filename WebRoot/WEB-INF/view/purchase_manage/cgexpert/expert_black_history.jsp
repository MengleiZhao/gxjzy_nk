<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/blackexpertgl/movehistory?id=${ebean.feId}',
method: 'post'
">
<thead>
	<tr>
		<th data-options="field:'feBId',hidden:true"></th>
		<th data-options="field:'fopName',required:'required',align:'center',width:100">操作人</th>
		<th data-options="field:'fblackTime',required:'required',align:'center',width:120,formatter: ChangeDateFormatHistory">操作时间</th>
		<th data-options="field:'fFlag',required:'required',align:'center',width:80,formatter: fflag">操作状态</th>
		<th data-options="field:'fblackDesc',required:'required',align:'center',width:400">原因</th>
	</tr>
</thead>
</table>

<script type="text/javascript">
//时间格式化
function ChangeDateFormatHistory(val) {
	//alert(val)
	var t, y, m, d, h, i, s;
	if (val == null) {
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
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d)+ ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}

function fflag(val) {
	if(val==1){
		return "移出";
	} else if(val==2){
		return "移入";
	}
}
</script>

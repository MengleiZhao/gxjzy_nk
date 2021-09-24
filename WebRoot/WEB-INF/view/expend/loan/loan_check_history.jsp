<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table id="appli-detail-dg" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/checkHistory/history?id=${bean.lId}&type=loan',
method: 'post',
striped : true,
nowrap : false,
rownumbers:true,
scrollbarSize:0,
singleSelect: true,
">
<thead>
	<tr>
		<th data-options="field:'fuserName',required:'required',align:'center',width:150">审批人</th>
		<th data-options="field:'fcheckResult',required:'required',align:'center',width:150,formatter: checkResult">审批结果</th>
		<th data-options="field:'fcheckTime',required:'required',align:'center',width:150,formatter: ChangeDateFormatHistory">审批时间</th>
		<th data-options="field:'fcheckRemake',required:'required',align:'center',width:185">审批内容</th>
	</tr>
</thead>

</table>
<script type="text/javascript">
function checkResult(val,row) {
	if(val==0) {
		return "<span style='color:red'>不通过</span>";
	}
	if(val==1) {
		return "<span style='color:green'>通过</span>";
	}
}

function ChangeDateFormatHistory(val) {
	var t, y, m, d, h, i, s;
    if(val==null){
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}
</script>
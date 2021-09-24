<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/cgreceiveLedger/history?id=${bean.fpId}',
method: 'post'
">
<thead>
	<tr>
		<th data-options="field:'cId',hidden:true"></th>
		<th data-options="field:'facpUser',width:60">验收人</th>
		<th data-options="field:'facpTime',width:100,formatter: ChangeDateFormat">验收时间</th>
		<th data-options="field:'facpAddr',width:100">验收地点</th>
		<th data-options="field:'fqualityIsOk',width:100,formatter:ZL">质量</th>
		<th data-options="field:'fisMatch',width:100,formatter:YJ">验收结果</th>
		<th data-options="field:'fqualityRemark',width:100">质量说明</th>
		<th data-options="field:'fmatchRemark',width:100">验收说明</th>
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
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
 function ZL(val) {
	if(val==1){
		return "合格";
	} else if(val==0){
		return "不合格";
	}
}

function YJ(val) {
	if(val==1){
		return "通过";
	} else if(val==0){
		return "不通过";
	}
} 

</script>

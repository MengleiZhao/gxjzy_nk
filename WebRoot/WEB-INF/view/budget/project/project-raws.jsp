<%@ page language="java" pageEncoding="UTF-8"%>

<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
	<tr>
		<td style="height: 28px;"><span style="color: ff6800">相关制度</span></td>
	</tr>
	<tr>
	<td valign="top">
		<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
	</td>
	</tr>
	<tr>
		<td style="height: 31px;">
			<input class="easyui-textbox" style="width:150px;"
			data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(e){}}]">
		</td>
	</tr>
	<c:forEach items="${cheterInfo}" var="li">
		<tr style="height: 30px;">
			<td>
				<a style="color: #666666" id="file${li.systemId}" href="#" onclick="findSystemFile(${li.systemId})">${li.fileName}</a>
			</td>
		</tr>
	</c:forEach>
</table>




<script type="text/javascript">
//寻找相关制度
function findSystemFile(id) {
	$.ajax({ 
		url: base+"/cheter/systemFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
}
</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table cellpadding="0" cellspacing="0">
	<tr class="trbody">
		<td colspan="3">
			<div style="margin-top: 10px;margin-left: 30px;" id="accessoryCSS11">
			</div>
		</td>
	</tr>
</table>
<script type="text/javascript">
var filesId = '${id}';
$.ajax({
			url: base+ "/project/historyAttaList?id="+filesId+"",
			type : 'post',
			async : false,
			dataType:'json',
		    contentType:'application/json;charset=UTF-8',
			success : function(json) {
				var html = "";
				if(json!=null && json.length>0){
					for( var i=0; i<json.length;i++){
						var originalName = json[i].originalName;
						var id = json[i].id;
						html += "<img src=\"${base}/resource-modality/${themenurl}/list/yulan.png\">";
						html += "&nbsp;&nbsp;<a href=\"#\" onclick=\"downloadFiles('"+id+"')\" style=\"color:#37a4ec\">"+originalName+"</a><br>";
					}
				}
				$("#accessoryCSS11").html(html);
			}
		});
function downloadFiles(id){
	if(id==null){
		alert("没有相关附件！");
		return;
	}
	window.open(base+'/attachment/download/'+id,'open');
}		
</script>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	 .footer{
        width:100%;
        position:absolute;
        bottom:0;
		text-align: center;
    }
</style>
<div class="window-tab" style="margin-left: 0px;margin-top: 10px">
	<table id="check-history-dg" class="easyui-datagrid"  style="width:695px;height:auto"
	data-options="
	<c:if test="${empty foCode}">
	url: '',
	</c:if>
	<c:if test="${!empty foCode}">
	url: '${base}/wflow/history?fpId=${fpId}&foCode=${foCode}',
	</c:if>
	method: 'post'
	">
	<thead>
		<tr>
			<th data-options="field:'fuserName',required:'required',align:'center',width:120">审批人</th>
			<th data-options="field:'fcheckResult',required:'required',align:'center',width:170,formatter: YJ">审批结果</th>
			<th data-options="field:'fcheckTime',required:'required',align:'center',width:180,formatter: ChangeDateFormatIndex">审批时间</th>
			<th data-options="field:'fcheckRemake',required:'required',align:'center',width:130">审批意见</th>
			<th data-options="field:'filesPid',align:'center',resizable:false,sortable:true,formatter:filesshow,width:100" >审批附件</th>
		</tr>
	</thead>
	</table>
	<div id="accessoryCSS" style="display: none;">
		<div id="accessoryCSS1">
		</div>
	</div>
</div>
<script type="text/javascript">
function YJ(val) {
	if(val==1){
		return "通过";
	} else if(val==0){
		return "不通过";
	}
}

function filesshow (val,row){
	if (val=="" || val==null) {
		return '<table><tr style="width: 75px;height:20px"><td><a href="#" class="easyui-linkbutton">无附件' +
			   '</a></td></table>';
	}else if (val!=null) {
		var data = val.split(',');
		if(data.length>0){
			return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="accessory(\''+val+'\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' +
					'</a></td></table>';
		}else {
			return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="downloadFiles(\'' + data[0]+ '\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' +
					'</a></td></table>';
		}
	}
}

function accessory(val){
	$("#accessoryCSS1").empty();
	if($("#accessoryCSS").css("display")=="block"){
		$("#accessoryCSS").css("display","none");
	}else {
		$("#accessoryCSS").css("display","block");
		$.ajax({
			url: base+ "/project/historyAttaList?id="+val+"",
			type : 'post',
			async : true,
			dataType:'json',
		    contentType:'application/json;charset=UTF-8',
			success : function(json) {
				var html = "";
				if(json!=null && json.length>0){
					html += "<div style=\"width:60%;position: relative;margin-left: 20%;background:rgba(255,255,255,1);border:1px solid rgba(217,227,231,1);opacity:1;border-radius:4px;\">";
					html += "<div style=\"width:100%;height:25px;background:rgba(204,204,205,1);opacity:1;border-radius:4px 4px 0px 0px;\"><span style=\"margin-left: 10px;color: black;text-align: center;line-height: 26px\">附件详情</span></div>";
					html += "<table>";
					html += "<tr style=\"width:100%;height:10%\">";
					html += "<td style=\"padding-left:20px;width:70%;line-height: 20px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap\">";
					for( var i=0; i<json.length;i++){
						var originalName = json[i].originalName;
						var id = json[i].id;
							
						html += "<img src=\"${base}/resource-modality/${themenurl}/list/yulan.png\">";
						html += "&nbsp;&nbsp;<a href=\"#\" onclick=\"downloadFiles('"+id+"')\" style=\"color:#37a4ec\">"+originalName+"</a><br>";
					}
					html += "</td>";
					html += "</tr>";
					html += "</table>";
					/* html += "<br><br>";
					html += "<a href=\"#\" onclick=\"accessory()\">";
					html += "<img src=\"${base}/resource-modality/${themenurl}/button/guanbi1.png\" onmouseover=\"this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')\" onmouseout=\"this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')\"/>";
					html += "</a>"; */
					html += "</div>";
				}
				$("#accessoryCSS1").append(html);
			}
		});
	}
	
}

function downloadFiles(id){
	if(id==null){
		alert("没有相关附件！");
		return;
	}
	//window.open(base+'/systemcentergl/viewPDF/'+fileName,'open');
	window.open(base+'/attachment/download/'+id,'open');
}
</script>

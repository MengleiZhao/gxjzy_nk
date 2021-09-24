<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style type="text/css">
.pro_outcome_th {
	width: 210px;
	background: #c1e3f2;
	font-weight: bold;
	color: #333333;
	text-align: center;
}
#pro_outcome_table td{text-align: center;}
.pro_outcome_input{
	width: 210px;
	border: 0;
	background-color: #f6f6f6;
	vertical-align: middle;
}
.accordion .accordion-header {
	height: 20px;
	width: 910px;
}
textarea {
	height: 60px;
	resize:none;
	padding: 8px;
}
.viewShowtd{
	margin-left: 10px;
}
</style>
<body>
	<form id="business_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="easyui-layout"style="border-bottom-color: #ffffff">
			<span style="font-size: 20;margin-left: 350px;margin-top: 50px;">收费项目立项申报表</span>
			<div class="easyui-accordion" data-options="" style="width:922px;margin-left: 20px">
				<div title="基本信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
					<table cellpadding="0" cellspacing="0"  border="1px" style="width: 900px">
						<tr class="trbody">
							<td class="td1-ys">&nbsp;&nbsp;申请单号</td>
							<td class="td2">
								<span class="viewShowtd">${bean.fBusiCode }</span>
							</td>
							<td class="td1-ys">&nbsp;&nbsp;申请部门</td>
							<td class="td2">
								<span class="viewShowtd">${bean.fDeptName }</span>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys">&nbsp;&nbsp;申请人</td>
							<td class="td2">
								<span class="viewShowtd">${bean.fOperatorName }</span>
							</td>
							<td class="td1-ys">&nbsp;&nbsp;申请时间</td>
							<td class="td2">
								<span class="viewShowtd">${bean.fBusiTime }</span>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys">&nbsp;&nbsp;项目名称</td>
							<td colspan="4">
								<span class="viewShowtd">${bean.fProName }</span>
							</td>
						</tr>
						<tr class="trbody">	
							<td class="td1-ys">&nbsp;&nbsp;预计定价</td>
							<td colspan="4">
								<span class="viewShowtd">${bean.fPlanPrice }</span>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys" >&nbsp;&nbsp;申请背景及原因</td>
							<td colspan="4">
								<span class="viewShowtd">${bean.fRemark }</span>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys" >&nbsp;&nbsp;项目实施计划</td>
							<td colspan="4">
								<span class="viewShowtd">${bean.fProPlan }</span>
							</td>
						</tr>
					</table>
				</div>
				<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
					<table id="check-history-dg" class="easyui-datagrid"  style="width:900px;height:auto"
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
								<th data-options="field:'fuserName',required:'required',align:'center',width:'15%'">审批人</th>
								<th data-options="field:'fcheckResult',required:'required',align:'center',width:'15%',formatter: YJ">审批结果</th>
								<th data-options="field:'fcheckTime',required:'required',align:'center',width:'25%',formatter: ChangeDateFormat">审批时间</th>
								<th data-options="field:'fcheckRemake',required:'required',align:'left',width:'26%'">审批意见</th>
								<th data-options="field:'filesPid',align:'center',resizable:false,sortable:true,formatter:filesshow" width="20%">审批附件</th>
							</tr>
						</thead>
					</table>										
				</div>
			</div>
		</div>
	</form>
<script type="text/javascript">
$(function(){
	setTimeout('window.print()',1000);
	 
});
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
</body>
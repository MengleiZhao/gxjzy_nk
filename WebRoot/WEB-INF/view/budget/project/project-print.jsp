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
/* .ystable{border:1px solid #999999;} */
</style>

<body>
<form id="project_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" >
		<div class="easyui-accordion" data-options="" style="width:922px;margin-left: 20px">
			<div title="项目基本信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
				<table cellpadding="0" cellspacing="0" border="1px" style="width: 900px">
					<tr class="trbody">
				   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目编号</td>
				     	<td class="td2"  colspan="4">
				     		<span class="viewShowtd">${bean.FProCode}</span>
				     		<!-- 项目id -->
							<input type="hidden" name="FProId" value="${bean.FProId }"/>
							<input type="text" id="spjlFile" name="spjlFiles" hidden="hidden" >
							<!-- 预算支出类型 -->
							<input type="hidden" id="project_add_FProOrBasic" onchange="FProOrBasicChange(${bean.FProOrBasic})" name="FProOrBasic" value="${bean.FProOrBasic}"/>
				     	</td>
				   	</tr>
					<tr class="trbody">
				   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目名称</td>
				     	<td class="td2" colspan="4">
				     		<span class="viewShowtd">${bean.FProName}</span>
				     	</td>
				   	</tr>
				    <tr class="trbody">
				    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;预算支出类型</td>
				     	<td class="td2">
							<span class="viewShowtd" id="project_add_FProOrBasic_show">
				     	</td>
				     	<td class="td1-ys">部门</td>
				     	<td class="td2" colspan="2">
				     		<span class="viewShowtd">${sbbm}</span>
				     	</td>
				    </tr>
					<tr class="trbody">
						<td class="td1-ys"><span class="style_must">*</span>&nbsp;所属一级名称</td>
				     	<td class="td2">
				     		<span class="viewShowtd">${bean.firstLevelName}</span>
				     	</td>
						<td class="td1-ys"><span class="style_must">*</span>&nbsp;所属一级代码</td>
						<td class="td2">
				     		<span class="viewShowtd">${bean.firstLevelCode }</span>
				     	</td> 
					</tr>
					
					<tr class="trbody">
						<td class="td1-ys"><span class="style_must">*</span>&nbsp;二级名称</td>
				     	<td class="td2">
				     		<span class="viewShowtd">${bean.secondLevelName}</span>
				     	</td>
						<td class="td1-ys"><span class="style_must">*</span>&nbsp;二级代码</td>
						<td class="td2">
				     		<span class="viewShowtd">${bean.secondLevelCode}</span>
				     	</td> 
					</tr>
				    <tr class="trbody">
				    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目预算金额</td>
				     	<td class="td2">
				     		<span class="viewShowtd" id="pro_add_FProBudgetAmount">${bean.FProBudgetAmount}元</span>
				     	</td>
				    	<td class="td1-ys">大写金额</td>
				     	<td class="td2" >
				     		<span style="color: red" class="viewShowtd" id="pro_add_UP_FProBudgetAmount">${bean.provideAmount1}</span>
				     	</td>
				    </tr>
				    <tr class="trbody">
				     	<td class="td1-ys">&nbsp;&nbsp;资金来源</td>
				     	<td class="td2" >
		     				<span class="viewShowtd">${fundsSourceText}</span>
				     	</td>
				     	<td class="td1-ys">&nbsp;&nbsp;开始执行年份</td>
		     			<td class="td2">
		     				<span class="viewShowtd">${bean.planStartYear}年</span>
		     			</td> 
				    </tr>
				    <tr class="trbody">
						<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目申报部门</td>
		     			<td class="td2">
		     				<div ondblclick="">
		     					<span class="viewShowtd">${sbbm }</span>
		     				</div>
		     			</td>
						<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目申报人</td>
		   				<td class="td2">
		   					<span class="viewShowtd">${sbr }</span>
		   				</td>
					</tr>
				    <tr class="trbody">
				     	<td class="td1-ys"><span class="style_must">*</span>&nbsp;立项依据</td>
				     	<td class="td2" colspan="4">
		     				<span class="viewShowtd">${bean.FProAccording }</span>
				     	</td>
				    </tr>
				    <tr class="trbody">
				     	<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目实施方案</td>
				     	<td class="td2" colspan="4">
		     				<span class="viewShowtd">${bean.FExplain }</span>
				     	</td>
				    </tr>
				</table>
			</div>
			<c:if test="${bean.FProOrBasic==1}">
				<div title="项目支出绩效目标" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
					<div>
						<table>
							<tr class="trbody">
						   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;总体目标：</td>
						     	<td class="td2" colspan="4">
						     		<span class="viewShowtd">${bean.totalityDescribe}</span>
								</td>
							</tr>
						</table>
					</div>
					<table id="detail_performance" class="easyui-datagrid" style="width:900px;height:auto"
						data-options="singleSelect: true,rownumbers : true,url: '${base}/project/proIndexList?fProId=${bean.FProId}',
							method: 'post',striped:true, ">
						<thead>
							<tr>
								<th data-options="align:'left',field:'tOneName'" style="width: 34%">一级指标</th>
								<th data-options="align:'left',field:'tTwoName'" style="width: 34%">二级指标</th>
								<th data-options="align:'left',field:'tIndexVal'" style="width: 34%">指标值</th>
							</tr>
						</thead>
					</table>
				</div>
			</c:if>
			<div title="项目支出明细" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
				<table id="pro_outcome_table" style="margin-left: 0px" cellpadding="1" cellspacing="1">
					<tr>
						<th class="pro_outcome_th" style="width: 30px">序号</th>
						<th class="pro_outcome_th">具体业务</th>
						<th class="pro_outcome_th" >经济分类科目</th>
						<th class="pro_outcome_th">支出金额（元）</th>
						<th class="pro_outcome_th">摘要</th>
						<!-- <th class="pro_outcome_th">子活动</th> -->
						<!-- <th class="pro_outcome_th">对子活动的描述</th> -->
					</tr>
					<c:forEach var="i" items="${expDetailList}" varStatus="status">
					<tr>
						<td><textarea disabled="disabled" class="pro_outcome_input" style="width:30px">${status.index+1}</textarea></td>
						<td><textarea disabled="disabled" class="pro_outcome_input">${i.activity}</textarea></td>
						<td><textarea disabled="disabled" class="pro_outcome_input">${i.subName}</textarea></td>
						<td><textarea disabled="disabled" class="pro_outcome_input"><fmt:formatNumber type="number" value="${i.outAmount}" maxFractionDigits="2" /></textarea></td>
						<td><textarea disabled="disabled" class="pro_outcome_input">${i.actDesc}</textarea></td>
						<%-- <td><textarea disabled="disabled" class="pro_outcome_input">${i.sonActivity}</textarea></td> --%>
						<%-- <td><textarea disabled="disabled" class="pro_outcome_input">${i.sonActDesc}</textarea></td> --%>
					</tr>
					</c:forEach>
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
							<th data-options="field:'fproCode',required:'required',align:'center',width:'16%',formatter: proCode">项目编号</th>
							<th data-options="field:'fproName',required:'required',align:'center',width:'15%',formatter: proName">项目名称</th>
							<th data-options="field:'fproHead',required:'required',align:'center',width:'8%',formatter: proHead">项目负责人</th>
							<th data-options="field:'fproAppliDepart',required:'required',align:'center',width:'10%',formatter: proDepart">申报部门</th>
							<th data-options="field:'fuserName',required:'required',align:'center',width:'10%'">审批人</th>
							<th data-options="field:'fcheckResult',required:'required',align:'center',width:'9%',formatter: YJ">审批结果</th>
							<th data-options="field:'fcheckTime',required:'required',align:'center',width:'10%',formatter: ChangeDateFormat">审批时间</th>
							<th data-options="field:'fcheckRemake',required:'required',align:'center',width:'15%'">审批意见</th>
							<th data-options="field:'filesPid',align:'center',resizable:false,sortable:true,formatter:filesshow" width="10%">审批附件</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>    	
	</div>
</form>
<script type="text/javascript">
//页面打印
$(function(){
	 window.print();
});

function validateProjectAdd(stepName){
	if(stepName=='项目基本信息'){
		return validateProjectAddBase();
	} else if(stepName=''){
		
	}
	return true;
}


function onChangeCgjeInput(){
	var sfcg = 	$('input:radio[name="FProcurementYn"]:checked').val();
	/* if(sfcg==0){
		$('#th_cgje').hide();
		$('#td_cgje').hide();
	}else if(sfcg==1){
		$('#th_cgje').show();
		$('#td_cgje').show();
	} */
}
/* function onChangeSfcxxxm(){
	var sfcx = $('input:radio[name="FContinuousYn"]:checked').val();
	if(sfcx==0){
		$('#pro_add_FProRollingCycle').numberbox('setValue','1');
	}else if(sfcx==1){
		$('#pro_add_FProRollingCycle').numberbox('setValue','');
	}
} */


//设置附件信息
function setAccoFile(){
	var s="";
	$(".fileUrl1").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files1").val(s);
}
function setPlanFile(){
	var s="";
	$(".fileUrl2").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files2").val(s);
}
function FProOrBasicChange(newValue,oldValue){
	//隐藏立项依据和项目实施方案
	if(newValue==1){
	//项目支出
		$('.FProAccording').show();
		$('.FExplain').show();
		$('#project_firstLevel').show();
		$('#project_secondLevel').show();
	}
}

$(function(){ 
	$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(${bean.FProBudgetAmount}*10000));
			var proOrBasic = '${bean.FProOrBasic}';
		   	if(proOrBasic==0){
		   	//基本支出
		   		$('.FProAccording').hide();
		   		$('.FExplain').hide();
		   		//$('#fProAccordingId').removeAttr('required');
		   		$('#project_add_FProOrBasic_show').html('基本支出');
		   	}else if(proOrBasic==1){
		   	//项目支出
		   		$('.FProAccording').show();
		   		$('.FExplain').show();
		   		$('#project_add_FProOrBasic_show').html('项目支出');
		   	}
});

//项目编号
function proCode(val,row){
	return '${bean.FProCode}';
}
//项目名称
function proName(val,row){
	return '${bean.FProName}';
}
//项目负责人
function proHead(val,row){
	return '${sbr}';
}
//申报部门
function proDepart(val,row){
	return '${bean.FProAppliDepart}';
}
function YJ(val) {
	if(val==1){
		return "通过";
	} else if(val==0){
		return "不通过";
	}
}

function filesshow (val,row){
	if (val=="" || val==null) {
		return '<table><tr style="width: 75px;height:20px"><td><a href="#" class="easyui-linkbutton">无附件' + '</a></td>'
		+'</table>';
	}else if (val!=null) {
	var data = val.split(',');
		if(data.length>0){
		return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="accessory(\''+val+'\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
				+'</table>';
		}else{
			return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="downloadFiles(\'' + data[0]+ '\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
			+'</table>';
		}
	}
}

function accessory(val){
	$("#accessoryCSS1").empty();
	if($("#accessoryCSS").css("display")=="block"){
		$("#accessoryCSS").css("display","none");
		
	}else{
	$("#accessoryCSS").css("display","block");
	
	$.ajax({
		url: base+ "/project/historyAttaList?id="+val+"",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				if(json!=null&&json.length>0){
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
					html += "<br><br><div class=\"footer\">";
						html += "<a href=\"#\" onclick=\"accessory()\">";
						html += "<img src=\"${base}/resource-modality/${themenurl}/button/guanbi1.png\" onmouseover=\"this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')\" onmouseout=\"this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')\"/>";
						html += "</a>";
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
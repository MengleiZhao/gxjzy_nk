<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search1">
					<%@include file="project-search-base.jsp" %>
				</td>	
				<td align="right" style="padding-right: 10px">
					<a  id='zk' href="#" onclick="zk()">
						<img style="vertical-align:bottom;text-align:left;"  src="${base}/resource-modality/${themenurl}/button/zk.png" >
					</a>
					<a id='sq' hidden="hidden" href="#" onclick="sq()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/sq.png" >
					</a>	
					&nbsp;&nbsp;
					<a href="#" onclick="queryProList('project-essb-table');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearProList('project-essb-table');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<c:if test="${!empty addPro}">
					<a href="#" onclick="addProSecond()">
						<img src="${base}/resource-modality/${themenurl}/button/xmsb1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xmsb2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xmsb1.png')"
						/>
					</a>
					</c:if>
					<c:if test="${settime=='open'}">
						<a href="#" onclick="openSetTimeSecond('${timeid}');">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/pzsj1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</c:if>
				</td>
				
			</tr>
		</table>
	</div>
	
	<div class="list-table2">
		<table id="project-essb-table" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/declare/essbProjectPage',
			pagination:true,scrollbarSize:0,method:'post',fit:true,singleSelect: true,striped: true">
			<thead>
				<tr>
					<th data-options="field:'fproId',hidden:true"></th>
					<th data-options="align:'center',field:'pageOrder'" style="width: 5%">序号</th>
					<th data-options="align:'center',field:'fproCode'" style="width: 15%">项目编号</th>
					<th data-options="align:'center',field:'fproName',formatter:formatCellTooltip" style="width: 15%">项目名称</th>
					<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
					<th data-options="align:'center',field:'planStartYear'" style="width: 5%">预算年度</th>
					<th data-options="align:'center',field:'fproOrBasic',formatter:transitionTypesss" style="width: 6%">支付类型</th>
					<th data-options="align:'right',field:'fproBudgetAmount',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 8%">项目预算金额[元]</th>
					<th data-options="align:'right',field:'provideAmount1',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 8%">项目控制金额[元]</th>
					<th data-options="align:'right',field:'chae',formatter: projectCE" style="width: 8%">差额[元]</th>
					<th data-options="align:'center',field:'fflowStauts',formatter: projectCheckStauts" style="width: 8%">审批状态</th>
					<th data-options="align:'left',field:'fext12',formatter:isEmpty" style="width: 12%">简要说明</th>
					<th data-options="align:'center',field:'cz',formatter:essbCZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div class="list-top" id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
		<table cellpadding="0" cellspacing="0">
		<tr style="height: 30px">
			<td>
				<a style="color: #ff6800">&nbsp;&nbsp;✧操作说明：以上项目预算申报金额超出预算，请重新编制项目支出计划后申报。项目预算申报时间:&nbsp;&nbsp;<fmt:formatDate value="${timebean.addStartTime }" pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;~&nbsp;&nbsp;<fmt:formatDate value="${timebean.addEndTime }" pattern="yyyy-MM-dd HH:mm"/>，请注意申报时间及时申报。</a>
			</td>		
		</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
function openSetTimeSecond (id){
	var win=creatWin('配置时间', 500,430, 'icon-search', '/project/setAddAndCheckTime?id='+id+'&fDataType=2');
	win.window('open');
}
//判断 是否为空
function isEmpty(str){
	if(str==null || str=="null" || str==""){
		return "未填写";
	}
	return str;
}
//二上申报操作
function essbCZ(val, row) {
	if(row.fext4=='21'&&row.fflowStauts!='39'){
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="selectProjectessb('+row.fproId+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a></td>'+'<td style="width: 25px"><a href="#" onclick="project_essb_filesUpdate(' + row.fproId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'+
				'<td style="width: 25px"><a href="#" onclick="reCall(\'project-essb-table\',' + row.fproId+ ',\'/declare/reCall\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">' + '</a></td>'
				+'</table>';
	}if(row.fflowStauts=='39'){
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="selectProjectessb('+row.fproId+')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>'
		+'</table>';
	}else {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="esEditPro('+row.fproId+','+row.fproBudgetAmount+','+row.provideAmount1+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a></td>'+'<td style="width: 25px"><a href="#" onclick="project_essb_filesUpdate(' + row.fproId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
				+'</table>';
	}
}
//点击弹出附件上传的页面
function project_essb_filesUpdate(id){
	var win = creatWin('附件上传', 600, 300, 'icon-search',"/resolve/filesjsp/" + id);
	win.window('open');
	
}
function esEditPro(id,fproBudgetAmount,provideAmount1){
	var win=creatWin('修改-项目信息',1330,630,'icon-search',"/project/esedit/"+id);
	win.window('open');
}
//查看项目信息
function selectProjectessb(id) {
	var win=creatWin('查看-项目信息',1330,630,'icon-search','/project/detail/'+id+'?logType=1');
	win.window('open');
}
function transitionTypesss(val){
	if(val==0){
		return "基本支出";
	}
	if(val==1){
		return "项目支出";
	}
}

//查询
function essbQuery() {
	$('#project-essb-table').datagrid('load', {
		/* FProCode:$('#essb_fproCode').val(), */
		FProName:$('#essb_fproName').val(),
		planStartYear:$('#essb_planStartYear').val(),
		FProOrBasic:$('#essb_FProOrBasic').val()
	});
	var year = new Date().getFullYear()+1;
	var y = $('#essb_planStartYear').numberbox('getValue');
	//当查询日期不等于明年的执行的项目，批量上报按钮隐藏
	if(year != y && y != '') {
		$('#essb-plsb').css('display','none');
	} else {
		$('#essb-plsb').css('display','');
	}
	
}
//项目评审清除查询条件
function essbClear() {
	/* $("#essb_fproCode").textbox('setValue',null); */
	$("#essb_fproName").textbox('setValue',null);
	$("#essb_FProOrBasic").combobox('setValue',null);
	var year = new Date().getFullYear()+1;
	$("#essb_planStartYear").numberbox('setValue',year);
	$('#project-essb-table').datagrid('load',{//清空以后，重新查一次
	});
}


//二上申报申请
function addProSecond(){
	 var win = creatWin('项目信息申报', 1330,630, 'icon-search', '/declare/add?fproOrBasic=1');
	 win.window('open');
}
</script>
</body>
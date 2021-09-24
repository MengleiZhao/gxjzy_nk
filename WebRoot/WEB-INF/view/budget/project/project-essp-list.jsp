<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
				<tr id="essp_top">
					<td class="top-table-search-pro" style="padding-left: 5px;width:675px;">
						<%@include file="project-search-base.jsp" %>
					</td>
					<td align="right" style="padding-right: 10px">
						<a id='zk' href="#" onclick="zk()">
							<img style="vertical-align:bottom;text-align:left;"  src="${base}/resource-modality/${themenurl}/button/zk.png" >
						</a>
						<a id='sq' hidden="hidden" href="#" onclick="sq()">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/sq.png" >
						</a>	
						&nbsp;
						<a href="#" onclick="queryProList('project-essp-table');">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearProList('project-essp-table');">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
 						<a href="#" onclick="esspResult('1')">
							<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="esspResult('0')">
							<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<input type="hidden" id="esspCheckProject"/>
						<input type="hidden" id="esspCheckProjectCode"/>
					</td> 
				</tr>
				<tr id="essp_history_top" style="display: none;">
					<td class="top-table-search-pro">
						<div class="top-table-search-td">
							<!-- &nbsp;&nbsp;支出类型&nbsp;
							<select id="pro_list_query_FProOrBasic2" class="easyui-combobox" data-options="required:true,editable:false" name="FProOrBasic" style="height:25px; width: 150px;">
								<option value="">-请选择-</option>
								<option value="0">基本支出</option>
								<option value="1">项目支出</option>
							</select> -->
							&nbsp;&nbsp;项目编码&nbsp;
							<input id="pro_list_query_FProCode2" style="width: 150px;height:25px;" class="easyui-textbox"/>
							&nbsp;&nbsp;项目名称&nbsp;
							<input id="pro_list_query_FProName2"  style="width: 150px;height:25px;" class="easyui-textbox"/>
							</div>
					</td>	
				 	<td align="right" style="padding-right: 10px">
						&nbsp;
						<a href="#" onclick="queryProList2('essp-checkInfo-table');">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;
						<a href="#" onclick="clearProList2('essp-checkInfo-table');">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
		</table>
	</div>
	
	<div class="list-table-tab2">
		<div class="tab-wrapper" id="essp-tab">
			<ul class="tab-menu">
			    <li class="active"onclick="dataTabESSPClick();">二上审批</li>
				<li  onclick="dataTabESSPHistoryClick();">审批记录</li>
			</ul>
				
				
			<div class="tab-content">
				<div style="height: 410px">
					<table id="project-essp-table" class="easyui-datagrid" 
						data-options="collapsible:true,url:'${base}/declare/esspProjectPage',
						scrollbarSize:0,method:'post',pagination:true,fit:true,singleSelect: false,striped: true">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true" style="width: 2%"></th>
								<th data-options="field:'fproId',hidden:true"></th>
								<th data-options="align:'center',field:'pageOrder'" style="width: 3%">序号</th>
								<th data-options="align:'center',field:'fproCode'" style="width: 10%">项目编号</th>
								<th data-options="align:'center',field:'fproName'" style="width: 11%">项目名称</th>
								<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
								<th data-options="align:'center',field:'planStartYear'" style="width: 10%">预算年度</th>
								<th data-options="align:'center',field:'fproOrBasic',formatter:transitionTypess" style="width: 8%">支付类型</th>
								<th data-options="align:'right',field:'fproBudgetAmount',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">项目预算金额[元]</th>
								<th data-options="align:'right',field:'provideAmount1',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">项目控制金额[元]</th>
								<th data-options="align:'right',field:'chae',formatter: projectCE" style="width: 9%">差额[元]</th>
								<th data-options="align:'center',field:'fflowStauts',formatter: projectCheckStauts" style="width: 8%">审批状态</th>
								<th data-options="align:'center',field:'FExt12'" style="width: 11%">简要说明</th>
								<th data-options="align:'center',field:'cz',formatter:operationEssp" style="width: 8%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div style="height: 410px">
					<table id="essp-checkInfo-table" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/declare/checkInfoPage?type=3',
						method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
							<thead>
								<tr>
									<th data-options="field:'cId',hidden:true"></th>
									<th data-options="align:'center',field:'num'" style="width: 5%">序号</th>
									<th data-options="align:'center',field:'fproCode'" style="width: 15%">项目编号</th>
									<th data-options="align:'center',field:'fproName'" style="width: 20%">项目名称</th>
									<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
									<th data-options="align:'center',field:'fcheckTime',formatter: ChangeDateFormat" style="width: 16%">审批时间</th>
									<th data-options="align:'center',field:'fcheckResult',formatter:ysCheckResult" style="width: 10%">审批结果</th>
									<th data-options="align:'center',field:'fcheckRemake'" style="width: 20%">审批意见</th>
									<th data-options="align:'center',field:'cz',formatter:operationEsspDetail" style="width: 10%">操作</th>
								</tr>
							</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="list-top" id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
		<table cellpadding="0" cellspacing="0">
		<tr style="height: 30px">
			<td>
				<a style="color: #ff6800">&nbsp;&nbsp;✧操作说明：请在左侧复选框中勾选需审批的项目进行审批。审批时间：&nbsp;&nbsp;
				<fmt:formatDate value="${timebean.checkStartTime }" pattern="yyyy-MM-dd HH:mm"/>
				&nbsp;&nbsp;~&nbsp;&nbsp;
				<fmt:formatDate value="${timebean.checkEndTime }" pattern="yyyy-MM-dd HH:mm"/></a>
			</td>		
		</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
//加载tab页
flashtab('essp-tab');

//审批结果
function esspResult(result) {
	var verify = true;
	$.ajax({
		type:'post',
		dataType:'json',
		url:base+'/project/verifyCheckTime', 
		data:{fDataType:2},
		async : false,
		success:function(data){
			verify=data;
		}
	});
	if(!verify){//校验是否 超过审批时间
		alert('不在审批时间，不允许审批！');
		return false;
	}
	if(confirm("是否确认选择结果")){
		//result为1是通过，0是不通过
		var data="";
		var data2="";
		var data3="";
		var checkedItems = $('#project-essp-table').datagrid('getChecked');
		$.each(checkedItems, function(index, item){
		    data += item.fproId + ',';
		    if(index==0){
			    data2 += item.fproName;
			    data3 += item.fproCode;
		    } else {
		    	data2 += ',' + item.fproName;
			    data3 += ',' + item.fproCode;
		    }
	    }); 
		if(data == "") {
			alert("请至少选择一行项目");
		} else {
			$('#esspCheckProject').val(data2);
			$('#esspCheckProjectCode').val(data3);
			var win = creatFirstWin('审批意见', 560, 500, 'icon-search', '/declare/checkRemake?type=essp&result='+result+'&data1='+data);
			win.window('open');
		}
	}
}

//二上审批操作
function operationEssp(val, row){
	var name = '"'+row.fproName+'"';
	var code = '"'+row.fproCode+'"';
	
	var btn = "<table><tr style='width: 105px; height:20px'>";
	var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='verdictEssp("+row.fproId+","+name+","+code+")'>"+
	"<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/check1.png'>"+
	"</a></td>";
	btn = btn + btn1 + "</tr></table>";
	return btn;
}
//二上审批记录操作
function operationEsspDetail(val, row){
	var name = '"'+row.fproName+'"';
	var code = '"'+row.fproCode+'"';
	var btn = "<table><tr style='width: 105px; height:20px'>";
	var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='verdictEsspDetail("+row.proId+","+name+","+code+")'>"+
	"<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"+
	"</a></td>";
	btn = btn + btn1 + "</tr></table>";
	return btn;
}
function verdictEssp(id,name,code){
	$('#esspCheckProject').val(name);
	$('#esspCheckProjectCode').val(code);
	var win=creatWin('二上审批',1330,630,'icon-search',"/declare/verdict2/"+id);
	win.window('open');
}
function verdictEsspDetail(id,name,code){
	$('#esspCheckProject').val(name);
	$('#esspCheckProjectCode').val(code);
	var win=creatWin('项目信息',1330,630,'icon-search',"/project/detail/"+id+"?logType=3&foCode="+code);
	win.window('open');
}


function dataTabESSPClick(){
	$("#project-essp-table").datagrid('reload');
	$("#essp_top").show();
	$("#essp_history_top").hide();
}
function dataTabESSPHistoryClick(){
	$("#essp-checkInfo-table").datagrid('reload');
	$("#essp_top").hide();
	$("#essp_history_top").show();
}

//二上审批
function esspQuery() {
	$('#project-essp-table').datagrid('load', {
		FProCode:$('#essp_fproCode').val(),
		FProName:$('#essp_fproName').val(),
		planStartYear:$('#essp_planStartYear').val(),
		FProOrBasic:$('#essb_FProOrBasic').val()
	});
	
}
//项目评审清除查询条件
function esspClear() {
	$("#essp_fproCode").textbox('setValue',null);
	$("#essp_fproName").textbox('setValue',null);
	$("#essb_FProOrBasic").combobox('setValue',null);
	$("#essp_planStartYear").numberbox('setValue',null);
	$('#project-essp-table').datagrid('load',{//清空以后，重新查一次
	});
}
function transitionTypess(val){
	if(val==0){
		return "基本支出";
	}
	if(val==1){
		return "项目支出";
	}
}
//评审记录
//点击查询
function esspHistoryQuery() {
	//alert($('#apply_time').val());
	$('#essp-checkInfo-table').datagrid('load', {
		/* FProCode:$('#essp_history_fproCode').val(), */
		FProName:$('#essp_history_fproName').val(),
		FProOrBasic:$('#essb_FProOrBasic').val()
	});
}
//清除查询条件
function esspHistoryClear() {
	/* $(".topTable :input[type='text']").each(function(){
		$(this).val("a");
	}); */
	/* $("#essp_history_fproCode").textbox('setValue',null); */
	$("#essp_history_fproName").textbox('setValue',null);
	$("#essb_FProOrBasics").combobox('setValue',null);
	$('#essp-checkInfo-table').datagrid('load',{//清空以后，重新查一次
	});
}
function queryProList2(datagridID){
	$("#"+datagridID).datagrid('load',{
		FProCode2:$('#pro_list_query_FProCode2').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName2').textbox('getValue').trim(),
		//FProOrBasic:$('#pro_list_query_FProOrBasic2').combobox('getValue').trim()=='--请选择--'?'':$('#pro_list_query_FProOrBasic2').combobox('getValue').trim(),
	});
}
function clearProList2(datagridID){
	$('#pro_list_query_FProCode2').textbox('setValue','');
	$('#pro_list_query_FProName2').textbox('setValue','');
	//$('#pro_list_query_FProOrBasic2').combobox('setValue','--请选择--');
	$("#"+datagridID).datagrid('load',{});
}
</script>
</body>

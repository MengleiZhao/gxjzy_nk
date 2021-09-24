<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search1">项目编号&nbsp;
						<input id="yssb_fproCode" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;项目名称
						<input id="yssb_fproName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;项目开始执行年份
						<input id="yssb_planStartYear" name=""  value="${year }" style="width: 150px; height:25px;" class="easyui-numberbox"></input>
						
						&nbsp;&nbsp;<a href="#" onclick="yssbQuery();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="yssbClear();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				
				<td align="right" style="padding-right: 20px">
					<div id="yssb-plsb">
					<a href="#" onclick="yssbChioseReview()">
						<img src="${base}/resource-modality/${themenurl}/button/drsbxm1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="firstUp()">
						<img src="${base}/resource-modality/${themenurl}/button/plsb1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="list-table2">
		<table id="project-yssb-table" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/declare/yssbProjectPage',
			method:'post',fit:true,pagination:false,singleSelect: false,scrollbarSize:0,
			selectOnCheck: true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true" style="width: 2%"></th>
						<th data-options="field:'fproId',hidden:true"></th>
						<th data-options="align:'center',field:'pageOrder'" style="width: 3%">序号</th>
						<th data-options="align:'center',field:'fproCode'" style="width: 10%">项目编号</th>
						<th data-options="align:'center',field:'fproName',formatter: changeProjectColor" style="width: 12%">项目名称</th>
						<th data-options="align:'center',field:'FProHead'" style="width: 10%">项目负责人</th>
						<th data-options="align:'center',field:'fproAppliDepart'" style="width: 10%">申报部门</th>
						<th data-options="align:'center',field:'planStartYear'" style="width: 10%">开始执行年份</th>
						<th data-options="align:'center',field:'fproAppliTime',formatter: ChangeDateFormat" style="width: 10%">申报时间</th>
						<th data-options="align:'right',field:'fproBudgetAmount',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">项目预算[元]</th>
						<th data-options="align:'center',field:'fext4',formatter: declareStauts" style="width: 10%">上报状态</th>
						<th data-options="align:'center',field:'fflowStauts',formatter: projectCheckStauts" style="width: 10%">审批状态</th>
						<th data-options="align:'center',field:'operation',formatter: yssbOperation" style="width: 10%">操作</th>
					</tr>
				</thead>
		</table>
	</div>
	
	<div class="list-top" id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
		<table cellpadding="0" cellspacing="0">
		<tr style="height: 30px">
			<td>
				<a style="color: #ff6800">&nbsp;&nbsp;✧操作说明：请在左侧复选框中勾选需上报的项目进行批量上报。</a>
			</td>		
		</tr>
		</table>
	</div>
</div>

<script type="text/javascript">
/* //分页样式调整
$(function(){
	var pager = $('#project-yssb-table').datagrid().datagrid('getPager');
	pager.pagination({layout:['sep','first','prev','links','next','last']});			
}); */

//项目名称颜色变化
function changeProjectColor(val ,row) {
	var value = row.fext4;
	if(value=='11' || value=='21') {
		return '<a style="color:#4fba7a;font-weight: bold;">'+ val + '</a>';
	} else {
		return val;
	}
}


//一上申报操作
function yssbOperation(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	   '<a href="#" onclick="selectProject(' + row.fproId + ')" class="easyui-linkbutton">'+
	   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	   '</a></td></tr></table>';
}

function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}

//查看项目信息
function selectProject(id) {
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+id+'?logType=2');
	win.window('open');
}



//一上批量上报
function firstUp() {
	var data1="";
	var data3="下列项目您已上报过，无需重复上报"+ '\n';
	var num = 0;
	var checkedItems = $('#project-yssb-table').datagrid('getChecked');
	$.each(checkedItems, function(index, item){
		//只有没有上报状态的才可以上报
		if(item.fext4 == '10'){
	    	data1 += item.fproId + ',';
		} else {
			data3 += item.fproName + '\n';
			num += 1;
		};
    }); 
	
	/* var data2="";
	var checkedItems = $('#project-yssb-table').datagrid('getRows');
	$.each(checkedItems, function(index, item){
    	data2 +=item.fproId + ',';
    });  */
	
	if(data1=="" && num==0) {
		alert("您尚未选择项目，请至少选择一行。");
	} else if(data1=="" && num!=0) {
		alert(data3+"请至少选择一行备选待定的项目。");
	} else if(num!=0) {
		if(confirm("是否确认上报")){
			alert(data3+"本次系统已为您智能过滤重复项目，请放心提交！");
			$.ajax({ 
				type: 'POST', 
				url: base+'/declare/yssb?fproIdLi='+data1,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#project-yssb-table").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			});
		}
	} else {
		if(confirm("是否确认上报")){
			$.ajax({ 
				type: 'POST', 
				url: base+'/declare/yssb?fproIdLi='+data1,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#project-yssb-table").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			});
		}
	}
}

//查询
function yssbQuery() {
	$('#project-yssb-table').datagrid('load', {
		FProCode:$('#yssb_fproCode').val(),
		FProName:$('#yssb_fproName').val(),
		planStartYear:$('#yssb_planStartYear').val()
	});
	var year = new Date().getFullYear()+1;
	var y = $('#yssb_planStartYear').numberbox('getValue');
	//当查询日期不等于明年的执行的项目，批量上报按钮隐藏
	if(year != y && y != '') {
		$('#yssb-plsb').css('display','none');
	} else {
		$('#yssb-plsb').css('display','');
	}
	
}
//项目评审清除查询条件
function yssbClear() {
	$("#yssb_fproCode").textbox('setValue',null);
	$("#yssb_fproName").textbox('setValue',null);
	var year = new Date().getFullYear()+1;
	$("#yssb_planStartYear").numberbox('setValue',year);
	$('#project-yssb-table').datagrid('load',{//清空以后，重新查一次
	});
}

//选择评审项目
function yssbChioseReview() {
	var win=creatWin('项目选择',970,580,'icon-search','/projectReview/chiose?type=yssb');
	win.window('open');
}
</script>

</body>

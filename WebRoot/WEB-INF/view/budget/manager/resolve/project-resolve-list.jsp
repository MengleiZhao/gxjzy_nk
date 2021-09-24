<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="project_resolve_top1">
				<td class="top-table-search-pro" class="queryth" style="width:90%">
					&nbsp;&nbsp;预算年份&nbsp;
					<input id="pro_resolve_list_query_planStartYear_1" value="${year}" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					&nbsp;&nbsp;项目编号&nbsp;
					<input id="pro_resolve_list_query_fproCode_1" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;项目名称&nbsp;
					<input id="pro_resolve_list_query_fproName_1" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;支出类型&nbsp;
					<select id="pro_resolve_list_query__FProOrBasic_1" class="easyui-combobox" data-options="required:true,editable:false" name="FProOrBasic" style="height:25px; width: 150px;">
     					<option value="">-请选择-</option>
     					<option value="0">基本支出</option>
     					<option value="1">项目支出</option>
     				</select>
					&nbsp;&nbsp;
					<a href="#" onclick="queryProResolveList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearProResolveList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="javascript:void(0)" onclick="saveProjectResolve()">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
			<tr id="project_resolve_top2" style="display: none">
				<td class="top-table-search-pro" class="queryth">
					&nbsp;&nbsp;预算年份&nbsp;
					<input id="pro_resolve_list_query_planStartYear_2" value="${year}" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					&nbsp;&nbsp;项目编号&nbsp;
					<input id="pro_resolve_list_query_fproCode_2" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;项目名称&nbsp;
					<input id="pro_resolve_list_query_fproName_2" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;支出类型&nbsp;
					<select id="pro_resolve_list_query__FProOrBasic_2" class="easyui-combobox" data-options="required:true,editable:false"  style="height:25px; width: 150px;">
     					<option value="">-请选择-</option>
     					<option value="0">基本支出</option>
     					<option value="1">项目支出</option>
     				</select>
					&nbsp;&nbsp;
					<a href="#" onclick="queryProResolveList(2);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearProResolveList(2);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
		</table>
	</div>

	<div class="list-table-tab2">
		<div class="tab-wrapper" id="yx-tab">
			<ul class="tab-menu">
				<li class="active" onclick="projectResolveTop1Click();">待分解项目</li>
			    <li onclick="projectResolveTop2Click();editProjectResolveIndex = undefined;">已分解项目</li>
			</ul>
				
				
			<div class="tab-content">
				<div style="height: 410px">
					<table id="project-resolve-table1" class="easyui-datagrid" 
						data-options="collapsible:true,url:'${base}/resolve/projectPage?type=0',onLoadSuccess:projectZE,
						onClickRow: onClickProjectResolveRow,scrollbarSize:0,method:'post',fit:true,singleSelect: false,striped: true,onSelect:onSelectIndex">
							<thead>
								<tr>
									<th data-options="field:'ck',checkbox:true" style="width: 2%"></th>
									<th data-options="field:'fproId',hidden:true"></th>
									<th data-options="align:'center',field:'pageOrder'" style="width: 5%">序号</th>
									<th data-options="align:'center',field:'fproCode'" style="width: 10%">项目编号</th>
									<th data-options="align:'center',field:'fproName',formatter:mouseTooltip" style="width: 15%">项目名称</th>
									<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
									<th data-options="field:'fproOrBasic',align:'center',formatter:transitionTypes" style="width: 10%">支出类型</th>
									<th data-options="align:'center',field:'planStartYear'" style="width: 5%">预算年度</th>
									<th data-options="align:'center',field:'fproBudgetAmount',options:{precision:2}" style="width: 10%">项目预算金额[元]</th>
									<th data-options="align:'center',field:'provideAmount1',required:'required',editor:{type:'numberbox',options:{onChange:kzsChanges,precision:2}},
									styler: function (value, row, index) { return 'background-color:#CEECC8;color:red;font-weight:bold;border-bottom:1px solid white';}" style="width: 10%">项目控制金额[元]</th>
									<th data-options="align:'center',field:'chae',formatter: projectCE,editor:{type:'numberbox',options:{precision:2}}" style="width: 10%">差额[元]</th>
									<th data-options="align:'center',field:'fext12',formatter:isEmpty,editor:{type:'textbox'}" style="width: 12%">简要说明</th>
									<th data-options="align:'center',field:'ysCZ',formatter:filesUpdate1" style="width: 8%">操作</th>
								</tr>
							</thead>
					</table>
				</div>
				
				<div style="height: 410px">
					<table id="project-resolve-table2" class="easyui-datagrid" 
						data-options="collapsible:true,url:'${base}/resolve/projectPage?type=1',
						scrollbarSize:0,method:'post',fit:true,singleSelect: true,striped: true">
							<thead>
								<tr>
									<th data-options="field:'fproId',hidden:true"></th>
									<th data-options="align:'center',field:'pageOrder'" style="width: 5%">序号</th>
									<th data-options="align:'center',field:'fproCode'" style="width: 10%">项目编号</th>
									<th data-options="align:'center',field:'fproName',formatter:mouseTooltip" style="width: 15%">项目名称</th>
										<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
									<th data-options="field:'fproOrBasic',align:'center',formatter:transitionTypes" style="width: 10%">支出类型</th>
									<th data-options="align:'center',field:'planStartYear'" style="width: 5%">预算年度</th>
									<th data-options="align:'center',field:'fproBudgetAmount',options:{precision:2}" style="width: 10%">项目预算金额[元]</th>
									<th data-options="align:'center',field:'provideAmount1',options:{precision:2}" style="width: 10%">项目控制金额[元]</th>
									<th data-options="align:'center',field:'chae',formatter: projectCE,options:{precision:2}" style="width: 10%">差额[元]</th>
									<th data-options="align:'center',field:'fext12',formatter:isEmpty" style="width: 22%">简要说明</th>
									<th data-options="align:'center',field:'ysCZ',formatter:filesUpdate2" style="width: 8%">操作</th>
								</tr>
							</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="list-top" id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
		<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr style="height: 30px">
			<td>
				<a style="color: #ff6800">&nbsp;&nbsp;✧操作说明：请填写项目控制金额后保存提交。</a>
			</td>		
			<td align="right" style="padding-right: 10px">
				&nbsp;&nbsp;项目预算总额：<a id="project-ze-amount" style="color:#ff5454">0.00</a>元&nbsp;&nbsp;
				&nbsp;&nbsp;项目控制总额：<a id="project-kz-amount" style="color:#ff5454">0.00</a>元&nbsp;&nbsp;
				&nbsp;&nbsp;差额：<a id="project-ce-amount" style="color:#ff5454">0.00</a>元&nbsp;&nbsp;
			</td>		
		</tr>
		</table>
	</div>

	<!-- 控制数分解内容提交表单 -->
	<form id="project-resolve-form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<input type="hidden" id="project-resolve-id" name="fproId"/>
		<input type="hidden" id="project-resolve-provideAmount1" name="provideAmount1"/>
		<input type="hidden" id="project-resolve-fext12" name="fext12"/>
	</form>
</div>
<script type="text/javascript">
//加载tab页
flashtab('yx-tab');

var editProjectResolveIndex = undefined;
function endProjectResolveEditing() {
	if (editProjectResolveIndex == undefined) {
		return true;
	}
	if ($('#project-resolve-table1').datagrid('validateRow', editProjectResolveIndex)) {
		$('#project-resolve-table1').datagrid('endEdit', editProjectResolveIndex);
		editProjectResolveIndex = undefined;
		return true;
	} else {
		return false;
	}
}

var editProjectResolveIndexs = undefined;
function onSelectIndex(rowIndex, rowData){
	editProjectResolveIndexs = rowIndex;
}
function onClickProjectResolveRow(index) {
	if (editProjectResolveIndex != index) {
		if (endProjectResolveEditing()) {
			$('#project-resolve-table1').datagrid('selectRow', index).datagrid('beginEdit',index);
			editProjectResolveIndex = index;
		} else {
			$('#project-resolve-table1').datagrid('selectRow', editProjectResolveIndex);
		}
	}
}


//控制数改变触发函数
function kzsChanges(newVal, oldVal) {
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	var rows = $('#project-resolve-table1').datagrid('getRows');
	var index=editProjectResolveIndexs;
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
			
		    var tr = $('#project-resolve-table1').datagrid('getEditors', index);
			tr[1].target.numberbox('setValue', newVal-rows[i].fproBudgetAmount);
		}else{
			num1+=addNumsKZS(rows,i);
		}
	}
	//页面项目控制总额
	$('#project-kz-amount').html(num1.toFixed(2));
	//页面差额
	var n1 = $('#project-kz-amount').html();
	var n2 = $('#project-ze-amount').html();
	var numCe = parseFloat(n1-n2).toFixed(4);
	$('#project-ce-amount').html(numCe);
	
}
function addNumsKZS(rows,index){
	var num=0;
	if(rows[index].provideAmount1!=''&&rows[index].provideAmount1!='NaN'&&rows[index].provideAmount1!=undefined){
		num = parseFloat(rows[index].provideAmount1);
	}else{
		num =0;
	}
	return num;
}
//控制数改变触发函数
function kzsChange(newVal, oldVal) {
	var num = 0;
	var index=$('#project-resolve-table1').datagrid('getRowIndex',$('#project-resolve-table1').datagrid('getSelected'));
	var rows = $('#project-resolve-table1').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].provideAmount1!=null && rows[i].provideAmount1!=""){
				num += parseFloat(rows[i].provideAmount1);
			}
		}
	}
	if(newVal != null && newVal != "") {
		num += parseFloat(newVal);
	}else {
		var tr = $('#project-resolve-table1').datagrid('getEditors', index);
		tr[0].target.textbox('setValue', 0);
	}
	//页面项目控制总额
	$('#project-kz-amount').html(num.toFixed(2));
	//页面差额
	var n1 = $('#project-kz-amount').html();
	var n2 = $('#project-ze-amount').html();
	var numCe = parseFloat(n1-n2).toFixed(4);
	$('#project-ce-amount').html(numCe);
	
	var rows = $('#project-resolve-table1').datagrid('getRows');
	//$('#project-resolve-table1').datagrid('acceptChanges')
	for (var i=0; i<rows.length; ++i) {
		//alert(2)
		rows[i].chae = numCe;
	}
}

//控制数分解保存
function saveProjectResolve() {
	var checkedItems = $('#project-resolve-table1').datagrid('getChecked');
	if(checkedItems.length<=0) {
		alert('请至少填写一行信息');
		return;
	}
	
	
	if(confirm("保存后将无法修改，是否确认保存")){
		if (endProjectResolveEditing()) {
			$('#project-resolve-table1').datagrid('acceptChanges');
		}
		var data1="";
		var data2="";
		var data3="";
		$.each(checkedItems, function(index, item){
			if(item.fext4 == '11'){
		    	data1 += item.fproId + ',';
		    	if(item.provideAmount1==null||item.provideAmount1=="") {
		    		data2 += 0 +',';
		    	} else {
		    		data2 += item.provideAmount1 + ',';
		    	}
		    	data3 += item.fext12 + ',';
			}
	    }); 
		$('#project-resolve-id').val(data1);
		$('#project-resolve-provideAmount1').val(data2);
		$('#project-resolve-fext12').val(data3);
		
		//提交
		$('#project-resolve-form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/resolve/projectResolve',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#project-resolve-table1').datagrid('load');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
				
			}
		}); 
	}
}
function filesUpdate1(val, row){
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="project_filesUpdate1(' + row.fproId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + 
			'</a></td>'+
			'<td><a href="#" onclick="detailResolvePro('+row.fproId+')"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png"></td>'
			+'</tr></table>';
}
function filesUpdate2(val, row){
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="project_filesUpdate2(' + row.fproId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + 
			'</a></td>'+
			'<td><a href="#" onclick="detailResolvePro('+row.fproId+')"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png"></td>'
			+'</tr></table>';
}
//点击弹出附件上传的页面
function project_filesUpdate1(id){
	var win = creatWin('附件上传', 600, 300, 'icon-search',"/resolve/filesjsp/" + id+"?type=1");
	win.window('open');
	
}
function project_filesUpdate2(id){
	var win = creatWin('附件上传', 600, 300, 'icon-search',"/resolve/filesjsp/" + id);
	win.window('open');
	
}
function detailResolvePro(proId){
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+proId);
	win.window('open');
}

//加载时差额计算见nkgl.js

//
function projectZE(){
	var sum1=0;
	var sum2=0;
	var rows = $('#project-resolve-table1').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		sum1 += parseFloat(rows[i].fproBudgetAmount);
		sum2 += parseFloat(rows[i].provideAmount1);
	}
	$('#project-ze-amount').html(sum1.toFixed(2));
	$('#project-kz-amount').html(sum2.toFixed(2));
}

//点击查询
function queryProResolveList(type) {
	console.log($("#pro_resolve_list_query__FProOrBasic_1").combobox('getValue'))
	if(type==1){
		$("#project-resolve-table1").datagrid('load',{
			planStartYear:$("#pro_resolve_list_query_planStartYear_1").textbox('getValue').trim(),
			FProCode:$("#pro_resolve_list_query_fproCode_1").textbox('getValue').trim(),
			FProName:$("#pro_resolve_list_query_fproName_1").textbox('getValue').trim(),
			FProOrBasic:$("#pro_resolve_list_query__FProOrBasic_1").combobox('getValue').trim(),
		});
	}
	if(type==2){
		$("#project-resolve-table2").datagrid('load',{
			planStartYear:$("#pro_resolve_list_query_planStartYear_2").textbox('getValue').trim(),
			FProCode:$("#pro_resolve_list_query_fproCode_2").textbox('getValue').trim(),
			FProName:$("#pro_resolve_list_query_fproName_2").textbox('getValue').trim(),
			FProOrBasic:$("#pro_resolve_list_query__FProOrBasic_2").combobox('getValue').trim(),
		});
	}
}

//清除查询条件
function clearProResolveList(type) {
	if(type==1){
		$("#pro_resolve_list_query_planStartYear_1").textbox('setValue','');//项目执行年份
		$("#pro_resolve_list_query_fproCode_1").textbox('setValue','');//项目编号
		$("#pro_resolve_list_query_fproName_1").textbox('setValue','');//项目名称
		$("#pro_resolve_list_query__FProOrBasic_1").combobox('setValue','');//支出类型
		$("#project-resolve-table1").datagrid('load',{});
	}
	if(type==2){
		$("#pro_resolve_list_query_planStartYear_2").textbox('setValue','');//项目执行年份
		$("#pro_resolve_list_query_fproCode_2").textbox('setValue','');//项目编号
		$("#pro_resolve_list_query_fproName_2").textbox('setValue','');//项目名称
		$("#pro_resolve_list_query__FProOrBasic_2").combobox('setValue','');//支出类型
		
		$("#project-resolve-table2").datagrid('load',{});
	}
}

function projectResolveTop1Click() {
	$("#project-resolve-table1").datagrid('reload');
	
	$("#project_resolve_top1").show();
	$("#project_resolve_bottom").show();
	$("#project_resolve_top2").hide();
}

function projectResolveTop2Click() {
	$("#project-resolve-table2").datagrid('reload');
	
	$("#project_resolve_top1").hide();
	$("#project_resolve_bottom").hide();
	$("#project_resolve_top2").show();
}
//判断 简要说明 是否为空
function isEmpty(str){
	if(str==null || str=="null" || str==""){
		return "未填写";
	}
	return str;
}
//鼠标悬浮单元格提示信息  
function mouseTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
} 
function transitionTypes(val){
	if(val==0){
		return "基本支出";
	}
	if(val==1){
		return "项目支出";
	}
}
</script>
</body>
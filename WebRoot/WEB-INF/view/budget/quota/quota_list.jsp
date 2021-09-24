<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro" id="quota_list_top1" style="width: 75%">
					<!-- &nbsp;&nbsp;预算指标编码&nbsp;
					<input id="quota_list_query_indexCode_1" style="width: 150px;height:25px;" class="easyui-numberbox"/> -->
					
					&nbsp;&nbsp;预算指标名称&nbsp;
					<input id="quota_list_query_indexName_1" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;使用部门&nbsp;
					<input id="quota_list_query_deptName_1" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;生成状态&nbsp;
					<select id="quota_list_query_stauts_1" style="width: 150px;height:25px;" class="easyui-combobox" data-options="required:false,editable:false" >
     					<option value="">-请选择-</option>
     					<option value="0">未生成</option>
     					<option value="1">已生成</option>
     				</select>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryQuotaList(0);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearQuotaList(0);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td class="top-table-search-pro" id="quota_list_top2" style="display: none;width: 75%">
					<!-- &nbsp;&nbsp;预算指标编码&nbsp;
					<input id="quota_list_query_indexCode_2" style="width: 150px;height:25px;" class="easyui-numberbox"/> -->
					
					&nbsp;&nbsp;预算指标名称&nbsp;
					<input id="quota_list_query_indexName_2" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;使用部门&nbsp;
					<input id="quota_list_query_deptName_2" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;生成状态&nbsp;
					<select id="quota_list_query_stauts_2" style="width: 150px;height:25px;" class="easyui-combobox" data-options="required:false,editable:false" >
     					<option value="">-请选择-</option>
     					<option value="0">未生成</option>
     					<option value="1">已生成</option>
     				</select>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryQuotaList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearQuotaList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" id="index-create" onclick="shengcheng()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shengcheng1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
					<%-- <a href="${base}/quota/download" id="index-download">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/mbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
				
					<a href="#" id="index-imput" onclick="imput()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a> 
				
					<a href="#" id="index-add" onclick="add()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a> --%>
				</td>
			</tr>
		</table>   
	</div>


	
	<div class="list-table-tab">
		<div class="tab-wrapper" id="quota-tab">
			<ul class="tab-menu">
				<li class="active" onclick="reloadbasic()">基本支出</li>
		    	<li onclick="reloadpro()">项目支出</li>
			</ul>
		  
			<div class="tab-content">
				<div style="height: 440px">
					<table id="basicIndex" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/quota/indexPage?indexType=0',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'center'" style="width: 15%">预算指标编码</th>
								<th data-options="field:'indexName',align:'center'" style="width: 15%">预算指标名称</th>
								<th data-options="field:'pfzAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">指标批复总额[元]</th>
								<th data-options="field:'deptName',align:'center'" style="width: 10%">使用部门</th>
								<th data-options="field:'pfAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">部门批复金额[元]</th>
								<th data-options="field:'appDate',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 14%">批复日期</th>
								<th data-options="field:'stauts',align:'center',formatter: indexStauts" style="width: 10%">指标状态</th>
								<th data-options="field:'cz',align:'center',formatter: cz" style="width: 10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
			   	<div style="height: 440px">
				    <table id="proIndex" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/quota/indexPage?indexType=1',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
						<thead>
							<tr>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'center'" style="width: 15%">预算指标编码</th>
								<th data-options="field:'indexName',align:'center'" style="width: 22%">预算指标名称</th>
								<th data-options="field:'ysAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">指标预算金额[元]</th>
								<th data-options="field:'deptName',align:'center'" style="width: 10%">使用部门</th>
								<th data-options="field:'appDate',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 14%">批复日期</th>
								<th data-options="field:'stauts',align:'center',formatter: indexStauts" style="width: 10%">指标状态</th>
								<th data-options="field:'cz',align:'center',formatter: cz" style="width: 10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		
		</div>
	</div>
</div>


<script type="text/javascript">
flashtab("quota-tab");

//分页样式调整
$(function(){
	var pager = $('#basicIndex').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});	
	
	var pager2 = $('#proIndex').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager2.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});


//指标状态设置
function indexStauts(val, row) {
	if(val==0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未生成" + '</a>';
	} else if(val==1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已生成" + '</a>';
	} else {
		return null;
	}
}

function cz(val, row) {
	var indexType=row.indexType;
	var stauts = row.stauts;
	if(indexType==0){	//基本支出
		/* if(stauts==0) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="edit(' + row.bId + ',0)" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="edit(' + row.bId + ',1)" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteIndex(' + row.bId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
		} else if(stauts==1) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="edit(' + row.bId + ',0)" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
		} */
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="edit(' + row.bId + ',0)" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td></tr></table>';
	}else if(indexType==1){	//项目支出
		if(stauts==0) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="edit(' + row.bId + ',0)" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				/* '<a href="#" onclick="deleteIndex(' + row.bId + ',0)" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+ */
				'</a></td></tr></table>';
		} else if(stauts==1) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="edit(' + row.bId + ',0)" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
		}
	}
}

//基本支出指标导入
function imput() {
	var win = creatWin('基本支出指标导入', 500, 200, 'icon-search', '/quota/imput');
	win.window('open');
}

//新增指标
function add() {
	var win = creatWin('支出指标新增', 766, 580, 'icon-search', '/quota/add?type='+type);
	win.window('open');
}

//修改指标
function edit(id,editType) {
	/*type为修改或查看1位修改，0位查看  */
	if(editType==1){
		var win = creatWin('支出指标修改', 706, 580, 'icon-search', '/quota/edit?id='+ id+'&editType='+editType);
		win.window('open');
	} else {
		var win = creatWin('支出指标查看', 706, 580, 'icon-search', '/quota/edit?id='+ id+'&editType='+editType);
		win.window('open');
	}
}
function deleteIndex(id){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/quota/delete?bId='+id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$("#basicIndex").datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		});
	}
}
//指标生成
function shengcheng() {
	var data="";
	var chongfuflag=0;
	if(type==0) {
		var checkedItems = $('#basicIndex').datagrid('getChecked');
		 $.each(checkedItems, function(index, item){
			 if(item.stauts==1){
				 alert(item.indexName+"指标已经生成，请不要重复生成");
				 chongfuflag=1;
				 return false;
			 }
       	  data +=item.bId + ',';
         });   
	}
	if(type==1) {
		var checkedItems = $('#proIndex').datagrid('getChecked');
		 $.each(checkedItems, function(index, item){
			 if(item.stauts==1){
				 alert(item.indexName+"指标已经生成，请不要重复选生成");
				 chongfuflag=1;
				 return false;
			 }
       	  data +=item.bId + ',';
         });   
	}
	if(chongfuflag==1){
		return false;
	}
	if(data==""){
		alert("请选择生成的指标");
		return false;
	}
	$.ajax({ 
		type: 'POST', 
		url: base+'/quota/generate?fproIdLi='+data,
		dataType: 'json',  
		success: function(data){ 
			if(data.success){
				$.messager.alert('系统提示',data.info,'info');
				$("#basicIndex").datagrid('reload');
				$("#proIndex").datagrid('reload');
			}else{
				$.messager.alert('系统提示',data.info,'error');
			}
		} 
	});
}

//type为指标类型0为基本1为项目
var type=0;
function reloadbasic() {
	//显示导入按钮支持基本指标导入
	$('#index-imput').css('display','');
	$('#index-add').css('display','');
	$('#index-download').css('display','');
	$('#index-create').css('display','');
	
	$('#basicIndex').datagrid('reload');
	type=0;
	
	$("#quota_list_top1").show();
	$("#quota_list_top2").hide();
}
function reloadpro() {
	//隐藏导入按钮
	$('#index-imput').css('display','none');
	$('#index-add').css('display','none');
	$('#index-download').css('display','none');
	//$('#index-create').css('display','none');
	
	$('#proIndex').datagrid('reload');
	type=1;
	
	$("#quota_list_top1").hide();
	$("#quota_list_top2").show();
}

//查询
function queryQuotaList(type) {
	if(type=="0"){
		$("#basicIndex").datagrid('load',{
			/* indexCode:$("#quota_list_query_indexCode_1").textbox('getValue').trim(), */
			indexName:$("#quota_list_query_indexName_1").textbox('getValue').trim(),
			deptName:$("#quota_list_query_deptName_1").textbox('getValue').trim(),
			stauts:$("#quota_list_query_stauts_1").combobox('getValue').trim(),
		});
	}
	if(type=="1"){
		$("#proIndex").datagrid('load',{
			/* indexCode:$("#quota_list_query_indexCode_2").textbox('getValue').trim(), */
			indexName:$("#quota_list_query_indexName_2").textbox('getValue').trim(),
			deptName:$("#quota_list_query_deptName_2").textbox('getValue').trim(),
			stauts:$("#quota_list_query_stauts_2").combobox('getValue').trim(),
		});
	}
}

//清除查询条件
function clearQuotaList(type) {
	if(type=="0"){
		/* $("#quota_list_query_indexCode_1").textbox('setValue',''); */
		$("#quota_list_query_indexName_1").textbox('setValue','');
		$("#quota_list_query_deptName_1").textbox('setValue','');
		$("#quota_list_query_stauts_1").combobox('setValue','');
		
		$("#basicIndex").datagrid('load',{});
	}
	if(type=="1"){
		/* $("#quota_list_query_indexCode_2").textbox('setValue',''); */
		$("#quota_list_query_indexName_2").textbox('setValue','');
		$("#quota_list_query_deptName_2").textbox('setValue','');
		$("#quota_list_query_stauts_2").combobox('setValue','');
		
		$("#proIndex").datagrid('load',{});
	}
}
</script>
</body>


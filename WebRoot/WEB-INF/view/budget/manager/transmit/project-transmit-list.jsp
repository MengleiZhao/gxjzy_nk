<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
		
			<tr id="project_transmit_top1">
				<td class="top-table-search-pro" class="queryth">
					<!-- &nbsp;&nbsp;预算指标编码&nbsp;
					<input id="transmi_list_query_indexCode_1" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					&nbsp; -->&nbsp;预算指标名称&nbsp;
					<input id="transmi_list_query_indexName_1" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="transmi_list_query_deptName_1" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;指标下达状态&nbsp;
					<select id="transmi_list_query_releaseStauts_1" style="width: 150px;height:25px;" class="easyui-combobox" data-options="required:false,editable:false" >
     					<option value="">-请选择-</option>
     					<option value="0">未下达</option>
     					<option value="1">已下达</option>
     				</select>
					&nbsp;&nbsp;
					<a href="#" onclick="queryTransmiList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearTransmiList(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="xiada1();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/plxd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			<tr id="project_transmit_top2" style="display: none;">
				<td class="top-table-search-pro" class="queryth">
					<!-- &nbsp;&nbsp;预算指标编码&nbsp;
					<input id="transmi_list_query_indexCode_2" style="width: 150px;height:25px;" class="easyui-numberbox"/>
					
					&nbsp; -->&nbsp;预算指标名称&nbsp;
					<input id="transmi_list_query_indexName_2" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="transmi_list_query_deptName_2" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;指标下达状态&nbsp;
					<select id="transmi_list_query_releaseStauts_2" style="width: 150px;height:25px;" class="easyui-combobox" data-options="required:false,editable:false" >
     					<option value="">-请选择-</option>
     					<option value="0">未下达</option>
     					<option value="1">已下达</option>
     				</select>
					&nbsp;&nbsp;
					<a href="#" onclick="queryTransmiList(2);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearTransmiList(2);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="xiada();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/plxd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
			
		</table>   
	</div>


	
	<div class="list-table-tab">
		<div class="tab-wrapper" id="transmit-tab">
			<ul class="tab-menu">
				<li class="active" onclick="reloadbasic()">基本支出</li>
		    	<li onclick="reloadpro()">项目支出</li>
			</ul>
		  
			<div class="tab-content">
				<div style="height: 440px">
					<table id="transmitBasicIndex" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/transmit/indexPage?indexType=0',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
						<thead>
							<tr>
							<!-- 	<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'left'" style="width: 15%">预算指标编码</th>
								<th data-options="field:'indexName',align:'left'" style="width: 15%">预算指标名称</th>
								<th data-options="field:'pfAmount',align:'left'" style="width: 10%">指标批复总额[元]</th>
								<th data-options="field:'deptName',align:'left'" style="width: 10%">申请部门</th>
								<th data-options="field:'umpfje',align:'left'" style="width: 10%">部门批复金额[元]</th>
								<th data-options="field:'appDate',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">批复日期</th>
								<th data-options="field:'stauts',align:'left',formatter: indexStauts" style="width: 10%">指标生成状态</th>
								<th data-options="field:'cz',align:'left',formatter: transmitCz" style="width: 10%">操作</th> -->
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'center'" style="width: 15%">预算指标编码</th>
								<th data-options="field:'indexName',align:'center'" style="width: 22%">预算指标名称</th>
								<th data-options="field:'deptName',align:'center'" style="width: 10%">申请部门</th>
								<th data-options="field:'pfAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">指标批复金额[元]</th>
								<th data-options="field:'xdAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">累计下达金额[元]</th>
								<th data-options="field:'syAmount',align:'right'" style="width: 10%">指标剩余金额[元]</th>
								<th data-options="field:'releaseStauts',align:'center',formatter: indexStauts" style="width: 10%">指标下达状态</th>
								<th data-options="field:'cz',align:'center',formatter: transmitCz" style="width: 10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
			   	<div style="height: 440px">
				    <table id="transmitProIndex" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/transmit/indexPage?indexType=1',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
						<thead>
							<tr><th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'center'" style="width: 15%">预算指标编码</th>
								<th data-options="field:'indexName',align:'center'" style="width: 26%">预算指标名称</th>
								<th data-options="field:'deptName',align:'center'" style="width: 10%">申请部门</th>
								<th data-options="field:'pfAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">指标批复金额[元]</th>
								<th data-options="field:'xdAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">累计下达金额[元]</th>
								<th data-options="field:'syAmount',align:'right'" style="width: 10%">指标剩余金额[元]</th>
								<th data-options="field:'releaseStauts',align:'center',formatter: indexStauts" style="width: 10%">指标下达状态</th>
								<!-- <th data-options="field:'cz',align:'center',formatter: transmitCz" style="width: 10%">操作</th> -->
							</tr>
						</thead>
					</table>
				</div>
			</div>
		
		</div>
	</div>
</div>


<script type="text/javascript">
flashtab("transmit-tab");

//指标状态设置
function indexStauts(val, row) {
	if(val==0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未下达" + '</a>';
	} else if(val==1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已下达" + '</a>';
	} else {
		return null;
	}
}

function transmitCz(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="indexTransmit(' + row.bId + ',' + row.releaseStauts + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/xiada1.png">'+
		   '</a></td></tr></table>';
}

//type为指标类型1位基本2为项目
var type=1;
function reloadbasic() {
	$('#transmitBasicIndex').datagrid('reload');
	type=1;
	
	$("#project_transmit_top1").show();
	$("#project_transmit_top2").hide();
}
function reloadpro() {
	$('#transmitProIndex').datagrid('reload');
	type=2;
	
	$("#project_transmit_top1").hide();
	$("#project_transmit_top2").show();
}
//指标下达
function indexTransmit(bId,releaseStauts) {
	
	 if(releaseStauts==1){
		 alert("预算已经下达，请不要重复下达！");
		 return false;
	 }
	 var  data =bId + ',';
	if (confirm('是否确定下达？')) {
		$.ajax({ 
			url : base + '/transmit/save?bId='+data,
			dataType:'json',
			success: function(data){
				$('#transmitBasicIndex').datagrid('reload');
				$('#transmitProIndex').datagrid('reload');
	    }});
		
	}
}
//基础指标下达
function xiada1() {
	var data="";
	var chongfuflag=0;
	var checkedItems = $('#transmitBasicIndex').datagrid('getChecked');
	$.each(checkedItems, function(index, item){
		 if(item.releaseStauts==1){
			 alert(item.indexName+"指标已经下达，请不要重复下达！");
			 chongfuflag=1;
			 return false;
		 }
  	  data +=item.bId + ',';
    }); 
	if(chongfuflag==1){
		alert("指标已经下达，无法重复下达");
			return false;
	}
	if(data==""){
		alert("指标已经下达，无法重复下达");
		return false;
	}
	$.messager.progress();
	if (confirm('是否确定下达？')) {
		$.ajax({ 
			url : base + '/transmit/save?bId='+data,
			dataType:'json',
			success: function(data){
				$('#transmitBasicIndex').datagrid('reload');
	    }});
	}
	$.messager.progress('close');
}
//指标下达
function xiada() {
	
	var data="";
	var chongfuflag=0;
	var checkedItems = $('#transmitProIndex').datagrid('getChecked');
	 $.each(checkedItems, function(index, item){
		 if(item.releaseStauts==1){
			 alert(item.indexName+"指标已经下达，请不要重复下达！");
			 chongfuflag=1;
			 return false;
		 }
  	  data +=item.bId + ',';
    }); 
	 if(chongfuflag==1){
			return false;
	}
	if(data==""){
		alert("指标已经下达，无法重复下达");
		return false;
	}
	$.messager.progress();
	if (confirm('是否确定下达？')) {
		$.ajax({ 
			url : base + '/transmit/save?bId='+data,
			dataType:'json',
			success: function(data){
				$('#transmitProIndex').datagrid('reload');
	    }});
		
	}
	$.messager.progress('close');
}


//查询
function queryTransmiList(type) {
	if(type==1){
		$("#transmitBasicIndex").datagrid('load',{
			/* indexCode:$("#transmi_list_query_indexCode_1").textbox('getValue').trim(), */
			indexName:$("#transmi_list_query_indexName_1").textbox('getValue').trim(),
			deptName:$("#transmi_list_query_deptName_1").textbox('getValue').trim(),
			releaseStauts:$("#transmi_list_query_releaseStauts_1").combobox('getValue').trim(),
			/* xdjd1:$("#transmi_list_query_xdjd1").val(),
			xdjd2:$("#transmi_list_query_xdjd2").val(), */
		});
	}
	if(type==2){
		$("#transmitProIndex").datagrid('load',{
			/* indexCode:$("#transmi_list_query_indexCode_2").textbox('getValue').trim(), */
			indexName:$("#transmi_list_query_indexName_2").textbox('getValue').trim(),
			deptName:$("#transmi_list_query_deptName_2").textbox('getValue').trim(),
			releaseStauts:$("#transmi_list_query_releaseStauts_2").combobox('getValue').trim(),
		});
	}
}

//清除查询条件
function clearTransmiList(type) {
	if(type==1){
		/* $("#transmi_list_query_indexCode_1").textbox('setValue',''); */
		$("#transmi_list_query_indexName_1").textbox('setValue','');
		$("#transmi_list_query_deptName_1").textbox('setValue','');
		$("#transmi_list_query_releaseStauts_1").textbox('setValue','');
		
		/* $("#transmi_list_query_xdjd1").combobox('select','0%');
		$("#transmi_list_query_xdjd2").combobox('select','0%'); */
		
		$("#transmitBasicIndex").datagrid('load',{});
	}
	if(type==2){
		/* $("#transmi_list_query_indexCode_2").textbox('setValue',''); */
		$("#transmi_list_query_indexName_2").textbox('setValue','');
		$("#transmi_list_query_deptName_2").textbox('setValue','');
		$("#transmi_list_query_releaseStauts_2").textbox('setValue','');
		
		$("#transmitProIndex").datagrid('load',{});
	}
}

</script>
</body>


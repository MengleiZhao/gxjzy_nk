<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="essp_history_top" >
				<td class="top-table-search-pro" class="queryth">
					&nbsp;&nbsp;审批结果&nbsp;
					<select id="record_history_fproCode" style="width: 150px;height:25px;" class="easyui-combobox">
						<option value="">--请选择--</option>
						<option value="1"> 同意</option>
						<option value="0">不同意</option>
					</select>
					<!-- &nbsp;&nbsp;项目名称&nbsp;
					<input id="record_history_fproName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					 -->
					&nbsp;&nbsp;<a href="#" onclick="esspHistoryQuery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<a href="#" onclick="esspHistoryClear();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="list-table-tab2">
		<div style="height: 410px">
			<table id="record-checkInfo-table" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/project/recordProjectPage',
				method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
					<thead>
						<tr>
							<th data-options="field:'cId',hidden:true"></th>
							<th data-options="align:'center',field:'num'" style="width: 5%">序号</th>
							<th data-options="align:'center',field:'fproCode'" style="width: 20%">项目编号</th>
							<th data-options="align:'center',field:'fproName'" style="width: 20%">项目名称</th>
							<th data-options="align:'center',field:'fcheckTime',formatter: ChangeDateFormat" style="width: 16%">审批时间</th>
							<th data-options="align:'center',field:'fcheckResult',formatter:ysCheckResult" style="width: 10%">审批结果</th>
							<th data-options="align:'center',field:'fcheckRemake'" style="width: 20%">审批意见</th>
							<th data-options="align:'center',field:'cz',formatter:operationEsspDetail" style="width: 9%">操作</th>
						</tr>
					</thead>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
//二上审批记录操作
function operationEsspDetail(val, row){
	var name = '"'+row.fproName+'"';
	var code = '"'+row.fproCode+'"';
	var btn = "<table><tr style='width: 105px; height:20px'>";
	var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='verdictEsspDetail("+row.FProID+","+name+","+code+")'>"+
	"<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"+
	"</a></td>";
	btn = btn + btn1 + "</tr></table>";
	return btn;
}
function verdictEsspDetail(id,name,code){
	$('#esspCheckProject').val(name);
	$('#esspCheckProjectCode').val(code);
	var win=creatWin('项目信息',1230,630,'icon-search',"/project/detail/"+id+"?logType=3&foCode="+code);
	win.window('open');
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
	$('#record-checkInfo-table').datagrid('load', {
		fcheckResult:$('#record_history_fproCode').val(),
		/* FProCode:$('#record_history_fproCode').val(), 
		FProName:$('#record_history_fproName').val(),*/
	});
}
//清除查询条件
function esspHistoryClear() {
	/* $(".topTable :input[type='text']").each(function(){
		$(this).val("a");
	}); */
	$("#record_history_fproCode").textbox('setValue',null); 
	/* $("#record_history_fproName").textbox('setValue',null); */
	$('#record-checkInfo-table').datagrid('load',{//清空以后，重新查一次
	});
}
</script>
</body>

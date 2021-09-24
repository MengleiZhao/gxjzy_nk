<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;申请单编号&nbsp;
					<input id="apply_check_list_top_gCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请摘要名称&nbsp;
					<input id="apply_check_list_top_gName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请时间&nbsp;
					<input id="apply_check_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[apply_check_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="apply_check_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[apply_check_list_top_reqTime1]"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryApplyCheck();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearApplyCheck();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>



	<div class="list-table">
		<table id="applyCheckTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/applyCheck/applyPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'gId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'gCode',align:'center',resizable:false" style="width: 15%">申请单编号</th>
					<th data-options="field:'gName',align:'center',resizable:false" style="width: 15%">申请摘要名称</th>
					<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 10%">申请事项</th>
					<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 10%">申请部门</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">申请人</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申请时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>


<script type="text/javascript">	

$("#apply_check_list_top_reqTime1").datebox({
    onSelect : function(beginDate){
        $('#apply_check_list_top_reqTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
//设置申请事项
function typeSet(val, row) {
	if (val == 1) {
		return '<span>' + "通用事项申请" + '</span>';
	} else if (val == 2) {
		return '<span>' + "会议申请" + '</span>';
	} else if (val == 3) {
		return '<span>' + "培训申请" + '</span>';
	} else if (val == 4) {
		return '<span>' + "差旅申请" + '</span>';
	} else if (val == 5) {
		return '<span>' + "接待申请" + '</span>';
	} else if (val == 6) {
		return '<span>' + "公务用车申请" + '</span>';
	} else if (val == 7) {
		return '<span>' + "公务出国申请" + '</span>';
	}
}
	
//设置审批状态
var c;
function flowStautsSet(val, row) {
	c = val;
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	if (c == 9 ) {
		return null;
	}else {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="checkApply(' + row.gId + ','+row.type+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
				'</a></td></tr></table>';
	}
}
	
	
//审批页面跳转
function checkApply(id,type) {
	var win = null;
	/* if('1'==type){
		win = creatWin('审批', 780, 600, 'icon-search', "/applyCheck/check?id="+ id);
		
	}else { */
		win = creatWin('审批', 1115, 600, 'icon-search', "/applyCheck/check?id="+ id);	
		
	//}
	win.window('open');
}
	
//查询
function queryApplyCheck() {
	var gCode="apply_check_list_top_gCode";
	var gName="apply_check_list_top_gName";
	var reqTime1="apply_check_list_top_reqTime1";
	var reqTime2="apply_check_list_top_reqTime2";
	
	$("#applyCheckTab").datagrid('load',{
		gCode:$("#"+gCode).textbox('getValue').trim(),
		gName:$("#"+gName).textbox('getValue').trim(),
		reqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reqTime2:$("#"+reqTime2).datebox('getValue').trim(),
	});
}
	
//清除查询条件
function clearApplyCheck() {
	var gCode="apply_check_list_top_gCode";
	var gName="apply_check_list_top_gName";
	var reqTime1="apply_check_list_top_reqTime1";
	var reqTime2="apply_check_list_top_reqTime2";
	
	$("#"+gCode).textbox('setValue',''),
	$("#"+gName).textbox('setValue',''),
	$("#"+reqTime1).datebox('setValue',''),
	$("#"+reqTime2).datebox('setValue',''),
	
	$("#applyCheckTab").datagrid('load',{});
}
</script>
</body>


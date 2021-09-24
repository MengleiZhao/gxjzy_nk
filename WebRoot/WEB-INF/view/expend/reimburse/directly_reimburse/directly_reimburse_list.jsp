<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body >
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">

		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="directly_list_top_drCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销时间&nbsp;
					<input id="directly_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[directly_list_top_reqTime2]"/>
					&nbsp;-&nbsp;
					<input id="directly_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[directly_list_top_reqTime1]"/>
					
					&nbsp;&nbsp;审批状态&nbsp;
					
					<select id="directly_list_top_flowStauts" class="easyui-combobox" style="width: 150px;height:25px;">
						<option value="">--请选择--</option>
						<option value="0">暂存</option>
						<option value="1">待审批</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryDirectly();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearDirectly();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addDirectly()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>



	<div class="list-table">
		<table id="directlyReimbTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/directlyReimburse/reimbursePage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'drId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'drCode',align:'center',resizable:false,sortable:true" style="width: 16%">报销单编号</th>
					<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 5%">报销类型</th>
					<th data-options="field:'summary',align:'center',resizable:false,sortable:true" style="width: 15%">报销摘要</th>
					<th data-options="field:'amount',align:'center',resizable:false,sortable:true" style="width: 8%">报销金额</th>
					<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 7%">报销部门</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 10%">报销请人</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">报销时间</th>
<!-- 					<th data-options="field:'indexAmount',align:'center',resizable:false,sortable:true" style="width: 14%">可用预算金额（万元）</th> -->
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>



<script type="text/javascript">
//设置申请事项
function typeSet(val, row) {
	if (val == 0) {
		return '<span>' + "直接报销" + '</span>';
	} else if (val == 1) {
		return '<span>' + "通用事项报销" + '</span>';
	} else if (val == 2) {
		return '<span>' + "会议报销" + '</span>';
	} else if (val == 3) {
		return '<span>' + "培训报销" + '</span>';
	} else if (val == 4) {
		return '<span>' + "差旅报销" + '</span>';
	} else if (val == 5) {
		return '<span>' + "接待报销" + '</span>';
	} else if (val == 6) {
		return '<span>' + "合同报销" + '</span>';
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
	}  else if (val == -4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	} else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	if (c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editReimburse(' + row.drId + ',0)" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
			   '<a href="#" onclick="reCall(\'directlyReimbTab\',' + row.drId + ',\'/directlyReimburse/directlyReimburseReCall\')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			   '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="exportDirmHtml(' + row.drId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
			   '</a></td></tr></table>';
	} else if(c == 0 || c == -1 || c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="editReimburse(' + row.drId + ',0)" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="editReimburse(' + row.drId + ',1)" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteReimburse(' + row.drId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}else 	if (c == 9 ) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="editReimburse(' + row.drId + ',0)" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td><td style="width: 25px">'+
			'<a href="#" onclick="exportDirmHtml(' + row.drId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
		   '</a></td></tr></table>';
} 
}


//打印
function exportDirmHtml(id) {
	//alert(id);
	window.open(base+"/exportApplyAndReim/reimburseExprotDirectly?id="+ id);//事后报销单
	/* window.open(base+"/exportApplyAndReim/requestApply?id="+ id);//事前申请单
	window.open(base+"/exportApplyAndReim/PastePage?id="+ id);//黏贴单 */
/* 	window.clearTimeout(t1);//去掉定时器 
	window.setTimeout(function () {
	},1000); */
}
//新增页面
function addDirectly() {
	var win = creatWin('直接报销', 1110, 600, 'icon-search', '/directlyReimburse/add');
	win.window('open');
}

//删除
function deleteReimburse(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/directlyReimburse/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#directlyReimbTab').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

//修改
function editReimburse(id,type) {
	var title = null;
	/*type为修改或查看1位修改，0位查看  */
	if(type==1){
		title = "直接报销明细-修改";
		var win = creatWin(title, 1110, 600, 'icon-search', "/directlyReimburse/edit?id="+ id +"&editType="+ type);
		win.window('open');
	}else {
		title = "直接报销明细";
		var win = creatWin(title, 1110, 600, 'icon-search', "/directlyReimburse/edit?id="+ id +"&editType="+ type);
		win.window('open');
}
}
//查询
function queryDirectly() {
	var drCode="directly_list_top_drCode";
	var reqTime1="directly_list_top_reqTime1";
	var reqTime2="directly_list_top_reqTime2";
	var flowStauts="directly_list_top_flowStauts";
	
	
	$("#directlyReimbTab").datagrid('load',{
		drCode:$("#"+drCode).textbox('getValue').trim(),
		reqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reqTime2:$("#"+reqTime2).datebox('getValue').trim(),
		flowStauts:$("#"+flowStauts).textbox('getValue').trim(),
	});
}
//清除查询条件
function clearDirectly() {
	var drCode="directly_list_top_drCode";
	var reqTime1="directly_list_top_reqTime1";
	var reqTime2="directly_list_top_reqTime2";
	var flowStauts="directly_list_top_flowStauts";
	
	$("#"+drCode).textbox('setValue');
	$("#"+reqTime1).datebox('setValue');
	$("#"+reqTime2).datebox('setValue');
	$("#"+flowStauts).textbox('setValue');
	
	$("#directlyReimbTab").datagrid('load',{});
}



$("#directly_list_top_reqTime1").datebox({
    onSelect : function(beginDate){
        $('#directly_list_top_reqTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});


</script>
</body>
</html>


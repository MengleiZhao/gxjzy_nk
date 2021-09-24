<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;申请单编号&nbsp;
					<input id="apply_list_top_gCode_${applyType}" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请摘要名称&nbsp;
					<input id="apply_list_top_gName_${applyType}" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请时间&nbsp;
					<input id="apply_list_top_reqTime1_${applyType}" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[apply_list_top_reqTime2_${applyType}]"/>
					&nbsp;-&nbsp;
					<input id="apply_list_top_reqTime2_${applyType}" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[apply_list_top_reqTime1_${applyType}]"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryApply(${applyType});">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearTable(${applyType});">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addApply(${applyType})">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<!-- <a href="#" onclick="addApplyNew()">
						新增
					</a> -->
				</td>
			
				<%-- <td class="top-table-td1">申请单编号：</td>
				<td class="top-table-td2">
					<input id="apply_list_top_gCode" style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">申请摘要名称：</td>
				<td class="top-table-td2">
					<input id="apply_list_top_gName" style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">申请时间：</td>
				<td>
					<input id="apply_list_top_reqTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>至
					<input id="apply_list_top_reqTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addApply(${applyType})">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td> --%>
			</tr>
		</table>   
	</div>

	<div class="list-table">
		<table id="applyTab${applyType}" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/apply/applyPage?applyType=${applyType}',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
			<thead>
				<tr>
					<th data-options="field:'gId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'gCode',align:'center',resizable:false" style="width: 15%">申请单编号</th>
					<th data-options="field:'gName',align:'center',resizable:false" style="width: 15%">申请摘要名称</th>
					<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 15%">申请事项</th>
					<th data-options="field:'deptName',align:'center',resizable:false" style="width: 10%">申请部门</th>
					<th data-options="field:'userName',align:'center',resizable:false" style="width: 10%">申请人</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,formatter: ChangeDateFormat1" style="width: 10%">申请日期</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>


<script type="text/javascript">
$("#apply_list_top_reqTime1_"+${applyType}).datebox({
    onSelect : function(beginDate){
        $('#apply_list_top_reqTime2_'+${applyType}).datebox().datebox('calendar').calendar({
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
		return '<span>' + "公务接待申请" + '</span>';
	} else if (val == 6) {
		return '<span>' + "公车运维申请" + '</span>';
	} else if (val == 7) {
		return '<span>' + "公务出国申请" + '</span>';
	} else if (val == 12) {
		return '<span>' + "参加培训申请" + '</span>';
	} else if (val == "13") {
		return '<span>' + "市内公务非公共交通申请" + '</span>';
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
	
	var nCode = row.nCode;
	if ( c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editApply(' + row.gId + ',0,' + ${applyType} + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="reCall(\'applyTab${applyType}\',' + row.gId + ',\'/apply/applyReCall\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
				'</a></td></tr></table>';
	} else if(c == 0 || c == -1 || c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="editApply(' + row.gId + ',0,' + ${applyType} + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="editApply(' + row.gId + ',1,' + ${applyType} + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteApply(' + row.gId + ',' + row.type + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}else if(c == 9 ){
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editApply(' + row.gId + ',0,' + ${applyType} + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="exportHtml(' + row.gId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
			   '</a></td></tr></table>';
	}
}
/* function addApplyNew(){
	var win = creatWin('', 1075, 580, 'icon-search', '/apply/addNew');
	win.window('open');
} */
//新增页面
function addApply(applyType) {
	var win =null;
	var title=null;
	if(applyType=="1") {
		title="通用事项-申请";
	} else if(applyType=="2") {
		title="会议-申请";
	} else if(applyType=="3") {
		title="培训-申请";
	} else if(applyType=="4") {
		title="差旅-申请";
	} else if(applyType=="5") {
		title="公务接待-申请";
	} else if(applyType=="6") {
		title="公车运维-申请";
	} else if(applyType=="7") {
		title="公务出国-申请";
	} else if(applyType=="12") {
		title="参加培训-申请";
	} else if(applyType=="13") {
		title="市内公务非公共交通-申请";
	}
	/* if(applyType=="1"){
	 	 win = creatWin(title, 780, 600, 'icon-search', '/apply/add?type='+applyType);
	}else {  */
		 win = creatWin(title, 1115, 600, 'icon-search', '/apply/add?type='+applyType);
	/* } */
	win.window('open');
}

//删除
function deleteApply(id,type) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/apply/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#applyTab'+type).datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

//修改
function editApply(id,type,applyType) {
	var title = null;
	var win =null;
	/*type为修改或查看1位修改，0位查看  */
	if(type==1){
		if(applyType=="1") {
			title="通用事项申请-修改";
		} else if(applyType=="2") {
			title="会议申请-修改";
		} else if(applyType=="3") {
			title="培训申请-修改";
		} else if(applyType=="4") {
			title="差旅申请-修改";
		} else if(applyType=="5") {
			title="公务接待申请-修改";
		} else if(applyType=="6") {
			title="公务用车申请-修改";
		} else if(applyType=="7") {
			title="公务出国申请-修改";
		} else if(applyType=="12") {
			title="参加培训申请-修改";
		} else if(applyType=="13") {
			title="市内公务非公共交通-修改";
		}
	}else if(type==0){
		if(applyType=="1") {
			title="通用事项明细";
		} else if(applyType=="2") {
			title="会议明细";
		} else if(applyType=="3") {
			title="培训明细";
		} else if(applyType=="4") {
			title="差旅明细";
		} else if(applyType=="5") {
			title="公务接待明细";
		} else if(applyType=="6") {
			title="公务用车明细";
		} else if(applyType=="7") {
			title="公务出国明细";
		} else if(applyType=="12") {
			title="参加培训明细";
		} else if(applyType=="13") {
			title="市内公务非公共交通明细";
		}
	}
	/* if(applyType=="1"){
		 win = creatWin(title, 800, 600, 'icon-search', "/apply/edit?id="+ id +"&editType="+ type +"&applyType="+ applyType);
	}else {  */
		 win = creatWin(title, 1105, 600, 'icon-search', "/apply/edit?id="+ id +"&editType="+ type +"&applyType="+ applyType);
	/* } */
	win.window('open');	
}

//打印
function exportHtml(id) {
	window.open(base+"/exportApplyAndReim/applyExprot?id="+ id);
}
//查询
function queryApply(applyType) {
	var tableid="applyTab"+applyType;
	
	var gCode="apply_list_top_gCode_"+applyType;
	var gName="apply_list_top_gName_"+applyType;
	var reqTime1="apply_list_top_reqTime1_"+applyType;
	var reqTime2="apply_list_top_reqTime2_"+applyType;
	
	$("#"+tableid).datagrid('load',{
		gCode:$("#"+gCode).textbox('getValue').trim(),
		gName:$("#"+gName).textbox('getValue').trim(),
		reqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reqTime2:$("#"+reqTime2).datebox('getValue').trim(),
	});
}

//清除查询条件
function clearTable(applyType) {
	var gCode="apply_list_top_gCode_"+applyType;
	var gName="apply_list_top_gName_"+applyType;
	var reqTime1="apply_list_top_reqTime1_"+applyType;
	var reqTime2="apply_list_top_reqTime2_"+applyType;
	
	$("#"+gCode).textbox('setValue','');
	$("#"+gName).textbox('setValue','');
	$("#"+reqTime1).datebox('setValue','');
	$("#"+reqTime2).datebox('setValue','');
	
	var tableid="applyTab"+applyType;
	$("#"+tableid).datagrid('load',{});
}
function ChangeDateFormat1(val) {
	var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
</script>
</body>

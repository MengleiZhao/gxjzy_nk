<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;&nbsp;
					<input id="list_top_check_aCode" style="width: 250px;height:25px;" class="easyui-textbox"/>
					
					<!-- &nbsp;&nbsp;项目名称&nbsp;
					<input id="list_top_check_aName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="list_top_check_aDept" style="width: 150px;height:25px;" class="easyui-textbox"/> -->
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryCheckApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearCheckTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				 <%-- <td align="right" style="padding-right: 10px">
					<a href="#" onclick="addApply()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>  --%>
			</tr>
		</table>   
	</div>

	<div class="list-table">
		<table id="accountsCheckTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/accountsCurrentCheck/accountsPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
			<thead>
				<tr>
					<th data-options="field:'fAcaId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'proCode',align:'center',resizable:false" style="width: 15%">立项单号</th>
					<th data-options="field:'proName',align:'center',resizable:false" style="width: 25%">项目名称</th>
					<th data-options="field:'deptName',align:'center',resizable:false" style="width: 15%">申请部门</th>
					<th data-options="field:'userName',align:'center',resizable:false" style="width: 10%">申请人</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,formatter: ChangeDateFormat1" style="width: 10%">立项时间</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>


<script type="text/javascript">

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
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="checkApply(' + row.fAcaId + ')" class="easyui-linkbutton">'+
	'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
	'</a></td></tr></table>';
}
//审批页面跳转
function checkApply(id) {
	var win = creatWin('审批', 1115, 600, 'icon-search', "/accountsCurrentCheck/check?id="+ id);	
	win.window('open');
}
//查询
function queryCheckApply(){
	var aCode="list_top_check_aCode";
	/* var aName="list_top_check_aName";
	var aDept="list_top_check_aDept"; */
	
	$("#accountsCheckTab").datagrid('load',{
		proCode:$("#"+aCode).textbox('getValue').trim(),
		/* proName:$("#"+aName).textbox('getValue').trim(),
		deptName:$("#"+aDept).textbox('getValue').trim(), */
	});
}

//清除查询条件
function clearCheckTable() {
	var gCode="list_top_check_aCode";
	/* var gName="list_top_check_aName";
	var aDept="list_top_check_aDept"; */
	$("#"+gCode).textbox('setValue','');
	/* $("#"+gName).textbox('setValue','');
	$("#"+aDept).textbox('setValue',''); */
	$("#accountsCheckTab").datagrid('load',{});
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
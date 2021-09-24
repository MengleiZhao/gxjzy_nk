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
					<input id="list_top_affirm_aCode" style="width: 250px;height:25px;" class="easyui-textbox"/>
					
					<!-- &nbsp;&nbsp;项目名称&nbsp;
					<input id="list_top_affirm_aName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;对方单位名称&nbsp;
					<input id="list_top_affirm_aDept" style="width: 150px;height:25px;" class="easyui-textbox"/> -->
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryAffirmApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearAffirmTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>
	<div class="list-table">
		<table id="accountsAffirmTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/registerAffirm/registerAffirmPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,rownumbers:true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
			<thead>
				<tr>
					<th data-options="field:'fMSId',hidden:true"></th>
					<th data-options="field:'fAcaId',hidden:true"></th>
					<th data-options="field:'num',align:'center',hidden:true" style="width: 5%">序号</th>
					<th data-options="field:'registerCode',align:'center',resizable:false" style="width: 15%">登记单号</th>
					<th data-options="field:'proName',align:'center',resizable:false" style="width: 25%">项目名称</th>
					<th data-options="field:'oppositeUnit',align:'center',resizable:false" style="width: 15%">对方单位名称</th>
					<th data-options="field:'planMoney',align:'center',resizable:false" style="width: 15%">预计来款金额</th>
					<th data-options="field:'deptName',align:'center',resizable:false" style="width: 10%">登记部门</th>
					<th data-options="field:'userName',align:'center',resizable:false" style="width: 10%">登记人</th>
					<th data-options="field:'reqTime',align:'center',resizable:false,formatter: ChangeDateFormat1" style="width: 10%">登记日期</th>
					<th data-options="field:'aStauts',align:'center',resizable:false,formatter:aStautsSet" style="width: 10%">确认状态</th>
					<th data-options="field:'name',align:'center',resizable:false,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
//设置审批状态
function aStautsSet(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未确认" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已确认" + '</a>';
	}  else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未确认" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	if ( row.aStauts==0) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editAccounts(' + row.fMSId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="addAffirmApply(' + row.fMSId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/qr1.png">'+
				'</a></td></tr></table>';
	}else{
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="editAccounts(' + row.fMSId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td></tr></table>';
	}
}
//新增页面
function addAffirmApply(id) {
	var win = creatWin("来款确认", 1115, 600, 'icon-search', '/registerAffirm/edit?id='+id);
	win.window('open');
}

//修改
function editAccounts(id,type) {
	var win = creatWin('来款确认-查看', 1115, 600, 'icon-search', "/registerAffirm/detail?id="+ id);
	 win.window('open');
}
//查询
function queryAffirmApply(applyType) {
	var aCode="list_top_affirm_aCode";
	/* var aName="list_top_affirm_aName";
	var aDept="list_top_affirm_aDept"; */
	
	$("#accountsAffirmTab").datagrid('load',{
		proCode:$("#"+aCode).textbox('getValue').trim(),
		/* proName:$("#"+aName).textbox('getValue').trim(),
		deptName:$("#"+aDept).textbox('getValue').trim(), */
	});
}

//清除查询条件
function clearAffirmTable(applyType) {
	var gCode="list_top_affirm_aCode";
	/* var gName="list_top_affirm_aName";
	var aDept="list_top_affirm_aDept"; */
	$("#"+gCode).textbox('setValue','');
	/* $("#"+gName).textbox('setValue','');
	$("#"+aDept).textbox('setValue',''); */
	$("#accountsAffirmTab").datagrid('load',{});
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
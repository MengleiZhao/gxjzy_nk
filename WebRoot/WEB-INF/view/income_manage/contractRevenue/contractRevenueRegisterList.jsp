<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;合同编号&nbsp;
					<input id="list_top_Code" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;合同名称&nbsp;
					<input id="list_top_Name" style="width: 150px;height:25px;" class="easyui-textbox"/>
					<!-- 
					&nbsp;&nbsp;收入类型&nbsp;
					<input id="list_top_type" style="width: 150px;height:25px;" class="easyui-textbox"/>
					 -->
					&nbsp;&nbsp;对方单位名称&nbsp;
					<input id="list_top_fSignName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;
					<a href="#" onclick="ContractRevenueQuery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="ContractRevenueClear();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>

	<div class="list-table">
			<table id="enforcing_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/proceedsPlan/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center'" width="15%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="19%">合同名称</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="12%">合同金额(元)</th>
						<th data-options="field:'fAllAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="12%">已收款金额(元)</th>
						<th data-options="field:'fNotAllAmountL',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="13%">未收款金额(元)</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="15%">所属部门</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>


<script type="text/javascript">
//设置确认状态
function confirmStatusSet(val, row) {
	if (val == 0 || val == 'null') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未确认" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已确认" + '</a>';
	} 
}
//设置收入类型
function ChangeTypeName(val, row) {
	if (val == 'HTFL-02') {
		return '收入类合同';
	} 
}


//设置确认状态
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
	return  '<a href="#" onclick="editAccounts(' + row.fcId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/qr1.png">'+
			'</a>';
}

//修改
function editAccounts(id) {
	var win = null;
	win = creatWin('来款确认-修改', 795, 600, 'icon-search', "/proceedsPlan/edit/"+ id);
	 win.window('open');	
}
//查看
function detailAccounts(id,cId,type) {
	var win = null;
	if(type==0){//查看原合同
	win = creatWin('合同详情-查看', 1115, 600, 'icon-search', "/Formulation/detail/"+ cId);
	}else{//查看变更合同
	win = creatWin('合同详情-查看', 1115, 600, 'icon-search', "/Change/detail/"+ cId);
	}
	 win.window('open');	
}
//查询
function ContractRevenueQuery(applyType) {
	$("#ContractRevenueTab").datagrid('load',{
		fcCode:$("#list_top_Code").textbox('getValue').trim(),
		fcTitle:$("#list_top_Name").textbox('getValue').trim(),
		/* type:$("#list_top_type").textbox('getValue').trim(), */
		fSignName:$("#list_top_fSignName").textbox('getValue').trim(),
	});
}

//清除查询条件
function ContractRevenueClear(applyType) {
	/* $("#list_top_type").textbox('setValue',''); */
	$("#list_top_Name").textbox('setValue','');
	$("#list_top_Code").textbox('setValue','');
	$("#list_top_fSignName").textbox('setValue','');
	/* $("#list_top_type").textbox('setValue',''); */
	$("#ContractRevenueTab").datagrid('load',{});
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
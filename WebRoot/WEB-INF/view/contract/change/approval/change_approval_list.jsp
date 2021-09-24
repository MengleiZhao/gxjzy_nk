<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" class="queryth">变更单编号&nbsp;
						<input id="upt_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;变更合同名称&nbsp;
						<input id="upt_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="change_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png"onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="change_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> 
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>
		</div>
		
		
		<div class="list-table">
			<table id="change_approval_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Change/approvalJson',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'fId_U',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="20%">变更单编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="21%">变更合同名称</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="10%" >申请日期</th>
						<th data-options="field:'fReqtIME',align:'center',resizable:false,sortable:true" width="15%">申请部门</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fFlowStauts',align:'center',resizable:false,sortable:true,formatter:formatPrice" width="10%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">

$("#upt_fReqtIMEStart").datebox({
    onSelect : function(beginDate){
        $('#upt_fReqtIMEEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

//清除查询条件
function change_clearTable() {
	$('#upt_fcCode').textbox('setValue',null);
	$('#upt_fcTitle').textbox('setValue',null);
	change_query();
}
function formatPrice(val, row) {
	if (val == 0) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
	} else if (val == 1) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
	}else if (val == 9) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
	}else if (val == 99) {
		return '<span style="color:#666666;">' + " 已删除" + '</span>';
	} else if (val == -1) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</span>';
	}else if (val == -4) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</span>';
	}
}

function change_add() {
	var win = creatWin('变更申请', 970,580, 'icon-search',"/Change/add");
	win.window('open');
}

function uptType(val, row) {
	if (val == 0) {
		return '<span >' + "" + '</span>';
	} else if (val == 'HTBGLX-01') {
		return '<span >' + "补充合同" + '</span>';
	}else if (val == 'HTBGLX-02') {
		return '<span >' + "变更合同" + '</span>';
	}
}
function CZ(val, row) {
	if(row.fFlowStauts==1){
		return 	'<a href="#" onclick="detailInfo(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="changeshowB(this)" onmouseout="changeshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>' 
				+'&nbsp;'
				+'<a href="#" onclick="approvalHTBG(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="changeshowC(this)" onmouseout="changeshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/approval1.png"></a>';
	}else {
		return 	'<a href="#" onclick="detailInfo(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="changeshowB(this)" onmouseout="changeshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>' 
	}
}
function changeshowC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/approval2.png';
}
function changeshowD(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/approval1.png';
}
function changeshowB(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
}
function changeshowA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function endingshowC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/ending2.png';
}
function endingshowD(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/ending1.png';
}
function change_query() {
	$('#change_approval_dg').datagrid('load', {
		fcCode : $('#upt_fcCode').val(),
		fcTitle : $('#upt_fcTitle').val(),
	});
}
function detailInfo(id) {
	var win = creatWin('查看', 1100, 600, 'icon-search',"/Change/detail/" + id);
	win.window('open');
}
function approvalHTBG(id) {
	var win = creatWin('审批', 1100, 600, 'icon-search',"/Change/approvalChange/" + id);
	win.window('open');
}
</script>
</body>
</html>


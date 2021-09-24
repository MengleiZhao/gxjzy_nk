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
						<!-- &nbsp;&nbsp;申请时间&nbsp;
						<input id="upt_fReqtIMEStart" name="" style="width: 150px;height:25px;"  class="easyui-datebox" editable="false" validType="dateBegin[upt_fReqtIMEEnd]"></input>
						&nbsp;-&nbsp;
						<input id="upt_fReqtIMEEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"validType="dateEnd[upt_fReqtIMEStart]"></input> -->
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="change_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png"onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="change_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> 
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="change_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>
		</div>
		
		
		<div class="list-table">
			<table id="change_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Change/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="17%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="20%">合同名称</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">合同金额(元)</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="9%" >申请日期</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
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
	/* $('#upt_fReqtIMEStart').datebox('setValue',null);
	$('#upt_fReqtIMEEnd').datebox('setValue',null); */
	change_query();
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
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
function CZ(val, row) {
	if(row.fFlowStauts=='-1'||row.fFlowStauts=='0'||row.fFlowStauts=='-4'){
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="changeshowB(this)" onmouseout="changeshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
				+'</a>'+ '</td><td style="width: 25px">'
				+'<a href="#" onclick="updateHT(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/change1.png">'
				+'</a>'+ '</td><td style="width: 25px">'
				+'<a href="#" onclick="deleteBG(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'
				+'</a></td></tr></table>';
	}else if(row.fFlowStauts=='1'){
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
				+'</a>'+ '</td><td style="width: 25px">'
				+ '<a href="#" onclick="reCall(\'change_dg\' ,'+ row.fcId+',\'/Formulation/reCall\''+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">' + '</a>'
				+'</td></tr></table>';
	}else {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
				+'</a>'+'</td></tr></table>';
	}
}
function changeshowC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/change2.png';
}
function changeshowD(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/change1.png';
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
	$('#change_dg').datagrid('load', {
		fUptCode : $('#upt_fcCode').val(),
		fContName : $('#upt_fcTitle').val(),
		/* fReqTimeStart : $('#upt_fReqtIMEStart').datebox('getValue').trim(),
		fReqTimeEnd : $('#upt_fReqtIMEEnd').datebox('getValue').trim(), */
	});
}
function addCF() {
	var node = $('#change_dg').datagrid('getSelected');
	var win = creatWin('合同变更', 1110,680, 'icon-add', '/Change/add');
	if (null != node) {
		win = creatWin('合同变更', 1110,680, 'icon-add',
				'/Change/add?departId=' + node.id);
	}
	win.window('open');
}

function change_add() {
	var win = creatFirstWin('合同信息', 970,550, 'icon-search',"/Change/contract");
	win.window('open');
}
function detailInfo(id) {
	var win = creatWin('查看', 1100,600, 'icon-search',"/Change/detail/"+ id);
	win.window('open');
	
}

function ending_update(id) {
	var win = creatWin('合同终止申请', 1100,600, 'icon-search',
			"/ending/edit/" + id);
	win.window('open');
}
function editCF() {
	var row = $('#change_dg').datagrid('getSelected');
	var selections = $('#change_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		var win = creatWin('合同变更', 1100,600, 'icon-search',
				"/Change/edit/" + row.fcId);
		win.window('open');
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function updateHT(id) {
	//var row = $('#change_dg').datagrid('getSelected');
	var win = creatWin('修改', 1100,600, 'icon-search',
			"/Change/edit/" + id);
	win.window('open');
}
function deleteBG(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/Formulation/delete/' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$("#change_dg").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
function CF_delete(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/Change/delete/' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$("#change_dg").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
function expListlawHelp() {
	//var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
	//win.window('open');
	if (confirm("按当前查询条件导出？")) {
		var queryForm = document.getElementById("lawHelp_list_form");
		queryForm.setAttribute("action", "${base}/demo/expList");
		queryForm.submit();
	}
}
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
	var t, y, m, d, h, i, s;
	if (val == null) {
		return "";
	}
	t = new Date(val)
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
</html>


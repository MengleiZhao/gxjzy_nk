<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" >合同编号&nbsp;
						<input id="receive_contract_fpCode" type="hidden" name="fPurchNo" value="${fPurchNo }">
						<input id="receive_fpCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="ledger_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同状态&nbsp;
						<select id="ledger_fContStauts" style="width: 150px;height:25px;" class="easyui-combobox">
							<option selected="selected" value="">--请选择--</option>
							<option value="-1">已终止</option>
							<option value="1">拟定</option>
							<option value="3">已结项</option>
							<option value="5">已归档</option>
							<option value="7">有纠纷</option>
							<option value="9">已备案</option>
							<option value="11">有变更</option>
						</select>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="queryledger();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="ledger_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> 
					<td align="right" style="padding-right: 10px">
						<a href="javascript:void(0)" onclick="exportContract()">
							<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="ledger_dg" class="easyui-datagrid" data-options="collapsible:true,
			<c:if test="${!empty fPurchNo}">url:'${base}/Ledger/JsonPagination?fcType=HTFL-01&fPurchNo=${fPurchNo}'</c:if>
			<c:if test="${empty fPurchNo}">url:'${base}/Ledger/JsonPagination'</c:if>
			,method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'left',resizable:false,sortable:true" width="14%">合同编号</th>
						<th data-options="field:'fcTitle',align:'left',resizable:false,sortable:true" width="16%">合同名称</th>
						<th data-options="field:'fSignTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" width="7%">签订日期</th>
						<th data-options="field:'fContStartTime',align:'left',formatter: ChangeDateFormat,resizable:false,sortable:true" width="7%" >合同开始日期</th>
						<th data-options="field:'fContEndTime',align:'left',formatter: ChangeDateFormat,resizable:false,sortable:true" width="7%" >合同结束日期</th>
						<th data-options="field:'fcAmount',align:'left',resizable:false,sortable:true" width="7%">合同金额</th>
						<th data-options="field:'fContractor',align:'left',resizable:false,sortable:true" width="10%" >签约方名称</th>
						<th data-options="field:'fContStauts',align:'left',resizable:false,sortable:true,formatter:ContStauts" width="5%">合同状态</th>
						<th data-options="field:'fContStauts1',align:'left',resizable:false,sortable:true,formatter:archiving" width="5%">是否归档</th>
						<th data-options="field:'fDeptName',align:'left',resizable:false,sortable:true" width="8%">承办部门</th>
						<th data-options="field:'fOperator',align:'left',resizable:false,sortable:true" width="5%">申请人</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="6%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<form id="form_contract_export" method="post" enctype="multipart/form-data">
			<input type="hidden" name="sbkLx" value="xmtz">
			<input id="form_contract_export_fcCode" type="hidden" name="fcCode">
			<input id="form_contract_export_fcTitle" type="hidden" name="fcTitle">
			<input id="form_contract_export_fContStauts" type="hidden" name="fContStauts">
			<input id="form_contract_export_fBudgetIndexCode" type="hidden" name="fBudgetIndexCode">
		</form>
		
		
	</div>
	


<script type="text/javascript">
//清除查询条件
function ledger_clearTable() {
	$('#ledger_fcCode').textbox('setValue',null);
	$('#ledger_fcTitle').textbox('setValue',null);
	//$('#ledger_fReqtIME').datebox('setValue',null);
	$('#ledger_fcTitle').combobox('setValue',null);
	queryledger();
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
//合同台账导出
function exportContract() {
	if(confirm('是否按查询条件导出？')){
		var fcCode =$('#ledger_fcCode').val();
		var fcTitle = $('#ledger_fcTitle').val();
		var fContStauts = $('#ledger_fContStauts').val();
		var fBudgetIndexCode= $('#lendger_fBudgetIndexCode').val();
		
		$("#form_contract_export_fcCode").val(fcCode);
		$("#form_contract_export_fcTitle").val(fcTitle);
		$("#form_contract_export_fContStauts").val(fContStauts);
		$("#form_contract_export_fBudgetIndexCode").val(fBudgetIndexCode);
		
		$('#form_contract_export').attr('action','${base}/Ledger/export');
		$('#form_contract_export').submit();
	}
}
	function ContStauts(val, row) {
		if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 拟定" + '</span>';
		} else if (val == 9) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已备案" + '</span>';
		}else if (val == 3) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已结项" + '</span>';
		}else if (val == 5) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已归档" + '</span>';
		}else if (val == 7) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 有纠纷" + '</span>';
		}else if (val == -1) {
			return '<span style="color:red;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已终止" + '</span>';
		}else if (val == 11) {
			return '<span style="color:red;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 有变更" + '</span>';
		}
	}
	function archiving(val, row) {
		if (row.fContStauts == 5) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已归档" + '</span>';
		}else {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 未归档" + '</span>';
		}
	}
	var fs;
	function formatPrice(val, row) {
		fs=val;
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
		} else if (val == 9) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
		}else if (val == 99) {
			return '<span style="color:#666666;">' + " 已删除" + '</span>';
		}
	}
	function CZ(val, row) {
			return '<a href="#" onclick="ledger_detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
	}
	function ledgershowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function ledgershowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#ledger_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function queryledger() {
		$('#ledger_dg').datagrid('load', {
			fcCode : $('#ledger_fcCode').val(),
			fcTitle : $('#ledger_fcTitle').val(),
			//fReqtIME : $('#ledger_fReqtIME').val(),
			fContStauts : $('#ledger_fContStauts').val(),
			fBudgetIndexCode : $('#lendger_fBudgetIndexCode').val()
		});
	}
	function ledger_detail(id) {
			var win = creatWin('合同台账', 770, 580, 'icon-search',"/Ledger/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#ledger_dg').datagrid('getSelected');
		var selections = $('#ledger_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 840, 450, 'icon-search',
					"/Formulation/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function CF_update(id) {
		//var row = $('#ledger_dg').datagrid('getSelected');
		var selections = $('#ledger_dg').datagrid('getSelections');
		var win = creatWin(' ', 840, 450, 'icon-search',
				"/Formulation/edit/" + id);
		win.window('open');
	}
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Formulation/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#ledger_dg").datagrid('reload');
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
	//在线帮助
	function helpDemo() {
		window.open("./resource/onlinehelp/zzzx/demo/help.html");
	}
	function test(val) {
		alert('test');
	}
	function formatOper(value, row, index) {
		return 'sfsdf';
		//return '<a href="#" onclick="test('+index+')">修改</a>';  
		//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
	}
	function CheckYou() {
		var flag = true;
		var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
		 if(!regu.test($('#"ledger_fAssCode_R"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} 
</script>
</body>
</html>


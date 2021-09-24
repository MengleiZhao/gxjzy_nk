<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" class="queryth">合同编号&nbsp;
						<input id="filing_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="filing_fcTitle" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;备案状态&nbsp;
						<input id="filing_fContStauts" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Formulation/lookupsJson?parentCode=HTBAZT',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="queryfiling();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="filing_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					
					
					</td>
					<%-- <td class="top-table-td1" class="queryth">合同编号：</td> 
					<td class="top-table-td2">
						<input id="filing_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1" class="queryth">合同名称：</td> 
					<td class="top-table-td2">
						<input id="filing_fcTitle" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<!-- <td class="top-table-td1" class="queryth">申请时间：</td> 
					<td class="top-table-td2">
						<input id="filing_fReqtIME" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td> -->
					<td class="top-table-td1" class="queryth">备案状态：</td> 
					<td class="top-table-td2">
						<input id="filing_fContStauts" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Formulation/lookupsJson?parentCode=HTBAZT',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td style="width: 36px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="queryfiling();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="filing_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<td style="width: 30px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="filing_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Filing/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="15%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="21%">合同名称</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="10%" >申请日期</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">合同金额(元)</th>
						<th data-options="field:'fFlowStauts',align:'center',resizable:false,sortable:true,formatter:formatPrice" width="10%">审批状态</th>
						<th data-options="field:'fContStauts',align:'center',resizable:false,sortable:true,formatter:ContStauts" width="10%">备案状态</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	


<script type="text/javascript">
	//查询
	function queryfiling() {
		var fs=$('#filing_fContStauts').val();
		if(fs=="HTBAZT-01"){
			fs="1";
		}else if(fs=="HTBAZT-02"){
			fs="9";
		}
		$('#filing_dg').datagrid('load', {
			fcCode : $('#filing_fcCode').val(),
			fcTitle : $('#filing_fcTitle').val(),
			fReqtIME : $('#filing_fReqtIME').val(),
			fContStauts : fs
		});
	}
	//清除查询条件
	function filing_clearTable() {
		$('#filing_fcCode').textbox('setValue',null);
		$('#filing_fcTitle').textbox('setValue',null);
		$('#filing_fReqtIME').textbox('setValue',null);
		$('#filing_fContStauts').combobox('setValue',null);
		queryfiling();
	}
	var fs;
	function ContStauts(val, row) {
		fs=val;
		if (val == 1) { 
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未备案" + '</span>';
		} else {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已备案" + '</span>';
		}
	}
	function formatPrice(val, row) {
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
		}else if(val == 9){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
		}
	}
	function CZ(val, row) {
		if(fs == 9||fs == 5||fs == 7||fs == -1||fs == 11){
			return '<a href="#" onclick="filing_detail(' + row.fcId + ')" class="easyui-linkbutton"><img onmouseover="filingshowB(this)" onmouseout="filingshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' +  '&nbsp;&nbsp;'+'</a>';
		}else if(fs == 1){
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="filing_detail(' + row.fcId + ')" class="easyui-linkbutton"><img onmouseover="filingshowB(this)" onmouseout="filingshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'
					+'</a>'+ '</td><td style="width: 25px">'
					+'<a href="#" onclick="filing_update(' + row.fcId + ')" class="easyui-linkbutton"><img onmouseover="filingshowC(this)" onmouseout="filingshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/filing1.png">'
					+'</a></td></tr></table>';
		}
	}
	function filingshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function filingshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function filingshowC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/filing2.png';
	}
	function filingshowD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/filing1.png';
	}
	function filingshowE(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/delete2.png';
	}
	function filingshowF(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
	}
	
	//修改
	function filing_update(id) {
		var win = creatWin('合同备案', 720, 580, 'icon-search','/Filing/edit/'+id);
		win.window('open');
	}
	
	//查看
	function filing_detail(id) {
		var win = creatWin('合同备案', 720, 580, 'icon-search','/Filing/detail/'+id);
		win.window('open');
	}
	
	/* function filing_addCF() {
		var node = $('#filing_dg').datagrid('getSelected');
		var win = creatWin('合同备案', 750, 550, 'icon-add', '/Filing/add');
		if (null != node) {
			win = creatWin('合同备案', 750, 550, 'icon-add',
					'/Filing/add?departId=' + node.id);
		}
		win.window('open');
	}
	function editCF() {
		var row = $('#filing_dg').datagrid('getSelected');
		var selections = $('#filing_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin('合同备案', 750, 550, 'icon-search',
					"/Filing/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	/* function deleteCF() {
		var row = $('#filing_dg').datagrid('getSelected');
		var selections = $('#filing_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/Filing/delete/' + row.fcId,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$("#filing_dg").datagrid('reload');
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	}
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Filing/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$("#filing_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	} */
	/* function expListlawHelp() {
		var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
		win.window('open');
		if (confirm("按当前查询条件导出？")) {
			var queryForm = document.getElementById("lawHelp_list_form");
			queryForm.setAttribute("action", "${base}/demo/expList");
			queryForm.submit();
		}
	} */
	/* function test(val) {
		alert('test')
	}
	function formatOper(value, row, index) {
		return 'sfsdf';
		//return '<a href="#" onclick="test('+index+')">修改</a>';  
		//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
	} */
</script>
</body>
</html>


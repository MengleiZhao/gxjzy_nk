<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">支出事项类型</td> 
					<td class="top-table-td2">
						<!-- <input id="em_feCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input> -->
						<input class="easyui-combobox" style="width: 150px;height:25px;" data-options="valueField: 'feType',textField: 'value',editable:false,
											data: [{feType: '1',value: '通用事项'},{feType: '2',value: '会议'},{feType: '3',value: '培训'},{feType: '4',value: '差旅'},
												   {feType: '5',value: '因公接待'},{feType: '6',value: '公务用车'},{feType: '7',value: '因公出国'},{feType: '8',value: '直接报销'}]" id="em_feType"/>
					</td>
					<td style="width: 30px;"></td>
					<td class="top-table-td1">支出事项名称</td> 
					<td class="top-table-td2">
						<input id="em_feName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 30px;"></td>
					<td class="top-table-td1">支出事项标准</td> 
					<td class="top-table-td2">
						<input id="em_feStandard" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 30px;"></td>
					<td style="width: 26px;">
						<a href="javascript:void(0)"  onclick="em_query();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 8px;"></td>
					<td>
						<a href="javascript:void(0)"  onclick="clearTable();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 8px;"></td>
					
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="em_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="EM_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/ExpenditureMatter/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'feCode',align:'center'" width="15%">支出事项编号</th>
						<th data-options="field:'feType',align:'center',resizable:false,sortable:true,formatter:expenditureType" width="15%">支出事项类型</th>
						<th data-options="field:'feName',align:'center',resizable:false,sortable:true" width="15%">支出事项名称</th>
						<th data-options="field:'feStandard',align:'center',resizable:false,sortable:true" width="15%">支出事项标准</th>
						<th data-options="field:'feRemark',align:'left',resizable:false,sortable:true" width="26%">支出事项说明</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:expenditureCZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	


<script type="text/javascript">

//清除查询条件
function clearTable() {
	$('#em_feType').textbox('setValue',null);
	$('#em_feName').textbox('setValue',null);
	$('#em_feStandard').textbox('setValue',null);
}


function expenditureCZ(val, row) {
	return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="EM_detail(' + row.feId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
			+'</td><td style="width: 25px">'+ '<a href="#" onclick="EM_update(' + row.feId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
			+'</td><td style="width: 25px">'+'<a href="#" onclick="EM_delete(' + row.feId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
			+'</td></tr></table>';
}

function em_query() {
	var fs=$('#em_feStandard').val();
	$('#EM_dg').datagrid('load', {
		feType : $('#em_feType').textbox('getValue'),
		feName : $('#em_feName').val(),
		feStandard : fs
	});
}

function em_add() {
	var node = $('#EM_dg').datagrid('getSelected');
	var win = creatWin('支出事项-新增', 705, 580, 'icon-search', '/ExpenditureMatter/add');
	if (null != node) {
		win = creatWin('支出事项-新增', 705, 580, 'icon-search',
				'/ExpenditureMatter/add?departId=' + node.id);
	}
	win.window('open');
}

function EM_detail(id) {
		var win = creatWin('支出事项明细', 705, 580, 'icon-search',"/ExpenditureMatter/detail/" + id);
		win.window('open');
}

function EM_update(id) {
	//var row = $('#EM_dg').datagrid('getSelected');
	var selections = $('#EM_dg').datagrid('getSelections');
	var win = creatWin('支出事项-修改', 707, 580, 'icon-search',
			"/ExpenditureMatter/edit/" + id);
	win.window('open');
}

function EM_delete(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/ExpenditureMatter/delete/' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#EMAddEditForm').form('clear');
					$('#EM_dg').datagrid('reload');
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

function expenditureType(val, row) {
	if(val==1) {
		return "通用事项";
	} else if(val==2) {
		return "会议";
	} else if(val==3) {
		return "培训";
	} else if(val==4) {
		return "差旅";
	} else if(val==5) {
		return "公务接待";
	} else if(val==6) {
		return "公务用车";
	} else if(val==7) {
		return "公务出国";
	} else if(val==8) {
		return "全局";
	}
}

</script>
</body>


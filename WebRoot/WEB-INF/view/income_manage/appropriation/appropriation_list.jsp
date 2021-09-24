<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="appropriation_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">登记单号&nbsp;
					<input id="registerCode" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;项目名称&nbsp;
					<input id="projectName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;对方单位&nbsp;
					<input id="unitName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					<a href="#" onclick="queryAppropriation();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearAppropriationTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addAppropriation()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="appropriationTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/appropriation/appropriationPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'aId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'registerCode',align:'center'" style="width: 15%">登记单号</th>
					<th data-options="field:'projectName',align:'center'" style="width: 12%">项目名称</th>
					<th data-options="field:'unitName',align:'center'" style="width: 13%">对方单位</th>
					<th data-options="field:'amount',align:'center',resizable:false,sortable:true" style="width: 9%">预计来款金额</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 8%">登记部门</th>
					<th data-options="field:'fOperatorName',align:'center',resizable:false,sortable:true" style="width: 6%">登记人</th>
					<th data-options="field:'fApplyDate',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 9%">登记日期</th>
					<th data-options="field:'fFlowStatus',align:'center',formatter:flowStautsSet" width="8%">审批状态</th>
					<th data-options="field:'fConfirmStatus',align:'center',formatter:confirmStautsSet" width="8%">确认状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 8%">操作</th>
				</tr>
			</thead>
		</table>
	</div>

</div>
<script type="text/javascript">
	//分页样式调整
	$(function(){
		var pager = $('#appropriationTab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});
	});
	
	//点击查询
	function queryAppropriation() {
		$('#appropriationTab').datagrid('load', {
			registerCode : $('#registerCode').textbox('getValue'),
			projectName : $('#projectName').textbox('getValue'),
			unitName : $('#unitName').textbox('getValue')
		});                            
	}

	//清除查询条件
	function clearAppropriationTable() {
		$("#registerCode").textbox('setValue','');
		$("#projectName").textbox('setValue','');
		$("#unitName").textbox('setValue','');
		queryAppropriation();
	}
	
	//审批状态
	var c;
	function flowStautsSet(val, row) {
		c = val;
		if (val == '0') {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
		} else if (val == '-1') {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
		} else if (val == '9') {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
		}  else if (val == '-4') {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
		}
	}
	
	//确认状态
	function confirmStautsSet(val, row){
		if (val == '0') {
			return '未确认';
		} else if (val == '1') {
			return '已确认';
		} else {
			return val;
		}
	}
	
	//操作栏创建
	function CZ(val, row) {
		if ( c == 1 || c == 2) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="editAppropriation(' + row.aId + ',0)" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td><td style="width: 25px">'+
					'<a href="#" onclick="reCall(\'appropriationTab\',' + row.aId + ',\'/appropriation/reCall\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
					'</a></td></tr></table>';
		} else if(c == 0 || c == -1 || c == -4) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="editAppropriation(' + row.aId + ',0)" class="easyui-linkbutton">'+
			   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   		'</a>'+ '</td><td style="width: 25px">'+
					'<a href="#" onclick="editAppropriation(' + row.aId + ',1)" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="deleteAppropriation(' + row.aId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a></td></tr></table>';
		}else if(c == 9 ){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="editAppropriation(' + row.aId + ',0)" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td>'+
				   '</td></tr></table>';
		}
	}
	
	//新增页面
	function addAppropriation() {
		var win = creatWin('来款登记-新增', 1115,600, 'icon-search', '/appropriation/add');
		win.window('open');
	}

	//修改
	function editAppropriation(id,type) {
		var title = '';
		if(type==1){
			title="来款登记-修改";
		}else if(type==0){
			title="来款登记";
		}
		
		var win = creatWin(title, 1115, 600, 'icon-search', "/appropriation/edit?id="+ id +"&editType="+ type);
		win.window('open');	
	}
	
	//删除
	function deleteAppropriation(id,type) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/appropriation/delete?id=' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#appropriationTab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
</script>
</body>
</html>


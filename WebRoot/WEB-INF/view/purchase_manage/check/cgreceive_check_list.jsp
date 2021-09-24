<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="cgsq_yanshou_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">采购批次编号&nbsp;
					<input id="receive_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称&nbsp;
					<input id="receive_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryReceive();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearReceiveTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<input type="hidden" id="gongId"/><!-- 验收完成提示评价信息   获取当前验收的采购信息的主键id -->
				</td>								
			</tr>
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="receive_list" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgreceive/cgreceiveCheckPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'fItems',hidden:true"></th>
					<th data-options="field:'fAcpId',hidden:true"></th>
					<th data-options="field:'fIsContract',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'center'" style="width: 15%">采购批次编号</th>
					<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" style="width: 15%">采购名称</th>
					<th data-options="field:'fpAmount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">采购金额[元]</th>
					<th data-options="field:'fUserName',align:'center',resizable:false,sortable:true" style="width: 12%">申请人</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 12%">申请部门</th>
					<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 12%">申请日期</th>
					<th data-options="field:'fIsReceive',align:'center',resizable:false,sortable:true,formatter:formatRecive" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	flashtab("receive-tab");
	
		//点击查询
		function queryReceive() {
			$("#receive_list").datagrid('load', {
				fpCode:$('#receive_fpCode').val(),
				fpName:$('#receive_fpName').val(),
			});
	
		}
		
		//清除查询条件
		function clearReceiveTable() {
			$("#receive_fpCode").textbox('setValue','');
			$("#receive_fpName").textbox('setValue','');
			queryReceive();
		}
		
		//设置评价信息状态
		var z;
		function formatEval(val, row) {
			z = val;
			if (val == 0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未评价" + '</a>';
			} else if (val == 1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已评价" + '</a>';
			} 
		}
	
		//设置验收状态（审批状态）
		var c;
		function formatRecive(val, row) {
			c = val;
			if (val == 0||val == '') {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未验收" + '</a>';
			} else if (val == 1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 验收中" + '</a>';
			} else {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已验收" + '</a>';
			}
		}
		
	//操作栏创建
	function CZ(val, row) {
		if(row.fIsContract=='0'){
			return 	'<table style="margin:0 auto;"><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="cgreceiveCheck(' + row.fAcpId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yanshou1.png">'+
			'</a></td></tr></table>';
		}else{
			return 	'<table style="margin:0 auto;"><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="cgreceiveCheck(' + row.fAcpId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yanshou1.png">'+
			'</a></td></tr></table>';
		}
	}
	//查看合同
	function htPro(fpId) {
		var win = creatFirstWin('合同信息',1115,580,'icon-search',"/cgreceive/detailContract/"+fpId);
		win.window('open');
	}
	
	//跳转查看页面
	function ys_lendger_detail_s(id) {
		var win = creatWin('验收详情', 970, 580, 'icon-search', "/cgreceive/detail?id="+ id);
		win.window('open');
	}	
	
	//跳转验收 
	function cgreceiveCheck(id) {
		var win = creatWin('审批', 1115, 580, 'icon-search', "/cgreceive/check?id="+ id);
		win.window('open');
	}		
</script>
</body>
</html>

